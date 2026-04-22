{
	lib,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./config.nix
	];
	programs.scroll = {
		enable = true;
		package = inputs.scroll-flake.packages.${pkgs.stdenv.hostPlatform.system}.scroll-git; # read more below
		extraPackages = lib.mkForce [];
		# Commands executed before scroll gets launched, see more examples here:
		# https://github.com/dawsers/scroll#environment-variables
		extraSessionCommands = ''
			# XDG desktop variables to set scroll as the desktop
			export XDG_CURRENT_DESKTOP=scroll
			export XDG_SESSION_TYPE=wayland
			export XDG_SESSION_DESKTOP=scroll
		'';
	};
}
