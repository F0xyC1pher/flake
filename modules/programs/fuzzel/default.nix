# ── Fuzzel — Wayland app launcher / dmenu ────────────────────────────────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {lib, ...}: {
			programs.fuzzel = {
				enable = true;
				settings = {
					main = {
						font = lib.mkForce "${vars.fontName}:size=${toString vars.fontSize}";
						dpi-aware = true;
						use-bold = false;
						prompt = ">> ";
						icons-enabled = true;
						password-character = "*";
						match-mode = "fzf";
						sort-result = true;
						terminal = vars.terminal;
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
							background = "${vars.style.theme.ui.deep}f0";
							text = "${vars.style.theme.text.main}ff";
							prompt = "${vars.style.theme.text.heading}ff";
							placeholder = "${vars.style.theme.text.faint}ff";
							input = "${vars.style.theme.text.main}ff";
							match = "${vars.style.theme.text.match}ff";
							selection = "${vars.style.theme.accent}ff";
							selection-text = "${vars.style.theme.ui.deep}ff";
							selection-match = "${vars.style.theme.text.match}ff";
							counter = "${vars.style.theme.text.faint}ff";
							border = "${vars.style.theme.accent}ff";
						};

					border = {
						width = 2;
						radius = 0;
					};
				};
			};
		};
	};
}
