{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} = { config, pkgs, lib, ... }: {
			programs.rofi = {
				enable = true;
				terminal = "kitty"; 

				extraConfig = {
                    modi = "run,drun,window";
                    icon-theme = "Papirus";
                    show-icons = true;
                    terminal = "kitty";
                    drun-display-format = "{icon} {name}";
                    location = 0;
                    hide-scrollbar = true;
                    display-drun = "   Apps ";
                    display-run = "   Run ";
                    display-window = " 󰕰  Window ";
                    sidebar-mode = true;
                    disable-history = true;
                    cycle = true;
                };

				theme = let
                    inherit (config.lib.formats.rasi) mkLiteral;
                in {
                    "*" = {
                        black = mkLiteral "#1a1a1a";
                        black-b = mkLiteral "#6f6f6f";
                        red = mkLiteral "#d76667";
                        red-b = mkLiteral "#d09a9b";
                        green = mkLiteral "#67b766";
                        green-b = mkLiteral "#9bd09a";
                        yellow = mkLiteral "#fed666";
                        yellow-b = mkLiteral "#ffeab3";
                        blue = mkLiteral "#0666ff";
                        blue-b = mkLiteral "#5294ff";
                        magenta = mkLiteral "#a666fd";
                        magenta-b = mkLiteral "#d3b4fe";
                        cyan = mkLiteral "#61d6d6";
                        bcyan = mkLiteral "#9ee6e6";
                        white = mkLiteral "#f0e0e0";
                        bwhite = mkLiteral "#ffffff";

                        bg = mkLiteral "#1a1a1a";
                        fg = mkLiteral "@white";
                        spacing = 0;
                        background-color = mkLiteral "transparent";
                    };

                    "window" = {
                        transparency = "real";
                        background-color = mkLiteral "#1a1a1acc"; 
                    };

                    "mainbox" = {
                        children = [ "inputbar" "message" "mode-switcher" "listview" ];
                        spacing = mkLiteral "10px";
                        padding = mkLiteral "10px 0";
                        border = mkLiteral "1px";
                        border-color = mkLiteral "@red";
                    };

                    "inputbar" = {
                        padding = mkLiteral "0 30px";
                        children = [ "prompt" "textbox-prompt-colon" "entry" "case-indicator" ];
                    };

                    "prompt" = {
                        text-color = mkLiteral "@fg";
                    };

                    "textbox-prompt-colon" = {
                        expand = false;
                        str = mkLiteral "\":\"";
                        margin = mkLiteral "0 1ch 0 0";
                        text-color = mkLiteral "@fg";
                    };

                    "entry" = {
                        text-color = mkLiteral "@fg";
                    };

                    "case-indicator" = {
                        text-color = mkLiteral "@fg";
                    };

                    "mode-switcher, message" = {
                        border = mkLiteral "1px 0";
                        border-color = mkLiteral "@red";
                    };

                    "button, textbox" = {
                        background-color = mkLiteral "@bg";
                        text-color = mkLiteral "@fg";
                        padding = mkLiteral "5px";
                    };

                    "button selected" = {
                        background-color = mkLiteral "@red";
                        text-color = mkLiteral "@black";
                    };

                    "listview" = {
                        scrollbar = true;
                        margin = mkLiteral "0 10px 0 30px";
                    };

                    "scrollbar" = {
                        background-color = mkLiteral "@bg";
                        handle-color = mkLiteral "@red";
                        handle-width = mkLiteral "10px";
                        border = mkLiteral "1 1px";
                        border-color = mkLiteral "@red";
                        margin = mkLiteral "0 0 0 20px";
                    };

                    "element" = {
                        padding = mkLiteral "5px";
                        spacing = mkLiteral "5px";
                        highlight = mkLiteral "bold underline";
                        children = [ "element-icon" "element-text" ];
                    };

                    "element-text, element-icon" = {
                        background-color = mkLiteral "inherit";
                        text-color = mkLiteral "inherit";
                    };

                    "element normal" = {
                        background-color = mkLiteral "transparent";
                    };

                    "element selected" = {
                        background-color = mkLiteral "@red";
                        text-color = mkLiteral "@black";
                    };

                    "element normal normal, element alternate normal" = {
                        text-color = mkLiteral "@fg";
                    };

                    "element selected urgent" = {
                        text-color = mkLiteral "@fg";
                        background-color = mkLiteral "@black";
                    };

                    "element normal urgent, element alternate urgent" = {
                        text-color = mkLiteral "@black";
                        background-color = mkLiteral "@fg";
                    };

                    "element selected active" = {
                        text-color = mkLiteral "@black";
                    };

                    "element normal active, element alternate active" = {
                        text-color = mkLiteral "@fg";
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