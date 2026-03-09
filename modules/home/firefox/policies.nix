{ config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.firefox = {
				policies = {
					EnableTrackingProtection = {
						Value = true;
						Locked = true;
					};

					# Updates & Background Services
					AppAutoUpdate                 = false;
					BackgroundAppUpdate           = false;

					# Feature Disabling
					DisableBuiltinPDFViewer       = true;
					DisableFirefoxStudies         = true;
					DisableFirefoxAccounts        = false;
					DisableFirefoxScreenshots     = false;
					DisableForgetButton           = false;
					DisableMasterPasswordCreation = true;
					DisableProfileImport          = false;
					DisableProfileRefresh         = false;
					DisableSetDesktopBackground   = true;
					DisablePocket                 = true;
					DisableTelemetry              = true;
					DisableFormHistory            = true;
					DisablePasswordReveal         = true;

					NoDefaultBookmarks = true;
					# Access Restrictions
					BlockAboutConfig              = false;
					BlockAboutProfiles            = true;
					BlockAboutSupport             = true;

					# UI and Behavior
					# DisplayMenuBar                = "never";
					DontCheckDefaultBrowser       = true;
					HardwareAcceleration          = true;
					OfferToSaveLogins             = false;
					DefaultDownloadDirectory      = "/home/{vars.userName}/Downloads";
				};
			};
		};
	};
}

