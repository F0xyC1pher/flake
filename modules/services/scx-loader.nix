{...}: {
	services.scx-loader = {
		enable = true;

		config = {
			default_sched = "scx_rusty";
			default_mode = "Auto"; # или "Server" если хочешь ещё больше throughput

			scheds = {
				scx_rusty = {
					auto_mode = ["--autopilot"]; # хороший баланс
					gaming_mode = ["--performance"]; # если вдруг понадобится
				};

				scx_lavd = {
					auto_mode = ["--autopilot"];
					gaming_mode = ["--performance" "--pinned-slice-us" "800"]; # тюнинг под старый 4c/8t CPU
				};
			};
		};
	};
}
