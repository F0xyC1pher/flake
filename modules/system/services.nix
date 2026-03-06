{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
#	========== SERVICES ==========
	services = {
		dbus.enable = true;
		gnome.gnome-keyring.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
		
		pipewire = {
			enable = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
			alsa = {	
				enable = true;
				support32Bit = true;
			};
			extraConfig = {
				pipewire."92-low-latency" = {
					"context.properties" = {
						"default.clock.rate" = 48000;
						"default.clock.quantum" = 32;
						"default.clock.min-quantum" = 32;
						"default.clock.max-quantum" = 32;
					};
				};
				pipewire-pulse."92-low-latency" = {
					context.modules = [
						{
							name = "libpipewire-module-protocol-pulse";
							args = {
								pulse.min.req = "32/48000";
								pulse.default.req = "32/48000";
								pulse.max.req = "32/48000";
								pulse.min.quantum = "32/48000";
								pulse.max.quantum = "32/48000";
							};
						}
					];
					stream.properties = {
						node.latency = "32/48000";
						resample.quality = 1;
					};
				};
			};
		};
		
		xserver = {
			enable = true;
			videoDrivers = ["nvidia"];
			xkb = {
				layout = "us,ru";
				model = "pc86";
				options = "grp:lalt_lshift_toggle;";
			};
		};
		
		mpd = {
			enable = true;
			user = "${vars.userName}";
			settings = {
				music_directory = "/home/${vars.userName}/CoolStuff/Music";
				
				# Вот как теперь задаётся audio_output (это список, можно несколько блоков)
				audio_output = [
					{
						type = "pipewire";
						name = "PipeWire Output";
						# Дополнительные параметры, если нужно (опционально):
						# format = "44100:16:2";      # пример
						# mixer_type = "software";
						# auto_resample = "no";
					}
				];
				# Если нужны другие простые параметры (не блоки), пиши их прямо здесь:
				# restore_paused = "yes";
				# max_playlist_length = "16384";
			};
			# network = {
			#     listenAddress = "any";          # если хочешь разрешить подключения не только с localhost
			#     startWhenNeeded = true;         # systemd socket activation — очень удобно
			#   };
			# Optional:
		#	network.listenAddress = "any"; # if you want to allow non-localhost connections
			startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
		};
		
		greetd = {
			enable = true;
			useTextGreeter = true;
			settings = {
				default_session = {
					command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
					user = "greeter";
				};
			};
		};
	};
	
	systemd.services.mpd.environment = {
		# https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
		XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
	};
}
