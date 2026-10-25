{pkgs, ...}: {
  services.xserver = {
    displayManager.startx.enable = true;
    enable = true;
    excludePackages = [pkgs.xterm];
    xkb = {
      layout = "us,ru";
      model = "pc86";
      options = "grp:lalt_lshift_toggle;";
    };
  };
}
