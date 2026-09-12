{
	inputs,
	pkgs,
	lib,
	vars,
	...
}: {
	programs.fish = {
		enable = true;
		useBabelfish = true;
	};
	imports = [
		./theme.nix
	];
	environment.shells = with pkgs; [
		fish
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.fish = {
				enable = true;
				interactiveShellInit = ''
					${
						lib.optionalString (vars.hasProgram "nix-your-shell") ''
							if command -q nix-your-shell
								nix-your-shell fish | source
							end
						''
					}
					tput cup (tput lines) 0
					set -gx fish_greeting
					if not set -q __tide_configured
						tide configure --auto \
						--style=Rainbow \
						--prompt_colors='True color' \
						--show_time='24-hour format' \
						--rainbow_prompt_separators=Angled \
						--powerline_prompt_heads=Sharp \
						--powerline_prompt_tails=Flat \
						--powerline_prompt_style='One line' \
						--prompt_spacing=Compact \
						--icons='Many icons' \
						--transient=Yes > /dev/null 2>&1
						set -U __tide_configured 1
					end
				'';
				functions = {
					yaml2nix = {
						body = ''
										#!/usr/bin/env fish

										# Список комментариев для Base16
										set -g color_comments \
							"00:Primary background (applications, terminal background)" \
							"01:Alternate / darker background (status bars, panels, sidebars)" \
							"02:Selection background (selected lines, cursor line, active item highlights)" \
							"03:Muted text / comments (low contrast text)" \
							"04:Secondary UI elements / borders / inactive indicators" \
							"05:Main foreground text" \
							"06:Secondary / bright text" \
							"07:Maximum brightness text / headings" \
							"08:Red (errors, deletion, critical alerts)" \
							"09:Orange (warnings, constants, integers)" \
							"0A:Yellow (classes, search highlights, warnings)" \
							"0B:Green (strings, success indicators, additions)" \
							"0C:Cyan (regex, escape characters, support functions)" \
							"0D:Blue (functions, primary methods, headings)" \
							"0E:Purple (keywords, storage types, control flow)" \
							"0F:Magenta (deprecated items, secondary accents)"

										# Функция конвертации одного файла
										function convert_yaml_to_nix -a input_file output_file
							set author (string match -r '^\s*author:\s*"(.*)"' < $input_file)[2]
							if test -z "$author"
							    set author (string match -r "^\s*author:\s*'(.*)'" < $input_file)[2]
							end

							set scheme (string match -r '^\s*scheme:\s*"(.*)"' < $input_file)[2]
							if test -z "$scheme"
							    set scheme (string match -r "^\s*scheme:\s*'(.*)'" < $input_file)[2]
							end

							set output ""
							if test -n "$scheme"
							    set output $output"# Scheme: $scheme\n"
							end
							if test -n "$author"
							    set output $output"# Author: $author\n"
							end

							set output $output"{\n"

							for entry in $color_comments
							    set key_id (string split ":" $entry)[1]
							    set comment (string split ":" $entry)[2]

							    set line (grep -i "base$key_id:" $input_file)
							    set hex (string match -r 'base[0-9A-Fa-f]{2}:\s*["\']?([0-9A-Fa-f]{6})["\']?' $line)[2]

							    if test -n "$hex"
							        set output $output"  base.\"$key_id\" = \"$hex\"; # $comment\n"
							    end
							end

							set output $output"}\n"

							echo -ne $output > $output_file
										end

										# Определение рабочей директории (по умолчанию - текущая)
										set target_dir "."
										if test (count $argv) -ge 1
							set target_dir $argv[1]
										end

										if not test -d $target_dir
							echo "Ошибка: директория '$target_dir' не существует!"
							exit 1
										end

										# Находим все yaml/yml файлы
										set yaml_files (find $target_dir -maxdepth 1 -type f \( -name "*.yaml" -o -name "*.yml" \))

										if test (count $yaml_files) -eq 0
							echo "В директории '$target_dir' не найдено файлов .yaml или .yml"
							exit 0
										end

										set count 0
										for file in $yaml_files
							# Формируем имя целевого .nix файла в той же папке
							set nix_file (string replace -r '\.(yaml|yml)$' '.nix' $file)

							echo -n "Конвертация: "(basename $file)" -> "(basename $nix_file)"... "
							convert_yaml_to_nix $file $nix_file
							echo "ОК"

							set count (math $count + 1)
										end

										echo "Готово! Успешно обработано файлов: $count"

						'';
					};
				};
				shellAliases = {
					# ls = "eza --icons";
					# ll = "eza -la --icons";
					# lt = "eza --tree --icons";
					# cat = "bat";
					# grep = "rg";
					yy = "yazi";
					gs = "git status";
					gl = "git log --oneline";
				};
				plugins = [
					{
						name = "autopair";
						src = pkgs.fishPlugins.autopair.src;
					}
					# {
					# 	name = "transient-fish";
					# 	src = pkgs.fishPlugins.transient-fish.src;
					# }
					{
						name = "tide";
						src = pkgs.fishPlugins.tide.src;
					}
					{
						name = "fifc";
						src = pkgs.fishPlugins.fifc.src;
					}
					{
						name = "forgit";
						src = pkgs.fishPlugins.forgit.src;
					}
					{
						name = "fzf";
						src = pkgs.fishPlugins.fzf.src;
					}
					{
						name = "grc";
						src = pkgs.fishPlugins.grc.src;
					}
				];
			};
		};
	};
}
