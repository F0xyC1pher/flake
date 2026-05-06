# ── Custom packages overlay ──────────────────────────────────────────────────
# Automatically picks up every *.nix file from modules/packages/custom/
# (skips files whose name starts with _).
# To add a new custom package — just drop a .nix file there; no registry needed.
{
	lib,
	inputs,
}: final: prev: let
	files =
		lib.filterAttrs
		(name: type: type == "regular" && builtins.match "^[^_].*\\.nix$" name != null)
		(builtins.readDir ../modules/packages/custom);
in
	builtins.foldl'
	(acc: name: let
			pkgName = lib.removeSuffix ".nix" name;
			value = final.callPackage ../modules/packages/custom/${name} {inherit inputs;};
		in
			acc // {"${pkgName}" = value;})
	{}
	(builtins.attrNames files)
