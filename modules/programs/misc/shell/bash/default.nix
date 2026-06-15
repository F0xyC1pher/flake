{pkgs, ...}: {
	environment.shells = with pkgs; [
		bash
	];
	programs = {
		bash = {
			enable = true;
			completion.enable = true;
		};
	};
}
