{...}: {
	services.flatpak = {
		enable = true;
		# Optional: Configure Flathub remote (recommended)
		remotes = [
			{
				name = "flathub";
				url = "https://flathub.org/repo/flathub.flatpakrepo";
			}
		];

		# Declaratively install Sober
		packages = [
			"org.vinegarhq.Sober" # This is the main app ID
		];

		# Optional but recommended: automatically remove any Flatpaks not declared here
		removeUnmanagedPackages = true;

		# Optional: Auto-update Flatpaks weekly
		update = {
			auto = {
				enable = true;
				onCalendar = "weekly"; # or "daily", etc.
			};
		};
	};
}
