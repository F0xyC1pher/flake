{...}: {
	services.scx-loader = {
		enable = true;

		config = {
			default_sched = "scx_bpfland";
			default_mode = "Auto";

			scheds = {
				scx_bpfland = {
					auto_mode = ["--autopilot" "--lowlatency"];
					gaming_mode = ["--performance" "--lowlatency"];
				};
			};
		};
	};
}
