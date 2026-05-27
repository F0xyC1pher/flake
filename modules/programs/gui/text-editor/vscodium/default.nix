{
  pkgs,
  inputs,
  vars,
  ...
}: let
  nix-embedded-highlighter = pkgs.vscode-utils.buildVscodeExtension {
    pname = "nix-embedded-highlighter";
    version = "0.0.1";
    vscodeExtName = "nix-embedded-highlighter";
    vscodeExtPublisher = "atomicspirit";
    vscodeExtUniqueId = "atomicspirit.nix-embedded-highlighter";

    src = pkgs.fetchurl {
      url = "https://open-vsx.org/api/atomicspirit/nix-embedded-highlighter/0.0.1/file/atomicspirit.nix-embedded-highlighter-0.0.1.vsix";
      sha256 = "sha256-KZfUaPjReHQH0XCCiejAs+0Go8WEeGiOuxjkTfSnku0=";
      name = "nix-embedded-highlighter-0.0.1.zip";
    };

    nativeBuildInputs = [pkgs.unzip];
    sourceRoot = "extension";
  };
  vscode-kdl-v1hz = pkgs.vscode-utils.buildVscodeExtension {
    pname = "vscode-kdl-v1hz";
    version = "2.1.3";
    vscodeExtName = "kdl";
    vscodeExtPublisher = "v1hz";
    vscodeExtUniqueId = "v1hz.kdl";

    src = pkgs.fetchurl {
      url = "https://open-vsx.org/api/v1hz/kdl/2.1.3/file/v1hz.kdl-2.1.3.vsix";
      sha256 = "sha256-i5J4hXU3cOnFiPS+LZ0fIwwQo7hV0dueF0cPXUv25z0=";
      name = "v1hz-kdl-0.0.1.zip";
    };

    nativeBuildInputs = [pkgs.unzip];
    sourceRoot = "extension";
  };
in {
  imports = [
    ./theme.nix # ← подключаем тему
  ];
  home-manager = {
    extraSpecialArgs = {inherit inputs vars;};
    users.${vars.user.name} = {pkgs, ...}: {
      home.file.".vscode-oss/argv.json".text = builtins.toJSON {
        "disable-hardware-acceleration" = false;
        "enable-crash-reporter" = false;
        "locale" = "ru";
        "password-store" = "basic";
      };
      programs.vscodium = {
        enable = true;
        # package = pkgs.vscodium;

        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            nix-embedded-highlighter
            vscode-kdl-v1hz
            jnoortheen.nix-ide
            christian-kohler.path-intellisense
            jeff-hykin.better-nix-syntax
            ms-ceintl.vscode-language-pack-ru
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
            # ── System ─────────────────────────────────────────────────
            "http.systemCertificatesNode" = true;
            "geminicodeassist.project" = "gen-lang-client-0845042642";
            "security.workspace.trust.untrustedFiles" = "open";

            # ── Window ─────────────────────────────────────────────────
            "window.titleBarStyle" = "custom";
            "window.menuBarVisibility" = "toggle";
            "window.zoomLevel" = 0;

            # ── Editor ─────────────────────────────────────────────────
            "editor.fontFamily" = vars.theme.font.name;
            "editor.fontSize" = 14;
            "editor.lineHeight" = 22;
            "editor.fontLigatures" = true;
            "editor.tabSize" = 4;
            "editor.indentSize" = 4;
            "editor.insertSpaces" = false;
            "editor.detectIndentation" = false;
            "editor.renderWhitespace" = "boundary";
            "editor.cursorStyle" = "block";
            "editor.cursorBlinking" = "phase";
            "editor.minimap.enabled" = true;
            "editor.scrollBeyondLastLine" = false;
            "editor.smoothScrolling" = true;
            "editor.bracketPairColorization.enabled" = true;
            "editor.guides.bracketPairs" = true;
            "editor.useTabStops" = true;
            "editor.formatOnSave" = true;

            # ── Workbench ──────────────────────────────────────────────
            "workbench.startupEditor" = "none";

            # ── Nix embedded languages ─────────────────────────────────
            "nix-embedded-languages.include" = {
              "KDL|kdl" = {
                "name" = "KDL/kdl";
                "scopeName" = "source.kdl";
              };
            };

            # ── Nix language server ────────────────────────────────────
            "[nix]" = {
              "editor.tabSize" = 4;
              "editor.insertSpaces" = false;
            };
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
            "nix.serverSettings" = {
              "nixd" = {
                "formatting"."command" = ["alejandra"];
                "options" = {
                  "nixos" = {
                    "expr" = "(builtins.getFlake \"/home/${vars.user.name}/flake\").nixosConfigurations.${vars.host}.options";
                  };
                  "home-manager" = {
                    "expr" = "(builtins.getFlake \"/home/${vars.user.name}/flake\").nixosConfigurations.${vars.host}.options.home-manager.users.type.getSubOptions []";
                  };
                };
              };
            };

            # ── Telemetry & updates ────────────────────────────────────
            "telemetry.telemetryLevel" = "off";
            "update.mode" = "none";

            # ── Files ──────────────────────────────────────────────────
            "files.autoSave" = "off";
            "files.trimTrailingWhitespace" = false;
            "files.insertFinalNewline" = false;
          };
        };
      };
    };
  };
}
