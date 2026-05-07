{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.yazi = {
				theme = {
					manager = {
						cwd = {fg = vars.theme.style.text.syntax.info;};

						hovered = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.accent;
							bold = true;
						};
						preview_hovered = {underline = true;};

						find_keyword = {
							fg = vars.theme.style.text.syntax.warning;
							bold = true;
							italic = true;
						};
						find_position = {
							fg = vars.theme.style.text.syntax.match;
							bold = true;
							italic = true;
						};

						marker_copied = {
							fg = vars.theme.style.text.syntax.error;
							bg = vars.theme.style.text.syntax.error;
						};
						marker_cut = {
							fg = vars.theme.style.accent;
							bg = vars.theme.style.accent;
						};
						marker_marked = {
							fg = vars.theme.style.text.syntax.success;
							bg = vars.theme.style.text.syntax.success;
						};
						marker_selected = {
							fg = vars.theme.style.text.syntax.keyword;
							bg = vars.theme.style.text.syntax.keyword;
						};

						tab_active = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.accent;
						};
						tab_inactive = {
							fg = vars.theme.style.text.faint;
							bg = vars.theme.style.ui.surface;
						};
						tab_width = 1;

						count_copied = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.text.syntax.error;
						};
						count_cut = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.accent;
						};
						count_selected = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.text.syntax.keyword;
						};

						border_symbol = "│";
						border_style = {fg = vars.theme.style.ui.border.inactive;};
						syntect_theme = "";
					};

					status = {
						separator_open = "";
						separator_close = "";
						separator_style = {
							fg = vars.theme.style.ui.border.inactive;
							bg = vars.theme.style.ui.surface;
						};

						mode_normal = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.colors.accent.orange;
							bold = true;
						};
						mode_select = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.text.syntax.success;
							bold = true;
						};
						mode_unset = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.text.syntax.keyword;
							bold = true;
						};

						progress_label = {
							fg = vars.theme.style.text.main;
							bold = true;
						};
						progress_normal = {
							fg = vars.theme.style.text.syntax.info;
							bg = vars.theme.style.ui.surface;
						};
						progress_error = {
							fg = vars.theme.style.accent;
							bg = vars.theme.style.ui.surface;
						};

						permissions_t = {fg = vars.theme.style.text.syntax.error;};
						permissions_r = {fg = vars.theme.style.text.syntax.warning;};
						permissions_w = {fg = vars.theme.style.accent;};
						permissions_x = {fg = vars.theme.style.text.syntax.success;};
						permissions_s = {fg = vars.theme.style.text.faint;};
					};

					input = {
						border = {fg = vars.theme.style.accent;};
						selected = {reversed = true;};
					};
					confirm = {
						border = {fg = vars.theme.style.accent;};
						title = {fg = vars.theme.style.accent;};
						btn_yes = {reversed = true;};
						btn_labels = ["  Yes  " "  No  "];
					};
					completion = {
						border = {fg = vars.theme.style.accent;};
						active = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.accent;
						};
						inactive = {};
					};
					tasks = {
						border = {fg = vars.theme.style.accent;};
						hovered = {underline = true;};
					};

					which = {
						mask = {bg = vars.theme.style.ui.surface;};
						cand = {fg = vars.theme.style.text.syntax.success;};
						rest = {fg = vars.theme.style.text.faint;};
						desc = {fg = vars.theme.style.text.main;};
						separator = "  ";
						separator_style = {fg = vars.theme.style.ui.border.inactive;};
					};

					help = {
						on = {fg = vars.theme.style.text.syntax.success;};
						exec = {fg = vars.theme.style.text.syntax.match;};
						desc = {fg = vars.theme.style.text.faint;};
						hovered = {
							bg = vars.theme.style.ui.overlay;
							bold = true;
						};
						footer = {
							fg = vars.theme.style.ui."0";
							bg = vars.theme.style.text.main;
						};
					};
				};
			};
		};
	};
}
