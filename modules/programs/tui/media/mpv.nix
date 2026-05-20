{
  inputs,
  vars,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs vars;};
    users.${vars.user.name} = {pkgs, ...}: {
      programs.mpv = {
        enable = true;

        package = (
          pkgs.mpv.override {
            scripts = with pkgs.mpvScripts; [
              uosc
              sponsorblock
            ];

            mpv-unwrapped = pkgs.mpv-unwrapped.override {
              waylandSupport = true;
              ffmpeg = pkgs.ffmpeg-full;
            };
          }
        );

        config = {
          ytdl-format = "bestvideo+bestaudio";
          image-display-duration = "inf";
          input-vo-keyboard = "yes";
          vo-kitty-use-shm = "yes";
          profile = "high-quality";
          really-quiet = "yes";
          force-window = "no";
          keep-open = "yes";
          osd-bar = "yes";
          quiet = "yes";
          cache = "yes";
          loop = "yes";
          vo = "kitty";
          osc = "yes";
          osd-font = "${vars.theme.font.name}";
          osd-font-size = 30;
          video-rotate = "0";
          # auto-window-resize = "no";
          # video-unscaled = "yes";
          panscan = 1.0;
        };
      };
    };
  };
}
