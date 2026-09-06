{
	lib,
	inputs,
}: {
	hostPath,
	userCfg,
	vars,
	programModules,
	serviceModules,
	mkModules,
}: let
	modulesBase = ./../modules;

	rawPrograms = userCfg.programs or [];
	rawServices = userCfg.services or [];

	activePrograms = mkModules.resolveActiveNames (modulesBase + "/programs") rawPrograms;
	activeServices = mkModules.resolveActiveNames (modulesBase + "/services") rawServices;

	hasProgram = p: lib.elem p activePrograms;
	hasService = s: lib.elem s activeServices;
in
	[
		modulesBase
		./../users/default.nix
		hostPath
	]
	++ programModules
	++ serviceModules
	++ [
		{nixpkgs.overlays = [(import ./overlay.nix {inherit lib inputs;})];}
		inputs.home-manager.nixosModules.home-manager
		inputs.nur.modules.nixos.default
	]
	++ lib.optional (hasService "proxy-suite") inputs.proxy-suite.nixosModules.default
	++ lib.optional (hasProgram "driftwm") inputs.driftwm.nixosModules.default
	++ lib.optional (hasProgram "shojiwm") inputs.shojiwm.nixosModules.default
	++ lib.optional (hasProgram "skwd-wall") inputs.skwd-wall.nixosModules.default
	++ [
		{
			home-manager = {
				useGlobalPkgs = true;
				useUserPackages = true;
				backupFileExtension = "backup";
				extraSpecialArgs = {inherit inputs vars;};

				sharedModules =
					[]
					++ lib.optional (hasProgram "nixcord") inputs.nixcord.homeModules.nixcord
					++ lib.optional (hasProgram "flatpak" || hasService "flatpak") inputs.nix-flatpak.homeManagerModules.nix-flatpak
					++ lib.optional (hasProgram "dms") inputs.dms.homeModules.dank-material-shell;

				users.${vars.user.name} = {...}: {
					home.username = vars.user.name;
					home.homeDirectory = "/home/${vars.user.name}";
				};
			};
		}
	]
