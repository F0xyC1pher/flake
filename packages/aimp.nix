{ pkgs, ... }:

let
  buildInputs = with pkgs; [
    gtk2 cairo pango atk gdk-pixbuf glib libpulseaudio alsa-lib libGL libGLU
    fontconfig freetype dbus libsecret curl openssl ffmpeg
    hicolor-icon-theme adwaita-icon-theme
  ] ++ (with pkgs.xorg; [
    libX11 libXext libXrender libXtst libXScrnSaver libXdamage libXfixes libXi
  ]);
in

pkgs.stdenv.mkDerivation rec {
  pname = "aimp";
  version = "nightly-2026-02-11";

  src = pkgs.fetchurl {
    url = "https://www.aimp.ru/files/windows/builds/aimp-nightly-x86_64.pkg.tar.zst";
    hash = "sha256-ooYvVtOgbfs/DE3oQsdvshKE/jsdH63vbFLUxEhRWcw=";  # Your SRI hash
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
    zstd
  ];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    mkdir unpack
    cd unpack
    ${pkgs.zstd}/bin/zstd -d -c $src | tar x
  '';

  installPhase = ''
    # Find the main app dir (usually /opt/aimp)
    APPDIR=$(find . -type d -name "*aimp*" | head -1)
    if [ -z "$APPDIR" ]; then
      echo "Error: No aimp directory found!" >&2
      exit 1
    fi

    mkdir -p $out/opt/aimp $out/bin $out/share

    # Copy app files
    cp -r "$APPDIR"/* $out/opt/aimp/ || true

    # Copy any share/icons
    cp -r ./{usr,opt}/share/* $out/share/ 2>/dev/null || true

    # Find binary and wrap
    BIN=$(find $out/opt/aimp -type f -executable -name "*aimp*" -print -quit)
    if [ -n "$BIN" ]; then
      makeWrapper "$BIN" $out/bin/aimp \
        --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath buildInputs} \
        --prefix XDG_DATA_DIRS : "$out/share:${pkgs.gtk2}/share:${pkgs.hicolor-icon-theme}/share"
    else
      echo "Error: No aimp binary found!" >&2
      exit 1
    fi
  '';

  meta = with pkgs.lib; {
    description = "AIMP music player (nightly Arch build)";
    homepage = "https://www.aimp.ru";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "aimp";
  };
}
