{ pkgs }:

let
  rofi-polkit-script = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/czaplicki/rofi-polkit-agent/master/rofi-polkit-agent";
    sha256 = "1lv5m291v45akj7kh2z29sjk8hd36bdf5c1h7saxvl8dkr6jm00y";
  };

in
pkgs.writeShellScriptBin "rofi-polkit-agent" ''
  #!/usr/bin/env bash
  ${builtins.readFile rofi-polkit-script}
''
