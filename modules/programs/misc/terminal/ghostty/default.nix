# ── Ghostty terminal ────────────────────────────────────────────────────────────
{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			programs.ghostty = {
				enable = true;
			};
		};
	};
}
