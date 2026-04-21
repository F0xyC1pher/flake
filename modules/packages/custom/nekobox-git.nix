{
	pkgs,
	inputs,
	...
}: let
	# Build kvantum plugin against the same Qt we use for Nekobox
	myKvantum =
		pkgs.kdePackages.qtstyleplugin-kvantum.override {
			qt6 = pkgs.qt6; # force using the current qt6 set
		};
in
	pkgs.stdenv.mkDerivation {
		pname = "nekobox-git";
		version = "5.10.40";

		src = inputs.nekobox-git;

		unpackPhase = ''
			runHook preUnpack
			cp -r $src/. .
			chmod -R +w .
			runHook postUnpack
		'';

		sourceRoot = ".";

		nativeBuildInputs = with pkgs; [
			cmake
			ninja
			qt6.wrapQtAppsHook
			copyDesktopItems
			imagemagick
			thrift
			pkg-config
			boost
		];

		buildInputs = with pkgs; [
			myKvantum
			qt6.qtbase
			qt6.qtwayland
			qt6.qtsvg
			qt6.qttools
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
			acl
			lmdb
		];

		cmakeFlags = ["-DNKR_PACKAGE=ON"];

		qtWrapperArgs = [
			# "--unset QT_PLUGIN_PATH"
			"--prefix QT_PLUGIN_PATH : ${myKvantum}/lib/qt-6/plugins"
			"--run 'mkdir -p \"$HOME/.config/nekobox\"'"
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
			install -Dm755 nekobox -t $out/bin/
			# Create a wrapper to fix chmod error (create config dir on first run)
			cat > $out/bin/nekobox-wrapper <<EOF
			#!/bin/sh
			mkdir -p "\$HOME/.config/nekobox"
			exec $out/bin/nekobox "\$@"
			EOF
			chmod +x $out/bin/nekobox-wrapper
			mv $out/bin/nekobox-wrapper $out/bin/nekobox
			runHook postInstall
		'';
	}
