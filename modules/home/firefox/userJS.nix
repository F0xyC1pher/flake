{ config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.firefox = {
				enable = true;

				profiles.${vars.userFullName} = {
					userJS = builtins.toFile "user.js" ''
						user_pref("media.ffmpeg.vaapi.enabled", true);
						user_pref("media.hardware-video-decoding.force-enabled", true);
						user_pref("media.rdd-ffmpeg.enabled", true);
						user_pref("gfx.x11-egl.force-enabled", true);
						user_pref("widget.dmabuf.force-enabled", true);
					'';
				};
			};
		};
	};
}

