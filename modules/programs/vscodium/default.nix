{
	pkgs,
	inputs,
	vars,
	...
}: let
	nix-embedded-highlighter =
		pkgs.vscode-utils.buildVscodeExtension {
			pname = "nix-embedded-highlighter";
			version = "0.0.1";
			vscodeExtName = "nix-embedded-highlighter";
			vscodeExtPublisher = "atomicspirit";
			vscodeExtUniqueId = "atomicspirit.nix-embedded-highlighter";

			src =
				pkgs.fetchurl {
					url = "https://open-vsx.org/api/atomicspirit/nix-embedded-highlighter/0.0.1/file/atomicspirit.nix-embedded-highlighter-0.0.1.vsix";
					sha256 = "sha256-KZfUaPjReHQH0XCCiejAs+0Go8WEeGiOuxjkTfSnku0=";
					name = "nix-embedded-highlighter-0.0.1.zip";
				};

			nativeBuildInputs = [pkgs.unzip];
			sourceRoot = "extension";
		};
in {
	imports = [
		./theme.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			home.file.".vscode-oss/argv.json".text =
				builtins.toJSON {
					"disable-hardware-acceleration" = false;
					"enable-crash-reporter" = false;
					"locale" = "ru";
					"password-store" = "basic";
				};
			programs.vscode = {
				enable = true;
				package = pkgs.vscodium;

				profiles.default = {
					extensions = with pkgs.vscode-extensions; [
						jnoortheen.nix-ide
						christian-kohler.path-intellisense
						jeff-hykin.better-nix-syntax
						ms-ceintl.vscode-language-pack-ru
						nix-embedded-highlighter
						pkief.material-icon-theme
						eamodio.gitlens
						usernamehw.errorlens
					];

					keybindings = [
						{
							key = "ctrl+/";
							command = "editor.action.commentLine";
							when = "editorTextFocus";
						}
						{
							key = "ctrl+Shift+/";
							command = "editor.action.blockComment";
							when = "editorTextFocus";
						}
					];

					userSettings = {
						# ── Window ─────────────────────────────────────────────────────
						"window.titleBarStyle" = "custom";
						"window.menuBarVisibility" = "toggle";
						"window.zoomLevel" = 0;

						# ── Editor ─────────────────────────────────────────────────────
						"editor.fontFamily" = "${vars.fontName}";
						"editor.fontSize" = 14;
						"editor.lineHeight" = 22;
						"editor.fontLigatures" = true;
						"editor.tabSize" = 4;
						"editor.indentSize" = 4;
						"editor.insertSpaces" = false;
						"editor.renderWhitespace" = "boundary";
						"editor.cursorStyle" = "block";
						"editor.cursorBlinking" = "phase";
						"editor.minimap.enabled" = true;
						"editor.scrollBeyondLastLine" = false;
						"editor.smoothScrolling" = true;
						"editor.bracketPairColorization.enabled" = true;
						"editor.guides.bracketPairs" = true;
						"editor.detectIndentation" = false;
						"editor.useTabStops" = true;
						"editor.formatOnSave" = true;
						# "editor.formatOnSaveMode"= "modifications";

						# ── Workbench ──────────────────────────────────────────────────
						# "workbench.colorTheme" = "Default Dark Modern";
						"workbench.startupEditor" = "none";
						"workbench.iconTheme" = "material-icon-theme";
						# "workbench.tree.indent" = 14;

						"nix-embedded-languages.include" = {
							"KDL|kdl" = {
								"name" = "KDL/kdl";
								"scopeName" = "source.kdl";
							};
						};

						"[nix]" = {
							"editor.tabSize" = 4;
							"editor.insertSpaces" = false;
						};
						"nix.enableLanguageServer" = true;
						"nix.serverPath" = "nixd"; # or "nil", or ["executable", "argument1", ...]
						# LSP config can be passed via the ``nix.serverSettings.{lsp}`` as shown below.
						"nix.serverSettings" = {
							# check https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md for all nixd config
							"nixd" = {
								"formatting"."command" = ["alejandra"];
								"options" = {
									# By default, this entry will be read from `import <nixpkgs> { }`.
									# You can write arbitrary Nix expressions here, to produce valid "options" declaration result.
									# Tip: for flake-based configuration, utilize `builtins.getFlake`
									"nixos" = {
										"expr" = "(builtins.getFlake \"/home/${vars.userName}/flake\").nixosConfigurations.${vars.hostName}.options";
									};
									"home-manager" = {
										"expr" = "(builtins.getFlake \"/home/${vars.userName}/flake\").nixosConfigurations.${vars.hostName}.options.home-manager.users.type.getSubOptions []";
									};
								};
							};
						};

						# ── Telemetry ────────────────────────────────────────────────────
						"telemetry.telemetryLevel" = "off";
						"update.mode" = "none";

						# ── Files ────────────────────────────────────────────────────────
						"files.autoSave" = false;
						"files.trimTrailingWhitespace" = false;
						"files.insertFinalNewline" = false;
					};
				};
			};
		};
	};
}
