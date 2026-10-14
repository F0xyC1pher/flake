{
  vars,
  lib,
  ...
}: {
  boot.kernelParams =
    [
      "mitigations=off"
      "preempt=full"
      "threadirqs"
      "nmi_watchdog=0"
      # "drm.edid_firmware=HDMI-A-1:edid/BenQ1080_75.bin"
    ]
    ++ lib.optionals vars.host.hardware.video.driver.nvidia.enable [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
    ]
    ++ (vars.host.kernel.params or []);
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';
}
