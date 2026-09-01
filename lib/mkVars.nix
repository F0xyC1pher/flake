# lib/mkVars.nix
{
	lib,
	themes,
	...
}: {
	hostName,
	hostMeta,
	userCfg,
	resolvedTheme,
}: let
	userName = hostMeta.user;
in {
	user = {
		name = userName;
		fullName = userCfg.user.fullName or userCfg.userFullName or userName;
		gitName = userCfg.user.gitName or (userCfg.user.fullName or userName);
		mail = userCfg.user.mail or "";
		password = userCfg.user.password or userCfg.userPassword or null;
		shell = userCfg.user.shell or userCfg.shell or "fish";
	};

	app =
		userCfg.app or {
			gui = {
				browser = "firefox";
				file-manager = "yazi";
				launcher = "fuzzel";
				text-editor = "zeditor";
			};
			terminal = "kitty";
			tui = {
				browser = "lyx";
				file-manager = "yazi";
				text-editor = "micro";
			};
		};

	theme = {
		name = userCfg.theme.name or "theMe";
		accentLevel = resolvedTheme.accentLevel;
		accentColor = resolvedTheme.accentColor;
		dark = userCfg.theme.dark or resolvedTheme.isDark;
		border =
			userCfg.theme.border or {
				width = 2;
				radius = 0;
			};
		font =
			userCfg.theme.font or {
				name = "CaskaydiaCove Nerd Font Mono";
				size = 14;
			};
		opacity = userCfg.theme.opacity or 1.0;
		opacityHex = themes.opacityToHex userCfg.theme.opacity;
		hexToRgb = themes.hexToRgb;
		hexToRgbString = themes.hexToRgbString;
		blur =
			userCfg.theme.blur or {
				enable = false;
				xray.enable = false;
			};
		liquid-glass = userCfg.theme.liquid-glass or false;
		style = resolvedTheme.theme;
		colors = resolvedTheme.colors;
	};

	host = hostMeta.host;
	hardware = hostMeta.hardware;
	system = userCfg.system or {};
}
