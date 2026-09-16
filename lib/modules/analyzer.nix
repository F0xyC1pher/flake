# lib/modules/analyzer.nix
{lib}: {
	hasPackageInFiles = files: pkgName:
		lib.any (
			file: let
				pathObj =
					if builtins.isPath file
					then file
					else /. + file;
				content =
					if builtins.pathExists pathObj
					then builtins.readFile pathObj
					else "";
				escapedPkg = lib.strings.escapeRegex pkgName;
				patterns = [
					"pkgs\\.${escapedPkg}"
					"\"${escapedPkg}\""
					"inputs\\.${escapedPkg}"
					"inputs\\.[a-zA-Z0-9_-]+\\.packages\\.\\$\\{[^}]+\\}\\.${escapedPkg}"
					"inputs\\.[a-zA-Z0-9_-]+\\.defaultPackage\\.\\$\\{[^}]+\\}\\.${escapedPkg}"
					"\\.${escapedPkg}"
				];
			in
				if content == ""
				then false
				else lib.any (pattern: builtins.match ".*(${pattern}).*" content != null) patterns
		)
		files;
}
