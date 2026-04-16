{
	lib,
	vars,
	...
}: let
	rate = vars.hardware.sound.rate; # твоя переменная: 48000, 96000, 192000 и т.д.

	baseRate = 48000;
	baseQuantum = 256; # ~5.33 мс при 48 кГц — хороший баланс

	rawQuantum = builtins.ceil (baseQuantum * rate / baseRate);

	quantum =
		if rawQuantum <= 64
		then 64
		else if rawQuantum <= 128
		then 128
		else if rawQuantum <= 256
		then 256
		else if rawQuantum <= 512
		then 512
		else if rawQuantum <= 1024
		then 1024
		else 2048;

	minQuantum = quantum / 2;
	maxQuantum = quantum * 4;
in {
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
			# ==================== ГЛОБАЛЬНЫЕ НАСТРОЙКИ PIPEWIRE ====================
			pipewire."10-low-latency" = {
				"context.properties" = {
					"default.clock.rate" = rate;
					"default.clock.allowed-rates" = [44100 48000 88200 96000 192000];

					"default.clock.min-quantum" = minQuantum;
					"default.clock.quantum" = quantum;
					"default.clock.max-quantum" = maxQuantum;
					"default.clock.quantum-limit" = 4096; # важно для стабильности

					"clock.power-of-two-quantum" = true;

					"log.level" = 0;
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

			# ==================== ОПТИМИЗАЦИЯ ДЛЯ JACK ====================
			jack."10-low-latency" = {
				"jack.properties" = {
					# Основной buffer size (quantum) для всех JACK-клиентов
					"jack.default-quantum" = quantum;

					# Фиксируем quantum — очень важно для стабильности JACK-приложений
					"node.lock-quantum" = true;

					# Если хочешь жёстко зафиксировать (некоторые DAW любят это)
					# "node.force-quantum" = quantum;

					# Дополнительные полезные опции
					"jack.show-monitor" = true; # показывает монитор в qpwgraph / catia
					"jack.merge-monitor" = false;
				};
			};

			# ==================== PIPEWIRE-PULSE ====================
			pipewire-pulse."10-low-latency" = {
				"pulse.properties" = {
					"pulse.min.req" = "${toString minQuantum}/${toString rate}";
					"pulse.default.req" = "${toString quantum}/${toString rate}";
					"pulse.max.req" = "${toString maxQuantum}/${toString rate}";
				};

				"stream.properties" = {
					"node.latency" = "${toString quantum}/${toString rate}";
					"resample.quality" = 10;
				};
			};
		};

		# ==================== WIREPLUMBER (ALSA) ====================
		wireplumber.extraConfig."10-low-latency" = {
			"monitor.alsa.rules" = [
				{
					matches = [{"device.name" = "~alsa_card.*";}];
					actions = {
						update-props = {
							"api.alsa.period-size" = minQuantum;
							"api.alsa.period-num" = 2;
							"session.suspend-timeout-seconds" = 0;
							"device.suspend-timeout-seconds" = 0;
							"audio.format" = "FLOAT32LE";
							"resample.quality" = 5;
						};
					};
				}
			];
		};
	};
}
