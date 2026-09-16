# lib/modules/finder.nix
{lib}: rec {
	toPath = p:
		if builtins.isPath p
		then p
		else if lib.hasPrefix "/nix/store" (toString p) || lib.hasPrefix "/nix/store" (builtins.unsafeDiscardStringContext (toString p))
		then builtins.toPath (builtins.unsafeDiscardStringContext (toString p))
		else if lib.hasPrefix "/" (toString p)
		then builtins.toPath (toString p)
		else throw "finder.nix: path '${toString p}' must be absolute";

	findDeep = basePath: name: let
		bPath = toPath basePath;
		entries = builtins.readDir bPath;
		asDir = bPath + "/${name}";
		asFile = bPath + "/${name}.nix";

		directMatches =
			lib.optional (builtins.pathExists asDir && builtins.pathExists (asDir + "/default.nix")) (asDir + "/default.nix")
			++ lib.optional (builtins.pathExists asFile) asFile;

		subdirs =
			lib.filterAttrs (
				n: t: t == "directory" && n != name && !(builtins.pathExists (bPath + "/${n}/default.nix"))
			)
			entries;

		subMatches = lib.concatMap (subdir: findDeep (bPath + "/${subdir}") name) (builtins.attrNames subdirs);
	in
		directMatches ++ subMatches;

	importCategoryDir = dirPath: let
		dPath = toPath dirPath;
		entries = builtins.readDir dPath;
		nixFiles =
			lib.filterAttrs (
				name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" && !(lib.hasPrefix "_" name)
			)
			entries;
		subdirs =
			lib.filterAttrs (
				name: type: type == "directory" && builtins.pathExists (dPath + "/${name}/default.nix") && !(lib.hasPrefix "_" name)
			)
			entries;
	in
		(map (name: dPath + "/${name}") (builtins.attrNames nixFiles))
		++ (map (name: dPath + "/${name}/default.nix") (builtins.attrNames subdirs));

	importModules = modulesBase: items: let
		mBase = toPath modulesBase;
		allPaths =
			lib.concatMap (
				item: let
					directDir = mBase + "/${item}";
					directFile = mBase + "/${item}.nix";
				in
					if builtins.pathExists directDir
					then
						if builtins.pathExists (directDir + "/default.nix")
						then [(directDir + "/default.nix")]
						else importCategoryDir directDir
					else if builtins.pathExists directFile
					then [directFile]
					else findDeep mBase item
			)
			items;
	in
		lib.unique allPaths;

	importPrograms = importModules;
	importServices = importModules;
	importPackages = importModules;

	resolveActiveNames = modulesBase: items: let
		mBase = toPath modulesBase;
		paths = importModules mBase items;
		extractIdentifiers = path: let
			relPath = lib.removePrefix "/" (lib.removePrefix (toString mBase) (toString path));
			parts = lib.splitString "/" relPath;
			fileName = lib.last parts;
			cleanFileName =
				if fileName == "default.nix"
				then ""
				else lib.removeSuffix ".nix" fileName;
			dirParts =
				if fileName == "default.nix"
				then parts
				else lib.init parts;
		in
			dirParts ++ (lib.optional (cleanFileName != "") cleanFileName);
	in
		lib.unique (items ++ (lib.concatMap extractIdentifiers paths));
}
