{ vars, ... }:
{

  home-manager.users.${vars.user.name} =
    {
      ...
    }:
    {
      home.preferXdgDirectories = true;
      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "/home/${vars.user.name}/Desktop";
        documents = "/home/${vars.user.name}/Documents";
        download = "/home/${vars.user.name}/Downloads";
        music = "/home/${vars.user.name}/Music";
        pictures = "/home/${vars.user.name}/Pictures";
        projects = "/home/${vars.user.name}/Projects";
        publicShare = "/home/${vars.user.name}/PublicShare";
        templates = "/home/${vars.user.name}/Templates";
        videos = "/home/${vars.user.name}/Videos";

        extraConfig = {
          MISC = "/home/${vars.user.name}/Misc";
        };
      };
    };
}
