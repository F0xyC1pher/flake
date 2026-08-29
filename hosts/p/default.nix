{vars, ...}: {
	imports = [
		./hardware-configuration.nix
	];
	system.stateVersion = "26.11";
	hardware.cpu.intel.updateMicrocode = true;
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			home.stateVersion = "26.11";
		};
	};
}
