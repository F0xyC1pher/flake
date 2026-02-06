{ config, pkgs, inputs, vars, ... }:
let
  # Короткий алиас, чтобы не писать длинную строку каждый раз
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
	programs.firefox = {
		enable = true;
		
		profiles.default = {
			id = 0;
			name = "Foxy_Chipher";
			isDefault = true;
			
			extensions = with addons; [
				ublock-origin;
				sponsorblock;
				return-youtube-dislike;
				stylus;
				violentmonkey;
				keepassxc-browser;
				sidebery;
			]
		};
		
		settings = {
			"browser.startup.homepage" = "about:blank";
			"browser.newtabpage.enabled" = false;
			"browser.search.defaultenginename" = "DuckDuckGo";
			"extensions.pocket.enabled" = false;
			"identity.fxaccounts.enabled" = false;  # без Mozilla-аккаунта
			"toolkit.legacyUserProfileCustomizations.stylesheets" = true;  # userChrome
			"sidebar.verticalTabs" = true;  # для Sidebery
			"browser.tabs.closeWindowWithLastTab" = false;
		};
	};
	
	policies = {
		DisableTelemetry = true;
		NoDefaultBookmarks = true;
		DisableFirefoxStudies = true;
		EnableTrackingProtection = {
			Value = true;
			Locked = true;
		};
	};
	
	# Если используешь Stylus → можно закинуть userContent.css / userChrome.css
	# home.file.".mozilla/firefox/default/chrome/userChrome.css".source = ./userChrome.css;
}
