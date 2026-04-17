{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			services.linux-wallpaperengine = {
				enable = true;
				assetsPath = "/home/f/Games/SteamLibrary/steamapps/common/wallpaper_engine/assets";
			};
		};
	};
}
