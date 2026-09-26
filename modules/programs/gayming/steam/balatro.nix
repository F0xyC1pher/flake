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

	lovelyVersion = (builtins.fromTOML (builtins.readFile "${inputs.lovely-src}/crates/lovely-core/Cargo.toml")).package.version;

	lovelyInjector =
		pkgs.stdenv.mkDerivation {
			pname = "lovely-injector";
			version = lovelyVersion;
			src = inputs.lovely-bin;
			dontUnpack = true;

			nativeBuildInputs = [pkgs.autoPatchelfHook];
			buildInputs = [pkgs.stdenv.cc.cc.lib];

			installPhase = ''
				mkdir -p $out/lib
				if [ -d "$src" ]; then
				  cp $src/liblovely.so $out/lib/
				elif [ -f "$src" ]; then
				  cp $src $out/lib/liblovely.so
				else
				  cp liblovely.so $out/lib/
				fi
			'';
		};

	# Компиляция luasteam.so из исходников
	luasteam =
		pkgs.stdenv.mkDerivation {
			pname = "luasteam";
			version = "1.0.4";
			src = inputs.luasteam-src;

			buildInputs = [pkgs.luajit];

			buildPhase = ''
				$CXX -O2 -shared -fPIC -I${pkgs.luajit}/include/luajit-2.1 src/*.cpp -o luasteam.so
			'';

			installPhase = ''
				mkdir -p $out/lib/lua/5.1
				cp luasteam.so $out/lib/lua/5.1/
			'';
		};

	balatro =
		pkgs.writeShellScriptBin "balatro" ''
			EXE=""
			for arg in "$@"; do
			  if [[ "$arg" == *"Balatro.exe"* ]]; then
			    EXE="$arg"
			    break
			  fi
			done

			if [ -z "$EXE" ]; then
			  EXE="${balatroExe}"
			fi

			if [ ! -f "$EXE" ]; then
			  echo "Ошибка: Balatro.exe не найден по пути $EXE"
			  exit 1
			fi

			# 1. Привязка сейвов из Proton (если нативной папки еще нет)
			NATIVE_SAVES="$HOME/.local/share/love/Balatro"
			PROTON_SAVES="${protonSaves}"

			if [ ! -e "$NATIVE_SAVES" ] && [ -d "$PROTON_SAVES" ]; then
			  mkdir -p "$HOME/.local/share/love"
			  ln -s "$PROTON_SAVES" "$NATIVE_SAVES"
			fi

			# 2. Идентификация игры для Steam API
			export SteamAppId="2379780"
			export SteamGameId="2379780"

			# 3. Нативный Wayland
			export SDL_VIDEODRIVER=wayland
			export WAYLAND_DISPLAY="''${WAYLAND_DISPLAY:-wayland-1}"
			export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

			# 4. Регистрируем скомпилированную luasteam.so в LUA_CPATH
			export LUA_CPATH="${luasteam}/lib/lua/5.1/?.so;''${LUA_CPATH}"

			# 5. Системные либы NixOS/NVIDIA + пути к Steam SDK для libsteam_api.so
			SYS_LIBS="${lib.makeLibraryPath [
					pkgs.curl
					pkgs.wayland
					pkgs.libxkbcommon
					pkgs.libGL
					pkgs.vulkan-loader
				]}:/run/opengl-driver/lib:$HOME/.steam/sdk64:$HOME/.local/share/Steam/ubuntu12_32:$HOME/.local/share/Steam/ubuntu12_64"

			export LD_LIBRARY_PATH="$SYS_LIBS''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

			# 6. Сохраняем Steam Overlay и добавляем Lovely
			export LD_PRELOAD="${lovelyInjector}/lib/liblovely.so''${LD_PRELOAD:+:$LD_PRELOAD}"

			# 7. Переходим в директорию игры
			cd "$(dirname "$EXE")"

			exec ${pkgs.love}/bin/love "$EXE" "$@"
		'';
in {
	environment.systemPackages = [
		pkgs.love
		balatro
	];
}
