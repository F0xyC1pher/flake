{
	inputs,
	vars,
	pkgs,
	...
}: let
	nixLogoSvg =
		pkgs.fetchurl {
			url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-colours.svg";
			hash = "sha256-42kGThoV8Rk9L5UeX3tS7Vn7I2G0k3R8gJ/N+4T1Jyo=";
		};
	nixLogoPng =
		pkgs.runCommand "nix-logo.png" {
			nativeBuildInputs = [pkgs.imagemagick];
		} ''
			magick -background transparent "${nixLogoSvg}" $out
		'';
in {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.fastfetch = {
				enable = true;
				settings = {
					logo = {
						source = "${nixLogoPng}";
						type = "kitty";
						width = 32;
						height = 16;
						padding = {
							right = 2;
						};
					};
				};
			};
		};
	};
}
