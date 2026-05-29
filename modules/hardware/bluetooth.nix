{
  vars,
  pkgs,
  ...
}:
{
  # ========== BLUETOOTH ==========
  hardware = {
    # xpadneo.enable = true;
    # xone.enable = true;
    # uinput.enable = true;
    bluetooth = {
      enable = vars.hardware.bluetooth.enable;
      powerOnBoot = true;
      package = pkgs.bluez-experimental;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
}
