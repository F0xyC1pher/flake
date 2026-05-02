{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.yazi = {
				theme = {
					manager = {
						cwd = {fg = vars.style.theme.text.syntax.info;};

						hovered = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.accent;
							bold = true;
						};
						preview_hovered = {underline = true;};

						find_keyword = {
							fg = vars.style.theme.text.syntax.warning;
							bold = true;
							italic = true;
						};
						find_position = {
							fg = vars.style.theme.text.syntax.match;
							bold = true;
							italic = true;
						};

						marker_copied = {
							fg = vars.style.theme.text.syntax.error;
							bg = vars.style.theme.text.syntax.error;
						};
						marker_cut = {
							fg = vars.style.theme.accent;
							bg = vars.style.theme.accent;
						};
						marker_marked = {
							fg = vars.style.theme.text.syntax.success;
							bg = vars.style.theme.text.syntax.success;
						};
						marker_selected = {
							fg = vars.style.theme.text.syntax.keyword;
							bg = vars.style.theme.text.syntax.keyword;
						};

						tab_active = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.accent;
						};
						tab_inactive = {
							fg = vars.style.theme.text.faint;
							bg = vars.style.theme.ui.surface;
						};
						tab_width = 1;

						count_copied = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.text.syntax.error;
						};
						count_cut = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.accent;
						};
						count_selected = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.text.syntax.keyword;
						};

						border_symbol = "│";
						border_style = {fg = vars.style.theme.ui.border.inactive;};
						syntect_theme = "";
					};

					status = {
						separator_open = "";
						separator_close = "";
						separator_style = {
							fg = vars.style.theme.ui.border.inactive;
							bg = vars.style.theme.ui.surface;
						};

						mode_normal = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.colors.accent.orange;
							bold = true;
						};
						mode_select = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.text.syntax.success;
							bold = true;
						};
						mode_unset = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.text.syntax.keyword;
							bold = true;
						};

						progress_label = {
							fg = vars.style.theme.text.main;
							bold = true;
						};
						progress_normal = {
							fg = vars.style.theme.text.syntax.info;
							bg = vars.style.theme.ui.surface;
						};
						progress_error = {
							fg = vars.style.theme.accent;
							bg = vars.style.theme.ui.surface;
						};

						permissions_t = {fg = vars.style.theme.text.syntax.error;};
						permissions_r = {fg = vars.style.theme.text.syntax.warning;};
						permissions_w = {fg = vars.style.theme.accent;};
						permissions_x = {fg = vars.style.theme.text.syntax.success;};
						permissions_s = {fg = vars.style.theme.text.faint;};
					};

					input = {
						border = {fg = vars.style.theme.accent;};
						selected = {reversed = true;};
					};
					confirm = {
						border = {fg = vars.style.theme.accent;};
						title = {fg = vars.style.theme.accent;};
						btn_yes = {reversed = true;};
						btn_labels = ["  Yes  " "  No  "];
					};
					completion = {
						border = {fg = vars.style.theme.accent;};
						active = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.accent;
						};
						inactive = {};
					};
					tasks = {
						border = {fg = vars.style.theme.accent;};
						hovered = {underline = true;};
					};

					which = {
						mask = {bg = vars.style.theme.ui.surface;};
						cand = {fg = vars.style.theme.text.syntax.success;};
						rest = {fg = vars.style.theme.text.faint;};
						desc = {fg = vars.style.theme.text.main;};
						separator = "  ";
						separator_style = {fg = vars.style.theme.ui.border.inactive;};
					};

					help = {
						on = {fg = vars.style.theme.text.syntax.success;};
						exec = {fg = vars.style.theme.text.syntax.match;};
						desc = {fg = vars.style.theme.text.faint;};
						hovered = {
							bg = vars.style.theme.ui.overlay;
							bold = true;
						};
						footer = {
							fg = vars.style.theme.ui."0";
							bg = vars.style.theme.text.main;
						};
					};
				};
			};
		};
	};
}
