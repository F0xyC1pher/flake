{ config, pkgs, inputs, vars, ... }:
let
  # Короткий алиас, чтобы не писать длинную строку каждый раз
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
	stylix.targets.firefox = {
		enable = true;
		# ← Самое важное: явно указываем имена профилей, к которым применять тему
		profileNames = [ "${vars.userLongName}" ];   # если у тебя профиль называется иначе — пиши его имя
	};
	
	programs.firefox = {
		enable = true;
		
		profiles.${vars.userLongName} = {
			id = 0;
			name = "${vars.userLongName}";
			isDefault = true;
			
			extensions.packages = with addons; [
				ublock-origin
				sponsorblock
				return-youtube-dislikes
				stylus
				violentmonkey
				keepassxc-browser
				sidebery
			];
			
			settings = {
				"browser.startup.homepage" = "about:blank";
				"browser.newtabpage.enabled" = false;
				"browser.search.defaultenginename" = "DuckDuckGo";
				"extensions.pocket.enabled" = false;
				"identity.fxaccounts.enabled" = true;  # без Mozilla-аккаунта
				"toolkit.legacyUserProfileCustomizations.stylesheets" = true;  # userChrome
				"sidebar.verticalTabs" = false;  # для Sidebery
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
	};
}
