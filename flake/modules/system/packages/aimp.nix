{ pkgs, ... }:

let
  runtimeDeps = with pkgs; [
    gtk3 gtk2 cairo pango atk gdk-pixbuf glib
    libpulseaudio alsa-lib libGL libGLU fontconfig freetype dbus libsecret curl
    soxr libao libogg libvorbis
    openssl ffmpeg harfbuzz zlib sqlite
    stdenv.cc.cc.lib
    libx11 libxext libxrender libxtst libxscrnsaver libxdamage libxfixes libxi
  ];

  libraryPath = pkgs.lib.makeLibraryPath runtimeDeps;
in

pkgs.stdenv.mkDerivation rec {
  pname = "aimp";
  version = "nightly";

  src = pkgs.fetchurl {
    url = "https://www.aimp.ru/files/windows/builds/aimp-nightly-x86_64.pkg.tar.zst";
    hash = "sha256-ooYvVtOgbfs/DE3oQsdvshKE/jsdH63vbFLUxEhRWcw=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
    zstd
  ];

  buildInputs = runtimeDeps;

  unpackPhase = ''
    mkdir -p source
    ${pkgs.zstd}/bin/zstd -d -c $src | tar xf - -C source
  '';

 autoPatchelfIgnoreMissingDeps = false;
  
  autoPatchelfSearchPath = map (p: "${p}/lib") runtimeDeps;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r source/* $out/
  
    chmod +x $out/opt/aimp/AIMP
  
    # Копируем libcurl внутрь приложения
    cp ${pkgs.curl.out}/lib/libcurl.so.4 $out/opt/aimp/
  
    makeWrapper "$out/opt/aimp/AIMP" $out/bin/aimp \
      --set XDG_DATA_DIRS "$out/usr/share:${pkgs.gtk3}/share" \
      --set LD_LIBRARY_PATH ${libraryPath}
  '';
	postFixup = ''
	  patchelf \
	    --add-rpath ${pkgs.lib.makeLibraryPath runtimeDeps} \
	    $out/opt/aimp/AIMP
	'';
  meta = with pkgs.lib; {
    description = "AIMP 6 nightly build (native Linux)";
    homepage = "https://www.aimp.ru/";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "aimp";
  };
}
