{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
	# ========== HOME ==========	
	# gtk = {
	# 	enable = true;
	# 	gtk3 = {
	# 	      extraConfig.gtk-application-prefer-dark-theme = true;
	# 	    };
	# };

	# qt = {
	# 	enable = true;
	# 	# platformTheme.name = lib.mkForce "qt6ct";
	# };
	
	# dconf.settings = {
	# 	"org/gtk/settings/file-chooser" = {
	#     	sort-directories-first = true;
	# 	};
	# };
	
	home.pointerCursor = {
		gtk.enable = true;
		x11.enable = true;
		package = pkgs.posy-cursors;
		name = "Posy_Cursor_Black";
		size = 32;
	};
	

	
	xdg = {
		enable = true;
		configFile = {
			"MangoHud/MangoHud.conf" = {
				enable = true;
				force = true;
				text = ''
					legacy_layout=false
					fps
					hud_compact
					hud_no_margin
					display_server
					engine_short_names
					toggle_logging=Shift_L+F2
					toggle_hud_position=Shift_R+F11
					log_interval=500
					fps_limit_method=late
					toggle_fps_limit=Shift_L+F1
					vsync=1
					gl_vsync=0
					background_alpha=0.4
					position=top-left
					table_columns=2
					toggle_hud=Shift_R+F12
					font_size=18
					gpu_color=2e9762
					cpu_color=2e97cb
					fps_value=30,60
					fps_color=cc0000,ffaa7f,92e79a
					gpu_load_value=60,90
					gpu_load_color=92e79a,ffaa7f,cc0000
					cpu_load_value=60,90
					cpu_load_color=92e79a,ffaa7f,cc0000
					background_color=000000
					frametime_color=00ff00
					vram_color=ad64c1
					ram_color=c26693
					wine_color=eb5b5b
					engine_color=eb5b5b
					text_color=ffffff
					media_player_color=ffffff
					network_color=e07b85
					battery_color=92e79a
					media_player_format={title};{artist};{album}
				'';
			};
		};
	};
};
};
}
