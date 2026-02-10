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
				"identity.fxaccounts.enabled" = true;  # аккаунты Mozilla
				"toolkit.legacyUserProfileCustomizations.stylesheets" = true;  # userChrome
				"sidebar.verticalTabs" = false;  # для Sidebery
				"sidebar.main.tools" = "none"; # или "" — скрывает стандартные инструменты в sidebar (history, bookmarks и т.д.), если они мешают
				"browser.tabs.tabmanager.enabled" = false; # иногда помогает отключить некоторые нативные фичи
				"browser.tabs.inTitlebar" = false; # если хочешь полностью убрать top bar (но обычно через userChrome)
				"browser.tabs.closeWindowWithLastTab" = false;
			};
			userChrome = ''
				#TabsToolbar {
					visibility: collapse !important;
				}
				/* Дополнительно, если sidebar-header от Firefox мешает */
				#sidebar-header {
					display: none !important;
				}
			'';
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
