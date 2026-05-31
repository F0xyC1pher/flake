{
  inputs,
  vars,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.user.name} =
      { ... }:
      {
        programs.firefox = {
          policies = {
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };

            # Updates & Background Services
            AppAutoUpdate = false;
            BackgroundAppUpdate = false;

            # Feature Disabling
            DisableBuiltinPDFViewer = true;
            DisableFirefoxStudies = true;
            DisableFirefoxAccounts = false;
            DisableFirefoxScreenshots = true;
            DisableForgetButton = false;
            DisableMasterPasswordCreation = true;
            DisableProfileImport = false;
            DisableProfileRefresh = false;
            DisableSetDesktopBackground = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DisableFormHistory = true;
            DisablePasswordReveal = true;
            NoDefaultBookmarks = true;
            # Access Restrictions
            BlockAboutConfig = false;
            BlockAboutProfiles = false;
            BlockAboutSupport = false;

            # UI and Behavior
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
            HardwareAcceleration = true;
            OfferToSaveLogins = false;
            DefaultDownloadDirectory = "/home/{vars.userName}/Downloads";
            DisplayBookmarksToolbar = "always"; # alternatives: "never" or "newtab"
            DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
            SearchBar = "unified"; # alternative: "separate"
          };
        };
      };
  };
}
