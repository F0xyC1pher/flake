{ config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.firefox = {
				profiles.${vars.userFullName} = {
					settings = {
						"browser.startup.homepage" = "about:blank";
						"browser.newtabpage.enabled" = false;
						"browser.search.defaultenginename" = "DuckDuckGo";
						"extensions.pocket.enabled" = false;
						"identity.fxaccounts.enabled" = true;  # аккаунты Mozilla
						"toolkit.legacyUserProfileCustomizations.stylesheets" = true;  # userChrome
						"sidebar.verticalTabs" = false;
						"sidebar.main.tools" = "none";
						"browser.tabs.tabmanager.enabled" = false;
						"browser.tabs.inTitlebar" = false;
						"browser.tabs.closeWindowWithLastTab" = false;
					};
				};
			};
		};
	};
}

