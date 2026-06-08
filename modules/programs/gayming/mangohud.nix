# ── MangoHUD — overlay colors ─────────────────────────────────────────────────
# Replaces stylix.targets.mangohud. All colors via role tree.
# MangoHUD config uses hex WITHOUT # prefix.
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {
			lib,
			vars,
			...
		}: let
			hex = s: lib.removePrefix "#" s;
			t = vars.theme.style;
		in {
			programs.mangohud = {
				enable = true;
				settings = {
					# ── Layout ─────────────────────────────────────────────────────
					legacy_layout = false;
					gpu_stats = true;
					cpu_stats = true;
					ram = true;
					vram = true;
					fps = true;
					frametime = false;
					frame_timing = 1;
					battery = true;
					gamemode = true;
					wine = true;
					vulkan_driver = true;
					histogram = false;
					fps_limit = 0;
					vsync = 0;
					network = false;
					pci_dev = 0;
					position = "top-left";
					font_size = vars.theme.font.size;
					font_scale = 1.0;
					round_corners = 0; # square mode
					background_alpha = 0.6;

					# ── Colors — all from role tree ─────────────────────────────────
					# Format: RRGGBB (no #)
					gpu_color = hex t.accent; # accent
					cpu_color = hex t.text.syntax.keyword; # keyword (purple)
					vram_color = hex t.text.syntax.function; # function (blue)
					ram_color = hex t.text.syntax.info; # info (blue)
					io_color = hex t.text.syntax.success; # success
					network_color = hex t.text.syntax.match; # match
					battery_color = hex t.text.syntax.warning; # warning
					text_color = hex t.text.main;
					media_player_color = hex t.text.faint;
					wine_color = hex t.text.syntax.number;
					engine_color = hex t.text.syntax.string;

					background_color = hex t.ui.main;
				};
			};
		};
	};
}
