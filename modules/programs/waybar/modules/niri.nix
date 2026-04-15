{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/niri.json".text = ''
				# json
				{
					"niri/workspaces" = {
						on-click = "activate";
						current-only = false;
						format = "{icon}";
						format-icons = {
							"1" = "一";
							"2" = "二";
							"3" = "三";
							"4" = "四";
							"5" = "五";
							"6" = "六";
							"7" = "七";
							"8" = "八";
							"9" = "九";
							"10" = "十";
							"11" = "一";
						};
						persistent-workspaces = {
							"DVI-D-1" = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
						};
					};

					"niri/language" = {
						format = "Язык: {}";
						format-en = "🇺🇸 EN";
						format-ru = "🇷🇺 RU";
						interval = 1;
					};
				}
			'';
		};
	};
}
