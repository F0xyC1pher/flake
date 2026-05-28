{
  lib,
  vars,
  pkgs,
  ...
}:
let
  rate = vars.hardware.audio.rate;
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
  minQuantum = quantum / 2;
  maxQuantum = quantum * 2;
in
{
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
                "audio.position" = [ "MONO" ];
                "node.autoconnect" = true;
                "stream.dont-remix" = true;
              };

              "playback.props" = {
                "node.name" = "rnnoise";
                "media.class" = "Audio/Source";
                "audio.rate" = 48000;
                "audio.channels" = 1;
                "audio.position" = [ "MONO" ];

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
            args = { };
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
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/main.lua.d/99-alsa-lowlatency.lua" ''
        alsa_monitor.rules = {
          {
            matches = {{{ "node.name", "matches", "alsa_output.*" }}};
            apply_properties = {
              ["audio.format"] = "${format.prefix}${toString format.value}${format.suffix}",
              ["audio.rate"] = "${toString rate}", -- for USB soundcards it should be twice your desired rate
              ["resample.quality"] = 10,
              ["api.alsa.period-size"] = ${toString (quantum / 2)}, -- defaults to 1024, tweak by trial-and-error
              ["api.alsa.period-num"] = 2,
              -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
              ["session.suspend-timeout-seconds"] = 0,
              ["device.suspend-timeout-seconds"] = 0,
            },
          },
        }
      '')
    ];
    # ==================== марио (сальса) ====================
    # wireplumber.extraConfig."99-low-latency" = {
    # "monitor.alsa.rules" = [
    #   {
    # правило для наушников
    #     matches = [ { "device.name" = "alsa_output.*"; } ];
    #     actions = {
    #       apply-props = {
    #         "api.alsa.period-size" = quantum / 2;
    #         "api.alsa.period-num" = 2;
    #         "session.suspend-timeout-seconds" = 0;
    #         "device.suspend-timeout-seconds" = 0;
    # "audio.format" = "F32LE";
    # "audio.format" = "S32LE";
    # "audio.format" = "S24LE";
    # "audio.format" = "${vars.hardware.audio.format.prefix}${toString vars.hardware.audio.format.value}${vars.hardware.audio.format.suffix}";
    # "audio.format" = "${vars.hardware.audio.format.prefix}${toString vars.hardware.audio.format.value}";
    #         "audio.format" = format;
    #         "resample.quality" = 10;
    #         "audio.rate" = rate;
    #       };
    #     };
    #   }
    # {
    # правило для USB микрофона
    # 	matches = [{"device.name" = "~alsa_card.usb-Audio*";}];
    # 	actions = {
    # 		update-props = {
    # 			"audio.rate" = 48000;
    # 			"audio.format" = "S16LE";
    # 			"api.alsa.period-size" = 1024;
    # 			"api.alsa.period-num" = 2;
    # 			"api.alsa.headroom" = 512;
    # 		};
    # 	};
    # }
    # ];
    #   "monitor.bluez.rules" = [
    #     {
    #       matches = [
    #         { "device.name" = "~bluez_card.*"; }
    #       ];
    #       actions = {
    #         update-props = {
    # Убираем засыпание для BT, чтобы не было лага при начале звука
    #           "session.suspend-timeout-seconds" = 0;
    # Для BT важен кодек, но мы можем форсировать частоту
    #           "audio.rate" = rate;
    # Улучшаем качество ресемпла, если кодек BT не совпадает с системным
    #           "resample.quality" = 10;
    #         };
    #       };
    #     }
    #     {
    # Конкретно для вывода звука (Sinks) на BT
    #       matches = [
    #         { "node.name" = "~bluez_output.*"; }
    #       ];
    #       actions = {
    #         update-props = {
    #           "node.latency" = "${toString quantum}/${toString rate}";
    #           "node.lock-quantum" = true;
    # Важно для BT: предотвращает разрыв звука при низких квантах
    #           "api.bluez5.hw-volume" = true;
    #         };
    #       };
    #     }
    #   ];
    # };
  };
}
