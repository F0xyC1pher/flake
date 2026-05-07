# ── Pointer cursor ────────────────────────────────────────────────────────────
{vars, ...}: {
	home-manager.users.${vars.user.name} = {pkgs, ...}: {
		home.pointerCursor = {
			gtk.enable = true;
			x11.enable = true;
			package = pkgs.posy-cursors;
			name = "Posy_Cursor_Black";
			size = 32;
		};
	};
}
