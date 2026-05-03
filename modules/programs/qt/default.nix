# ── Qt (Qt5 + Qt6) — Kvantum theme via qtct ──────────────────────────────────
# Stylix manages the Qt platform (qtct) and generates base colours from the
# base16 scheme. We layer a hand-crafted Kvantum theme on top so apps that
# support Kvantum get full role-tree fidelity. Apps falling back to qtct get
# Stylix's base16 colours automatically.
#
# We do NOT override qt.platformTheme or qt.style — those belong to Stylix.
# We only write config files and point qtct → kvantum.
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {
			pkgs,
			vars,
			lib,
			...
		}: let
			t = vars.style.theme;

			kvconfig = ''
				[%General]
				author=FoxyChipher
				comment=Role-driven dark theme — square mode
				x11drag=menubar_and_primary_toolbar
				alt_mnemonic=true
				left_tabs=true
				attach_active_tab=false
				mirror_doc_tabs=true
				group_toolbar_buttons=false
				toolbar_item_spacing=0
				toolbar_interior_spacing=2
				spread_progressbar=true
				composite=true
				menu_shadow_depth=6
				spread_menuitems=true
				tooltip_shadow_depth=4
				splitter_width=3
				scroll_width=8
				scroll_arrows=false
				scroll_min_extent=36
				slider_width=4
				slider_handle_width=14
				slider_handle_length=14
				tickless_slider_handle_size=10
				center_toolbar_handle=true
				check_size=14
				textless_progressbar=false
				progressbar_thickness=6
				menubar_mouse_tracking=true
				toolbutton_style=1
				double_click=false
				translucent_windows=false
				blurry_translucent=false
				popup_blurring=false
				vertical_spin_indicators=false
				spin_button_width=20
				fill_rubberband=false
				merge_menubar_with_toolbar=false
				small_icon_size=16
				large_icon_size=32
				button_icon_size=16
				toolbar_icon_size=22
				combo_as_lineedit=true
				animate_states=false
				button_contents_shift=false
				combo_menu=true
				hide_combo_checkboxes=false
				combo_focus_rect=false
				groupbox_top_label=true
				inline_spin_indicators=true
				joined_inactive_tabs=true
				layout_spacing=4
				layout_margin=6
				submenu_overlap=0
				submenu_delay=250
				tab_button_extra_margin=0
				tooltip_delay=-1
				tree_branch_line=true
				no_window_pattern=true
				reduce_window_opacity=0
				reduce_menu_opacity=0
				contrast=1.00
				intensity=1.00
				saturation=1.00
			'';

			kvcolors = ''
				[GeneralColors]
				window.color=${t.ui.main}
				base.color=${t.ui.deep}
				alt.base.color=${t.ui.surface}
				button.color=${t.ui.surface}
				light.color=${t.ui.overlay}
				mid.light.color=${t.ui.selection}
				mid.color=${t.ui.highlight}
				dark.color=${t.ui.border.inactive}
				shadow.color=${t.ui.deep}
				highlight.color=${t.accent}
				inactive.highlight.color=${t.ui.selection}
				text.color=${t.text.main}
				window.text.color=${t.text.main}
				button.text.color=${t.text.heading}
				base.text.color=${t.text.main}
				highlight.text.color=${t.text.onAccent}
				link.color=${t.text.syntax.info}
				link.visited.color=${t.text.syntax.match}
				tooltip.text.color=${t.text.main}
				tooltip.base.color=${t.ui.deep}

				[Hovered]
				window.color=${t.ui.main}
				base.color=${t.ui.surface}
				alt.base.color=${t.ui.overlay}
				button.color=${t.ui.overlay}
				light.color=${t.ui.selection}
				mid.light.color=${t.ui.highlight}
				mid.color=${t.ui.highlight}
				dark.color=${t.ui.border.active}
				shadow.color=${t.ui.deep}
				highlight.color=${t.accent}
				text.color=${t.text.heading}
				window.text.color=${t.text.heading}
				button.text.color=${t.text.heading}

				[Disabled]
				window.color=${t.ui.main}
				text.color=${t.text.faint}
				window.text.color=${t.text.faint}
				button.text.color=${t.text.faint}
				highlight.color=${t.ui.selection}
				highlight.text.color=${t.text.faint}
			'';

			fontStr5 = "${vars.fontName},${toString vars.fontSize},-1,5,50,0,0,0,0,0";
			fontStr6 = "${vars.fontName},${toString vars.fontSize},-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
		in {
			home.packages = with pkgs; [
				libsForQt5.qtstyleplugin-kvantum
				qt6Packages.qtstyleplugin-kvantum
				libsForQt5.qt5ct
				qt6Packages.qt6ct
				papirus-icon-theme
			];

			# ── Kvantum theme selection ───────────────────────────────────────────
			xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
				[General]
				theme=FoxyChipher
			'';
			xdg.configFile."Kvantum/FoxyChipher/FoxyChipher.kvconfig".text = kvconfig;
			xdg.configFile."Kvantum/FoxyChipher/FoxyChipher.colors".text = kvcolors;

			# ── qt5ct / qt6ct — point style at Kvantum ───────────────────────────
			xdg.configFile."qt5ct/qt5ct.conf".text = ''
				[Appearance]
				icon_theme=Papirus-Dark
				standard_dialogs=xdgdesktopportal
				style=kvantum

				[Fonts]
				fixed="${fontStr5}"
				general="${fontStr5}"

				[Interface]
				activate_item_on_single_click=1
				buttonbox_layout=0
				cursor_flash_time=1000
				dialog_buttons_have_icons=1
				double_click_interval=400
				gui_effects=@Invalid()
				keyboard_scheme=2
				menus_have_icons=true
				show_shortcuts_in_context_menus=true
				stylesheets=@Invalid()
				toolbutton_style=4
				underline_shortcut=1
				wheel_scroll_lines=3
			'';

			xdg.configFile."qt6ct/qt6ct.conf".text = ''
				[Appearance]
				icon_theme=Papirus-Dark
				standard_dialogs=xdgdesktopportal
				style=kvantum

				[Fonts]
				fixed="${fontStr6}"
				general="${fontStr6}"

				[Interface]
				activate_item_on_single_click=1
				buttonbox_layout=0
				cursor_flash_time=1000
				dialog_buttons_have_icons=1
				double_click_interval=400
				gui_effects=@Invalid()
				keyboard_scheme=2
				menus_have_icons=true
				show_shortcuts_in_context_menus=true
				stylesheets=@Invalid()
				toolbutton_style=4
				underline_shortcut=1
				wheel_scroll_lines=3
			'';

			# ── Stylix Qt target points at qtct; qtct points style → kvantum ─────
			# No qt.platformTheme override — Stylix owns that.
			home.sessionVariables = {
				QT_STYLE_OVERRIDE = lib.mkDefault "kvantum";
			};
		};
	};
}
