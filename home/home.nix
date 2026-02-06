{ lib, config, pkgs, inputs, vars, ... }:
{
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
	
	services.mopidy = {
		enable = true;
		
		extensionPackages = with pkgs; [
			mopidy-mpd        # ← MPD протокол (ncmpcpp, rmpc и т.д. будут работать)
			mopidy-local      # локальная музыка
			mopidy-youtube    # YouTube поиск/плейлисты/каналы
			mopidy-iris       # веб-интерфейс[](http://localhost:6680/iris)
		#	mopidy-spotify    # кал
		];
		
		settings = {
			core = {
				cache_dir = "${config.xdg.cacheHome}/mopidy";  # или ~/.cache/mopidy
				config_dir = "${config.xdg.configHome}/mopidy";
				data_dir   = "${config.xdg.dataHome}/mopidy";
			};
			
			audio = {
				output = "pipewiresink client-name=mopidy";
			#	Опционально: уменьшить задержку (latency в микросекундах)
			#	buffer_time = 200000;  # 200 мс
			#	latency = 60000;       # 60 мс
			};
			
			local = {
				enabled = true;
				media_dir = [ "/home/${vars.userName}/CoolStuff/Music" ];
				# follow_symlinks = true;
			#	excluded_file_extensions = ".jpg .png .txt";
			};
			
			mpd = {
				enabled = true;
			#	hostname = "127.0.0.1";
			#	port = 6600;
			};
			
			youtube = {
				enabled = true;
			#	youtube_api_key = "твой_ключ_из_google_console";  # если нужно больше результатов
			#	search_results = 20;
			#	autoplay_enabled = false;
			#	video_codec_priority = "vp9,h264";
			};
		};
	};
	
	programs.zarumet = {
		enable = true;
		settings = {
			mpd = {
				address = "localhost:6600";
			};
			colors = {
			album = "#fae280";
			artist = "#fae280";
			border = "#fae280";
			status = "#fae280";
			title = "#fae280";
			};
			# pipewire = {
			# 	bit_perfect_enabled = false;
			# };
		};
	};
	
	programs.emacs = {
	    enable = true;
	    package = pkgs.emacs-gtk;
	    # extraConfig = ''
	    #   (setq standard-indent 2)
	    # '';
	  };
	
	programs.helix = {
	  enable = true;
	  languages.language = [{
	    name = "nix";
	    auto-format = true;
	    formatter.command = lib.getExe pkgs.nixfmt;
	  }];
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
	#			"xdg-desktop-portal-termfilechooser/config" = {
	#				enable = true;
	#				force = true;
	#				text = ''
	# [filechooser]
	# cmd=${config.home.homeDirectory}/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
	# default_dir=${config.home.homeDirectory}/Downloads
	# env=TERMCMD=kitty
	# open_mode=suggested
	# save_mode=last
	# '';
	# };
	#	"xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
	#		enable = true;
	#		executable = true;
	#		force = true;
	#		text = ''
#!${pkgs.bash}/bin/bash
# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.
#
# For more information about input/output arguments read `xdg-desktop-portal-termfilechooser(5)`

# set -eu
# 
# if [ "$6" -ge 4 ]; then
#     set -x
# fi
# 
# multiple="$1"
# directory="$2"
# save="$3"
# path="$4"
# out="$5"
# 
# cmd="${pkgs.yazi}/bin/yazi"
# 
# if [ "$save" = "1" ]; then
#     # save a file
#     exec "$TERMCMD" "$cmd" --chooser-file="$out" "$path"
# elif [ "$directory" = "1" ]; then
#     # upload files from a directory
#     exec "$TERMCMD" "$cmd" --chooser-file="$out" --cwd-file="$out"".1" "$path"
# elif [ "$multiple" = "1" ]; then
#     # upload multiple files
#     exec "$TERMCMD" "$cmd" --chooser-file="$out" --choose-multiple "$path"
# else
#     # upload only 1 file
#     exec "$TERMCMD" "$cmd" --chooser-file="$out" "$path"
# fi


# if [ "$save" = "1" ]; then
#     # save a file
#     set -- --chooser-file="$out" "$path"
# elif [ "$directory" = "1" ]; then
#     # upload files from a directory
#     set -- --chooser-file="$out" --cwd-file="$out"".1" "$path"
# elif [ "$multiple" = "1" ]; then
#     # upload multiple files
#     set -- --chooser-file="$out" "$path"
# else
#     # upload only 1 file
#     set -- --chooser-file="$out" "$path"
# fi

# command="$TERMCMD $cmd"
# for arg in "$@"; do
#     # escape double quotes
#     escaped=$(printf "%s" "$arg" | sed 's/"/\\"/g')
#     # escape special
#     command="$command \"$escaped\""
# done

# sh -c "$command"

# if [ "$directory" = "1" ]; then
#     if [ ! -s "$out" ] && [ -s "$out"".1" ]; then
#         cat "$out"".1" > "$out"
#         rm "$out"".1"
#     else
#         rm "$out"".1"
#     fi
# fi

# '';
			# };
		};
	};
	
	# ========== WAYBAR ==========
	programs.waybar = {
		enable = true;
		systemd.enable = true;
		style = ''
			* {
				border: none;
				border-radius: 0;
				font-family: "FiraCode Nerd Font Mono";
				font-weight: bold;
				font-size: 14px;
				min-height: 0;
			}

			window#waybar {
				background: #060606;
				color: #f6f6f6;
			}

			#custom-launcher {
				padding: 0 10px 0 12px;
				color: #61d6d6;
				font-size: 20px;
			}

			#custom-launcher:hover {
				background: #363636;
			}

			#workspaces button {
				padding: 0 8px;
				color: #d6d6d6;
				background: transparent;
			}

			#workspaces button:hover {
				background: #363636;
			}

			#workspaces button.active {
				color: #88C0D0;
				background: #363636;
			}

			#workspaces button.focused {
				color: #d76667;
				background: #363636;
				font-weight: bold;
			}

			#workspaces button.empty {
				color: #767676;
			}

			#workspaces button.current_output {
				opacity: 1;
			}

			#workspaces button:not(.current_output) {
				opacity: 0.6;
			}

			#window {
				padding: 0 15px;
				color: #88C0D0;
				font-weight: bold;
				font-style: italic;
			}

			window#waybar.empty #window {
				background-color: transparent;
				color: #767676;
				font-style: normal;
			}

			window#waybar.solo #window {
				color: #A3BE8C;
			}

			#tray, #language, #pulseaudio, #network, #cpu, #memory, #clock {
				padding: 0 10px;
			}

			#language {
				color: #B48EAD;
				background: #2E3440;
			}

			#language:hover {
				background: #3B4252;
			}

			#pulseaudio {
				color: #EBCB8B;
			}

			#pulseaudio.muted {
				color: #4C566A;
			}

			#network {
				color: #81A1C1;
			}

			#network.disconnected {
				color: #BF616A;
			}

			#cpu {
				color: #D08770;
			}

			#memory {
				color: #A3BE8C;
			}

			#clock {
				color: #88C0D0;
				font-weight: bold;
			}

			#tray {
				color: #5E81AC;
			}

			#tray > .passive {
				-gtk-icon-effect: dim;
			}

			#tray > .needs-attention {
				-gtk-icon-effect: highlight;
				color: #BF616A;
			}
		'';

		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 30;
				spacing = 4;

				modules-left = [ "custom/launcher" "niri/workspaces" ];
				modules-center = [ "niri/window" ];
				modules-right = [ "tray" "niri/language" "pulseaudio" "network" "cpu" "memory" "clock" ];

				"custom/launcher" = {
					format = "";
					on-click = "sh -c rofi -show drun";
					tooltip = false;
				};

				"niri/workspaces" = {
					format = "{icon}";
					format-icons = {
						"focused"= "󰮯";
						"active"= "󰮯";
						"default"= "󰊠";
						"empty"= "󰝦";
					};
					disable-click = false;
					current-only = false;
					all-outputs = false;
				};

				"niri/window" = {
					format = "{title}";
					rewrite = {
						"(.*) - Mozilla Firefox"= "🌎 $1";
						"(.*) - Kitty"= " $1";
						"kitty"= " Terminal";
					};
					separate-outputs = false;
					icon = false;
				};

				"niri/language" = {
					format = "{}";
					format-en = "🇺🇸 EN";
					format-ru = "🇷🇺 RU";
					tooltip = false;
				};

				"tray" = {
					icon-size = 16;
					spacing = 8;
				};

				"pulseaudio" = {
					format = "{volume}% {icon}";
					format-bluetooth = "{volume}% {icon}";
					format-bluetooth-muted = "󰸈 {icon}";
					format-muted = "󰸈";
					format-icons = {
						default = [ "󰕿" "󰖀" "󰕾" ];
					};
					on-click = "pavucontrol";
					tooltip-format = "{desc}";
				};

				"network" = {
					format-wifi = "{essid} 󰖩";
					format-ethernet = "󰈀";
					format-disconnected = "󰖪";
					tooltip-format = "{ifname}: {ipaddr}/{cidr}";
					tooltip-format-wifi = "{essid} ({signalStrength}%) 󰖩";
				};

				"cpu" = {
					format = "󰍛 {usage}%";
					interval = 2;
					tooltip = false;
				};

				"memory" = {
					format = "󰍛 {}%";
					interval = 2;
				};

				"clock" = {
					format = "{:%H:%M:%S}";
					tooltip-format = "{:%A, %d %B %Y}\n<tt><small>{calendar}</small></tt>";
					format-alt = "{:%d/%m}";
					interval = 1;
				};
			};
		};
	};
	
	# ========== NIRI ==========
	programs.niri = {
		settings = {
			clipboard.disable-primary = false;
			screenshot-path = "~/Cooltuff/Pictures/Screenshots/%Y-%m-%d %H:%M:%S.png";
			input = {
				focus-follows-mouse.enable = true;
				mod-key = "Super";
				keyboard.repeat-delay = 450;
				keyboard.repeat-rate = 30;
				keyboard.xkb = {
					layout = "us,ru";
					options = "grp:alt_shift_toggle";
				};
			};

			layout = {
				focus-ring.enable = false;
				border = {
					enable = true;
					width = 4;
					active.color = "#d76667";
					inactive.color = "#363636";
				};
				gaps = 30;
				struts = {
					left = 10;
					top = -10;
					right = 10;
					bottom = -10;
				};
			};
			
			binds = {
				"Mod+Shift+Slash" = { action.show-hotkey-overlay = {}; };
				
				"Mod+Q" = { action.close-window = {}; };
				"Mod+Tab" = { action.toggle-overview = {}; };
				"Mod+Return" = { action.spawn = [ "kitty" ]; };
				"Mod+T" = { action.spawn = [ "kitty" ]; };
				"MOD+Y" = { action.spawn = [ "kitty" "yazi" ]; hotkey-overlay.title = "File Manager: Yazi"; };
				"Mod+R" = { action.spawn-sh = [ "rofi -show drun" ]; };
				"Mod+Alt+L" = { action.spawn = [ "swaylock" ]; };

				"Mod+1" = { action.focus-workspace = 1; };
				"Mod+2" = { action.focus-workspace = 2; };
				"Mod+3" = { action.focus-workspace = 3; };
				"Mod+4" = { action.focus-workspace = 4; };
				"Mod+5" = { action.focus-workspace = 5; };
				"Mod+6" = { action.focus-workspace = 6; };
				"Mod+7" = { action.focus-workspace = 7; };
				"Mod+8" = { action.focus-workspace = 8; };
				"Mod+9" = { action.focus-workspace = 9; };

				"Mod+Shift+1" = { action.move-column-to-workspace = 1; };
				"Mod+Shift+2" = { action.move-column-to-workspace = 2; };
				"Mod+Shift+3" = { action.move-column-to-workspace = 3; };
				"Mod+Shift+4" = { action.move-column-to-workspace = 4; };
				"Mod+Shift+5" = { action.move-column-to-workspace = 5; };
				"Mod+Shift+6" = { action.move-column-to-workspace = 6; };
				"Mod+Shift+7" = { action.move-column-to-workspace = 7; };
				"Mod+Shift+8" = { action.move-column-to-workspace = 8; };
				"Mod+Shift+9" = { action.move-column-to-workspace = 9; };

				"Mod+Up" = { action.focus-window-or-workspace-up = {}; };
				"Mod+Down" = { action.focus-window-or-workspace-down = {}; };
				"Mod+Left" = { action.focus-column-left = {}; };
				"Mod+Right" = { action.focus-column-right = {}; };
				"Mod+Shift+Up" = { action.move-window-up-or-to-workspace-up = {}; };
				"Mod+Shift+Down" = { action.move-window-down-or-to-workspace-down = {}; };
				"Mod+Shift+Left" = { action.move-column-left = {}; };
				"Mod+Shift+Right" = { action.move-column-right = {}; };

				"Mod+Home" = { action.focus-column-first = {}; };
				"Mod+End" = { action.focus-column-last = {}; };
				"Mod+Ctrl+Home" = { action.move-column-to-first = {}; };
				"Mod+Ctrl+End" = { action.move-column-to-last = {}; };

				"Mod+Page_Down" = { action.focus-workspace-down = {}; };
				"Mod+Page_Up" = { action.focus-workspace-up = {}; };
				"Mod+Shift+Page_Down" = { action.move-window-to-workspace-down = {}; };
				"Mod+Shift+Page_Up" = { action.move-window-to-workspace-up = {}; };

				"Mod+Ctrl+Page_Down" = { action.move-workspace-down = {}; };
				"Mod+Ctrl+Page_Up" = { action.move-workspace-up = {}; };

				"Mod+WheelScrollRight" = { action.focus-column-right = {}; };
				"Mod+WheelScrollLeft" = { action.focus-column-left = {}; };
				"Mod+Ctrl+WheelScrollRight" = { action.move-column-right = {}; };
				"Mod+Ctrl+WheelScrollLeft" = { action.move-column-left = {}; };

				"Mod+Shift+WheelScrollDown" = { action.focus-column-right = {}; };
				"Mod+Shift+WheelScrollUp" = { action.focus-column-left = {}; };
				"Mod+Ctrl+Shift+WheelScrollDown" = { action.move-column-right = {}; };
				"Mod+Ctrl+Shift+WheelScrollUp" = { action.move-column-left = {}; };

				"Mod+F" = { action.maximize-column = {}; };
				"Mod+Shift+F" = { action.fullscreen-window = {}; };
				"Mod+space" = { action.toggle-window-floating = {}; };
				"Mod+Shift+space" = { action.switch-focus-between-floating-and-tiling = {}; };
				"Print" = { action.screenshot = {}; };
				"Ctrl+Mod+Alt+Q" = { action.quit = {}; };
				"Ctrl+Alt+Delete" = { action.quit = {}; };
				"Mod+Shift+P" = { action.power-off-monitors = {}; };
			};
		};
	};

	wayland.windowManager.mango = {
		enable = true;
		settings = ''
            blur=0
            blur_layer=0
            blur_optimized=1
            blur_params_num_passes = 2
            blur_params_radius = 5
            blur_params_noise = 0.02
            blur_params_brightness = 0.9
            blur_params_contrast = 0.9
            blur_params_saturation = 1.2
            
            shadows = 0
            layer_shadows = 0
            shadow_only_floating = 1
            shadows_size = 10
            shadows_blur = 15
            shadows_position_x = 0
            shadows_position_y = 0
            shadowscolor= 0x000000ff
            
            border_radius=0
            no_radius_when_single=0
            focused_opacity=1.0
            unfocused_opacity=1.0
            
            # Animation Configuration(support type:zoom,slide)
            # tag_animation_direction: 1-horizontal,0-vertical
            animations=1
            layer_animations=1
            animation_type_open=none
            animation_type_close=none
            
            animation_fade_in=1
            animation_fade_out=1
            tag_animation_direction=0
            zoom_initial_ratio=0.3
            zoom_end_ratio=0.8
            fadein_begin_opacity=0.8
            fadeout_begin_opacity=0.5
            animation_duration_move=500
            animation_duration_open=400
            animation_duration_tag=350
            animation_duration_close=400
            animation_duration_focus=400
            animation_curve_open=0.46,1.0,0.29,1
            animation_curve_move=0.46,1.0,0.29,1
            animation_curve_tag=0.46,1.0,0.29,1
            animation_curve_close=0.08,0.92,0,1
            animation_curve_focus=0.46,1.0,0.29,1
            animation_curve_opafadeout=0.4,0.3,0.2,0.1
            animation_curve_opafadein=0.46,1.0,0.29,1
            
            # Scroller Layout Setting
            scroller_structs=20
            scroller_default_proportion=0.95
            scroller_focus_center=0
            scroller_prefer_center=1
            edge_scroller_pointer_focus=1
            scroller_default_proportion_single=0.95
            scroller_proportion_preset=0.95,0.5
            
            # Master-Stack Layout Setting
            new_is_master=1
            default_mfact=0.55
            default_nmaster=1
            smartgaps=0
            
            # Overview Setting
            hotarea_size=10
            enable_hotarea=1
            ov_tab_mode=0
            overviewgappi=5
            overviewgappo=30
            
            # Misc
            no_border_when_single=0
            axis_bind_apply_timeout=100
            focus_on_activate=1
            idleinhibit_ignore_visible=0
            sloppyfocus=1
            warpcursor=1
            focus_cross_monitor=0
            focus_cross_tag=0
            enable_floating_snap=1
            snap_distance=30
            cursor_size=24
            drag_tile_to_tile=1
            
            repeat_rate=30
            repeat_delay=400
            numlockon=0
            xkb_rules_layout=us,ru
            xkb_rules_options=grp:lalt_lshift_toggle
            
            disable_trackpad=1
            tap_to_click=1
            tap_and_drag=1
            drag_lock=1
            trackpad_natural_scrolling=0
            disable_while_typing=0
            left_handed=0
            middle_button_emulation=0
            swipe_min_threshold=1
            
            mouse_natural_scrolling=0
            
            gappih=20
            gappiv=20
            gappoh=20
            gappov=20
            scratchpad_width_ratio=0.8
            scratchpad_height_ratio=0.9
            borderpx=4
            rootcolor=0x201b14ff
            bordercolor=0x444444ff
            focuscolor=0xc9b890ff
            maximizescreencolor=0x89aa61ff
            urgentcolor=0xad401fff
            scratchpadcolor=0x516c93ff
            globalcolor=0xb153a7ff
            overlaycolor=0x14a57cff
            
            # layout support:
            # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
            tagrule=id:1,layout_name:scroller
            tagrule=id:2,layout_name:scroller
            tagrule=id:3,layout_name:scroller
            tagrule=id:4,layout_name:scroller
            tagrule=id:5,layout_name:scroller
            tagrule=id:6,layout_name:scroller
            tagrule=id:7,layout_name:scroller
            tagrule=id:8,layout_name:scroller
            tagrule=id:9,layout_name:scroller
            
            # Key Bindings
            # key name refer to `xev` or `wev` command output,
            # mod keys name: super,ctrl,alt,shift,none
            
            # reload config
            bind=SUPER,r,reload_config
            
            bind=Alt,space,spawn,rofi -show drun
            bind=SUPER,Return,spawn,kitty
            
            # exit
            bind=CTRL+SUPER+ALT,q,quit
            bind=SUPER,q,killclient,
            
            # switch window focus
            bind=SUPER,Tab,focusstack,next
            bind=SUPER,Left,focusdir,left
            bind=SUPER,Right,focusdir,right
            bind=SUPER,Up,focusdir,up
            bind=SUPER,Down,focusdir,down
            
            # swap window
            bind=SUPER+SHIFT,Up,exchange_client,up
            bind=SUPER+SHIFT,Down,exchange_client,down
            bind=SUPER+SHIFT,Left,exchange_client,left
            bind=SUPER+SHIFT,Right,exchange_client,right
            
            # switch window status
            bind=SUPER,g,toggleglobal,
            bind=ALT,Tab,toggleoverview,
            bind=SUPER,space,togglefloating,
            bind=ALT,f,togglemaximizescreen,
            bind=SUPER,f,togglefullscreen,
            bind=SUPER+SHIFT,f,togglefakefullscreen,
            bind=SUPER,i,minimized,
            bind=SUPER,o,toggleoverlay,
            bind=SUPER+SHIFT,I,restore_minimized
            bind=ALT,z,toggle_scratchpad
            
            # scroller layout
            bind=ALT,e,set_proportion,1.0
            bind=ALT,x,switch_proportion_preset,
            
            # switch layout
            bind=SUPER,n,switch_layout
            
            # tag switch
            # bind=SUPER,Left,viewtoleft,0
            bind=CTRL,Left,viewtoleft_have_client,0
            # bind=SUPER,Right,viewtoright,0
            bind=CTRL,Right,viewtoright_have_client,0
            bind=CTRL+SUPER,Left,tagtoleft,0
            bind=CTRL+SUPER,Right,tagtoright,0
            
            bind=SUPER,1,view,1,0
            bind=SUPER,2,view,2,0
            bind=SUPER,3,view,3,0
            bind=SUPER,4,view,4,0
            bind=SUPER,5,view,5,0
            bind=SUPER,6,view,6,0
            bind=SUPER,7,view,7,0
            bind=SUPER,8,view,8,0
            bind=SUPER,9,view,9,0
            
            # tag: move client to the tag and focus it
            # tagsilent: move client to the tag and not focus it
            # bind=Alt,1,tagsilent,1
            bind=SUPER+SHIFT,1,tag,1,0
            bind=SUPER+SHIFT,2,tag,2,0
            bind=SUPER+SHIFT,3,tag,3,0
            bind=SUPER+SHIFT,4,tag,4,0
            bind=SUPER+SHIFT,5,tag,5,0
            bind=SUPER+SHIFT,6,tag,6,0
            bind=SUPER+SHIFT,7,tag,7,0
            bind=SUPER+SHIFT,8,tag,8,0
            bind=SUPER+SHIFT,9,tag,9,0
            
            # gaps
            bind=ALT+SHIFT,X,incgaps,1
            bind=ALT+SHIFT,Z,incgaps,-1
            bind=ALT+SHIFT,R,togglegaps
            
            # movewin
            # bind=CTRL+SHIFT,Up,movewin,+0,-50
            # bind=CTRL+SHIFT,Down,movewin,+0,+50
            # bind=CTRL+SHIFT,Left,movewin,-50,+0
            # bind=CTRL+SHIFT,Right,movewin,+50,+0
            
            # resizewin
            # bind=CTRL+ALT,Up,resizewin,+0,-50
            # bind=CTRL+ALT,Down,resizewin,+0,+50
            # bind=CTRL+ALT,Left,resizewin,-50,+0
            # bind=CTRL+ALT,Right,resizewin,+50,+0
            
            # Mouse Button Bindings
            # NONE mode key only work in ov mode
            mousebind=SUPER,btn_left,moveresize,curmove
            # mousebind=NONE,btn_middle,togglemaximizescreen,0
            mousebind=SUPER,btn_right,moveresize,curresize
            mousebind=NONE,btn_left,toggleoverview,1
            mousebind=NONE,btn_right,killclient,0
            
            # Axis Bindings
            axisbind=SUPER,UP,viewtoleft_have_client
            axisbind=SUPER,DOWN,viewtoright_have_client
            
            
            # layer rule
            layerrule=animation_type_open:zoom,layer_name:rofi
            layerrule=animation_type_close:zoom,layer_name:rofi
            
		'';
	};
	wayland.windowManager.hyprland = {
		enable = true;
		systemd.enable = true;
		xwayland.enable = true;
		plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
		      csgo-vulkan-fix
		      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.
		    ];
 		settings = {
# 			decoration = {
# 				shadow_offset = "0 5";
# 				"col.shadow" = "rgba(00000099)";
# 			};
# 
 			"$mod" = "SUPER";
# 
 			bind = [
 				# Execute Rofi with only the SUPER key
 				"$mod, Super_L, exec, pkill rofi || rofi -show drun"
 
 				"$mod, left, movefocus, l"
 				"$mod, right, movefocus, r"
 				"$mod, up, movefocus, u"
 				"$mod, down, movefocus, d"
 				"$mod, 1, workspace, 1"
 				"$mod, 2, workspace, 2"
 				"$mod, 3, workspace, 3"
 				"$mod, 4, workspace, 4"
 				"$mod, 5, workspace, 5"
 				"$mod, 6, workspace, 6"
 				"$mod, 7, workspace, 7"
 				"$mod, 8, workspace, 8"
 				"$mod, 9, workspace, 9"
 				"$mod, 0, workspace, 10"
 				"$mod SHIFT, 1, movetoworkspace, 1"
 				"$mod SHIFT, 2, movetoworkspace, 2"
 				"$mod SHIFT, 3, movetoworkspace, 3"
 				"$mod SHIFT, 4, movetoworkspace, 4"
 				"$mod SHIFT, 5, movetoworkspace, 5"
 				"$mod SHIFT, 6, movetoworkspace, 6"
 				"$mod SHIFT, 7, movetoworkspace, 7"
 				"$mod SHIFT, 8, movetoworkspace, 8"
 				"$mod SHIFT, 9, movetoworkspace, 9"
 				"$mod SHIFT, 0, movetoworkspace, 10"
 			
 				# ""
 				"$mod, space, togglefloating,"
 
 				"$mod, Q, exec, killactive,"
 				"$mod, T, exec, kitty,"
 				"$mod, Return, exec, kitty,"
 				"CTRL $mod ALT, Q, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
 			];

			# Startup Apps
			# exec-once = [
				# "waybar"
			# ];

			bindm = [
				# mouse movements
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizewindow"
				# "$mod ALT, mouse:272, resizewindow"
			];
	 	};
	};
	home.activation.reloadNiri = lib.hm.dag.entryAfter ["writeBoundary"] ''
		if command -v niri >/dev/null 2>&1; then
		niri msg action reload-config 2>/dev/null || true
		fi
	'';
}
