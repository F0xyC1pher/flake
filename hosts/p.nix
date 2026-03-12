{ config, pkgs, lib, vars, ... }:
{
        # ======================================================
        # Машиноспецифичные настройки для хоста: p
        # Железо: Smartbuy SSD 128GB + WD 1TB + Seagate 500GB
        # ======================================================

        # Диск для загрузчика (весь диск, не раздел)
        # Найти свой: ls -la /dev/disk/by-id/ | grep -v part
        boot.loader.limine.biosDevice = if vars.bootLoader == "Limine" then
          lib.mkForce "/dev/disk/by-id/ata-Smartbuy_SSD_128GB_LCN263R001798"
        else
          null;
        
        boot.loader.grub.device = if vars.bootLoader == "GRUB" then
          lib.mkForce "/dev/disk/by-id/ata-Smartbuy_SSD_128GB_LCN263R001798"
        else
          null;


sops = {
  defaultSopsFile = ../secrets/secrets.yaml; # Путь к твоему yaml
  age.keyFile = "/home/${vars.userName}/.config/sops/age/keys.txt";

  secrets.github_ssh_key = {
    owner = vars.userName;
    # Sops положит расшифрованный ключ прямо в .ssh
    path = "/home/${vars.userName}/.ssh/id_ed25519";
    mode = "0600";
  };
};
}
