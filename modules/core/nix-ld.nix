{pkgs, ...}: {
	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [
			libsecret

			# Базовые и X11
			glib
			libGL
			libxkbcommon
			libX11
			libXrandr
			libXcursor
			libXi
			libxcb

			# C++ и сеть
			openssl
			zlib
			stdenv.cc.cc

			# Дополнительно (Qt, иконки, Wayland, опционально)
			dbus
			fontconfig
			wayland
			pango
			cairo
			libGLU
		];
	};
}
