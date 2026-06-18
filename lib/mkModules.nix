{lib, ...}: rec {
	findDeep = basePath: name: let
		entries = builtins.readDir basePath;

		asDir = basePath + "/${name}";
		asFile = basePath + "/${name}.nix";

		directMatches =
			lib.optional (builtins.pathExists asDir && builtins.pathExists "${asDir}/default.nix") "${asDir}/default.nix"
			++ lib.optional (builtins.pathExists asFile) asFile;

		subdirs =
			lib.filterAttrs (
				n: t:
					t
					== "directory"
					&& n != name
					&& !(builtins.pathExists (basePath + "/${n}/default.nix"))
			)
			entries;

		subMatches =
			lib.concatMap
			(subdir: findDeep (basePath + "/${subdir}") name)
			(builtins.attrNames subdirs);
	in
		directMatches ++ subMatches;

	importCategoryDir = dirPath: let
		entries = builtins.readDir dirPath;
		nixFiles =
			lib.filterAttrs (
				name: type:
					type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" && !(lib.hasPrefix "_" name)
			)
			entries;
		subdirs =
			lib.filterAttrs (
				name: type:
					type == "directory" && builtins.pathExists "${dirPath}/${name}/default.nix" && !(lib.hasPrefix "_" name)
			)
			entries;
	in
		(map (name: "${dirPath}/${name}") (builtins.attrNames nixFiles))
		++ (map (name: "${dirPath}/${name}/default.nix") (builtins.attrNames subdirs));

	importPrograms = programsBase: items: let
		allPaths =
			lib.concatMap (
				item: let
					directDir = programsBase + "/${item}";
					directFile = programsBase + "/${item}.nix";
				in
					if builtins.pathExists directDir
					then
						if builtins.pathExists "${directDir}/default.nix"
						then ["${directDir}/default.nix"]
						else importCategoryDir directDir
					else if builtins.pathExists directFile
					then [directFile]
					else findDeep programsBase item
			)
			items;
		uniquePaths = lib.unique allPaths;
	in
		map (path: import path) uniquePaths;
}
