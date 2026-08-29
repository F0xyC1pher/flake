# lib/mkHost.nix
{
	lib,
	inputs,
	system,
	themes,
	overlay,
	mkModules,
}: hostName: let
	hostPath = ./../hosts + "/${hostName}";
	hostMeta = import (hostPath + "/meta.nix");

	userName = hostMeta.user;

	userCfg = import (./../users + "/${userName}/default.nix") {inherit lib;};

	resolvedTheme =
		themes.resolve {
			name = userCfg.theme.name or "theMe";
			accentLevel = userCfg.theme.accentLevel or userCfg.theme.level or null;
			accentColor = userCfg.theme.accentColor or userCfg.theme.color or userCfg.theme.accent or null;
			colorOverrides = userCfg.theme.colorOverrides or {};
			roleOverrides = userCfg.theme.roleOverrides or {};
		};

	modulesBase = ./../modules;
	servicesBase = modulesBase + "/services";
	programsBase = modulesBase + "/programs";

	programModules = mkModules.importPrograms programsBase (userCfg.programs or []);
	serviceModules = mkModules.importServices servicesBase (userCfg.services or []);

	vars = {
		user = {
			name = userName;
			fullName = userCfg.user.fullName or userCfg.userFullName or userName;
			gitName = userCfg.user.gitName or (userCfg.user.fullName or userName);
			mail = userCfg.user.mail or "";
			password = userCfg.user.password or userCfg.userPassword or null;
			shell = userCfg.user.shell or userCfg.shell or "fish";
		};

		app =
			userCfg.app or {
				gui = {
					browser = "firefox";
					file-manager = "yazi";
					launcher = "fuzzel";
					text-editor = "zeditor";
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
			accentLevel = resolvedTheme.accentLevel;
			accentColor = resolvedTheme.accentColor;
			# Автоматически берём динамически рассчитанный флаг из resolve (с фоллбэком на конфиг пользователя)
			dark = userCfg.theme.dark or resolvedTheme.isDark;
			border =
				userCfg.theme.border or {
					width = 2;
					radius = 0;
				};
			font =
				userCfg.theme.font or {
					name = "CaskaydiaCove Nerd Font Mono";
					size = 14;
				};
			# Исходное значение 0.0 - 1.0
			opacity = userCfg.theme.opacity or 1.0;
			# Перевод в 2 HEX-символа через экспортированную функцию темы
			opacityHex = themes.opacityToHex userCfg.theme.opacity;
			# Конвертеры HEX -> RGB
			hexToRgb = themes.hexToRgb;
			hexToRgbString = themes.hexToRgbString;
			blur =
				userCfg.theme.blur or {
					enable = false;
					xray.enable = false;
				};
			liquid-glass = userCfg.theme.liquid-glass or false;
			colorOverrides = userCfg.theme.colorOverrides or {};
			roleOverrides = userCfg.theme.roleOverrides or {};
			style = resolvedTheme.theme;
			colors = resolvedTheme.colors;
		};

		host = hostMeta.host;
		hardware = hostMeta.hardware;
		system = userCfg.system or {};
	};

	inherit
		(inputs)
		nur
		home-manager
		sops-nix
		# dms
		nixcord
		skwd-wall
		nix-flatpak
		proxy-suite
		happ-nix
		driftwm
		shojiwm
		niri-glass
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
			++ serviceModules
			++ [
				{nixpkgs.overlays = [overlay];}

				nur.modules.nixos.default
				sops-nix.nixosModules.sops

				skwd-wall.nixosModules.default
				proxy-suite.nixosModules.default
				happ-nix.nixosModules.default

				driftwm.nixosModules.default
				shojiwm.nixosModules.default
				home-manager.nixosModules.home-manager

				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						backupFileExtension = "backup";
						extraSpecialArgs = {inherit inputs vars;};
						sharedModules = [
							sops-nix.homeManagerModules.sops
							nixcord.homeModules.nixcord
							# dms.homeModules.dank-material-shell
							nix-flatpak.homeManagerModules.nix-flatpak
						];
						users.${userName} = {...}: {
							home.username = userName;
							home.homeDirectory = "/home/${userName}";
						};
					};
				}
			];
	}
