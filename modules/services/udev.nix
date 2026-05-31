{ pkgs, ... }:
{
  services = {
    udev = {
      enable = true;
      packages = with pkgs; [
        game-devices-udev-rules
      ];

      # Отключаем энергосбережение для USB
      extraRules = ''
        SUBSYSTEM=="irq", ATTR{threaded}="1"

        SUBSYSTEM=="usb", ATTR{idVendor}=="*", ATTR{idProduct}=="*", ATTR{product}=="*Usb Microphone*", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"
        ACTION=="add|change", SUBSYSTEM=="usb", ATTRS{idVendor}=="*", ATTR{bInterfaceClass}=="03", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"

        ACTION=="add|change", KERNEL=="nvme*", ATTR{queue/scheduler}="none"
        ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
        ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"


      '';
    };
  };
}
