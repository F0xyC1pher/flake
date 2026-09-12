#lib/mk-vars.nix
{
	lib,
	themes,
}: {
	hostName,
	hostCfg,
	userCfg,
	resolvedTheme,
	modulesBase,
	mkModules,
}: let
	userName = hostCfg.user;

	rawPrograms = userCfg.programs or [];
	rawServices = userCfg.services or [];
	rawPackages = userCfg.packages or [];

	activePrograms = mkModules.resolveActiveNames (modulesBase + "/programs") rawPrograms;
	activeServices = mkModules.resolveActiveNames (modulesBase + "/services") rawServices;
	activePackages = mkModules.resolveActiveNames (modulesBase + "/packages") rawPackages;

	activePackageFiles = mkModules.importPackages (modulesBase + "/packages") rawPackages;
in {
	hasProgram = p: lib.elem p activePrograms;
	hasService = s: lib.elem s activeServices;

	hasPackage = pkg:
		(lib.elem pkg activePackages)
		|| (mkModules.hasPackageInFiles activePackageFiles pkg);

	host =
		hostCfg
		// {
			name = hostName;
		};

	system = userCfg.system or {};

	user = {
		name = userName;
		fullName = userCfg.user.fullName or userName;
		gitName = userCfg.user.gitName or (userCfg.user.fullName or userName);
		mail = userCfg.user.mail or "";
		password = userCfg.user.password or userCfg.userPassword or null;
		shell = userCfg.user.shell or userCfg.shell or "fish";
	};
	app =
		userCfg.app or {
			terminal = "kitty";
			launcher = "fuzzel";
			file-manager = {
				tui = "yazi";
				gui = null;
			};
			browser = {
				tui = "lyx";
				gui = "firefox";
			};
			text-editor = {
				tui = "micro";
				gui = "zeditor";
			};
		};

	theme = {
		name = userCfg.theme.name or "theMe";
		accentLevel = resolvedTheme.accentLevel;
		accentColor = resolvedTheme.accentColor;
		dark = userCfg.theme.dark or resolvedTheme.isDark;
		opacity = userCfg.theme.opacity or 1.0;
		opacityHex = themes.opacityToHex userCfg.theme.opacity;
		hexToRgb = themes.hexToRgb;
		hexToRgbString = themes.hexToRgbString;
		liquid-glass = userCfg.theme.liquid-glass or false;
		style = resolvedTheme.theme;
		colors = resolvedTheme.colors;

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
		blur =
			userCfg.theme.blur or {
				enable = false;
				xray.enable = false;
			};
		shadows =
			userCfg.theme.shadows or{
				enable = true;
				neon = false;
			};
	};
}
