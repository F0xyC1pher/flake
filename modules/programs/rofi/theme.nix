{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {config, ...}: {
			programs.rofi = {
				theme = let
					inherit (config.lib.formats.rasi) mkLiteral;
				in {
					"*" = {
						spacing = 0;
						# background-color = mkLiteral "transparent";
					};

					"window" = {
						transparency = "real";
						background-color = mkLiteral "${vars.style.theme.ui."0"}53";
					};

					"mainbox" = {
						children = [
							"inputbar"
							"message"
							"mode-switcher"
							"listview"
						];
						spacing = mkLiteral "10px";
						padding = mkLiteral "10px 0";
						border = mkLiteral "1px";
						border-color = mkLiteral "${vars.style.theme.accent}";
					};

					"inputbar" = {
						padding = mkLiteral "0 30px";
						children = [
							"prompt"
							"textbox-prompt-colon"
							"entry"
							"case-indicator"
						];
					};

					"prompt" = {
						text-color = mkLiteral "${vars.style.theme.text.main}";
					};

					"textbox-prompt-colon" = {
						expand = false;
						str = mkLiteral "\":\"";
						margin = mkLiteral "0 1ch 0 0";
						text-color = mkLiteral "${vars.style.theme.text.main}";
					};

					"entry" = {
						text-color = mkLiteral "${vars.style.theme.text.main}";
					};

					"case-indicator" = {
						text-color = mkLiteral "${vars.style.theme.text.main}";
					};

					"mode-switcher, message" = {
						border = mkLiteral "1px 0";
						border-color = mkLiteral "${vars.style.theme.accent}";
					};

					"button, textbox" = {
						background-color = mkLiteral "${vars.style.theme.ui."0"}";
						text-color = mkLiteral "${vars.style.theme.text.main}";
						padding = mkLiteral "5px";
					};

					"button selected" = {
						background-color = mkLiteral "${vars.style.theme.accent}";
						text-color = mkLiteral "${vars.style.theme.ui."0"}";
					};

					"listview" = {
						scrollbar = true;
						margin = mkLiteral "0 10px 0 30px";
					};

					"scrollbar" = {
						background-color = mkLiteral "${vars.style.theme.ui."0"}";
						handle-color = mkLiteral "${vars.style.theme.accent}";
						handle-width = mkLiteral "10px";
						border = mkLiteral "2 2px";
						border-color = mkLiteral "${vars.style.theme.accent}";
						margin = mkLiteral "0 0 0 20px";
					};

					"element" = {
						padding = mkLiteral "5px";
						spacing = mkLiteral "5px";
						highlight = mkLiteral "bold underline";
						children = [
							"element-icon"
							"element-text"
						];
					};

					"element-text, element-icon" = {
						background-color = mkLiteral "inherit";
						text-color = mkLiteral "inherit";
					};

					"element normal" = {
						background-color = mkLiteral "transparent";
					};

					"element selected" = {
						background-color = mkLiteral "${vars.style.theme.accent}";
						text-color = mkLiteral "${vars.style.theme.ui."0"}";
					};

					"element normal normal, element alternate normal" = {
						text-color = mkLiteral "${vars.style.theme.text.main}";
					};

					"element selected urgent" = {
						text-color = mkLiteral "${vars.style.theme.text.main}";
						background-color = mkLiteral "${vars.style.theme.ui."0"}";
					};

					"element normal urgent, element alternate urgent" = {
						text-color = mkLiteral "${vars.style.theme.ui."0"}";
						background-color = mkLiteral "${vars.style.theme.text.main}";
					};

					"element selected active" = {
						text-color = mkLiteral "${vars.style.theme.ui."0"}";
					};

					"element normal active, element alternate active" = {
						text-color = mkLiteral "${vars.style.theme.text.main}";
					};

					# Filebrowser settings - исправлено
					"filebrowser" = {
						directories-first = true;
						sorting-method = mkLiteral "\"name\"";
					};

					# Timeout settings - исправлено
					"timeout" = {
						action = mkLiteral "\"kb-cancel\"";
						delay = 0;
					};
				};
			};
		};
	};
}
