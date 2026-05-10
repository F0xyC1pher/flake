{...}: {
	security.pam.loginLimits = [
		{
			domain = "*";
			type = "soft";
			item = "nofile";
			value = "1048576";
		}
		{
			domain = "*";
			type = "hard";
			item = "nofile";
			value = "1048576";
		}
		# {
		# 	domain = "*";
		# 	type = "soft";
		# 	item = "nice";
		# 	value = "-20";
		# }
	];
}
