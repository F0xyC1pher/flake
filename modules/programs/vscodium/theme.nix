# ── VSCodium — workbench color customisations via vars.style.theme.* ─────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {
			vars,
			lib,
			...
		}: let
			t = vars.style.theme;
		in {
			programs.vscode.profiles.default.userSettings = {
				# ── Window ─────────────────────────────────────────────────────
				"window.titleBarStyle" = "custom";
				"window.menuBarVisibility" = "toggle";
				"window.zoomLevel" = 0;

				# ── Editor ─────────────────────────────────────────────────────
				"editor.fontFamily" = lib.mkForce "${vars.fontName}";
				"editor.fontSize" = 14;
				"editor.lineHeight" = 22;
				"editor.fontLigatures" = true;
				"editor.tabSize" = 4;
				"editor.insertSpaces" = false;
				"editor.renderWhitespace" = "boundary";
				"editor.cursorStyle" = "block";
				"editor.cursorBlinking" = "phase";
				"editor.minimap.enabled" = true;
				"editor.scrollBeyondLastLine" = false;
				"editor.smoothScrolling" = true;
				"editor.bracketPairColorization.enabled" = true;
				"editor.guides.bracketPairs" = true;

				# ── Workbench ──────────────────────────────────────────────────
				"workbench.colorTheme" = "Default Dark Modern";
				"workbench.startupEditor" = "none";
				"workbench.iconTheme" = "material-icon-theme";
				"workbench.tree.indent" = 14;

				"workbench.colorCustomizations" = {
					# ── Editor core ────────────────────────────────────────────
					"editor.background" = t.ui.main;
					"editor.foreground" = t.text.main;
					"editor.selectionBackground" = t.ui.overlay;
					"editor.selectionHighlightBackground" = t.ui.selection;
					"editor.lineHighlightBackground" = t.ui.surface;
					"editor.findMatchBackground" = t.accent;
					"editor.findMatchHighlightBackground" = t.ui.selection;
					"editorCursor.foreground" = t.accent;
					"editorCursor.background" = t.ui.main;
					"editorLineNumber.foreground" = t.ui.highlight;
					"editorLineNumber.activeForeground" = t.text.faint;
					"editorWhitespace.foreground" = t.ui.selection;
					"editorIndentGuide.background1" = t.ui.overlay;
					"editorIndentGuide.activeBackground1" = t.ui.highlight;
					"editorBracketMatch.background" = t.ui.overlay;
					"editorBracketMatch.border" = t.accent;

					# ── Activity bar ───────────────────────────────────────────
					"activityBar.background" = t.ui.main;
					"activityBar.foreground" = t.text.main;
					"activityBar.inactiveForeground" = t.ui.highlight;
					"activityBar.border" = t.ui.border.inactive;
					"activityBar.activeBorder" = t.accent;
					"activityBarBadge.background" = t.accent;
					"activityBarBadge.foreground" = t.ui.main;

					# ── Sidebar ────────────────────────────────────────────────
					"sideBar.background" = t.ui.surface;
					"sideBar.foreground" = t.text.main;
					"sideBar.border" = t.ui.border.inactive;
					"sideBarSectionHeader.background" = t.ui.overlay;
					"sideBarSectionHeader.foreground" = t.text.faint;
					"sideBarTitle.foreground" = t.text.heading;
					"list.activeSelectionBackground" = t.ui.overlay;
					"list.activeSelectionForeground" = t.accent;
					"list.hoverBackground" = t.ui.surface;
					"list.focusBackground" = t.ui.overlay;
					"list.inactiveSelectionBackground" = t.ui.overlay;

					# ── Title bar ──────────────────────────────────────────────
					"titleBar.activeBackground" = t.ui.main;
					"titleBar.activeForeground" = t.text.heading;
					"titleBar.inactiveBackground" = t.ui.surface;
					"titleBar.inactiveForeground" = t.text.faint;
					"titleBar.border" = t.ui.border.inactive;

					# ── Tabs ───────────────────────────────────────────────────
					"tab.activeBackground" = t.ui.main;
					"tab.activeForeground" = t.accent;
					"tab.inactiveBackground" = t.ui.surface;
					"tab.inactiveForeground" = t.text.faint;
					"tab.border" = t.ui.border.inactive;
					"tab.activeBorderTop" = t.accent;
					"tab.hoverBackground" = t.ui.overlay;

					# ── Status bar ─────────────────────────────────────────────
					"statusBar.background" = t.ui.surface;
					"statusBar.foreground" = t.text.main;
					"statusBar.border" = t.ui.border.inactive;
					"statusBar.debuggingBackground" = t.accent;
					"statusBar.debuggingForeground" = t.ui.main;
					"statusBar.noFolderBackground" = t.ui.surface;
					"statusBarItem.hoverBackground" = t.ui.overlay;

					# ── Panel / terminal ───────────────────────────────────────
					"panel.background" = t.ui.main;
					"panel.border" = t.ui.border.inactive;
					"panelTitle.activeForeground" = t.accent;
					"panelTitle.inactiveForeground" = t.text.faint;
					"panelTitle.activeBorder" = t.accent;
					"terminal.background" = t.ui.main;
					"terminal.foreground" = t.text.main;
					"terminal.ansiBlack" = t.ui.main;
					"terminal.ansiRed" = vars.style.colors.accent.red;
					"terminal.ansiGreen" = vars.style.colors.accent.green;
					"terminal.ansiYellow" = vars.style.colors.accent.yellow;
					"terminal.ansiBlue" = vars.style.colors.accent.blue;
					"terminal.ansiMagenta" = vars.style.colors.accent.purple;
					"terminal.ansiCyan" = vars.style.colors.accent.cyan;
					"terminal.ansiWhite" = t.text.main;
					"terminal.ansiBrightBlack" = t.ui.selection;
					"terminal.ansiBrightRed" = vars.style.colors.accent.red;
					"terminal.ansiBrightGreen" = vars.style.colors.accent.green;
					"terminal.ansiBrightYellow" = vars.style.colors.accent.yellow;
					"terminal.ansiBrightBlue" = vars.style.colors.accent.blue;
					"terminal.ansiBrightMagenta" = vars.style.colors.accent.purple;
					"terminal.ansiBrightCyan" = vars.style.colors.accent.cyan;
					"terminal.ansiBrightWhite" = t.text.heading;
					"terminalCursor.foreground" = t.accent;

					# ── Input / dropdown ───────────────────────────────────────
					"input.background" = t.ui.surface;
					"input.foreground" = t.text.main;
					"input.border" = t.ui.border.inactive;
					"input.placeholderForeground" = t.text.faint;
					"inputOption.activeBackground" = t.ui.overlay;
					"inputOption.activeBorder" = t.accent;
					"dropdown.background" = t.ui.surface;
					"dropdown.border" = t.ui.border.inactive;
					"dropdown.foreground" = t.text.main;

					# ── Buttons ────────────────────────────────────────────────
					"button.background" = t.accent;
					"button.foreground" = t.ui.main;
					"button.hoverBackground" = t.ui.selection;

					# ── Scrollbar ──────────────────────────────────────────────
					"scrollbar.shadow" = t.ui.main;
					"scrollbarSlider.background" = t.ui.selection;
					"scrollbarSlider.hoverBackground" = t.ui.highlight;
					"scrollbarSlider.activeBackground" = t.ui.selection;

					# ── Notifications ──────────────────────────────────────────
					"notifications.background" = t.ui.surface;
					"notifications.border" = t.ui.border.inactive;
					"notificationToast.border" = t.accent;
					"notificationsErrorIcon.foreground" = t.text.syntax.error;
					"notificationsWarningIcon.foreground" = t.text.syntax.warning;
					"notificationsInfoIcon.foreground" = t.text.syntax.info;

					# ── Badge / progress ───────────────────────────────────────
					"badge.background" = t.accent;
					"badge.foreground" = t.ui.main;
					"progressBar.background" = t.accent;

					# ── Peek / diff ────────────────────────────────────────────
					"peekView.border" = t.accent;
					"peekViewEditor.background" = t.ui.surface;
					"peekViewResult.background" = t.ui.main;
					"peekViewResult.selectionBackground" = t.ui.overlay;
					"diffEditor.insertedTextBackground" = "${t.text.syntax.success}33";
					"diffEditor.removedTextBackground" = "${t.text.syntax.error}33";

					# ── Git decorations ────────────────────────────────────────
					"gitDecoration.modifiedResourceForeground" = vars.style.colors.accent.orange;
					"gitDecoration.deletedResourceForeground" = t.text.syntax.error;
					"gitDecoration.addedResourceForeground" = t.text.syntax.success;
					"gitDecoration.untrackedResourceForeground" = t.text.syntax.info;
					"gitDecoration.ignoredResourceForeground" = t.ui.highlight;
					"gitDecoration.conflictingResourceForeground" = t.text.syntax.warning;

					# ── Focus / shadow ─────────────────────────────────────────
					"focusBorder" = t.accent;
					"widget.shadow" = t.ui.deep;
					"icon.foreground" = t.text.main;
				};

				# ── Telemetry ────────────────────────────────────────────────────
				"telemetry.telemetryLevel" = "off";
				"update.mode" = "none";

				# ── Files ────────────────────────────────────────────────────────
				# "files.autoSave" = "afterDelay";
				# "files.autoSaveDelay" = 500;
				"files.trimTrailingWhitespace" = false;
				"files.insertFinalNewline" = false;

				# ── Nix ──────────────────────────────────────────────────────────
				# "nix.enableLanguageServer" = true;
				# "nix.serverPath" = "nixd";
			};
		};
	};
}
