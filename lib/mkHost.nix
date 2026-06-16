# lib/mkHost.nix
{
	lib,
	inputs,
	system,
	themes,
	overlay,
	utils,
}: hostName: let
	hostPath = ./../hosts + "/${hostName}";
	hostMeta = import (hostPath + "/meta.nix");

	userName = hostMeta.user; # fix: было mainUser

	userCfg = import (./../users + "/${userName}/default.nix") {inherit lib;};

	resolvedTheme =
		themes.resolve {
			name = userCfg.theme.name or "theMe";
			accentName = userCfg.theme.accent or null; # fix: было accent (неверное имя арг)
			colorOverrides = userCfg.theme.colorOverrides or {};
			roleOverrides = userCfg.theme.roleOverrides or {};
		};

	modulesBase = ./../modules;
	programsBase = modulesBase + "/programs";

	programModules = utils.importPrograms programsBase (userCfg.programs or []);

	vars = {
		user = {
			name = userName;
			fullName = userCfg.user.fullName or userCfg.userFullName or userName;
			gitName = userCfg.user.gitName or (userCfg.user.fullName or userName);
			mail = userCfg.user.mail or "";
			password = userCfg.user.password or userCfg.userPassword or null;
			shell = userCfg.user.shell or userCfg.shell or "fish";
		};

		# Fallback для модулей, которые ещё используют vars.app.*
		app =
			userCfg.app or {
				gui = {
					browser = "firefox";
					file-manager = "yazi";
					launcher = "fuzzel";
					text-editor = "vscodium";
				};
				terminal = "kitty";
				tui = {
					browser = "lyx";
					file-manager = "yazi";
					text-editor = "micro";
				};
			};

		theme = {
			name = userCfg.theme.name or "theMe";
			dark = userCfg.theme.dark or true;
			font =
				userCfg.theme.font or {
					name = "JetBrains Mono";
					size = 12;
				};
			blur =
				userCfg.theme.blur or {
					enable = false;
					xray.enable = false;
				};
			colorOverrides = userCfg.theme.colorOverrides or {};
			roleOverrides = userCfg.theme.roleOverrides or {};
			style = resolvedTheme.theme;
			colors = resolvedTheme.colors;
		};

		host = hostMeta.host; # fix: было hostMeta (весь сет), нужна строка
		hardware = hostMeta.hardware; # fix: отсутствовало
		system = userCfg.system or {};
	};

	inherit
		(inputs)
		nur
		home-manager
		sops-nix
		dms
		alejandra
		nixcord
		skwd-wall
		;
in
	lib.nixosSystem {
		inherit system;

		specialArgs = {inherit inputs vars;};

		modules =
			[
				modulesBase
				./../users/default.nix # создание системного пользователя
				hostPath
			]
			++ programModules
			++ [
				{nixpkgs.overlays = [overlay];}

				nur.modules.nixos.default
				sops-nix.nixosModules.sops

				skwd-wall.nixosModules.default

				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						backupFileExtension = "backup";
						extraSpecialArgs = {inherit inputs vars;}; # fix: vars отсутствовал
						sharedModules = [
							sops-nix.homeManagerModules.sops
							nixcord.homeModules.nixcord
							dms.homeModules.dank-material-shell
						];
						users.${userName} = {...}: {
							home.username = userName;
							home.homeDirectory = "/home/${userName}";
							home.stateVersion = "26.05";
						};
					};
				}
			];
	}
