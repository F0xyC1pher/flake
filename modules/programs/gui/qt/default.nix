{
	vars,
	lib,
	pkgs,
	...
}: {
	imports = [./kvantum-svg.nix];
	home-manager.users.${vars.user.name} = {vars, ...}: let
		c = vars.theme.colors;
		accentColor = vars.theme.accentColor;
		opacity = vars.theme.opacityHex;
		accentActiveBg = c.accent.bg.normal.${accentColor};
		accentActiveFg = c.accent.fg.normal.${accentColor};
		accentDimmedBg = c.accent.bg.dimmed.${accentColor};

		themeName = vars.theme.name;
		themeDir = "Kvantum/${themeName}";
	in {
		qt = {
			enable = true;
			platformTheme.name = "qt6ct";

			qt6ctSettings = {
				Appearance = {
					# custom_palette = true;
					standard_dialogs = "xdgdesktopportal";
					style = "kvantum-dark";
				};

				Fonts = {
					fixed = "\"${vars.theme.font.name},${toString vars.theme.font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1\"";
					general = "\"${vars.theme.font.name},${toString vars.theme.font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1\"";
				};
			};
		};

		xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
			[General]
			theme=${themeName}
		'';

		xdg.configFile."${themeDir}/${themeName}.kvconfig".text = ''
			[%General]
			author=theMe
			comment=Dynamic Generated Theme
			round_corners=false
			combo_focus_rect=true
			spread_menuitems=true
			left_tabs=true
			mirror_doc_tabs=true
			scroll_width=8
			attach_active_tab=true
			composite=true
			menu_shadow_depth=7
			tooltip_shadow_depth=0
			splitter_width=7
			check_size=16
			slider_width=4
			slider_handle_width=18
			slider_handle_length=18
			textless_progressbar=false
			menubar_mouse_tracking=true
			slim_toolbars=false
			toolbutton_style=1
			x11drag=menubar_and_primary_toolbar
			double_click=false
			translucent_windows=true
			# blurring=${lib.boolToString vars.theme.blur.enable}
			# popup_blurring=${lib.boolToString vars.theme.blur.enable}
			opaque=kaffeine,kmplayer,subtitlecomposer,kdenlive,vlc,smplayer,smplayer2,avidemux,avidemux2_qt4,avidemux3_qt4,avidemux3_qt5,kamoso,QtCreator,VirtualBox,trojita,dragon,digikam,qmplay2
			group_toolbar_buttons=false
			vertical_spin_indicators=false
			fill_rubberband=false
			spread_progressbar=true
			merge_menubar_with_toolbar=true
			small_icon_size=16
			large_icon_size=32
			button_icon_size=16
			scroll_arrows=false
			iconless_pushbutton=true
			toolbar_icon_size=16
			combo_as_lineedit=true
			button_contents_shift=false
			groupbox_top_label=true
			inline_spin_indicators=true
			joined_inactive_tabs=false
			layout_spacing=2
			submenu_overlap=0
			tooltip_delay=-1
			animate_states=false
			transient_scrollbar=true
			alt_mnemonic=true
			combo_menu=true
			layout_margin=4
			no_window_pattern=false
			respect_DE=true
			scroll_min_extent=36
			scrollable_menu=false
			scrollbar_in_view=false
			spin_button_width=16
			submenu_delay=250
			tree_branch_line=true
			progressbar_thickness=8
			click_behavior=0
			contrast=1.00
			dialog_button_layout=0
			drag_from_buttons=false
			hide_combo_checkboxes=false
			intensity=1.00
			no_inactiveness=false
			reduce_menu_opacity=0
			reduce_window_opacity=0
			saturation=1.00
			shadowless_popup=false
			transient_groove=false
			[Controls]
			# Ensure frame and button interior elements do not retain padding curves
			button_radius=0
			frame_radius=0
			[GeneralColors]
			   window.color=${c.base.ui.active.bg}${opacity}
			   base.color=${c.base.ui.active.bg}${opacity}
			   alt.base.color=${c.base.ui.active.overlay}${opacity}
			   button.color=${c.base.ui.active.surface}FF
			   light.color=${c.base.text.disabled.dimmed}FF
			   mid.light.color=${c.base.text.disabled.dimmed}FF
			   dark.color=${c.base.ui.active.bg}${opacity}
			   mid.color=${c.base.ui.active.bg}${opacity}
			   highlight.color=${accentActiveBg}FF
			   inactive.highlight.color=${accentDimmedBg}FF
			   tooltip.base.color=${c.base.ui.active.bg}${opacity}
			   text.color=${c.base.text.active.main}FF
			   window.text.color=${c.base.text.active.main}FF
			   button.text.color=${c.base.text.active.main}FF
			   disabled.text.color=${c.base.text.disabled.dimmed}${opacity}
			   tooltip.text.color=${c.base.text.active.main}FF
			   highlight.text.color=${accentActiveFg}FF
			   link.color=${c.base."0D"}FF
			   link.visited.color=${c.base."0B"}FF

			[ItemView]
			inherits=PanelButtonCommand
			frame.element=itemview
			interior.element=itemview
			frame=true
			interior=true
			text.iconspacing=3
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}

			[RadioButton]
			inherits=PanelButtonCommand
			frame=false
			interior.element=radio

			[CheckBox]
			inherits=PanelButtonCommand
			frame=false
			interior.element=checkbox

			[TreeExpander]
			indicator.element=tree
			indicator.size=8

			[ToolTip]
			frame.top=4
			frame.right=4
			frame.bottom=4
			frame.left=4
			frame=true

			[PanelButtonCommand]
			inherits=PanelButtonCommand
			interior.element=button
			frame.element=button
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}

			[PanelButtonTool]
			inherits=PanelButtonCommand

			[DockTitle]
			inherits=PanelButtonCommand
			interior=false
			frame=false
			text.margin.top=5
			text.margin.bottom=5
			text.margin.left=5
			text.margin.right=5
			indicator.size=0

			[Dock]
			interior.element=toolbar
			frame.element=toolbar
			frame=true
			interior=true

			[GroupBox]
			inherits=PanelButtonCommand
			interior.element=tabframe
			interior=true
			frame=false

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
			frame.element=common
			frame.top=1
			frame.bottom=1
			frame.left=1
			frame.right=1

			[Slider]
			inherits=PanelButtonCommand
			interior=true
			frame.element=slider
			interior.element=slider
			frame.top=3
			frame.bottom=3
			frame.left=3
			frame.right=3
			focusFrame=true

			[SliderCursor]
			inherits=PanelButtonCommand
			interior=true
			interior.element=slidercursor
			frame=false

			[LineEdit]
			inherits=PanelButtonCommand
			frame.element=lineedit
			interior.element=lineedit

			[IndicatorSpinBox]
			inherits=LineEdit
			frame.element=lineedit
			interior.element=lineedit
			frame.top=0
			frame.bottom=2
			frame.left=2
			frame.right=2
			indicator.size=8

			[DropDownButton]
			inherits=PanelButtonCommand
			frame.top=2
			frame.bottom=2
			frame.left=0
			frame.right=1
			indicator.size=8

			[ToolboxTab]
			inherits=PanelButtonCommand
			frame.element=tabframe
			frame.top=1
			frame.bottom=1
			frame.left=1
			frame.right=1

			[Tab]
			inherits=PanelButtonCommand
			interior.element=tab
			frame.element=tab
			frame.top=2
			frame.bottom=3
			frame.left=3
			frame.right=3
			indicator.size=10
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}
			focusFrame=true

			[TabBarFrame]
			inherits=GenericFrame
			frame=true
			frame.element=tabBarFrame
			interior=false
			frame.top=4
			frame.bottom=4
			frame.left=4
			frame.right=4

			[TabFrame]
			inherits=PanelButtonCommand
			frame.element=tabframe
			interior.element=tabframe

			[Dialog]
			inherits=TabBarFrame
			frame.element=tabframe
			interior=false
			frame=false
			frame.top=1
			frame.bottom=1
			frame.left=1
			frame.right=1

			[HeaderSection]
			inherits=PanelButtonCommand
			interior.element=header
			frame.element=header
			frame.top=0
			frame.bottom=1
			frame.left=1
			frame.right=1
			frame.expansion=0
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}
			indicator.element=harrow

			[SizeGrip]
			inherits=PanelButtonCommand
			frame=false
			interior=false
			indicator.element=resize-grip
			indicator.size=0

			[Toolbar]
			inherits=PanelButtonCommand
			interior.element=menubar
			frame.element=menubar
			frame=true
			frame.bottom=4
			frame.left=4
			frame.right=4
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}
			text.bold=false

			[MenuBar]
			inherits=PanelButtonCommand
			frame.element=menubar
			interior.element=menubar
			frame.bottom=0
			text.normal.color=${c.base.text.active.main}
			frame.expansion=0
			text.bold=false

			[ToolbarButton]
			frame.element=tbutton
			interior.element=tbutton
			indicator.element=arrow
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}
			text.bold=false

			[ToolbarLineEdit]
			frame.element=lineedit
			interior.element=lineedit

			[Scrollbar]
			inherits=PanelButtonCommand
			indicator.size=0
			interior=false
			frame=false

			[ScrollbarGroove]
			inherits=PanelButtonCommand
			interior=false
			frame=false

			[ScrollbarSlider]
			inherits=PanelButtonCommand
			interior=false
			frame.element=scrollbarslider
			frame.top=4
			frame.bottom=4
			frame.left=4
			frame.right=4

			[ProgressbarContents]
			inherits=PanelButtonCommand
			frame=true
			frame.element=progress-pattern
			interior.element=progress-pattern
			frame.top=2
			frame.bottom=2
			frame.left=2
			frame.right=2

			[Progressbar]
			inherits=PanelButtonCommand
			frame.element=progress
			interior.element=progress
			frame.top=2
			frame.bottom=2
			frame.left=2
			frame.right=2
			text.margin=0
			text.normal.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}
			text.bold=false
			frame.expansion=18

			[RadioButton]
			inherits=PanelButtonCommand

			[Menu]
			frame.element=menu
			interior.element=menu
			inherits=PanelButtonCommand
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}
			text.bold=false
			frame.top=3
			frame.bottom=3
			frame.left=3
			frame.right=3

			[MenuItem]
			inherits=PanelButtonCommand
			interior.element=menuitem
			indicator.size=8
			frame=true
			frame.element=menuitem
			frame.right=10
			frame.left=10
			text.focus.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.main}

			[MenuBarItem]
			inherits=PanelButtonCommand
			interior.element=menubaritem
			frame=false
			text.margin.top=3
			text.margin.bottom=3
			text.margin.left=5
			text.margin.right=5

			[StatusBar]
			inherits=Toolbar
			frame.element=toolbar
			font.bold=true
			text.normal.color=${c.base.text.active.main}
			frame=true
			frame.top=0
			frame.bottom=0

			[TitleBar]
			inherits=PanelButtonCommand
			frame=false
			interior=false
			text.margin.top=2
			text.margin.bottom=2
			text.margin.left=3
			text.margin.right=3

			[ComboBox]
			inherits=PanelButtonCommand
			indicator.size=8
			frame.top=3
			frame.bottom=3
			frame.left=3
			frame.right=3
			text.margin.top=1
			text.margin.bottom=1
			text.margin.left=3
			text.margin.right=3
			text.press.color=${c.base.text.active.main}
			text.toggle.color=${c.base.text.active.main}

			[ToolboxTab]
			inherits=PanelButtonCommand
			text.normal.color=${c.base.text.active.main}
			text.press.color=${c.base.text.active.main}
			text.focus.color=${c.base.text.active.main}

			[Hacks]
			# transparent_dolphin_view=true
			# blur_konsole=true
			# transparent_ktitle_label=true
			# transparent_menutitle=true
			respect_darkness=true
			kcapacitybar_as_progressbar=true
			force_size_grip=false
			iconless_pushbutton=true
			iconless_menu=false
			disabled_icon_opacity=100
			lxqtmainmenu_iconsize=0
			normal_default_pushbutton=true
			single_top_toolbar=false
			tint_on_mouseover=0
			# transparent_pcmanfm_sidepane=true
			# transparent_pcmanfm_view=true
			# blur_translucent=${lib.boolToString vars.theme.blur.enable}
			centered_forms=true
			kinetic_scrolling=true
			middle_click_scroll=false
			no_selection_tint=true
			# noninteger_translucency=false
			style_vertical_toolbars=false
			blur_only_active_window=false

			[Window]
			interior=true
			interior.element=window
			frame.top=0
			frame.bottom=0
			frame.left=0
			frame.right=0
		'';
	};
}
