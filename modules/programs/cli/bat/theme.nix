{
	pkgs,
	vars,
	...
}: let
	plistFormat = pkgs.formats.plist {};
in {
	home-manager.users.${vars.user.name}.programs.bat.themes.custom = {
		src =
			plistFormat.generate "custom.tmTheme" {
				name = "Custom Theme";
				settings = [
					{
						settings = {
							background = vars.theme.style.ui.bg;
							caret = vars.theme.style.text.main;
							foreground = vars.theme.style.text.main;
							invisibles = vars.theme.style.text.comment;
							lineHighlight = vars.theme.style.ui.overlay;
							selection = vars.theme.style.ui.overlay;
						};
					}
					{
						name = "Comment";
						scope = "comment";
						settings = {foreground = vars.theme.style.text.comment;};
					}
					{
						name = "String";
						scope = "string";
						settings = {foreground = vars.theme.style.text.syntax.string;};
					}
					{
						name = "Number";
						scope = "constant.numeric";
						settings = {foreground = vars.theme.style.text.syntax.number;};
					}
					{
						name = "Built-in constant";
						scope = "constant.language";
						settings = {foreground = vars.theme.style.text.syntax.number;};
					}
					{
						name = "User-defined constant";
						scope = "constant.character, constant.other";
						settings = {foreground = vars.theme.style.text.syntax.number;};
					}
					{
						name = "Variable";
						scope = "variable";
						settings = {fontStyle = "";};
					}
					{
						name = "Keyword";
						scope = "keyword";
						settings = {foreground = vars.theme.style.text.syntax.keyword;};
					}
					{
						name = "Storage";
						scope = "storage";
						settings = {
							fontStyle = "";
							foreground = vars.theme.style.text.syntax.keyword;
						};
					}
					{
						name = "Storage type";
						scope = "storage.type";
						settings = {
							fontStyle = "italic";
							foreground = vars.theme.style.text.syntax.info;
						};
					}
					{
						name = "Class name";
						scope = "entity.name.class";
						settings = {
							fontStyle = "underline";
							foreground = vars.theme.style.text.syntax.success;
						};
					}
					{
						name = "Inherited class";
						scope = "entity.other.inherited-class";
						settings = {
							fontStyle = "italic underline";
							foreground = vars.theme.style.text.syntax.success;
						};
					}
					{
						name = "Function name";
						scope = "entity.name.function";
						settings = {
							fontStyle = "";
							foreground = vars.theme.style.text.syntax.function;
						};
					}
					{
						name = "Function argument";
						scope = "variable.parameter";
						settings = {
							fontStyle = "italic";
							foreground = vars.theme.style.text.syntax.number;
						};
					}
					{
						name = "Tag name";
						scope = "entity.name.tag";
						settings = {
							fontStyle = "";
							foreground = vars.theme.style.text.syntax.keyword;
						};
					}
					{
						name = "Tag attribute";
						scope = "entity.other.attribute-name";
						settings = {
							fontStyle = "";
							foreground = vars.theme.style.text.syntax.success;
						};
					}
					{
						name = "Library function";
						scope = "support.function";
						settings = {
							fontStyle = "";
							foreground = vars.theme.style.text.syntax.info;
						};
					}
					{
						name = "Library constant";
						scope = "support.constant";
						settings = {
							fontStyle = "";
							foreground = vars.theme.style.text.syntax.info;
						};
					}
					{
						name = "Library class/type";
						scope = "support.type, support.class";
						settings = {
							fontStyle = "italic";
							foreground = vars.theme.style.text.syntax.info;
						};
					}
					{
						name = "Library variable";
						scope = "support.other.variable";
						settings = {fontStyle = "";};
					}
					{
						name = "Invalid";
						scope = "invalid";
						settings = {
							background = vars.theme.style.text.syntax.error;
							fontStyle = "";
							foreground = vars.theme.style.ui.bg;
						};
					}
					{
						name = "Invalid deprecated";
						scope = "invalid.deprecated";
						settings = {
							background = vars.theme.style.text.syntax.keyword;
							fontStyle = "";
							foreground = vars.theme.style.ui.bg;
						};
					}
				];
			};
	};
}
