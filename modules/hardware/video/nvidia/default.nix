{
  vars,
  pkgs,
  config,
  ...
}: let
  nvidiaPkg = config.boot.kernelPackages.nvidiaPackages.${vars.host.hardware.video.driver.nvidia.package};
in {
  boot = {
    extraModulePackages = [nvidiaPkg];
    blacklistedKernelModules = ["nouveau"];
    initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_drm" "nvidia_uvm"];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    # display.edid.enable = true;
    # display.edid.modelines = {
    # 	"BenQ1080_75" = "220.75  1920 2056 2264 2608  1080 1083 1088 1130 -hsync +vsync";
    # };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        nv-codec-headers-12
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        nvidia-vaapi-driver
        nv-codec-headers-12
      ];
    };
    nvidia = {
      package = nvidiaPkg;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = vars.host.hardware.video.driver.nvidia.open;
    };
  };

  imports = [
    ./application-profiles.nix
    ./persistence-mode-max-perf.nix
  ];
}
