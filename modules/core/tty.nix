# ── Console colors ────────────────────────────────────────────────────────────
# Replaces stylix.targets.console. Sets the 16 VT color slots from the raw
# palette. NixOS console.colors takes hex strings WITHOUT the leading #.
{
  lib,
  vars,
  pkgs,
  ...
}:
let
  hex = s: lib.removePrefix "#" s;
  c.a = vars.theme.colors.accent;
  c.b = vars.theme.colors.base;
in
{
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    useXkbConfig = true;
    earlySetup = true;

    colors = [
      # Normal (0-7)
      (hex c.b."0") # 0  Black   → deepest bg
      (hex c.a.red) # 1  Red
      (hex c.a.green) # 2  Green
      (hex c.a.yellow) # 3  Yellow
      (hex c.a.blue) # 4  Blue
      (hex c.a.purple) # 5  Magenta
      (hex c.a.cyan) # 6  Cyan
      (hex c.b."d") # 7  White   → primary text

      # Bright (8-15)
      (hex c.b."4") # 8  Bright Black  → selection bg
      (hex c.a.red) # 9  Bright Red
      (hex c.a.green) # 10 Bright Green
      (hex c.a.yellow) # 11 Bright Yellow
      (hex c.a.blue) # 12 Bright Blue
      (hex c.a.purple) # 13 Bright Magenta
      (hex c.a.cyan) # 14 Bright Cyan
      (hex c.b."f") # 15 Bright White  → headings
    ];
  };
}
