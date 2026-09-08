{
	vars,
	lib,
	...
}: {
	boot.loader = let
		lowerLoader = lib.toLower vars.host.boot.loader;
	in
		if lowerLoader == "grub"
		then {
			grub.enable = true;
			grub.device = vars.host.boot.device;
			limine.enable = false;
		}
		else if lowerLoader == "limine"
		then {
			limine.enable = true;
			limine.biosDevice = vars.host.boot.device;
			limine.enableEditor = true;
			limine.extraConfig = ''
				remember_last_entry: yes
			'';
			grub.enable = false;
		}
		else throw "Unknown boot loader: ${vars.host.boot.loader}";
}
