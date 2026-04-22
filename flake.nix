{
	description = "flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Актуальная unstable ветка

		# hardware-configuration = {
		# 	url = "path:/etc/nixos/hardware-configuration.nix";
		# 	flake = false;
		# };

		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		sops-nix.url = "github:Mic92/sops-nix";
		sops-nix.inputs.nixpkgs.follows = "nixpkgs";

		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixcord.url = "github:FlameFlag/nixcord";

		niri = {
			url = "github:sodiboo/niri-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		scroll-flake = {
			url = "github:Diax170/scroll-flake";
			inputs.nixpkgs.follows = "nixpkgs"; # this assumes nixos unstable
		};

		nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";

		# awww = {
		# 	url = "git+https://codeberg.org/LGFae/awww";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };

		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser = {
			url = "github:youwen5/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		freesmlauncher = {
			url = "github:FreesmTeam/FreesmLauncher";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# rmpc = {
		# 	url = "github:mierak/rmpc";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };

		queercat = {
			url = "https://github.com/Elsa002/queercat";
			type = "git";
			submodules = true;
		};

		pawbar = {
			url = "https://github.com/nekorg/pawbar";
			type = "git";
			submodules = true;
		};

		ayugram-desktop = {
			url = "https://github.com/ndfined-crp/ayugram-desktop/";
			type = "git";
			submodules = true;
		};

		nekobox = {
			url = "https://github.com/qr243vbi/nekobox/releases/download/5.10.40/nekobox-5.10.40-linux-amd64.tar.gz";
			flake = false;
		};
		nekobox-git = {
			url = "https://github.com/qr243vbi/nekobox";
			type = "git";
			flake = false;
			submodules = true;
		};

		rofi-polkit-agent = {
			url = "https://github.com/Zebra2711/rofi-polkit-agent";
			type = "git";
			submodules = true;
			flake = false;
		};

		fuzzel-polkit-agent = {
			url = "https://codeberg.org/lukeflo/fuzzel-polkit-agent";
			type = "git";
			submodules = true;
			flake = false;
		};

		cliphist = {
			url = "https://github.com/sentriz/cliphist";
			type = "git";
			submodules = true;
			flake = false;
		};
		jbr-wayland-nix.url = "github:BananchickPasha/jbr-wayland-nix";
	};

	outputs = {
		self,
		nixpkgs,
		# hardware-configuration,
		home-manager,
		sops-nix,
		stylix,
		niri,
		scroll-flake,
		nixcord,
		# jbr-wayland-nix,
		# awww,
		firefox-addons,
		# rmpc,
		freesmlauncher,
		rofi-polkit-agent,
		...
	} @ inputs: let
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		#vars = import ./vars;
		themes = import ./modules/themes/lib.nix {inherit lib;};
		# Оверлей: автоматически подхватывает все пакеты из packages/*.nix
		overlay = final: prev: let
			files =
				lib.filterAttrs (
					name: type: type == "regular" && builtins.match "^[^_].*\\.nix$" name != null
				) (builtins.readDir ./modules/packages/custom);
		in
			builtins.foldl' (
				acc: name: let
					pkgName = lib.removeSuffix ".nix" name;
					value = final.callPackage ./modules/packages/custom/${name} {inherit inputs;};
				in
					acc // {"${pkgName}" = value;}
			) {} (builtins.attrNames files);

		# ── mkHost ──────────────────────────────────────────────────────────────
		# Reads hosts/<name>/meta.nix and users/<mainUser>/default.nix as pure
		# data, resolves the chosen theme, and bundles everything into a single
		# `vars` attrset that gets passed to every NixOS / HM module.
		mkHost = hostName: let
			# 1. Читаем ЧИСТЫЕ данные из meta.nix (это не функция, импорт всегда успешен)
			hostMeta = import (./hosts + "/${hostName}/meta.nix");
			targetUser = hostMeta.mainUser;

			# 2. Подтягиваем настройки этого юзера (тоже вызываем как функцию)
			userSettings = import (./users + "/${targetUser}/default.nix") {inherit lib;};
			resolved =
				themes.resolve {
					name = userSettings.theme;
					colorOverrides = userSettings.colorOverrides or {};
					roleOverrides = userSettings.roleOverrides  or {};
				};
			# Формируем итоговые vars
			hostVars = {
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
				hardware = hostMeta.hardware  or {};
			};
		in
			lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit inputs;
					vars = hostVars; # Передаем сформированный объект
				};
				modules = [
					./modules
					./hosts/${hostName}
					# inputs.hardware-configuration.outPath
					home-manager.nixosModules.home-manager
					stylix.nixosModules.stylix
					niri.nixosModules.niri
					scroll-flake.nixosModules.default
					sops-nix.nixosModules.sops
					(
						{...}: {
							nixpkgs.overlays = [overlay];
						}
					)
					{
						home-manager = {
							extraSpecialArgs = {
								inherit inputs;
								vars = hostVars;
							};
							useGlobalPkgs = true;
							useUserPackages = true;
							backupFileExtension = "backup";
							sharedModules = [
								sops-nix.homeManagerModules.sops
								nixcord.homeModules.nixcord
							];
							users.${targetUser} = {...}: {
								home.username = "${targetUser}";
								home.homeDirectory = "/home/${targetUser}";
								home.stateVersion = "26.05";
							};
						};
					}
				];
			};
	in {
		nixosConfigurations = let
			# Автоматически подхватывает все поддиректории из hosts/
			# Чтобы добавить хост — создай hosts/имяхоста/default.nix, больше ничего не нужно
			hostDirs = builtins.readDir ./hosts;
			hostNames =
				builtins.filter (
					name: (hostDirs.${name} == "directory") && (builtins.pathExists (./hosts + "/${name}/default.nix"))
				) (builtins.attrNames hostDirs);
		in
			builtins.listToAttrs (
				map (hostName: {
						name = hostName;
						value = mkHost hostName;
					})
				hostNames
			);
	};
}
