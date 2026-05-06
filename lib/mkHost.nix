# ── mkHost ───────────────────────────────────────────────────────────────────
#
# Reads hosts/<name>/meta.nix and users/<mainUser>/default.nix as pure data,
# resolves the chosen theme, and bundles everything into a single `vars`
# attrset that every NixOS / HM module receives via specialArgs.
#
# To add a new host: create hosts/<name>/default.nix (+ meta.nix).
# No changes to flake.nix are needed — hosts are auto-discovered.
{
	lib,
	inputs,
	system,
	themes,
	overlay,
}: hostName: let
	hostMeta = import (../hosts + "/${hostName}/meta.nix");
	targetUser = hostMeta.mainUser;

	userSettings = import (../users + "/${targetUser}/default.nix") {inherit lib;};

	resolved =
		themes.resolve {
			name = userSettings.theme;
			colorOverrides = userSettings.colorOverrides or {};
			roleOverrides = userSettings.roleOverrides  or {};
		};

	vars = {
		# identity
		userName = targetUser;
		userFullName = userSettings.userFullName;
		userPassword = userSettings.userPassword or null;

		# appearance
		fontName = userSettings.fontName;
		fontSize = userSettings.fontSize;
		shell = userSettings.shell;
		terminal = userSettings.terminal;
		blur =
			userSettings.blur or {
				enable = false;
				xray.enable = false;
			};

		# style bundle
		style = {
			colors = resolved.colors;
			theme = resolved.theme;
		};

		# host
		hostName = hostMeta.hostName;
		bootLoader = hostMeta.bootLoader or null;
		hardware = hostMeta.hardware   or {};
	};

	inherit
		(inputs)
		home-manager
		sops-nix
		nur
		nixcord
		zen-browser
		noctalia
		system76-scheduler-niri
		scroll-flake
		niri
		;
in
	lib.nixosSystem {
		inherit system;
		specialArgs = {inherit inputs vars;};
		modules = [
			../modules
			../users
			../hosts/${hostName}

			home-manager.nixosModules.home-manager
			niri.nixosModules.niri
			scroll-flake.nixosModules.default
			sops-nix.nixosModules.sops
			nur.modules.nixos.default

			({...}: {nixpkgs.overlays = [overlay];})

			{
				home-manager = {
					extraSpecialArgs = {inherit inputs vars;};
					useGlobalPkgs = true;
					useUserPackages = true;
					backupFileExtension = "backup";
					sharedModules = [
						sops-nix.homeManagerModules.sops
						nixcord.homeModules.nixcord
						zen-browser.homeModules.twilight
						noctalia.homeModules.default
						system76-scheduler-niri.homeModules.default
					];
					users.${targetUser} = {...}: {
						home.username = targetUser;
						home.homeDirectory = "/home/${targetUser}";
						home.stateVersion = "26.05";
					};
				};
			}
		];
	}
