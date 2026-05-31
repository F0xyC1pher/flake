{
  config,
  inputs,
  vars,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.user.name} =
      { lib, ... }:
      let
        ffVersion = config.programs.firefox.package.version;
        rddEnabled = if (lib.versionOlder ffVersion "97.0.0") then lock-true else lock-false;
        # t = vars.theme.style;
        lock-false = {
          Value = false;
          Status = "locked";
        };
        lock-true = {
          Value = true;
          Status = "locked";
        };
      in
      {
        programs.firefox = {
          profiles.${vars.user.fullName} = {
            settings = {
              "browser.startup.homepage" = "about:blank";
              "browser.newtabpage.enabled" = false;
              "browser.search.defaultenginename" = "DuckDuckGo";
              "extensions.pocket.enabled" = lock-false;
              "identity.fxaccounts.enabled" = true; # аккаунты Mozilla
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # userChrome
              "sidebar.verticalTabs" = lock-false;
              "sidebar.main.tools" = "none";
              # "browser.tabs.tabmanager.enabled" = lock-false;
              "browser.tabs.inTitlebar" = lock-false;
              "browser.tabs.closeWindowWithLastTab" = lock-false;
              # "browser.compactmode.show" = lock-true;
              # "browser.uidensity" = 1; # compact
              "svg.context-properties.content.enabled" = lock-true;
              "layers.acceleration.force-enabled" = lock-true;
              # "gfx.webrender.all" = true;
              "browser.tabs.tabMinWidth" = 0;
              # "browser.display.background_color" = t.ui.main;
              # "browser.display.foreground_color" = t.text.main;
              # "browser.display.document_color_use" = 2;//

              "media.ffmpeg.vaapi.enabled" = lock-true;
              "media.hardware-video-decoding.force-enabled" = lock-true;
              "media.rdd-ffmpeg.enabled" = rddEnabled;
              "gfx.x11-egl.force-enabled" = lock-true;
              "widget.dmabuf.force-enabled" = lock-true;

              "browser.contentblocking.category" = {
                Value = "strict";
                Status = "locked";
              };

              "extensions.screenshots.disabled" = lock-true;
              "browser.topsites.contile.enabled" = lock-false;
              "browser.formfill.enable" = lock-false;
              "browser.search.suggest.enabled" = lock-false;
              "browser.search.suggest.enabled.private" = lock-false;
              "browser.urlbar.suggest.searches" = lock-false;
              "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
              "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
              "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
              "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
              "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
              "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
              "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
              "browser.newtabpage.activity-stream.showSponsored" = lock-false;
              "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
            };
          };
        };
      };
  };
}
