{vars, ...}: {
	programs.shojiwm = {
		enable = true;
		initConfig = {
			enable = true;
			users = ["${vars.user.name}"];
		};
	};
}
