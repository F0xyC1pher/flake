{
	lib,
	vars,
	pkgs,
	...
}: let
	rate = vars.hardware.audio.rate.value;
	format = vars.hardware.audio.format;
	quantumMap = {
		"44100" = 512;
		"48000" = 512;
		"88200" = 1024;
		"96000" = 1024;
		"176400" = 2048;
		"192000" = 2048;
	};

	quantum = quantumMap."${toString rate}";
	minQuantum = quantum;
	maxQuantum = quantum * 2;
in {
	security.rtkit.enable = lib.mkDefault true;

	services.pipewire = {
		enable = true;
		systemWide = true;
		audio.enable = true;

		pulse.enable = true;
		wireplumber.enable = true;
		jack.enable = true;
		alsa = {
			enable = true;
			support32Bit = true;
		};

		extraLadspaPackages = [
			pkgs.rnnoise-plugin
			pkgs.ladspaPlugins
		];
		extraConfig = {
			# ==================== глобальный конфиг пипеваре ====================
			pipewire."98-low-latency" = {
				"context.properties" = {
					"default.clock.rate" = rate;
					"default.clock.allowed-rates" = [
						192000
						176400
						96000
						88200
						48000
						44100
					];

					"default.clock.min-quantum" = minQuantum;
					"default.clock.quantum" = quantum;
					"default.clock.max-quantum" = maxQuantum;
					"default.clock.quantum-limit" = 8192;

					"clock.power-of-two-quantum" = true;

					# "log.level" = 0;
				};
			};
			pipewire."98-rt-priority" = {
				"context.modules" = [
					{
						name = "libpipewire-module-rtkit";
						args = {
							"nice.level" = -18;
							"rt.prio" = 89;
							"rt.time.soft" = 200000;
							"rt.time.hard" = 200000;
						};
					}
				];
			};
			# ==================== пипеваре глушение пердежа микрофона ====================
			pipewire."98-rnnoise" = {
				"context.modules" = [
					{
						name = "libpipewire-module-filter-chain";
						args = {
							"node.description" = "RNNoise | Noise Suppressor";
							"media.name" = "RNNoise Professional";

							"filter.graph" = {
								nodes = [
									{
										type = "ladspa";
										name = "rnnoise";
										plugin = "librnnoise_ladspa";
										label = "noise_suppressor_mono";
										control = {
											"VAD Threshold (%)" = 90.0;
											"VAD Grace Period (ms)" = 200;
											"Retroactive VAD Grace (ms)" = 30;
										};
									}
								];
							};

							"capture.props" = {
								"node.name" = "capture.rnnoise";
								"node.passive" = true;
								"audio.rate" = 48000;
								"audio.channels" = 1;
								"audio.position" = ["MONO"];
								"node.autoconnect" = true;
								"stream.dont-remix" = true;
							};

							"playback.props" = {
								"node.name" = "rnnoise";
								"media.class" = "Audio/Source";
								"audio.rate" = 48000;
								"audio.channels" = 1;
								"audio.position" = ["MONO"];

								"node.nick" = "RNNoise";
								"node.description" = "Noise Cancelling";
								"priority.driver" = 2000;
								"priority.session" = 2000;
								"node.priority" = 2000;
								"node.group" = "audio-filter";

								"application.name" = "PipeWire RNNoise";
								"node.icon-name" = "microphone-sensitivity-high";
							};
						};
					}
				];
			};
			# ==================== дрочка ====================
			jack."98-low-latency" = {
				"jack.properties" = {
					"jack.default-quantum" = quantum;
					"node.lock-quantum" = true;
					"node.force-quantum" = quantum;
					"jack.show-monitor" = true;
					"jack.merge-monitor" = false;
				};
			};

			# ==================== пипеваре-рельсотрон ====================
			pipewire-pulse."98-low-latency" = {
				"context.properties" = [
					{
						name = "libpipewire-module-protocol-pulse";
						args = {};
					}
				];
				"pulse.properties" = {
					"pulse.min.req" = "${toString minQuantum}/${toString rate}";
					"pulse.default.req" = "${toString quantum}/${toString rate}";
					"pulse.max.req" = "${toString maxQuantum}/${toString rate}";
					"pulse.min.quantum" = "${toString minQuantum}/${toString rate}";
					"pulse.max.quantum" = "${toString maxQuantum}/${toString rate}";
				};

				"stream.properties" = {
					"node.latency" = "${toString quantum}/${toString rate}";
					"resample.quality" = 10;
				};
			};
		};
		# Disable suspend of Toslink output to prevent audio popping.
		wireplumber.extraConfig."99-disable-suspend" = {
			"monitor.alsa.rules" = [
				{
					matches = [
						{
							"node.name" = "~alsa_input.*";
						}
						{
							"node.name" = "~alsa_output.*";
						}
					];
					actions = {
						update-props = {
							"session.suspend-timeout-seconds" = 0;
						};
					};
				}
			];
		};
		# ==================== марио (сальса) ====================
		wireplumber.extraConfig."99-low-latency" = {
			"monitor.alsa.rules" = [
				{
					# правило для наушников
					matches = [{"node.name" = "~alsa_output.*";}];
					actions = {
						update-props = {
							"api.alsa.period-size" = quantum / 2;
							"api.alsa.period-num" = 3;
							"session.suspend-timeout-seconds" = 0;
							"audio.format" = "${format.prefix}${toString format.value}_${format.suffix}";
							"resample.quality" = 10;
							"audio.rate" = rate;
						};
					};
				}
				{
					# правило для USB микрофона
					matches = [{"node.name" = "~alsa_input.usb*";}];
					actions = {
						update-props = {
							"audio.rate" = 48000;
							"audio.format" = "S16_LE";
							"api.alsa.period-size" = 1024;
							"api.alsa.period-num" = 4;
							"api.alsa.headroom" = 512;
						};
					};
				}
			];
			"monitor.bluez.rules" = [
				{
					matches = [
						{"device.name" = "~bluez_card.*";}
					];
					actions = {
						update-props = {
							"session.suspend-timeout-seconds" = 0;
							"audio.rate" = rate;
							"resample.quality" = 10;
						};
					};
				}
				{
					# Конкретно для вывода звука (Sinks) на BT
					matches = [
						{"node.name" = "~bluez_output.*";}
					];
					actions = {
						update-props = {
							"node.latency" = "${toString quantum}/${toString rate}";
							"node.lock-quantum" = true;
							"api.bluez5.hw-volume" = true;
						};
					};
				}
			];
		};
	};
}
