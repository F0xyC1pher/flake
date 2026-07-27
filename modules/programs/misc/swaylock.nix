# ── SwayNC — notification center ─────────────────────────────────────────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {
			pkgs,
			vars,
			...
		}: {
			programs.swaylock = {
				enable = true;
				package = pkgs.swaylock-effects;
			};
		};
	};
}
