{pkgs, ...}: {
	environment.systemPackages = with pkgs; [
		google-antigravity
		google-antigravity-ide
		google-antigravity-cli
	];
}
