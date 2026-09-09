{
	vars,
	lib,
	pkgs,
	...
}: {
	home-manager.users.${vars.user.name} = {vars, ...}: let
		c = vars.theme.colors;
		accentColor = vars.theme.accentColor;

		accentActiveBg = c.accent.bg.normal.${accentColor};
		accentActiveFg = c.accent.fg.normal.${accentColor};
		accentDimmedBg = c.accent.bg.dimmed.${accentColor};

		toQtColor = alpha: color: let
			cleanColor = lib.removePrefix "#" color;
			len = builtins.stringLength cleanColor;
		in
			if len == 6
			then "#${alpha}${cleanColor}"
			else color;

		formatPalette = colors: builtins.concatStringsSep ", " (map (toQtColor "ff") colors);

		themeName = vars.theme.name;
		themeDir = "Kvantum/${themeName}";
	in {
		qt = {
			enable = true;
			platformTheme.name = "qt6ct";

			qt6ctSettings = {
				Appearance = {
					custom_palette = true;
					standard_dialogs = "xdgdesktopportal";
					style = "kvantum-dark";
				};

				Fonts = {
					fixed = "\"${vars.theme.font.name},${toString vars.theme.font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1\"";
					general = "\"${vars.theme.font.name},${toString vars.theme.font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1\"";
				};

				ColorScheme = {
					active_colors =
						formatPalette [
							c.base.text.active.main
							c.base.ui.active.surface
							c.base.ui.active.overlay
							c.base.ui.active.surface
							c.base.ui.active.border
							c.base.ui.active.bg
							c.base.text.active.main
							c.base.text.active.heading
							c.base.text.active.main
							c.base.ui.active.bg
							c.base.ui.active.bg
							c.base.ui.active.border
							accentActiveBg
							accentActiveFg
							c.base."0D"
							c.base."0B"
							c.base.ui.active.overlay
							c.base.ui.active.surface
							c.base.ui.active.surface
							c.base.text.active.main
							(toQtColor "80" c.base.text.active.dimmed)
							accentActiveBg
						];

					inactive_colors =
						formatPalette [
							c.base.text.inactive.main
							c.base.ui.inactive.surface
							c.base.ui.inactive.overlay
							c.base.ui.inactive.surface
							c.base.ui.inactive.border
							c.base.ui.inactive.bg
							c.base.text.inactive.main
							c.base.text.inactive.heading
							c.base.text.inactive.main
							c.base.ui.inactive.bg
							c.base.ui.inactive.bg
							c.base.ui.inactive.border
							accentDimmedBg
							c.base.text.inactive.main
							c.base."0D"
							c.base."0B"
							c.base.ui.inactive.overlay
							c.base.ui.inactive.surface
							c.base.ui.inactive.surface
							c.base.text.inactive.main
							(toQtColor "80" c.base.text.inactive.dimmed)
							accentDimmedBg
						];

					disabled_colors =
						formatPalette [
							c.base.text.disabled.dimmed
							c.base.ui.disabled.surface
							c.base.ui.disabled.overlay
							c.base.ui.disabled.surface
							c.base.ui.disabled.border
							c.base.ui.disabled.bg
							c.base.text.disabled.dimmed
							c.base.text.disabled.heading
							c.base.text.disabled.dimmed
							c.base.ui.disabled.bg
							c.base.ui.disabled.bg
							c.base.ui.disabled.border
							c.base.ui.disabled.overlay
							c.base.text.disabled.comment
							c.base.text.disabled.dimmed
							c.base.text.disabled.dimmed
							c.base.ui.disabled.overlay
							c.base.ui.disabled.surface
							c.base.ui.disabled.surface
							c.base.text.disabled.dimmed
							(toQtColor "66" c.base.text.disabled.comment)
							c.base.ui.disabled.border
						];
				};
			};
		};

		xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
			[General]
			theme=${themeName}
		'';

		# Берём валидный SVG ArcDark прямо из пакета arc-theme
		xdg.configFile."${themeDir}/${themeName}.svg".source = "${pkgs.arc-theme}/share/Kvantum/ArcDark/ArcDark.svg";

		xdg.configFile."${themeDir}/${themeName}.kvconfig".text = ''
			[%General]
			author=Tsu Jan & theMe
			comment=Arc inspired dynamic theme
			x11drag=menubar_and_primary_toolbar
			alt_mnemonic=true
			left_tabs=true
			attach_active_tab=true
			mirror_doc_tabs=true
			group_toolbar_buttons=false
			toolbar_item_spacing=1
			toolbar_interior_spacing=3
			spread_progressbar=true
			composite=true
			menu_shadow_depth=5
			menu_separator_height=6
			tooltip_shadow_depth=6
			splitter_width=4
			scroll_width=9
			scroll_arrows=false
			scroll_min_extent=60
			slider_width=6
			slider_handle_width=18
			slider_handle_length=18
			center_toolbar_handle=true
			check_size=14
			textless_progressbar=false
			progressbar_thickness=3font
			menubar_mouse_tracking=true
			toolbutton_style=1
			click_behavior=0
			translucent_windows=false
			blurring=false
			popup_blurring=false
			vertical_spin_indicators=false
			spin_button_width=32
			fill_rubberband=false
			merge_menubar_with_toolbar=true
			small_icon_size=16
			large_icon_size=32
			button_icon_size=16
			toolbar_icon_size=22
			combo_as_lineedit=true
			animate_states=false
			combo_menu=true
			hide_combo_checkboxes=true
			combo_focus_rect=true
			groupbox_top_label=true
			inline_spin_indicators=false
			joined_inactive_tabs=false
			layout_spacing=6
			layout_margin=9
			scrollbar_in_view=true
			transient_scrollbar=true
			transient_groove=true
			submenu_overlap=3
			tooltip_delay=-1
			tree_branch_line=true

			[GeneralColors]
			window.color=${c.base.ui.active.bg}
			base.color=${c.base.ui.active.bg}
			alt.base.color=${c.base.ui.active.overlay}
			button.color=${c.base.ui.active.surface}
			light.color=${c.base.ui.active.overlay}
			mid.light.color=${c.base.ui.active.surface}
			dark.color=${c.base.ui.active.border}
			mid.color=${c.base.ui.active.bg}
			highlight.color=${accentActiveBg}
			inactive.highlight.color=${accentDimmedBg}
			text.color=${c.base.text.active.main}
			window.text.color=${c.base.text.active.main}
			button.text.color=${c.base.text.active.main}
			disabled.text.color=${c.base.text.disabled.dimmed}
			tooltip.text.color=${c.base.text.active.main}
			highlight.text.color=${accentActiveFg}
			link.color=${c.base."0D"}
			link.visited.color=${c.base."0B"}
			progress.indicator.text.color=${accentActiveFg}

			[Hacks]
			transparent_ktitle_label=true
			transparent_dolphin_view=false
			transparent_pcmanfm_sidepane=true
			blur_translucent=false
			transparent_menutitle=true
			respect_darkness=true
			force_size_grip=true
			iconless_pushbutton=true
			iconless_menu=false
			disabled_icon_opacity=100
			lxqtmainmenu_iconsize=22
			normal_default_pushbutton=true
			single_top_toolbar=true
			tint_on_mouseover=0
			transparent_pcmanfm_view=false

			[PanelButtonCommand]
			frame=true
			frame.element=button
			frame.top=3
			frame.bottom=3
			frame.left=3
			frame.right=3
			interior=true
			interior.element=button
			indicator.size=9
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.heading}
			text.press.color=${accentActiveFg}
			text.toggle.color=${accentActiveFg}
			text.shadow=0
			text.margin=1
			text.iconspacing=4
			indicator.element=arrow
			text.margin.top=2
			text.margin.bottom=2
			text.margin.left=2
			text.margin.right=2
			min_width=+0.3font
			min_height=+0.3font
			frame.expansion=6

			[PanelButtonTool]
			inherits=PanelButtonCommand

			[Dock]
			inherits=PanelButtonCommand
			interior.element=dock
			frame.element=dock
			frame.top=1
			frame.bottom=1
			frame.left=1
			frame.right=1
			text.normal.color=${c.base.text.active.main}

			[DockTitle]
			inherits=PanelButtonCommand
			frame=false
			interior=false
			text.normal.color=${c.base.text.active.dimmed}
			text.focus.color=${c.base.text.active.heading}
			text.bold=true

			[IndicatorSpinBox]
			inherits=PanelButtonCommand
			frame=true
			interior=true
			frame.left=1
			indicator.element=spin
			indicator.size=10
			text.normal.color=${c.base.text.active.main}

			[RadioButton]
			inherits=PanelButtonCommand
			frame=false
			interior.element=radio
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.heading}

			[CheckBox]
			inherits=PanelButtonCommand
			frame=false
			interior.element=checkbox
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.heading}

			[Focus]
			inherits=PanelButtonCommand
			frame=true
			frame.element=focus
			frame.top=1
			frame.bottom=1
			frame.left=1
			frame.right=1
			frame.patternsize=20

			[GenericFrame]
			inherits=PanelButtonCommand
			frame=true
			interior=false
			frame.element=common
			interior.element=common
			frame.top=3
			frame.bottom=3
			frame.left=3
			frame.right=3

			[LineEdit]
			inherits=PanelButtonCommand
			frame.element=lineedit
			interior.element=lineedit
			text.margin.left=1
			text.margin.right=1

			[DropDownButton]
			inherits=PanelButtonCommand
			indicator.element=arrow-down

			[IndicatorArrow]
			indicator.element=arrow
			indicator.size=9

			[ToolboxTab]
			inherits=PanelButtonCommand
			text.normal.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.dimmed}
			text.focus.color=${c.base.text.active.heading}

			[Tab]
			inherits=PanelButtonCommand
			interior.element=tab
			text.margin.left=8
			text.margin.right=8
			text.margin.top=2
			text.margin.bottom=2
			frame.element=tab
			indicator.element=tab
			frame.top=4
			frame.bottom=4
			frame.left=4
			frame.right=4
			text.normal.color=${c.base.text.inactive.main}
			text.focus.color=${c.base.text.active.main}
			text.toggle.color=${accentActiveFg}
			frame.expansion=0

			[TabFrame]
			inherits=PanelButtonCommand
			frame.element=tabframe
			interior.element=tabframe
			frame.top=4
			frame.bottom=4
			frame.left=4
			frame.right=4

			[TreeExpander]
			inherits=PanelButtonCommand
			indicator.size=12
			indicator.element=tree

			[HeaderSection]
			inherits=PanelButtonCommand
			interior.element=header
			frame.element=header
			frame.top=3
			frame.bottom=3
			frame.left=1
			frame.right=1
			text.bold=true
			text.normal.color=${c.base.text.active.dimmed}
			text.focus.color=${accentActiveBg}
			text.toggle.color=${c.base.text.active.heading}
			frame.expansion=0

			[SizeGrip]
			indicator.element=resize-grip

			[Toolbar]
			inherits=PanelButtonCommand
			indicator.element=toolbar
			indicator.size=5
			text.margin=0
			frame=false
			interior.element=menubar
			frame.element=menubar
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.heading}
			frame.bottom=0
			frame.expansion=0

			[Slider]
			inherits=PanelButtonCommand
			frame.element=slider
			interior.element=slider
			frame.top=3
			frame.bottom=3
			frame.left=3
			frame.right=3

			[SliderCursor]
			inherits=PanelButtonCommand
			frame=false
			interior.element=slidercursor

			[Progressbar]
			inherits=PanelButtonCommand
			frame.element=progress
			interior.element=progress
			text.margin=0
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.heading}
			text.press.color=${accentActiveFg}
			text.toggle.color=${accentActiveFg}
			text.bold=false
			frame.expansion=8

			[ProgressbarContents]
			inherits=PanelButtonCommand
			frame=true
			frame.element=progress-pattern
			interior.element=progress-pattern

			[ItemView]
			inherits=PanelButtonCommand
			text.margin=0
			frame.element=itemview
			interior.element=itemview
			frame.top=2
			frame.bottom=2
			frame.left=2
			frame.right=2
			text.margin.top=2
			text.margin.bottom=2
			text.margin.left=4
			text.margin.right=4
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.heading}
			text.press.color=${accentActiveFg}
			text.toggle.color=${accentActiveFg}
			frame.expansion=0

			[Splitter]
			indicator.size=48

			[Scrollbar]
			inherits=PanelButtonCommand
			indicator.element=arrow
			indicator.size=10

			[ScrollbarSlider]
			inherits=PanelButtonCommand
			frame.element=scrollbarslider
			interior=false
			frame.left=6
			frame.right=6
			frame.top=6
			frame.bottom=6
			indicator.element=grip
			indicator.size=13
			frame.expansion=48

			[ScrollbarGroove]
			inherits=PanelButtonCommand
			interior=false
			frame=false

			[MenuItem]
			inherits=PanelButtonCommand
			frame=true
			frame.element=menuitem
			interior.element=menuitem
			indicator.element=menuitem
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${accentActiveFg}
			text.margin.top=1
			text.margin.bottom=1
			text.margin.left=15
			text.margin.right=5
			frame.top=3
			frame.bottom=3
			frame.left=3
			frame.right=3
			frame.expansion=0

			[MenuBar]
			inherits=PanelButtonCommand
			frame.element=menubar
			interior.element=menubar
			frame.bottom=0
			frame.expansion=0

			[MenuBarItem]
			inherits=PanelButtonCommand
			interior=true
			interior.element=menubaritem
			frame.element=menubaritem
			frame.top=2
			frame.bottom=2
			frame.left=2
			frame.right=2
			text.margin.left=4
			text.margin.right=4
			text.margin.top=0
			text.margin.bottom=0
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${accentActiveFg}
			frame.expansion=0

			[TitleBar]
			inherits=PanelButtonCommand
			frame=false
			interior.element=titlebar
			indicator.size=12
			indicator.element=mdi
			text.normal.color=${c.base.text.active.dimmed}
			text.focus.color=${c.base.text.active.heading}
			text.bold=true
			text.italic=true
			frame.expansion=0

			[ComboBox]
			inherits=PanelButtonCommand
			interior.element=combo
			frame.element=combo
			text.press.color=${c.base.text.active.main}
			indicator.element=carrow

			[Menu]
			inherits=PanelButtonCommand
			frame.top=1
			frame.bottom=1
			frame.left=1
			frame.right=1
			frame.element=menu
			interior.element=menu
			text.normal.color=${c.base.text.active.main}
			text.shadow=false
			frame.expansion=0

			[GroupBox]
			inherits=GenericFrame
			frame=false
			text.shadow=0
			text.margin=0
			text.normal.color=${c.base.text.active.dimmed}
			text.focus.color=${c.base.text.active.heading}
			text.bold=true
			frame.expansion=0

			[TabBarFrame]
			inherits=GenericFrame
			frame=true
			frame.element=tabBarFrame
			interior=false
			frame.top=4
			frame.bottom=4
			frame.left=4
			frame.right=4

			[ToolTip]
			inherits=GenericFrame
			frame.top=3
			frame.bottom=3
			frame.left=3
			frame.right=3
			interior=true
			text.shadow=0
			text.margin=0
			interior.element=tooltip
			frame.element=tooltip
			frame.expansion=0

			[StatusBar]
			inherits=GenericFrame
			frame=false
			interior=false

			[Window]
			interior=true
			interior.element=window
		'';
	};
}
