{...}: {
	services.udev.extraRules = ''
		SUBSYSTEM=="sound", ACTION=="add", KERNEL=="card*", ATTR{power/control}="on"
		SUBSYSTEM=="sound", ACTION=="add", KERNEL=="controlC*", ATTR{power/control}="on"
		SUBSYSTEM=="sound", ACTION=="add", ATTR{power/control}="on"
	'';
}
