{ pkgs }:

let
  rofi-polkit-script = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Zebra2711/rofi-polkit-agent/heads/master/rofi-polkit-agent";
    sha256 = "sha256-zBcVx80KdkRtl2Zc5uEgAXbkY4wybm+qLh0fQqOzX3I=";
  };

in
pkgs.writeShellScriptBin "rofi-polkit-agent" ''
  ${builtins.readFile rofi-polkit-script}
''
