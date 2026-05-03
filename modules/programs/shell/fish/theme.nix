# ── Fish shell — colors + config ──────────────────────────────────────────────
# Replaces stylix.targets.fish (NixOS + HM).
# Full set_color mappings driven by role tree — zero hardcoded hex.
{
	inputs,
	vars,
	lib,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {
			programs.fish = {
				enable = true;
				interactiveShellInit = let
					t = vars.style.theme;
				in ''
					# ── FoxyChipher fish colors — role-driven ─────────────────────────
					set -g fish_color_normal           ${t.text.main}
					set -g fish_color_command          ${t.accent}
					set -g fish_color_keyword          ${t.text.syntax.keyword}
					set -g fish_color_quote            ${t.text.syntax.string}
					set -g fish_color_redirection      ${t.text.syntax.function}
					set -g fish_color_end              ${t.text.heading}
					set -g fish_color_error            ${t.text.syntax.error}
					set -g fish_color_param            ${t.text.main}
					set -g fish_color_valid_path       ${t.text.syntax.info} --underline
					set -g fish_color_option           ${t.text.sub-main}
					set -g fish_color_comment          ${t.text.comment}
					set -g fish_color_selection        --background=${t.ui.selection}
					set -g fish_color_search_match     --background=${t.ui.overlay}
					set -g fish_color_operator         ${t.text.syntax.info}
					set -g fish_color_escape           ${t.text.syntax.match}
					set -g fish_color_autosuggestion   ${t.text.faint}
					set -g fish_color_cancel           ${t.text.syntax.error}
					set -g fish_color_cwd              ${t.text.syntax.info}
					set -g fish_color_cwd_root         ${t.text.syntax.error}
					set -g fish_color_host             ${t.text.syntax.success}
					set -g fish_color_host_remote      ${t.text.syntax.warning}
					set -g fish_color_user             ${t.accent}
					set -g fish_color_status           ${t.text.syntax.error}
					set -g fish_color_bind             ${t.text.syntax.keyword}
					set -g fish_color_history_current  --bold

					set -g fish_pager_color_prefix              ${t.text.match}
					set -g fish_pager_color_completion          ${t.text.main}
					set -g fish_pager_color_description         ${t.text.faint}
					set -g fish_pager_color_progress            ${t.text.faint}
					set -g fish_pager_color_background          --background=${t.ui.surface}
					set -g fish_pager_color_selected_background --background=${t.ui.selection}
					set -g fish_pager_color_selected_prefix     ${t.accent}
					set -g fish_pager_color_selected_completion ${t.text.heading}
				'';

				shellAliases = {
					ls = "eza --icons";
					ll = "eza -la --icons";
					lt = "eza --tree --icons";
					cat = "bat";
					grep = "rg";
					yy = "yazi";
					gs = "git status";
					gl = "git log --oneline";
				};
			};
		};
	};
}
