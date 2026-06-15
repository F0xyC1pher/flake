# lib/utils.nix
{lib, ...}: rec {
	# Рекурсивно ищет модуль по имени в любой поддиректории basePath.
	# Возвращает список найденных путей (директории с default.nix или .nix-файлы).
	findDeep = basePath: name: let
		entries = builtins.readDir basePath;

		asDir = basePath + "/${name}";
		asFile = basePath + "/${name}.nix";

		directMatches =
			lib.optional
			(builtins.pathExists asDir && builtins.pathExists (asDir + "/default.nix"))
			asDir
			++ lib.optional (builtins.pathExists asFile) asFile;

		# Рекурсия во все поддиректории (кроме самой `name`, чтобы не войти повторно)
		subdirs = lib.filterAttrs (n: t: t == "directory" && n != name) entries;
		subMatches =
			lib.concatMap
			(subdir: findDeep (basePath + "/${subdir}") name)
			(builtins.attrNames subdirs);
	in
		directMatches ++ subMatches;

	# Импорт категории: все .nix-файлы и все поддиректории с default.nix
	importCategoryDir = dirPath: let
		entries = builtins.readDir dirPath;

		nixFiles =
			lib.filterAttrs (
				name: type:
					type
					== "regular"
					&& lib.hasSuffix ".nix" name
					&& name != "default.nix"
					&& !(lib.hasPrefix "_" name)
			)
			entries;

		subdirs =
			lib.filterAttrs (
				name: type:
					type
					== "directory"
					&& builtins.pathExists (dirPath + "/${name}/default.nix")
					&& !(lib.hasPrefix "_" name)
			)
			entries;
	in
		map (name: import (dirPath + "/${name}")) (builtins.attrNames nixFiles)
		++ map (name: import (dirPath + "/${name}/default.nix")) (builtins.attrNames subdirs);

	# Основная функция: принимает список имён программ/категорий,
	# находит каждую где угодно в поддереве programsBase.
	importPrograms = programsBase: items:
		lib.concatMap (
			item: let
				directDir = programsBase + "/${item}";
				directFile = programsBase + "/${item}.nix";
			in
				if builtins.pathExists directDir
				then
					if builtins.pathExists (directDir + "/default.nix")
					then [import (directDir + "/default.nix")] # один модуль
					else importCategoryDir directDir # категория
				else if builtins.pathExists directFile
				then [import directFile]
				else
					# Не нашли напрямую — ищем рекурсивно
					map (
						p:
							if builtins.pathExists (p + "/default.nix")
							then import (p + "/default.nix")
							else import p
					) (findDeep programsBase item)
		)
		items;
}
