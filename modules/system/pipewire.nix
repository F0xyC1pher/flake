{
	services.pipewire = {
		enable = true;
		pulse.enable = true;
		wireplumber.enable = true;
		jack = {
			enable = true;
			rtkit = true;
		};
		alsa = {
			enable = true;
			support32Bit = true;
		};

		extraConfig = {
			pipewire."10-low-latency" = {
				"context.properties" = {
					# Для качества лучше 48000 или 96000, но проверьте поддержку звуковой картой
					"default.clock.rate" = 48000; # или 96000
					"default.clock.quantum" = 128; # Баланс между задержкой и стабильностью
					"default.clock.min-quantum" = 64;
					"default.clock.max-quantum" = 2048;

					# Приоритет реального времени
					"default.clock.allowed-rates" = [48000 96000];
				};

				"context.modules" = [
					{
						name = "libpipewire-module-protocol-native";
						args = {
							"rt.prio" = 88; # Высокий приоритет для реального времени
						};
					}
				];
			};

			pipewire-pulse."10-low-latency" = {
				"pulse.properties" = {
					"server.address" = ["unix:native"];
					"pulse.min.req" = "64/48000";
					"pulse.default.req" = "128/48000";
					"pulse.max.req" = "2048/48000";
					"pulse.min.quantum" = "64/48000";
					"pulse.max.quantum" = "2048/48000";
				};

				"stream.properties" = {
					"node.latency" = "128/48000";
					"resample.quality" = 10; # Максимальное качество ресемплинга
					"resample.disable" = false;
				};
			};

			wireplumber."10-low-latency" = {
				"monitor.alsa.rules" = [
					{
						matches = [{"device.name" = "~alsa_card.*";}];
						actions = {
							update-props = {
								"api.alsa.period-size" = 64;
								"api.alsa.headroom" = 2048;
								"api.alsa.disable-mmap" = false;
								"api.alsa.use-chmap" = true;
								"session.suspend-timeout-seconds" = 0; # Не отключать устройство
							};
						};
					}
				];
			};
		};
	};
}
