{
	lib,
	inputs,
}: {
	hostPath,
	vars,
	userCfg,
	mkModules,
	programModules,
	serviceModules,
}: let
	modulesBase = ./../modules;
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
	++ lib.optional (vars.hasService "proxy-suite") inputs.proxy-suite.nixosModules.default
	++ lib.optional (vars.hasProgram "driftwm") inputs.driftwm.nixosModules.default
	++ lib.optional (vars.hasProgram "shojiwm") inputs.shojiwm.nixosModules.default
	++ lib.optional (vars.hasProgram "skwd-wall") inputs.skwd-wall.nixosModules.default
	++ [
		{
			home-manager = {
				useGlobalPkgs = true;
				useUserPackages = true;
				backupFileExtension = "backup";
				extraSpecialArgs = {inherit inputs vars;};

				sharedModules =
					[]
					++ lib.optional (vars.hasProgram "nixvim") inputs.nixvim.homeModules.nixvim
					++ lib.optional (vars.hasProgram "umbriel") inputs.umbriel.homeModules.default
					++ lib.optional (vars.hasProgram "noctalia") inputs.noctalia.homeModules.default
					++ lib.optional (vars.hasProgram "nixcord") inputs.nixcord.homeModules.nixcord
					++ lib.optional (vars.hasProgram "flatpak" || vars.hasService "flatpak") inputs.nix-flatpak.homeManagerModules.nix-flatpak
					++ lib.optional (vars.hasProgram "dms") inputs.dms.homeModules.dank-material-shell;

				users.${vars.user.name} = {...}: {
					home.username = vars.user.name;
					home.homeDirectory = "/home/${vars.user.name}";
				};
			};
		}
	]
