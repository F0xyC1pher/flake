{
	pkgs,
	inputs,
	...
}:
pkgs.stdenv.mkDerivation {
	pname = "nekobox";
	version = "5.10.40";

	src = inputs.nekobox;

	nativeBuildInputs = with pkgs; [
		autoPatchelfHook
		makeWrapper
		copyDesktopItems
		imagemagick # Добавим для конвертации иконки из .ico в .png
	];

	buildInputs = with pkgs; [
		kdePackages.qtstyleplugin-kvantum
		libxkbcommon
		libx11
		glib
		libGL
		dbus
		fontconfig
		libxcursor
		libxrandr
		libxi
		icu
		openssl
		zlib
		libkrb5
		e2fsprogs
		harfbuzz
		wayland
		libSM
		libICE
		libgpg-error
		libdrm
		libgcrypt
		libva
		mesa
	];

	desktopItems = [
		(pkgs.makeDesktopItem {
				name = "nekobox";
				exec = "nekobox";
				icon = "nekobox";
				comment = "NekoRay/Nekobox Client";
				desktopName = "Nekobox";
				categories = ["Network"];
			})
	];

	installPhase = ''
		runHook preInstall

		mkdir -p $out/share/nekobox $out/bin
		cp -r ./* $out/share/nekobox/

		BIN_PATH="$out/share/nekobox/nekobox"
		[ ! -f "$BIN_PATH" ] && BIN_PATH="$out/share/nekobox/source/nekobox"
		chmod +x "$BIN_PATH"

		# Конвертируем .ico в .png для корректного отображения в лаунчере
		mkdir -p $out/share/icons/hicolor/256x256/apps
		magick "$out/share/nekobox/nekobox.ico[0]" $out/share/icons/hicolor/256x256/apps/nekobox.png

		makeWrapper "$BIN_PATH" "$out/bin/nekobox" \
		  --prefix QT_PLUGIN_PATH : "${pkgs.kdePackages.qtstyleplugin-kvantum}/lib/qt-6/plugins" \
		  --prefix QT_PLUGIN_PATH : "$out/share/nekobox/usr/plugins" \
		  --prefix QT_PLUGIN_PATH : "$out/share/nekobox/source/usr/plugins" \
		  --prefix LD_LIBRARY_PATH : "$out/share/nekobox/usr/lib:$out/share/nekobox/source/usr/lib:${pkgs.libGL}/lib:${pkgs.mesa}/lib:/run/opengl-driver/lib" \
		  --set FONTCONFIG_FILE "${pkgs.fontconfig.out}/etc/fonts/fonts.conf" \
		  --set FONTCONFIG_PATH "${pkgs.fontconfig.out}/etc/fonts"

		runHook postInstall
	'';
}
