{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{	  
	# sops.secrets.github_ssh_key = {
	#   # sops-nix сам расшифрует его и положит сюда
	#   path = "/home/${vars.userName}/.ssh/id_ed25519";
	#   mode = "0600";
	#   owner = vars.userName;
	# };
}
