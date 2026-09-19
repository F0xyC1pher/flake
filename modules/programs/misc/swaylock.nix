# ── SwayNC — notification center ─────────────────────────────────────────────
{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.swaylock = {
				enable = true;
				package = pkgs.swaylock-effects;
			};
		};
	};
}
