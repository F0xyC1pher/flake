{ ... }:
{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # Размер в мегабайтах (тут 16 ГБ)
    }
  ];
  # boot.kernelParams = [
  # 	"zswap.enabled=0"
  # ];
  boot.zswap.enable = true;
  zramSwap = {
    enable = false;
    algorithm = "zstd";
    memoryPercent = 30;
    priority = 100;
  };
}
