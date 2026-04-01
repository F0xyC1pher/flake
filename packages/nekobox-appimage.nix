# {pkgs, ...}: let
# 	pname = "nekobox";
# 	version = "5.10.29";
# in
# 	pkgs.appimageTools.wrapType2 {
# 		inherit pname version;

# 		src = inputs.nekobox-appimage;

# 		extraPkgs = pkgs:
# 			with pkgs; [
# 				libkrb5
# 				keyutils
# 				icu
# 				openssl
# 				zlib
# 				libsecret
# 				libexttextcat
# 			];

# 		extraInstallCommands = ''
# 			# Добавляем version в extract, иначе билд падает
# 			install -m 444 -D ${pkgs.appimageTools.extract {
# 					inherit pname version;
# 					src = inputs.nekobox-appimage;
# 				}}/nekobox.desktop $out/share/applications/nekobox.desktop

# 			substituteInPlace $out/share/applications/nekobox.desktop \
# 			  --replace "Exec=nekobox" "Exec=$out/bin/nekobox"
# 		'';
# 	}
