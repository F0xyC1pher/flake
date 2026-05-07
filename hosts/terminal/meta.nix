{
	user = "cicada";
	host = "terminal";
	bootLoader = "grub"; #GRUB LIMINE
	hardware = {
		bluetooth = true;
		wifi = true;

		sound = {
			rate = 192000;
			format.prefix = "FLOAT"; # FLOAT S
			format.name = 32;
			format.suffix = "LE";
		};

		nvidia = {
			enable = true;
			package = "latest"; # "latest" "legacy_580" "legacy_470"
			perf = {
				# true для максимума | число для указания Ватт | "строка" процент Ватт от максимума | false | null
				value = true;
				persistence = true;
			};
		};
	};
}
