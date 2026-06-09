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
						# --- Истинно Индусы и Интеграции ---
						"browser.ai.control.linkPreviewKeyPoints" = "blocked";
						"browser.ai.control.pdfjsAltText" = "blocked";
						"browser.ai.control.smartTabGroups" = "blocked";
						"browser.ai.control.translations" = "blocked";
						"browser.ml.chat.page.footerBadge" = false;
						"browser.ml.chat.page.menuBadge" = false;
						"browser.ml.chat.provider" = "https://gemini.google.com";
						"browser.ml.chat.shortcuts" = false;
						"browser.ml.linkPreview.enabled" = false;
						"extensions.pocket.enabled" = false;

						# --- Внешний вид и темы ---
						"browser.compactmode.show" = true;
						"browser.settings-redesign.promo.dismissed" = true;
						"browser.smartwindow.nova.enabled" = false;
						"browser.tabs.allow_transparent_browser" = true;
						"browser.tabs.closeWindowWithLastTab" = false;
						"browser.tabs.inTitlebar" = false;
						"browser.tabs.tabMinWidth" = 0;
						"browser.toolbars.bookmarks.visibility" = "always";
						"layout.css.prefers-color-scheme.content-override" = 0;
						"layout.css.prefers-reduced-transparency.enabled" = false;
						"svg.context-properties.content.enabled" = true;
						"toolkit.legacyUserProfileCustomizations.stylesheets" = true;

						# --- Загрузки и Формы ---
						"browser.download.autohideButton" = false;
						"browser.download.panel.shown" = true;
						"browser.formfill.enable" = false;

						# --- Шрифты ---
						"font.minimum-size.x-cyrillic" = vars.theme.font.size;
						"font.minimum-size.x-western" = vars.theme.font.size;
						"font.size.monospace.x-cyrillic" = vars.theme.font.size;
						"font.size.monospace.x-western" = vars.theme.font.size;
						"font.size.variable.x-cyrillic" = vars.theme.font.size;
						"font.size.variable.x-western" = vars.theme.font.size;

						# --- Графика и Аппаратное Ускорение ---
						"browser.preferences.defaultPerformanceSettings.enabled" = false;
						"gfx.webgpu.ignore-blocklist" = true;
						"gfx.webrender.all" = true;
						"gfx.webrender.compositor" = true;
						"gfx.webrender.compositor.force-enabled" = true;
						"gfx.webrender.enabled" = true;
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
						"layers.acceleration.force-enabled" = true;
						"media.ffmpeg.vaapi.enabled" = true;
						"media.hardware-video-decoding.force-enabled" = true;
						"media.rdd-ffmpeg.enabled" = rddEnabled;

						# --- Синхронизация и аккаунт ---
						"identity.fxaccounts.account.device.name" = "${vars.user.name}@${vars.host}";
						"identity.fxaccounts.enabled" = true;

						# --- Страница новой вкладки и домашняя страница ---
						"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
						"browser.newtabpage.activity-stream.feeds.snippets" = false;
						"browser.newtabpage.activity-stream.feeds.topsites" = false;
						"browser.newtabpage.activity-stream.nova.enabled" = false;
						"browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
						"browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
						"browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
						"browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
						"browser.newtabpage.activity-stream.showSearch" = false;
						"browser.newtabpage.activity-stream.showSponsored" = false;
						"browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
						"browser.newtabpage.activity-stream.system.showSponsored" = false;
						"browser.newtabpage.enabled" = false;
						"browser.startup.homepage" = "about:blank";
						"browser.topsites.contile.enabled" = false;

						# --- Конфиденциальность и Защита ---
						"browser.aboutConfig.showWarning" = false;
						"browser.contentblocking.category" = {
							Value = "strict";
							Status = "locked";
						};
						"extensions.screenshots.disabled" = true;
						"privacy.donottrackheader.enabled" = true;

						# --- Боковая Панель ---
						"sidebar.main.tools" = "none";
						"sidebar.revamp" = false;
						"sidebar.verticalTabs" = false;
						"sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
						"sidebar.visibility" = "hide-sidebar";

						# --- Переводчик ---
						"browser.translations.automaticallyPopup" = false;
						"browser.translations.enable" = false;

						# --- Адресная строка и поиск ---
						"browser.ctrlTab.sortByRecentlyUsed" = true;
						"browser.search.defaultenginename" = "DuckDuckGo";
						"browser.search.suggest.enabled" = true;
						"browser.search.suggest.enabled.private" = false;
						"browser.tabs.tabmanager.enabled" = true;
						"browser.urlbar.showSearchSuggestionsFirst" = false;
						"browser.urlbar.suggest.searches" = false;

						# --- Wayland и Управление Окнами ---
						"widget.dmabuf.force-enabled" = true;
						"widget.gtk.rounded-bottom-corners.enabled" = true;
						"widget.transparent-windows" = true;
						"widget.wayland.opaque-by-default" = false;
					};
				};
			};
		};
	};
}
