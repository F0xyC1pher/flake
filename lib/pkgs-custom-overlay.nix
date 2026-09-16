#lib/pkgs-custom-overlay.nix
{
	lib,
	inputs,
}: final: prev: let
	files =
		lib.filterAttrs
		(name: type: type == "regular" && builtins.match "^[^_].*\\.nix$" name != null)
		(builtins.readDir ../modules/custom-packages);

	customPackages =
		builtins.foldl'
		(acc: name: let
				pkgName = lib.removeSuffix ".nix" name;
				value = final.callPackage ../modules/custom-packages/${name} {inherit inputs;};
			in
				acc // {"${pkgName}" = value;})
		{}
		(builtins.attrNames files);
in {
	custom = (prev.custom or {}) // customPackages;
}
