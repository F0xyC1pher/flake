{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			programs.mpv = {
				enable = true;

				package = (
					pkgs.mpv.override {
						scripts = with pkgs.mpvScripts; [
							uosc
							sponsorblock
						];

						mpv-unwrapped =
							pkgs.mpv-unwrapped.override {
								waylandSupport = true;
								ffmpeg = pkgs.ffmpeg-full;
							};
					}
				);

				config = {
					profile = "high-quality";
					ytdl-format = "bestvideo+bestaudio";
					cache-default = 4000000;
					vo = "gpu";
					gpu-context = "wayland";
				};
				profiles = {
					kitty = {
						image-display-duration = "inf";
						keep-open = "yes";
						osd-bar = "yes";
						cache = "yes";
						loop = "yes";
						vo = "kitty";
						osc = "yes";
					};
				};
			};
		};
	};
}
