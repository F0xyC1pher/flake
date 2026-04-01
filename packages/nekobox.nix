# {pkgs, ...}:
# pkgs.stdenv.mkDerivation {
# 	pname = "nekobox";
# 	version = "custom";

# 	src = inputs.nekobox-src;

# 	nativeBuildInputs = [
# 		pkgs.cmake
# 		pkgs.ninja
# 		pkgs.pkg-config
# 		pkgs.go
# 		pkgs.thrift
# 		pkgs.protobuf
# 		pkgs.qt6.wrapQtAppsHook
# 	];

# 	buildInputs = [
# 		pkgs.qt6.qtbase
# 		pkgs.qt6.qtwayland
# 		pkgs.qt6.qtsvg
# 		pkgs.qt6.qttools
# 		pkgs.boost
# 		pkgs.acl # Добавили libacl, который просит лог
# 		pkgs.libsecret
# 		pkgs.libxkbcommon
# 		pkgs.libx11
# 		pkgs.glib
# 		pkgs.libGL
# 	];

# 	preConfigure = ''
# 		export HOME=$TMPDIR
# 		export GOPATH=$TMPDIR/go
# 	'';

# 	cmakeFlags = [
# 		"-DCMAKE_BUILD_TYPE=Release"
# 		"-DUSE_QT6=ON"
# 	];

# 	qtWrapperArgs = [
# 		"--set QT_QPA_PLATFORM wayland"
# 		"--set XDG_SESSION_TYPE wayland"
# 	];

# 	meta = with pkgs.lib; {
# 		description = "NekoBox Modern Fork (Source Build)";
# 		homepage = "https://github.com/qr243vbi/nekobox";
# 		platforms = platforms.linux;
# 	};
# }
