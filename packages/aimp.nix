# packages/aimp.nix
{ pkgs, stdenv, fetchurl, ... }:  # или { stdenv, fetchurl, ... } если хочешь явно

pkgs.stdenv.mkDerivation rec {
  pname = "aimp";
  version = "6.00.3037a";

  src = pkgs.fetchurl {
    url = "https://disk.yandex.ru/d/ClIiI_mP79J43w/v6.00%20Alpha/aimp-6.00-3037a-x86_64.pkg.tar.zst";
    hash = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=";  # рассчитай через `nix hash file --type sha256 --base32 файл`
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
    zstd
    libarchive
  ];

  buildInputs = with pkgs; [
    gtk2 cairo pango atk gdk-pixbuf glib libpulseaudio alsa-lib libGL libGLU
    fontconfig freetype dbus libsecret curl openssl ffmpeg
    hicolor-icon-theme adwaita-icon-theme
  ] ++ (with pkgs.xorg; [
    libX11 libXext libXrender libXtst libXScrnSaver libXdamage libXfixes libXi
  ]);

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    mkdir -p unpack
    cd unpack
    tar --use-compress-program=${pkgs.zstd}/bin/zstd -xf $src
  '';

  installPhase = ''
    mkdir -p $out/opt/aimp $out/bin $out/share

    cp -r unpack/usr/* $out/opt/aimp/ 2>/dev/null || cp -r unpack/* $out/opt/aimp/

    BIN=$(find $out/opt/aimp -type f -executable -name "*aimp*" | head -1)
    if [ -f "$BIN" ]; then
      makeWrapper "$BIN" $out/bin/aimp \
        --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath buildInputs} \
        --set XDG_DATA_DIRS "$$   out/share:   $${pkgs.gtk2}/share:${pkgs.hicolor-icon-theme}/share"
    else
      echo "Ошибка: бинарник aimp не найден!" >&2
      exit 1
    fi

    cp -r $out/opt/aimp/share/* $out/share/ 2>/dev/null || true
  '';

  meta = {
    description = "AIMP 6 alpha native Linux (из Arch pkg.tar.zst)";
    homepage = "https://www.aimp.ru/";
    platforms = [ "x86_64-linux" ];
    mainProgram = "aimp";
  };
}
