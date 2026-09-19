# ── Rio terminal ────────────────────────────────────────────────────────────
{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			programs.rio = {
				enable = true;
			};
		};
	};
}
