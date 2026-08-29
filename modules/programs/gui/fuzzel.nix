# ── Fuzzel — Wayland app launcher / dmenu ────────────────────────────────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			programs.fuzzel = {
				enable = true;
				settings = {
					main = {
						font = lib.mkForce "${vars.theme.font.name}:size=${toString vars.theme.font.size}";
						dpi-aware = true;
						use-bold = false;
						prompt = ">> ";
						icons-enabled = true;
						password-character = "*";
						match-mode = "fzf";
						sort-result = true;
						terminal = vars.app.terminal;
						list-executables-in-path = false;

						anchor = "center";
						lines = 18;
						width = 60;
						tabs = 4;
						horizontal-pad = 20;
						vertical-pad = 10;
						inner-pad = 10;

						keyboard-focus = "exclusive";
						exit-on-keyboard-focus-loss = true;

						auto-select = false;
						enable-mouse = false;
					};

					colors =
						lib.mkForce {
							background = "${vars.theme.style.ui.bg}${vars.theme.opacityHex}";
							text = "${vars.theme.style.text.main}ff";
							prompt = "${vars.theme.style.text.heading}ff";
							placeholder = "${vars.theme.style.text.dimmed}ff";
							input = "${vars.theme.style.text.main}ff";
							match = "${vars.theme.style.text.heading}ff";
							selection = "${vars.theme.style.accent}ff";
							selection-text = "${vars.theme.style.ui.bg}ff";
							selection-match = "${vars.theme.style.text.heading}ff";
							counter = "${vars.theme.style.text.dimmed}ff";
							border = "${vars.theme.style.accent}ff";
						};

					border = vars.theme.border;
				};
			};
		};
	};
}
