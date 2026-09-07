{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			programs.umbriel.settings.window_rule = [
				{
					blur = vars.theme.blur.enable or true;
					blur_optimized = vars.theme.blur.xray.enable or false;
				}
				{
					match = [
						{content_type = "game";}
						{app_id = "^steam_app_";}
						{app_id = "^(heroic|lutris|org\\.prismlauncher\\.PrismLauncher|org\\.freesmlauncher\\.FreesmLauncher)$";}
					];
					blur = false;
				}
				{
					match.app_id = "^(pavucontrol|org\\.pulseaudio\\.pavucontrol|qalculate-gtk|zenity|xdg-desktop-portal.*)$";
					default_floating = true;
				}
				{
					match.title = "^(Open File|Select a File|Choose wallpaper|Save As|Library|Picture-in-Picture|Picture in picture)$";
					default_floating = true;
				}
				{
					match.title = "^(Картинка в картинке|Picture-in-Picture|Picture in picture)$";
					default_floating = true;
					default_pinned = true;
					focus = false;
					blur = false;
				}
				{
					match.app_id = "^(steam_app_.*|gamescope|overwatch)$";
					default_fullscreen = true;
					vrr = "always";
				}
				{
					match = {
						app_id = "steam";
						title = "^notificationtoasts_\\d+_desktop$";
					};
					default_floating = true;
					focus = false;
				}
				{
					match.app_id = "^org\\.keepassxc\\.KeePassXC$";
					block_out_from = "screen-capture";
				}
			];
		};
	};
}
