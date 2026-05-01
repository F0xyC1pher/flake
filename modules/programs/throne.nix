{pkgs, ...}: let
	throne-updated =
		pkgs.throne.overrideAttrs (oldAttrs: {
				version = "1.1.1";
				src =
					pkgs.fetchFromGitHub {
						owner = "throneproj";
						repo = "Throne";
						rev = "v1.1.1";
						# You'll need to update this hash.
						# Run `nix-prefetch-url --unpack https://github.com/throneproj/Throne/archive/refs/tags/v1.1.1.tar.gz`
						# to get the correct SRI hash.
						hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
					};
			});
in {
	programs.throne = {
		enable = true;
		tunMode.enable = true;
	};
}
