{
	inputs,
	vars,
	pkgs,
	...
}: let
	nixLogoSvg = inputs.nix-logo-svg;
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
						type = "kitty-direct";
					};
				};
			};
		};
	};
}
