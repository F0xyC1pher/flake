{
  inputs,
  pkgs,
  lib,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "husi";
  version = "1.2.2";

  src = inputs.husi;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
    zstd  # обязателен для .tar.zst
  ];

  buildInputs = with pkgs; [
    glibc
    glib
    libGL
    libxkbcommon
    libX11
    libXrandr
    libXcursor
    libXi
    libxcb
    openssl
    zlib
    fontconfig
    dbus
    wayland
  ];

  unpackPhase = ''
    runHook preUnpack

    # Определяем, где лежит архив
    if [ -f "$src" ]; then
      ARCHIVE="$src"
    elif [ -d "$src" ]; then
      ARCHIVE=$(find "$src" -type f -name "*.pkg.tar.zst" | head -1)
      if [ -z "$ARCHIVE" ]; then
        echo "No .pkg.tar.zst found in $src"
        ls -la "$src"
        exit 1
      fi
    else
      echo "src is neither file nor directory: $src"
      exit 1
    fi

    echo "Extracting $ARCHIVE"
    tar --zstd -xvf "$ARCHIVE"

    # Отладка: показать, что распаковалось
    echo "Unpacked contents:"
    ls -la

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    # Копируем всё, что распаковалось (обычно это usr/, etc/, opt/...)
    # Но избегаем копирования самой $src
    for item in *; do
      if [ "$item" != "$(basename "$ARCHIVE")" ]; then
        cp -r "$item" $out/
      fi
    done

    # Если бинарник лежит не в usr/bin, поищем его
    if [ -f "$out/usr/bin/husi" ]; then
      BIN="$out/usr/bin/husi"
    elif [ -f "$out/bin/husi" ]; then
      BIN="$out/bin/husi"
    else
      echo "ERROR: husi binary not found"
      find $out -name "husi" -type f 2>/dev/null || echo "Not found anywhere"
      exit 1
    fi

    chmod +x "$BIN"

    # Создаём ссылку в $out/bin, если её нет
    mkdir -p $out/bin
    if [ ! -f "$out/bin/husi" ]; then
      ln -s "$BIN" $out/bin/husi
    fi

    # Обёртка
    wrapProgram "$out/bin/husi" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
      --set XKB_CONFIG_ROOT "${pkgs.xkeyboard_config}/share/X11/xkb"

    # Копируем иконки и .desktop файлы, если есть
    if [ -d "$out/usr/share/applications" ]; then
      mkdir -p $out/share/applications
      cp -r $out/usr/share/applications/* $out/share/applications/
    fi
    if [ -d "$out/usr/share/icons" ]; then
      mkdir -p $out/share/icons
      cp -r $out/usr/share/icons/* $out/share/icons/
    fi

    runHook postInstall
  '';

  # Опциональный desktop-файл (если в архиве нет своего)
  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "husi";
      exec = "husi";
      icon = "husi";
      comment = "Husi application";
      desktopName = "Husi";
      categories = ["Network" "Utility"];
    })
  ];

  meta = with lib; {
    description = "Husi (fr.husi) – application from Arch Linux package";
    homepage = "https://codeberg.org/xchacha20-poly1305/husi";
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = with maintainers; [ FoxyChipher ];
  };
}