{
	config,
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: let
			# false = {
			# 	Value = false;
			# 	Status = "locked";
			# };
			# true = {
			# 	Value = true;
			# 	Status = "locked";
			# };
			ffVersion = config.programs.firefox.package.version;
			rddEnabled =
				if (lib.versionOlder ffVersion "97.0.0")
				then true
				else false;
		in {
			programs.firefox = {
				profiles.${vars.user.fullName} = {
					settings = {
						"browser.startup.homepage" = "about:blank";
						"browser.newtabpage.enabled" = false;
						"browser.search.defaultenginename" = "DuckDuckGo";
						"extensions.pocket.enabled" = false;
						"identity.fxaccounts.enabled" = true; # аккаунты Mozilla
						"toolkit.legacyUserProfileCustomizations.stylesheets" = true; # userChrome
						"sidebar.verticalTabs" = false;
						"sidebar.main.tools" = "none";
						"browser.settings-redesign.promo.dismissed" = true;
						"browser.tabs.tabmanager.enabled" = true;
						"browser.tabs.inTitlebar" = false;
						"browser.tabs.closeWindowWithLastTab" = false;
						"browser.tabs.allow_transparent_browser" = true;
						"browser.compactmode.show" = true;
						# "browser.uidensity" = 1; # compact
						"browser.smartwindow.nova.enabled" = false;
						"svg.context-properties.content.enabled" = true;
						"layers.acceleration.force-enabled" = true;
						"browser.tabs.tabMinWidth" = 0;
						"browser.toolbars.bookmarks.visibility" = "always";

						"widget.wayland.opaque-by-default" = false;
						"widget.transparent-windows" = true;
						"layout.css.prefers-reduced-transparency.enabled" = false;
						"widget.gtk.rounded-bottom-corners.enabled" = true;
						"sidebar.revamp" = false;
						"privacy.donottrackheader.enabled" = true;
						"sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
						"sidebar.visibility" = "hide-sidebar";
						"media.ffmpeg.vaapi.enabled" = true;
						"media.hardware-video-decoding.force-enabled" = true;
						"media.rdd-ffmpeg.enabled" = rddEnabled;
						"browser.preferences.defaultPerformanceSettings.enabled" = false;
						"gfx.webrender.all" = true;
						"gfx.webrender.enabled" = true;
						"gfx.webgpu.ignore-blocklist" = true;
						"gfx.webrender.compositor" = true;
						"gfx.webrender.compositor.force-enabled" = true;
						"gfx.webrender.svg-filter-effects" = true;
						"gfx.webrender.svg-filter-effects.also-convert-css-filters" = true;
						"gfx.webrender.svg-filter-effects.also-use-for-docshell-fecolormatrix" = false;
						"gfx.webrender.svg-filter-effects.feblend" = true;
						"gfx.webrender.svg-filter-effects.fecolormatrix" = true;
						"gfx.webrender.svg-filter-effects.fecomponenttransfer" = true;
						"gfx.webrender.svg-filter-effects.fecomposite" = true;
						"gfx.webrender.svg-filter-effects.feconvolvematrix" = true;
						"gfx.webrender.svg-filter-effects.fediffuselighting" = true;
						"gfx.webrender.svg-filter-effects.fedisplacementmap" = true;
						"gfx.webrender.svg-filter-effects.fedropshadow" = true;
						"gfx.webrender.svg-filter-effects.feflood" = true;
						"gfx.webrender.svg-filter-effects.fegaussianblur" = true;
						"gfx.webrender.svg-filter-effects.feimage" = true;
						"gfx.webrender.svg-filter-effects.femerge" = true;
						"gfx.webrender.svg-filter-effects.femorphology" = true;
						"gfx.webrender.svg-filter-effects.feoffset" = true;
						"gfx.webrender.svg-filter-effects.fespecularlighting" = true;
						"gfx.webrender.svg-filter-effects.fetile" = true;
						"gfx.webrender.svg-filter-effects.feturbulence" = true;
						"gfx.webrender.svg-filter-effects.opacity" = true;
						"gfx.webrender.svg-filter-effects.toalpha" = true;
						"gfx.webrender.svg-images" = true;
						"gfx.webrender.svg-shapes" = true;
						"gfx.webrender.unaccelerated-widget.force" = false;
						"gfx.webrender.use-optimized-shaders" = true;
						"gfx.x11-egl.force-enabled" = true;
						"widget.dmabuf.force-enabled" = true;
						"layout.css.prefers-color-scheme.content-override" = 0;
						"browser.contentblocking.category" = {
							Value = "strict";
							Status = "locked";
						};

						"browser.aboutConfig.showWarning" = false;
						"browser.ai.control.linkPreviewKeyPoints" = "blocked";
						"browser.ai.control.pdfjsAltText" = "blocked";
						"browser.ai.control.smartTabGroups" = "blocked";
						"browser.ai.control.translations" = "blocked";

						"browser.bookmarks.showMobileBookmarks" = false;
						"browser.ctrlTab.sortByRecentlyUsed" = true;

						"font.minimum-size.x-cyrillic" = vars.theme.font.size;
						"font.minimum-size.x-western" = vars.theme.font.size;
						"font.size.monospace.x-cyrillic" = vars.theme.font.size;
						"font.size.monospace.x-western" = vars.theme.font.size;
						"font.size.variable.x-cyrillic" = vars.theme.font.size;
						"font.size.variable.x-western" = vars.theme.font.size;

						"identity.fxaccounts.account.device.name" = "${vars.user.name}@${vars.host}";

						"browser.download.autohideButton" = false;
						"browser.download.panel.shown" = true;

						"browser.ml.chat.page.footerBadge" = false;
						"browser.ml.chat.page.menuBadge" = false;
						"browser.ml.chat.provider" = "https://gemini.google.com";
						"browser.ml.chat.shortcuts" = false;
						"browser.ml.linkPreview.enabled" = false;

						"extensions.screenshots.disabled" = true;
						"browser.topsites.contile.enabled" = false;
						"browser.formfill.enable" = false;
						"browser.search.suggest.enabled" = true;
						"browser.search.suggest.enabled.private" = false;
						"browser.urlbar.suggest.searches" = false;
						"browser.newtabpage.activity-stream.showSearch" = false;
						"browser.urlbar.showSearchSuggestionsFirst" = false;
						"browser.newtabpage.activity-stream.nova.enabled" = false;
						"browser.newtabpage.activity-stream.feeds.topsites" = false;
						"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
						"browser.newtabpage.activity-stream.feeds.snippets" = false;
						"browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
						"browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
						"browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
						"browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
						"browser.newtabpage.activity-stream.showSponsored" = false;
						"browser.newtabpage.activity-stream.system.showSponsored" = false;
						"browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
						"browser.translations.automaticallyPopup" = false;
						"browser.translations.enable" = false;
					};
				};
			};
		};
	};
}
