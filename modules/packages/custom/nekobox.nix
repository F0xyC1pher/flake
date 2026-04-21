{
	pkgs,
	inputs,
	...
}:
pkgs.stdenv.mkDerivation {
	pname = "nekobox";
	version = "5.10.38";

	src = inputs.nekobox;

	nativeBuildInputs = [pkgs.autoPatchelfHook pkgs.makeWrapper];

	buildInputs = with pkgs; [
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

	installPhase = ''
		mkdir -p $out/share/nekobox $out/bin
		cp -r ./* $out/share/nekobox/
		BIN_PATH="$out/share/nekobox/nekobox"
		[ ! -f "$BIN_PATH" ] && BIN_PATH="$out/share/nekobox/source/nekobox"
		chmod +x "$BIN_PATH"

		makeWrapper "$BIN_PATH" "$out/bin/nekobox" \
		  --set QT_QPA_PLATFORM "xcb" \
		  --prefix LD_LIBRARY_PATH : "$out/share/nekobox/usr/lib:$out/share/nekobox/source/usr/lib:${pkgs.libGL}/lib:${pkgs.mesa}/lib:/run/opengl-driver/lib" \
		  --set QT_PLUGIN_PATH "$out/share/nekobox/usr/plugins:$out/share/nekobox/source/usr/plugins" \
		  --set FONTCONFIG_FILE "${pkgs.fontconfig.out}/etc/fonts/fonts.conf" \
		  --set FONTCONFIG_PATH "${pkgs.fontconfig.out}/etc/fonts"
	'';
}
