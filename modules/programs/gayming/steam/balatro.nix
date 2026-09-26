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

	balatro =
		pkgs.writeShellScriptBin "balatro" ''
			EXE=""
			for arg in "$@"; do
			  if [[ "$arg" == *"Balatro.exe"* ]]; then
			    EXE="$arg"
			    break
			  fi
			done

			# Если запущен напрямую из терминала, берем дефолтный путь из SteamLibrary
			if [ -z "$EXE" ]; then
			  EXE="${balatroExe}"
			fi

			if [ ! -f "$EXE" ]; then
			  echo "Ошибка: Balatro.exe не найден по пути $EXE"
			  exit 1
			fi

			# Если папка сейвов Proton существует, а нативной папки love еще нет — подвязываем сейвы налету
			NATIVE_SAVES="$HOME/.local/share/love/Balatro"
			PROTON_SAVES="${protonSaves}"

			if [ ! -e "$NATIVE_SAVES" ] && [ -d "$PROTON_SAVES" ]; then
			  mkdir -p "$HOME/.local/share/love"
			  ln -s "$PROTON_SAVES" "$NATIVE_SAVES"
			fi

			export LD_LIBRARY_PATH="${lib.makeLibraryPath [pkgs.curl]}:$LD_LIBRARY_PATH"
			export LD_PRELOAD="${lovelyInjector}/lib/liblovely.so"

			exec ${pkgs.love}/bin/love "$EXE"
		'';
in {
	environment.systemPackages = [
		pkgs.love
		balatro
	];
}
