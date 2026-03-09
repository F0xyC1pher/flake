{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.yazi = {
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
			};
		};
	};
}
