{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: let
			t = vars.style.theme;
			c = vars.style.colors.accent;
		in {
			programs.firefox = {
				profiles.${vars.userFullName} = {
					settings = {
						"browser.startup.homepage" = "about:blank";
						"browser.newtabpage.enabled" = false;
						"browser.search.defaultenginename" = "DuckDuckGo";
						"extensions.pocket.enabled" = false;
						"identity.fxaccounts.enabled" = true; # аккаунты Mozilla
						"toolkit.legacyUserProfileCustomizations.stylesheets" = true; # userChrome
						"sidebar.verticalTabs" = false;
						"sidebar.main.tools" = "none";
						"browser.tabs.tabmanager.enabled" = false;
						"browser.tabs.inTitlebar" = false;
						"browser.tabs.closeWindowWithLastTab" = false;
						"browser.compactmode.show" = true;
						"browser.uidensity" = 1; # compact
						"svg.context-properties.content.enabled" = true;
						"layers.acceleration.force-enabled" = true;
						"gfx.webrender.all" = true;
						"browser.tabs.tabMinWidth" = 0;
						"browser.display.background_color" = t.ui.main;
						"browser.display.foreground_color" = t.text.main;
						"browser.display.document_color_use" = 2;
					};
				};
			};
		};
	};
}
