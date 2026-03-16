{ config, pkgs, vars, lib, ... }:
{
  home-manager.users.${vars.userName} = { config, ... }: {
  #  programs.ssh = {
  #    enable = true;
  #    matchBlocks."github.com" = {
  #      hostname = "github.com";
  #      user = "git";
  #       identityFile = "/home/${vars.userName}/.ssh/id_ed25519";
  #     };
  #  };

    services.ssh-agent = {
      enable = false;
    };
    
    # Добавим принудительную настройку, чтобы агент создавал сокет там, где мы его ждем
 #   # systemd.user.services.ssh-agent.Service.ExecStart = lib.mkForce "${pkgs.openssh}/bin/ssh-agent -D -a %t/ssh-agent";

  #  programs.fish.shellInit = ''
  #    # Если системный агент включен, NixOS сама заполнит SSH_AUTH_SOCK.
  #    # Но на случай, если мы в странном окружении:
  #    if not set -q SSH_AUTH_SOCK
 #         set -gx SSH_AUTH_SOCK (ls -t /tmp/ssh-*/agent.* 2>/dev/null | head -n 1)
 #     end
 #   
 #     # Авто-добавление ключа
 #     if not ssh-add -l > /dev/null 2>&1
 #         if test -f ~/.ssh/id_ed25519
 #             ssh-add ~/.ssh/id_ed25519 2>/dev/null
 #         end
 #     end
  #  '';
 # };
}
