{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {config, ...}: {
			programs.rofi = {
				theme = let
					inherit (config.lib.formats.rasi) mkLiteral;
				in {
					"*" = {
						spacing = 0;
						background-color = mkLiteral "transparent";
						text-color = mkLiteral "${vars.theme.style.text.main}";
					};

					"window" = {
						background-color = mkLiteral "${vars.theme.style.ui.bg}${vars.theme.opacityHex}";
						transparency = "real";
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
						border-color = mkLiteral "${vars.theme.style.accent}";
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

					"textbox-prompt-colon" = {
						expand = false;
						str = mkLiteral "\":\"";
						margin = mkLiteral "0 1ch 0 0";
					};

					"mode-switcher, message" = {
						border = mkLiteral "1px 0";
						border-color = mkLiteral "${vars.theme.style.accent}";
					};

					"button, textbox" = {
						padding = mkLiteral "5px";
					};

					"button selected" = {
						background-color = mkLiteral "${vars.theme.style.accent}";
						text-color = mkLiteral "${vars.theme.style.ui.bg}";
					};

					"listview" = {
						scrollbar = true;
						margin = mkLiteral "0 10px 0 30px";
					};

					"scrollbar" = {
						background-color = mkLiteral "transparent";
						handle-color = mkLiteral "${vars.theme.style.accent}";
						handle-width = mkLiteral "10px";
						border = mkLiteral "2px";
						border-color = mkLiteral "${vars.theme.style.accent}";
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

					"element selected" = {
						background-color = mkLiteral "${vars.theme.style.accent}";
						text-color = mkLiteral "${vars.theme.style.ui.bg}";
					};

					"element normal urgent, element alternate urgent" = {
						text-color = mkLiteral "${vars.theme.style.ui.bg}";
						background-color = mkLiteral "${vars.theme.style.text.main}";
					};

					"element selected urgent" = {
						text-color = mkLiteral "${vars.theme.style.text.main}";
						background-color = mkLiteral "${vars.theme.style.ui.bg}";
					};
				};
			};
		};
	};
}
