{pkgs, ...}: {
	environment.systemPackages = with pkgs; [
		wineWow64Packages.stagingFull
		wineWow64Packages.waylandFull
		wineWow64Packages.fonts
		wineasio
		winetricks
	];
}
