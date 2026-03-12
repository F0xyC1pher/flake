{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{	  
	sops = {
		# defaultSopsFile = ../../secrets.yaml; # путь к твоему зашифрованному файлу

		secrets.github_ssh_key = {
			owner = "f";
			path = "/home/f/.ssh/id_ed25519";
			mode = "0600";
		};
	};
}
