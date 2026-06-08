{
	# vars,
	...
}: {
	services.sysc-greet = {
		enable = true;
		# compositor = "niri";
		# Optional: Set initial session for auto-login
		# settings.initial_session = {
		#   command = "niri-session";
		#   user = "${vars.user.name}";
		# };
	};
}
