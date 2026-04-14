{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			# ========== HOME ==========
			# gtk = {
			# 	enable = true;
			# 	gtk3 = {
			# 	      extraConfig.gtk-application-prefer-dark-theme = true;
			# 	    };
			# };

			# qt = {
			# 	enable = true;
			# 	# platformTheme.name = lib.mkForce "qt6ct";
			# };

			# dconf.settings = {
			# 	"org/gtk/settings/file-chooser" = {
			#     	sort-directories-first = true;
			# 	};
			# };

			home.pointerCursor = {
				gtk.enable = true;
				x11.enable = true;
				package = pkgs.posy-cursors;
				name = "Posy_Cursor_Black";
				size = 32;
			};
		};
	};
}
