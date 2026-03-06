{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
	programs.yazi = {
			
		enable = true;
		
		enableFishIntegration = true;
		enableBashIntegration = true;
		
		plugins = with pkgs.yaziPlugins; {
			sudo = sudo;
			glow = glow;
			piper = piper;
			mount = mount;
			gitui = gitui;
			chmod = chmod;
			miller = miller;
			yatline = yatline;
			mime-ext = mime-ext;
			compress = compress;
			mediainfo = mediainfo;
			toggle-pane = toggle-pane;
			full-border = full-border;
		};
		
		
		 
		initLua = ''
			require("full-border"):setup()
			
			require("yatline"):setup({
			section_separator = { open = "▐", close = "▌" },
			part_separator = { open = "[", close = "]" },
			})
			
			require("mime-ext.local"):setup {
				-- Расширение базы имён файлов (with_files): для точных имён вроде Makefile
				with_files = {
					-- Примеры; добавьте свои, если нужно
					makefile = "text/makefile",
					readme = "text/markdown",
				},
				
				-- Расширение базы расширений (with_exts): для .md и других
				with_exts = {
					-- Из вашего блока: для *.md
					md = "text/markdown",
					
					-- Примеры для text/* (текстовые расширения)
					txt = "text/plain",
					log = "text/plain",
					conf = "text/plain",
					ini = "text/plain",
					
					-- Примеры для image/* (изображения)
					jpg = "image/jpeg",
					png = "image/png",
					gif = "image/gif",
					bmp = "image/bmp",
					
					-- Примеры для video/* (видео)
					mp4 = "video/mp4",
					mkv = "video/x-matroska",
					avi = "video/x-msvideo",
					
					-- Примеры для audio/* (аудио)
					mp3 = "audio/mpeg",
					wav = "audio/wav",
					ogg = "audio/ogg",
					
					-- Примеры для application/* (приложения/документы)
					pdf = "application/pdf",
					docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
					xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
					zip = "application/zip",
				},
				
			-- Fallback на file(1) для неизвестных типов (рекомендую true для точности, false для максимальной скорости)
				fallback_file1 = true,
			}
		'';
		
		settings = {
			
			manager = {
				show_hidden = true;
				sort_by = "natural";
				sort_dir_first = true;
			};
			
			preview = {
				max_width = 1200;
				max_height = 900;
				cache_dir = "${config.xdg.cacheHome}/yazi";
			};
			
			plugin = {
				prepend_fetchers = [
					{ id = "mime"; url = "local://*"; run = "mime-ext.local"; prio = "high"; }  # Для локальных файлов
					{ id = "mime"; url = "remote://*"; run = "mime-ext.remote"; prio = "high"; }  # Для удалённых, если нужно
				];
				prepend_previewers = [
					{ name = "*.md"; run = "glow"; }  # Если glow установлен
				];
			};
		};
		
		keymap = {
			manager.prepend_keymap = [
				# gitui
				{
					on = [ "g" "i" ];
					run = "plugin gitui";
					desc = "gitui";
				}
				
				# sudo
				{
					on = [ "!" ];
					run = "plugin sudo";
					desc = "sudo";
				}
				
				# chmod
				{
					on = [ "c" "m" ];
					run = "plugin chmod";
					desc = "chmod";
				}
				
				# compress
				{
					on = [ "c" "a" ];
					run = "plugin compress";
					desc = "compress";
				}
				
				# mediainfo
				{
					on = [ "m" "i" ];
					run = "plugin mediainfo";
					desc = "media info";
				}
				
				# mount
				{
					on = [ "M" ];
					run = "plugin mount";
					desc = "mount";
				}
				
				# toggle pane
				{
					on = [ "T" ];
					run = "plugin toggle-pane";
					desc = "toggle pane";
				}
			];
		};
	};
	};
	};
}
