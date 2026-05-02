{...}: {
	imports = [
		./swap.nix
		# ./tmpfs.nix
		./zram.nix
		./zswap.nix
	];
}
