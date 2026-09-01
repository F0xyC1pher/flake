# lib/mkHost.nix
{
	lib,
	inputs,
	system,
	themes,
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
		};

	# 1. Сборка объекта vars через отдельный модуль
	mkVars = import ./mkVars.nix {inherit lib themes;};
	vars = mkVars {inherit hostName hostMeta userCfg resolvedTheme;};

	# 2. Инициализация системных и пользовательских программ
	modulesBase = ./../modules;
	programModules = mkModules.importPrograms (modulesBase + "/programs") (userCfg.programs or []);
	serviceModules = mkModules.importServices (modulesBase + "/services") (userCfg.services or []);

	# 3. Генерация списка активных модулей системы
	mkSystemModules = import ./mkSystemModules.nix {inherit lib inputs;};
	systemModules =
		mkSystemModules {
			inherit hostPath userCfg vars programModules serviceModules mkModules;
		};
in
	lib.nixosSystem {
		inherit system;
		specialArgs = {inherit inputs vars;};
		modules = systemModules;
	}
