{...}: {
  imports = [
    ./security
    ./xdg
    ./etc.nix
    ./locale.nix
    ./network.nix
    ./nix-init.nix
	./nix-ld.nix
    ./nix.nix
    ./ssh.nix
    # ./systemd.nix
    ./time.nix
    ./tty.nix
    ./variables.nix
  ];
}
