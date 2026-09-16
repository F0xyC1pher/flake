{
	lib,
	vars,
	pkgs,
	...
}: let
	audioCfg = vars.host.hardware.audio;
	outCfg = audioCfg.output;
	inCfg = audioCfg.input;
	# outFormatStr = "${outCfg.format.prefix}${toString outCfg.format.value}_${outCfg.format.suffix}";
	inFormatStr = "${inCfg.format.prefix}${toString inCfg.format.value}_${inCfg.format.suffix}";
	quantumMap = {
		"44100" = 512;
		"48000" = 512;
		"88200" = 1024;
		"96000" = 1024;
		"176400" = 2048;
		"192000" = 2048;
	};
	outRateStr = toString outCfg.rate.value;
	inRateStr = toString inCfg.rate.value;
	outQuantum =
		if quantumMap ? ${outRateStr}
		then quantumMap.${outRateStr}
		else 1024;
	inQuantum =
		if quantumMap ? ${inRateStr}
		then quantumMap.${inRateStr}
		else 512;
in {
	security.rtkit.enable = lib.mkDefault true;

	services.pipewire = {
		enable = true;
		audio.enable = true;

		pulse.enable = true;
		wireplumber.enable = true;
		jack.enable = true;
		alsa = {
			enable = true;
			support32Bit = true;
		};

		extraLadspaPackages =
			lib.optionals inCfg.noiseCancellation [
				pkgs.rnnoise-plugin
				pkgs.ladspaPlugins
			];

		extraConfig = {
			# ===================== глобальный конфиг пипеваре =====================
			pipewire."98-low-latency" = {
				"context.properties" = {
					"default.clock.rate" = outCfg.rate.value;
					"default.clock.allowed-rates" = [
						192000
						176400
						96000
						88200
						48000
						44100
					];

					# Динамический квант: от 512 до 2048
					"default.clock.min-quantum" = 512;
					"default.clock.quantum" = outQuantum;
					"default.clock.max-quantum" = 2048;
					"default.clock.quantum-limit" = 8192;

					"clock.power-of-two-quantum" = true;
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

			# ===================== глушение пердежа микрофона =====================
			pipewire."98-rnnoise" =
				lib.mkIf inCfg.noiseCancellation {
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
									"audio.rate" = inCfg.rate.value;
									"audio.format" = inFormatStr;
									"audio.allowed-formats" = [inFormatStr];
									"node.passive" = true;
									"audio.channels" = 1;
									"audio.position" = ["MONO"];
									"node.autoconnect" = true;
									"node.force-quantum" = inQuantum;
								};

								"playback.props" = {
									"node.name" = "rnnoise";
									"audio.rate" = inCfg.rate.value;
									"audio.format" = inFormatStr;
									"audio.allowed-formats" = [inFormatStr];
									"media.class" = "Audio/Source";
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

			# ===================== дрочка =====================
			jack."98-low-latency" = {
				"jack.properties" = {
					"jack.default-quantum" = outQuantum;
					"node.lock-quantum" = false;
					"jack.show-monitor" = true;
					"jack.merge-monitor" = false;
				};
			};

			# ===================== пипеваре-рельсотрон =====================
			pipewire-pulse."98-low-latency" = {
				"context.properties" = [
					{
						name = "libpipewire-module-protocol-pulse";
						args = {};
					}
				];
				"pulse.properties" = {
					"pulse.min.req" = "512/48000";
					"pulse.default.req" = "512/48000";
					"pulse.max.req" = "2048/48000";
					"pulse.min.quantum" = "512/48000";
					"pulse.max.quantum" = "2048/48000";
				};

				"stream.properties" = {
					"resample.quality" = 10;
					"pulse.disable-latency-bias" = true;
				};
			};
		};

		wireplumber.extraConfig."99-disable-suspend" = {
			"monitor.alsa.rules" = [
				{
					matches = [
						{"node.name" = "~alsa_input.*";}
						{"node.name" = "~alsa_output.*";}
					];
					actions = {
						update-props = {
							"session.suspend-timeout-seconds" = 0;
						};
					};
				}
			];
		};

		# ===================== марио (сальса) =====================
		wireplumber.extraConfig."99-alsa-output" = {
			"monitor.alsa.rules" = [
				{
					matches = [{"node.name" = "~alsa_output.*";}];
					actions = {
						update-props = {
							"resample.quality" = 10;
							"node.lock-quantum" = false;

							# Настройки под Xeon X3450
							"api.alsa.headroom" = 256;
							"api.alsa.disable-mmap" = false;
							"api.alsa.disable-tsched" = false;
							"api.alsa.disable-batch" = false;

							"api.alsa.use-acp" = false;
							"api.alsa.use-ucm" = false;
							"api.alsa.ignore-dB" = true;
						};
					};
				}
			];
		};

		# ===================== ALSA Вход (Микрофон) =====================
		wireplumber.extraConfig."99-alsa-input" = {
			"monitor.alsa.rules" = [
				{
					matches = [{"node.name" = "~alsa_input.*";}];
					actions = {
						update-props = {
							"audio.rate" = inCfg.rate.value;
							"audio.format" = inFormatStr;
							"audio.allowed-formats" = [inFormatStr];
							"node.lock-quantum" = false;
						};
					};
				}
			];
		};

		wireplumber.extraConfig."99-bluez" = {
			"monitor.bluez.rules" = [
				{
					matches = [{"device.name" = "~bluez_card.*";}];
					actions = {
						update-props = {
							"session.suspend-timeout-seconds" = 0;
							"resample.quality" = 10;
						};
					};
				}
				{
					matches = [{"node.name" = "~bluez_output.*";}];
					actions = {
						update-props = {
							"node.lock-quantum" = false;
							"resample.quality" = 10;
						};
					};
				}
			];
		};
	};
}
