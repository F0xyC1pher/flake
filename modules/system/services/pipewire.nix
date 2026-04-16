{lib, ...}: {
	security.rtkit.enable = lib.mkDefault true;
	services.pipewire = {
		enable = true;
		pulse.enable = true;
		wireplumber.enable = true;
		jack.enable = true;
		alsa = {
			enable = true;
			support32Bit = true;
		};

		extraConfig = {
			pipewire."10-low-latency" = {
				"context.properties" = {
					# Для качества лучше 48000 или 96000, но проверьте поддержку звуковой картой
					"default.clock.rate" = 48000; # или 96000
					# Разрешённые частоты
					"default.clock.allowed-rates" = [44100 48000 88200 96000 192000];
					"default.clock.min-quantum" = 128; # 64/192000 = 0.33 мс (минимальная задержка)
					"default.clock.quantum" = 256; # 256/192000 = 1.33 мс (стабильнее чем 128)
					"default.clock.max-quantum" = 1024; # 2048/192000 = 10.6 мс
					"default.clock.quantum-limit" = 4096;

					"core.daemon" = true;
					"link.max-buffers" = 64;
					"clock.power-of-two-quantum" = false;
					"link.follow-exclusive-outputs" = false;

					#"cpu.affinity" = [2 3 6 7];

					# Настройка приоритетов для потоков
					# "default.video.width" = 640;
					# "default.video.height" = 480;
					# "default.video.rate.num" = 25;
					# "default.video.rate.denom" = 1;
					# JACK специфичные настройки
					"jack.default.rate" = 48000;
					"jack.default.quantum" = 256;
					# Дополнительные оптимизации
					"log.level" = 0; # Минимум логов для производительности
				};

				"context.modules" = [
					{
						name = "libpipewire-module-rtkit";
						args = {
							"nice.level" = -11;
							"rt.prio" = 88;
							"rt.time.soft" = 200000;
							"rt.time.hard" = 200000;
						};
					}
				];
			};

			pipewire-pulse."10-low-latency" = {
				"pulse.properties" = {
					"server.address" = ["unix:native"];
					"pulse.min.req" = "128/48000";
					"pulse.default.req" = "256/48000";
					"pulse.max.req" = "1024/48000";
					"pulse.min.quantum" = "128/48000";
					"pulse.max.quantum" = "1024/48000";
				};

				"stream.properties" = {
					"node.latency" = "256/48000";
					"resample.quality" = 10; # Максимальное качество ресемплинга
					"resample.disable" = false;
					# Дополнительные оптимизации
					"node.autoconnect" = true;
					"node.want-driver" = true;
				};
				# Правила для приложений
				# "pulse.rules" = [
				# {
				# "matches" = [{"application.process.binary" = "firefox";}];
				# "actions" = {
				# 	"update-props" = {
				# 		"pulse.min.req" = "256/48000";
				# 		"node.latency" = "256/48000";
				# 	};
				# };
				# }
				# ];
			};
		};
		wireplumber.extraConfig = {
			"10-low-latency" = {
				"wireplumber.settings" = {
					"log.level" = 2;
					"default-configure" = true;
					"link-factory.default-node-flags" = ["passive"];
				};
				"monitor.alsa.rules" = [
					{
						matches = [{"device.name" = "~alsa_card.*";}];
						actions = {
							update-props = {
								"api.alsa.period-size" = 128;
								"api.alsa.period-num" = 2;
								# "api.alsa.headroom" = 4096;
								# "api.alsa.disable-mmap" = false;
								# "api.alsa.mmap" = true;
								# "api.alsa.use-chmap" = true;

								# Качество ресемплинга
								"resample.quality" = 5;
								"resample.disable" = false;
								# Приоритеты
								"priority.driver" = 1000;
								"priority.session" = 1000;
								# Отключаем энергосбережение
								"session.suspend-timeout-seconds" = 0;
								"device.suspend-timeout-seconds" = 0;
								# Формат с плавающей точкой для лучшего качества
								"audio.format" = "FLOAT32LE";
							};
						};
					}
				];
			};
		};
	};
}
