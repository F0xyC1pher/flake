#lib/mk-host.nix
{
	lib,
	inputs,
	system,
	themes,
	mkModules,
}: hostName: let
	hostPath = ./../hosts + "/${hostName}";
	hostMeta = import (hostPath + "/meta.nix");
	hostCfg = hostMeta.host;
	userName = hostCfg.user;

	userCfg = import (./../users + "/${userName}/default.nix") {inherit lib;};

	resolvedTheme =
		themes.resolve {
			name = userCfg.theme.name or "theMe";
			accentLevel = userCfg.theme.accentLevel or null;
			accentColor = userCfg.theme.accentColor or null;
		};

	modulesBase = ./../modules;

	mkVars = import ./mk-vars.nix {inherit lib themes;};
	vars = mkVars {inherit hostName hostCfg userCfg resolvedTheme modulesBase mkModules;};

	programModules = mkModules.importPrograms (modulesBase + "/programs") (userCfg.programs or []);
	serviceModules = mkModules.importServices (modulesBase + "/services") (userCfg.services or []);
	packageModules = mkModules.importPackages (modulesBase + "/packages") (userCfg.packages or []);

	mkSystemModules = import ./mk-system-modules.nix {inherit lib inputs;};
	systemModules =
		mkSystemModules {
			inherit hostPath userCfg vars programModules serviceModules packageModules mkModules;
		};
in
	lib.nixosSystem {
		inherit system;
		specialArgs = {inherit inputs vars;};
		modules = systemModules;
	}
