{ lib, config, pkgs, inputs, vars, ... }:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };

    users.${vars.userName} = { config, pkgs, lib, ... }:
    let
      keyPath = "/home/${vars.userName}/.ssh/id_ed25519";
    in
    {
      sops = {
        age.keyFile = "/home/${vars.userName}/.config/sops/age/keys.txt";
        defaultSopsFile = ../../secrets/secrets.yaml;
      };

      sops.secrets.github_ssh_key = {
        path = keyPath;
        mode = "0600";
      };
		services.ssh-agent.enable = true;
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks = {
          "*" = {
            addKeysToAgent = "yes";
          };
      
         github = {
                host = "github.com";
                user = "git";
                identityFile = keyPath;
                identitiesOnly = true;
                addKeysToAgent = "yes";
              };
        };
      };
    };
  };
}
