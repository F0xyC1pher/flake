{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	# ========== TTY ==========
	console = {
		font = "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
		packages = with pkgs; [ terminus_font ];
		useXkbConfig = true;
		earlySetup = true;
	};
	# ========== LOCALE ==========
	i18n.defaultLocale = "ru_RU.UTF-8";
	i18n.supportedLocales = ["all"];
	# ========== TIME ==========
	time.timeZone = "Europe/Moscow";
}
