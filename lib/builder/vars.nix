# lib/builder/vars.nix
{
	lib,
	inputs ? {},
	flakeRoot ? ../..,
	themeBuilder ? {},
	moduleResolver ? {},
	...
}: {
	hostName,
	hostCfg,
	userCfg,
	resolvedTheme,
	modulesBase ? "${flakeRoot}/modules",
	...
}: let
	userName = hostCfg.user;

	rawPrograms = userCfg.programs or [];
	rawServices = userCfg.services or [];
	rawPackages = userCfg.packages or [];

	activePrograms = moduleResolver.resolveActiveNames (modulesBase + "/programs") rawPrograms;
	activeServices = moduleResolver.resolveActiveNames (modulesBase + "/services") rawServices;
	activePackages = moduleResolver.resolveActiveNames (modulesBase + "/packages") rawPackages;

	activePackageFiles = moduleResolver.importPackages (modulesBase + "/packages") rawPackages;
in {
	hasProgram = p: lib.elem p activePrograms;
	hasService = s: lib.elem s activeServices;

	hasPackage = pkg:
		(lib.elem pkg activePackages)
		|| (moduleResolver.hasPackageInFiles activePackageFiles pkg);

	host = hostCfg // {name = hostName;};

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
		opacityHex = themeBuilder.opacityToHex userCfg.theme.opacity;
		hexToRgb = themeBuilder.hexToRgb;
		hexToRgbString = themeBuilder.hexToRgbString;
		liquid-glass = userCfg.theme.liquid-glass or false;
		style = resolvedTheme.theme;
		colors = resolvedTheme.colors;

		gaps =
			userCfg.theme.gaps or {
				"in" = 10;
				"out" = 10;
			};
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
				offset = 1;
				passes = 3;
				noise = 0.002;
				saturation = 1.1;
				xray.enable = false;
			};
		shadows =
			userCfg.theme.shadows or {
				enable = true;
				neon = false;
			};
	};
}
