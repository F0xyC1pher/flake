{ config, pkgs, vars, ... }:
{
  home-manager.users.${vars.userName} = { config, ... }: {
    programs.ssh = {
      enable = true;
      matchBlocks."github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/${vars.userName}/.ssh/id_ed25519";
      };
    };

    services.ssh-agent.enable = true;

    programs.fish.shellInit = ''
      # Указываем путь к сокету
      set -gx SSH_AUTH_SOCK "/run/user/1000/ssh-agent"

      # Добавляем ключ в агент при запуске шелла
      if not ssh-add -l > /dev/null 2>&1
        if test -f /home/${vars.userName}/.ssh/id_ed25519
          ssh-add /home/${vars.userName}/.ssh/id_ed25519 2>/dev/null
        end
      end
    '';
  };
}
