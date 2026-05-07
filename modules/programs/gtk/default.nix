# GTK3 + GTK4 with enhanced CSS, focus indicators, backdrop states,
# and optional dark/light switching. Uses the resolved theme from `vars.theme.style`.
{
	pkgs,
	vars,
	lib,
	config,
	...
}: let
	t = vars.theme.style; # resolved role tree
	dark = vars.theme.dark or true;
	fontName = vars.theme.font.name or "Inter";
	fontSize = vars.theme.font.size or 11;

	# Common CSS color definitions (role‑based)
	colorDefs = ''
		/* ── Color definitions (from theMe roles) ────────────────────── */
		@define-color bg_deep        ${t.ui.deep};
		@define-color bg_main        ${t.ui.main};
		@define-color bg_surface     ${t.ui.surface};
		@define-color bg_overlay     ${t.ui.overlay};
		@define-color bg_selection   ${t.ui.selection};
		@define-color bg_highlight   ${t.ui.highlight};
		@define-color fg_main        ${t.text.main};
		@define-color fg_heading     ${t.text.heading};
		@define-color fg_faint       ${t.text.faint};
		@define-color fg_dimmed      ${t.text.dimmed};
		@define-color accent_color   ${t.accent};
		@define-color accent_fg      ${t.text.onAccent};
		@define-color border_active  ${t.ui.border.active};
		@define-color border_inact   ${t.ui.border.inactive};
		@define-color sem_error      ${t.text.syntax.error};
		@define-color sem_warning    ${t.text.syntax.warning};
		@define-color sem_success    ${t.text.syntax.success};
		@define-color sem_info       ${t.text.syntax.info};
	'';

	# Main CSS (square corners, full widget coverage, accessibility)
	baseCss = ''
		/* ── Square mode (no rounded corners) ───────────────────────── */
		* {
		  border-radius: 0;
		  -gtk-outline-radius: 0;
		  box-shadow: none;
		  background-image: none;
		}

		/* ── Focus indicators (accessibility) ───────────────────────── */
		*:focus-visible, *:focus {
		  outline: 2px solid @accent_color;
		  outline-offset: -2px;
		}
		button:focus-visible, entry:focus-visible, spinbutton:focus-visible {
		  outline-offset: 1px;
		}

		/* ── Windows & backgrounds ──────────────────────────────────── */
		window, dialog, .background {
		  background-color: @bg_main;
		  color: @fg_main;
		}
		.background:backdrop {
		  background-color: alpha(@bg_main, 0.97);
		}

		headerbar, .titlebar {
		  background-color: @bg_surface;
		  color: @fg_heading;
		  border-bottom: 1px solid @border_inact;
		  padding: 4px 8px;
		  box-shadow: none;
		}
		headerbar:backdrop, .titlebar:backdrop {
		  background-color: @bg_main;
		  color: @fg_faint;
		}
		.window-frame, .window-frame:backdrop {
		  border-style: none;
		  margin: 0;
		}

		/* ── Sidebar ────────────────────────────────────────────────── */
		.sidebar, sidebar, placessidebar, .navigation-sidebar {
		  background-color: @bg_surface;
		  border-right: 1px solid @border_inact;
		}
		.sidebar list row:selected, placessidebar row:selected {
		  background-color: @bg_overlay;
		  color: @accent_color;
		}

		/* ── Buttons ────────────────────────────────────────────────── */
		button {
		  background-color: @bg_surface;
		  color: @fg_main;
		  border: 1px solid @border_inact;
		  padding: 4px 12px;
		}
		button:hover {
		  background-color: @bg_overlay;
		  color: @fg_heading;
		  border-color: @border_active;
		}
		button:active, button:checked {
		  background-color: @accent_color;
		  color: @accent_fg;
		  border-color: @accent_color;
		}
		button:backdrop {
		  background-color: @bg_main;
		  color: @fg_faint;
		  border-color: @border_inact;
		}
		button.suggested-action {
		  background-color: @accent_color;
		  color: @accent_fg;
		}
		button.destructive-action {
		  background-color: @sem_error;
		  color: @bg_deep;
		}

		/* ── Entries & spinbuttons ──────────────────────────────────── */
		entry, spinbutton {
		  background-color: @bg_deep;
		  color: @fg_main;
		  border: 1px solid @border_inact;
		  padding: 4px 8px;
		  caret-color: @accent_color;
		}
		entry:focus, spinbutton:focus {
		  border-color: @accent_color;
		  outline: 2px solid @accent_color;
		  outline-offset: 0;
		}
		entry selection, spinbutton selection {
		  background-color: @bg_selection;
		  color: @fg_heading;
		}
		entry:backdrop, spinbutton:backdrop {
		  background-color: @bg_surface;
		  color: @fg_faint;
		}

		/* ── Lists & treeview ───────────────────────────────────────── */
		list, treeview {
		  background-color: @bg_main;
		  color: @fg_main;
		}
		list row:selected, treeview:selected {
		  background-color: @bg_overlay;
		  color: @accent_color;
		}
		list row:hover, treeview:hover {
		  background-color: @bg_surface;
		}
		list row:backdrop, treeview:backdrop {
		  background-color: @bg_main;
		  color: @fg_faint;
		}

		/* ── Notebook tabs ──────────────────────────────────────────── */
		notebook header {
		  background-color: @bg_surface;
		  border-bottom: 1px solid @border_inact;
		}
		notebook header tab {
		  background-color: @bg_surface;
		  color: @fg_faint;
		  padding: 6px 14px;
		  border: none;
		}
		notebook header tab:checked {
		  color: @accent_color;
		  background-color: @bg_main;
		  border-bottom: 2px solid @accent_color;
		  margin-bottom: -1px;
		}
		notebook header tab:hover {
		  color: @fg_heading;
		}

		/* ── Menus & popovers ───────────────────────────────────────── */
		menu, popover, popover.menu, .context-menu {
		  background-color: @bg_surface;
		  border: 1px solid @border_inact;
		  padding: 4px;
		}
		menuitem, popover modelbutton {
		  color: @fg_main;
		  padding: 4px 12px;
		}
		menuitem:hover, popover modelbutton:hover {
		  background-color: @bg_overlay;
		  color: @accent_color;
		}

		/* ── Switches & check/radio ─────────────────────────────────── */
		switch {
		  background-color: @bg_overlay;
		  border: 1px solid @border_inact;
		}
		switch:checked {
		  background-color: @accent_color;
		  border-color: @accent_color;
		}
		switch slider {
		  background-color: @fg_heading;
		}
		switch:backdrop slider {
		  background-color: @fg_dimmed;
		}
		checkbutton check, radiobutton radio {
		  background-color: @bg_deep;
		  border: 1px solid @border_inact;
		  min-width: 14px;
		  min-height: 14px;
		}
		checkbutton check:checked, radiobutton radio:checked {
		  background-color: @accent_color;
		  border-color: @accent_color;
		  color: @accent_fg;
		}

		/* ── Scrollbars ─────────────────────────────────────────────── */
		scrollbar {
		  background-color: @bg_main;
		  border: none;
		}
		scrollbar slider {
		  background-color: @bg_selection;
		  min-width: 8px;
		  min-height: 8px;
		}
		scrollbar slider:hover {
		  background-color: @bg_highlight;
		}
		scrollbar slider:active {
		  background-color: @accent_color;
		}

		/* ── Progress bars ──────────────────────────────────────────── */
		progressbar trough {
		  background-color: @bg_surface;
		  border: 1px solid @border_inact;
		}
		progressbar progress {
		  background-color: @accent_color;
		}

		/* ── Infobars (urgency) ─────────────────────────────────────── */
		.info,    infobar.info    { background-color: @bg_surface; color: @sem_info;    border-left: 3px solid @sem_info;    }
		.warning, infobar.warning { background-color: @bg_surface; color: @sem_warning; border-left: 3px solid @sem_warning; }
		.error,   infobar.error   { background-color: @bg_surface; color: @sem_error;   border-left: 3px solid @sem_error;   }
		.success, infobar.success { background-color: @bg_surface; color: @sem_success; border-left: 3px solid @sem_success; }

		/* ── Tooltips ───────────────────────────────────────────────── */
		tooltip {
		  background-color: @bg_deep;
		  border: 1px solid @border_inact;
		  color: @fg_main;
		  padding: 4px 8px;
		}

		/* ── Links & selection ──────────────────────────────────────── */
		*:link    { color: @sem_info;     }
		*:visited { color: @accent_color; }
		selection { background-color: @bg_selection; color: @fg_heading; }

		/* ── Additional widgets (calendar, combobox, search) ────────── */
		combobox arrow {
		  background-color: @bg_surface;
		  border: 1px solid @border_inact;
		}
		calendar {
		  background-color: @bg_main;
		  color: @fg_main;
		}
		calendar:selected {
		  background-color: @accent_color;
		  color: @accent_fg;
		}
		calendar.header {
		  background-color: @bg_surface;
		  color: @fg_heading;
		}
		.search-bar {
		  background-color: @bg_surface;
		  border-bottom: 1px solid @border_inact;
		}
		dialog .dialog-vbox, .message-dialog {
		  background-color: @bg_surface;
		}
	'';

	# GTK4‑only additions
	gtk4Only = ''
		/* GTK4 specific */
		.dropdown, popover list, .popover list {
		  background-color: @bg_surface;
		}
		.revealer {
		  transition: all 200ms ease;
		}
		.flat-toggle:checked {
		  background-color: @accent_color;
		  color: @accent_fg;
		}
	'';

	fullCss = colorDefs + baseCss;
in {
	home-manager.users.${vars.user.name} = {
		vars,
		lib,
		...
	}: {
		gtk = {
			enable = true;
			font = {
				name = vars.fontName or "Inter";
				size = vars.fontSize or 11;
			};
			theme = {
				name =
					if vars.useDarkTheme or true
					then "Adwaita-dark"
					else "Adwaita";
				package = pkgs.gnome-themes-extra;
			};
			iconTheme = {
				name =
					if vars.useDarkTheme or true
					then "Papirus-Dark"
					else "Papirus";
				package = pkgs.papirus-icon-theme;
			};

			gtk3.extraCss = lib.mkForce fullCss;
			gtk4.extraCss = lib.mkForce (fullCss + gtk4Only);

			gtk3.extraConfig = {
				gtk-application-prefer-dark-theme =
					if vars.useDarkTheme or true
					then 1
					else 0;
				gtk-decoration-layout = "menu:";
				gtk-enable-event-sounds = 0;
				gtk-enable-input-feedback-sounds = 0;
			};
			gtk4.extraConfig = {
				gtk-application-prefer-dark-theme =
					if vars.useDarkTheme or true
					then 1
					else 0;
				gtk-decoration-layout = "menu:";
			};
		};
	};
}
