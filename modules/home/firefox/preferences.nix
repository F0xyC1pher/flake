{ config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.firefox = {
				preferences = let ffVersion = config.programs.firefox.package.version; in {
					"media.ffmpeg.vaapi.enabled" = true;
					"media.hardware-video-decoding.force-enabled" = true;
					"media.rdd-ffmpeg.enabled" = lib.versionOlder ffVersion "97.0.0";
					
					"gfx.x11-egl.force-enabled" = true;
					"widget.dmabuf.force-enabled" = true;
				};
			};
		};
	};
}

