{
	pkgs,
	lib,
	vars,
	inputs,
	...
}: let
	steamLib = "/home/${vars.user.name}/Games/SteamLibrary";
	balatroExe = "${steamLib}/steamapps/common/Balatro/Balatro.exe";
	protonSaves = "${steamLib}/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro";
	nativeSaves = "$HOME/.local/share/love/Balatro";

	lovelyInjector =
		pkgs.stdenv.mkDerivation {
			pname = "lovely-injector";
			version = "latest";
			src = inputs.lovely-bin;

			nativeBuildInputs = [pkgs.autoPatchelfHook];
			buildInputs = [pkgs.stdenv.cc.cc.lib];

			installPhase = ''
				mkdir -p $out/lib

				if [ -d "$src" ]; then
				  SO_FILE=$(find "$src" -type f -name "liblovely.so" | head -n 1)
				  [ -n "$SO_FILE" ] && cp "$SO_FILE" $out/lib/liblovely.so || { echo "Ошибка: liblovely.so не найден"; exit 1; }
				else
				  TMP_TAR=$(mktemp -d)
				  cp "$src" "$TMP_TAR/lovely.tar.gz"
				  tar -xzf "$TMP_TAR/lovely.tar.gz" -C "$TMP_TAR"
				  SO_FILE=$(find "$TMP_TAR" -type f -name "liblovely.so" | head -n 1)
				  [ -n "$SO_FILE" ] && cp "$SO_FILE" $out/lib/liblovely.so || { echo "Ошибка: liblovely.so не найден в архиве"; exit 1; }
				fi
				chmod +x $out/lib/liblovely.so
			'';
		};

	luasteam =
		pkgs.stdenv.mkDerivation {
			pname = "luasteam";
			version = "1.2.0";
			src = inputs.luasteam-bin;
			dontUnpack = true;

			nativeBuildInputs = [
				pkgs.patchelf
			];
			buildInputs = [
				pkgs.stdenv.cc.cc.lib
				pkgs.glibc
				pkgs.luajit
			];

			installPhase = ''
				mkdir -p $out/lib/lua/5.1

				if [ -d "$src" ]; then
				  SO_FILE=$(find "$src" -type f -name "*.so" | head -n 1)
				  [ -n "$SO_FILE" ] && cp "$SO_FILE" $out/lib/lua/5.1/luasteam.so || { echo "Ошибка: .so не найден"; exit 1; }
				else
				  cp "$src" $out/lib/lua/5.1/luasteam.so
				fi
				chmod +w $out/lib/lua/5.1/luasteam.so
			'';

			postFixup = ''
				${pkgs.patchelf}/bin/patchelf --set-rpath \
					"''$ORIGIN:${lib.makeLibraryPath [pkgs.stdenv.cc.cc.lib pkgs.glibc pkgs.luajit]}" \
					$out/lib/lua/5.1/luasteam.so
			'';
		};

	balatro =
		pkgs.writeShellScriptBin "balatro" ''
			EXE="${balatroExe}"
			GAME_DIR="$(dirname "$EXE")"

			if [ ! -f "$EXE" ]; then
			  echo "Ошибка: Balatro.exe не найден по пути $EXE"
			  exit 1
			fi

			# Проверяем наличие libsteam_api.so в папке с игрой
			if [ ! -f "$GAME_DIR/libsteam_api.so" ]; then
			  echo "Ошибка: libsteam_api.so не найдена в $GAME_DIR"
			  echo "Скопируй её из Steam-клиента:"
			  echo "  cp ~/.local/share/Steam/steamrt64/libsteam_api.so $GAME_DIR/"
			  exit 1
			fi

			# 1. Привязка сохранений из Proton
			if [ ! -e "${nativeSaves}" ] && [ -d "${protonSaves}" ]; then
			  mkdir -p "$HOME/.local/share/love"
			  ln -s "${protonSaves}" "${nativeSaves}"
			fi

			# 2. Идентификаторы Steam
			export SteamAppId="2379780"
			export SteamGameId="2379780"

			# 3. Пути к Lua модулям
			export LUA_CPATH="${luasteam}/lib/lua/5.1/?.so;''${LUA_CPATH}"

			# 4. Библиотечные пути
			export LD_LIBRARY_PATH="${luasteam}/lib/lua/5.1:${lib.makeLibraryPath [pkgs.stdenv.cc.cc.lib pkgs.curl pkgs.luajit]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

			# 5. Переходим в папку с игрой (как в оригинальном run_lovely_linux.sh)
			cd "$GAME_DIR"

			# 6. Предзагрузка: libsteam_api.so ищется в текущей директории (мы в $GAME_DIR)
			#    liblovely.so — абсолютный путь из nix-store
			export LD_PRELOAD="libsteam_api.so:${lovelyInjector}/lib/liblovely.so''${LD_PRELOAD:+:$LD_PRELOAD}"

			# 7. Запуск через love
			exec ${pkgs.love}/bin/love "$EXE" "$@"
		'';
in {
	environment.systemPackages = [
		pkgs.love
		balatro
	];
}
