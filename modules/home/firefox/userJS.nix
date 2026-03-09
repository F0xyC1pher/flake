{ config, pkgs, inputs, vars, lib, ... }:
let
	ffVersion = config.programs.firefox.package.version;
	rddEnabled = lib.versionOlder ffVersion "97.0.0";
in 
{
	home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {
		home.file.".mozilla/firefox/${vars.userFullName}/user.js".text = ''
			user_pref("media.ffmpeg.vaapi.enabled", true);
			user_pref("media.hardware-video-decoding.force-enabled", true);
			user_pref("media.rdd-ffmpeg.enabled", ${lib.toString rddEnabled});
			user_pref("gfx.x11-egl.force-enabled", true);
			user_pref("widget.dmabuf.force-enabled", true);
		'';
	};
}
