{
	config,
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {lib, ...}: let
			ffVersion = config.programs.firefox.package.version;
			rddEnabled = lib.versionOlder ffVersion "97.0.0";
			t = vars.style.theme;
			# c = vars.style.colors.accent;
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

						"media.ffmpeg.vaapi.enabled" = true;
						"media.hardware-video-decoding.force-enabled" = true;
						"media.rdd-ffmpeg.enabled" = lib.toString rddEnabled;
						"gfx.x11-egl.force-enabled" = true;
						"widget.dmabuf.force-enabled" = true;
					};
				};
			};
		};
	};
}
