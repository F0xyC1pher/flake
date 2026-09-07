{
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	home-manager.users.${vars.user.name} = {
		pkgs,
		lib,
		...
	}: {
		xdg.portal =
			lib.mkForce {
				enable = true;
				xdgOpenUsePortal = true;
				extraPortals = [
					pkgs.xdg-desktop-portal-termfilechooser
					inputs.niri-screenshare.packages.${pkgs.stdenv.hostPlatform.system}.default
					inputs.xdg-desktop-portal-umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default
					inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
					pkgs.xdg-desktop-portal-gtk
				];
				config = {
					common = {
						default = ["termfilechooser" "gtk"];
						"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
						"org.freedesktop.impl.portal.Settings" = ["gtk"];
					};
					niri = {
						default = ["termfilechooser" "gtk"];
						"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
						"org.freedesktop.impl.portal.ScreenCast" = ["niri"];
						"org.freedesktop.impl.portal.Settings" = ["gtk"];
					};
					Hyprland = {
						default = ["termfilechooser" "gtk"];
						"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
						"org.freedesktop.impl.portal.ScreenCast" = ["hyprland"];
						"org.freedesktop.impl.portal.Settings" = ["gtk"];
					};
					umbriel = {
						default = ["termfilechooser" "gtk"];
						"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
						"org.freedesktop.impl.portal.ScreenCast" = ["umbriel"];
						"org.freedesktop.impl.portal.Settings" = ["gtk"];
					};
				};
			};
	};
}
