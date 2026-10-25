# ── Fonts — NixOS + HM fontconfig ────────────────────────────────────────────
{
  pkgs,
  vars,
  ...
}: {
  # ── NixOS-level font configuration ──────────────────────────────────────────
  fonts = {
    packages = with pkgs; [
      noto-fonts-color-emoji
      monocraft
      pixel-code
      cozette
      cascadia-code
      material-symbols
      font-awesome
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      enable = true;
      cache32Bit = true;
      antialias = true;
      allowBitmaps = true;
      useEmbeddedBitmaps = true;

      subpixel = {
        rgba = "none";
        lcdfilter = "default";
      };

      hinting = {
        enable = true;
        style = "full";
        autohint = false;
      };

      defaultFonts = {
        monospace = [vars.theme.font.name "Symbols Nerd Font Mono"];
        sansSerif = [vars.theme.font.name "Symbols Nerd Font Mono"];
        serif = [vars.theme.font.name "Symbols Nerd Font Mono"];
        emoji = ["Noto Color Emoji" "Symbols Nerd Font Mono"];
      };
      # localConf = ''
      #   <?xml version="1.0"?>
      #   <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      #   <fontconfig>
      #     <match target="scan">
      #       <test name="family" compare="eq">
      #         <string>CozetteVector</string>
      #       </test>
      #       <edit name="spacing" mode="assign">
      #         <int>100</int>
      #       </edit>
      #       <edit name="scalable" mode="assign">
      #         <bool>true</bool>
      #       </edit>
      #     </match>
      #   </fontconfig>
      # '';
    };
  };
}
