{
	mainUser = "f";
	hostName = "p";
	bootLoader = "grub"; #GRUB LIMINE
	hardware = {
		bluetooth = true;
		wifi = true;

		sound = {
			rate = 192000;
		};

		nvidia = {
			enable = true;
			package = "legacy_580"; # "latest" "legacy_580" "legacy_470"
			perf = {
				# true для максимума | число для указания Ватт | "строка" процент Ватт от максимума | false | null
				value = true;
				persistence = true;
			};
		};
	};
}
