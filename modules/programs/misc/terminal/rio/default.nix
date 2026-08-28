# ── Rio terminal ────────────────────────────────────────────────────────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.rio = {
				enable = true;
			};
		};
	};
}
