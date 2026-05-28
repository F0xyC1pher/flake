{
  pkgs,
  vars,
  ...
}:
{
  # ========== USER ==========
  users.users.${vars.user.name} = {
    isNormalUser = true;
    description = "${vars.user.fullName}";
    home = "/home/${vars.user.name}";
    shell = pkgs.${vars.user.shell};
    hashedPassword = "${vars.user.password}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "pipewire"
      "input"
      "uinput"
      "rtkit"
      "realtime"
      "adbusers"
      "polkituser"
      "render"
      "games"
      "gamemode"
      "mpd"
      "cdrom"
      "disk"
      "floppy"
      "kmem"
    ];
  };
}
