# lib/colors/validators.nix
{lib}: let
	isHex = str:
		builtins.isString str && builtins.match "^#?[0-9a-fA-F]{6}$" str != null;

	validateColor = str:
		if !builtins.isString str
		then throw "ColorValidation: Expected string, got ${builtins.typeOf str}"
		else if !isHex str
		then throw "ColorValidation: Invalid hex color '${str}'"
		else if builtins.substring 0 1 str == "#"
		then str
		else "#${str}";

	validateColors = value:
		if builtins.isAttrs value
		then lib.mapAttrs (_: validateColors) value
		else if builtins.isList value
		then map validateColors value
		else if builtins.isString value && isHex value
		then validateColor value
		else value;
in {
	inherit validateColor validateColors;
}
