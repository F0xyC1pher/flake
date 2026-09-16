# lib/overlays/custom-pkgs.nix
{
	lib,
	inputs ? {},
	flakeRoot,
	customPkgsDir ? "${flakeRoot}/modules/custom-packages",
	...
}: final: prev: let
	toPath = p:
		if builtins.isPath p
		then p
		else if lib.hasPrefix "/nix/store" (toString p) || lib.hasPrefix "/nix/store" (builtins.unsafeDiscardStringContext (toString p))
		then builtins.toPath (builtins.unsafeDiscardStringContext (toString p))
		else if lib.hasPrefix "/" (toString p)
		then builtins.toPath (toString p)
		else throw "custom-pkgs.nix: path '${toString p}' must be absolute";

	targetDir = toPath customPkgsDir;

	files =
		if builtins.pathExists targetDir
		then
			lib.filterAttrs (
				name: type: type == "regular" && builtins.match "^[^_].*\\.nix$" name != null
			) (builtins.readDir targetDir)
		else {};

	customPackages =
		builtins.foldl' (
			acc: name: let
				pkgName = lib.removeSuffix ".nix" name;
				value = final.callPackage (targetDir + "/${name}") {inherit inputs;};
			in
				acc // {"${pkgName}" = value;}
		) {} (builtins.attrNames files);
in {
	custom = (prev.custom or {}) // customPackages;
}
