{
  pkgs,
  inputs,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "nekobox";
  version = "5.11.15";

  src = inputs.nekobox;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    qt6Packages.wrapQtAppsHook
    makeWrapper
    copyDesktopItems
    imagemagick # Для конвертации иконки из .ico в .png
  ];

  buildInputs = with pkgs; [
    qt6Packages.qtbase
    qt6Packages.qtwayland
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

    # Исправляем иконку
    mkdir -p $out/share/icons/hicolor/256x256/apps
    if [ -f "$out/share/nekobox/nekobox.ico" ]; then
        ${pkgs.imagemagick}/bin/magick "$out/share/nekobox/nekobox.ico[0]" $out/share/icons/hicolor/256x256/apps/nekobox.png
    fi

    makeWrapper "$BIN_PATH" "$out/bin/nekobox" \
      --prefix QT_PLUGIN_PATH : "${pkgs.kdePackages.qtwayland}/lib/qt-6/plugins" \
      --prefix QT_PLUGIN_PATH : "${pkgs.kdePackages.qtstyleplugin-kvantum}/lib/qt-6/plugins" \
      --prefix QT_PLUGIN_PATH : "$out/share/nekobox/usr/plugins" \
      --prefix LD_LIBRARY_PATH : "${pkgs.libGL}/lib:${pkgs.mesa}/lib:${pkgs.libxkbcommon}/lib" \
      --prefix LD_LIBRARY_PATH : "$out/share/nekobox/usr/lib:$out/share/nekobox/source/usr/lib" \
      --set XKB_CONFIG_ROOT "${pkgs.xkeyboard_config}/share/X11/xkb" \
      --set FONTCONFIG_FILE "${pkgs.fontconfig.out}/etc/fonts/fonts.conf" \
      --set FONTCONFIG_PATH "${pkgs.fontconfig.out}/etc/fonts"

    runHook postInstall
  '';
}
