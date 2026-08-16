# ── Ghostty terminal ────────────────────────────────────────────────────────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.ghostty = {
				enable = true;
			};
		};
	};
}
