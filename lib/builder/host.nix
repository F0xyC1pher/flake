# lib/builder/host.nix
{
	lib,
	inputs,
	system,
	flakeRoot,
	themeBuilder,
	moduleResolver,
	varsBuilder,
	pkgsOverlay,
	hostsBase ? "${flakeRoot}/hosts",
	usersBase ? "${flakeRoot}/users",
	modulesBase ? "${flakeRoot}/modules",
}: {
	hostName,
	systemImports ? (import "${flakeRoot}/system-imports.nix" {
			inherit lib inputs pkgsOverlay;
		}),
}: let
	hostPath = "${hostsBase}/${hostName}";
	hostMeta = import (hostPath + "/meta.nix");
	hostCfg = hostMeta.host;
	userName = hostCfg.user;

	userCfg = import "${usersBase}/${userName}/default.nix" {inherit lib;};

	resolvedTheme =
		themeBuilder.resolve {
			name = userCfg.theme.name or "theMe";
			accentLevel = userCfg.theme.accentLevel or null;
			accentColor = userCfg.theme.accentColor or null;
		};

	# Передаем окружение в первый слой varsBuilder
	vars =
		varsBuilder {
			inherit hostName hostCfg userCfg resolvedTheme modulesBase;
		};

	programModules = moduleResolver.importPrograms (modulesBase + "/programs") (userCfg.programs or []);
	serviceModules = moduleResolver.importServices (modulesBase + "/services") (userCfg.services or []);
	packageModules = moduleResolver.importPackages (modulesBase + "/packages") (userCfg.packages or []);

	systemModules =
		systemImports {
			inherit hostPath vars userCfg programModules serviceModules packageModules modulesBase usersBase;
		};
in
	lib.nixosSystem {
		inherit system;
		specialArgs = {inherit inputs vars pkgsOverlay;};
		modules = systemModules;
	}
