{
  lib,
  config,
  pkgs,
  inputs,
  vars,
  ...
}:

let
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

    nativeBuildInputs = [ pkgs.unzip ];
    sourceRoot = "extension";
  };
in
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.userName} =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {

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
            ];

            keybindings = [
              {
                key = "ctrl+/";
                command = "editor.action.commentLine";
                when = "editorTextFocus && !editorReadonly";
              }
            ];

            userSettings = {
              "locale" = "ru-ru";
              "editor.fontFamily" = lib.mkForce "FiraCode Nerd Font Mono";
              "editor.fontSize" = lib.mkForce 14;
              "editor.fontLigatures" = true;
              "editor.tabSize" = 4;
              "editor.insertSpaces" = false;
              "editor.detectIndentation" = false;
              "editor.useTabStops" = true;
              "editor.indentSize" = "tabSize";
              "editor.formatOnSave" = true;

              # "[nix]" = {
              # };

              "nix.enableLanguageServer" = true;
              "nix.serverPath" = "nixd";
              "nix.serverSettings.nixd.options" = {
                "nixos".expr = "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.${vars.hostName}.options";
                "home-manager".expr =
                  "(builtins.getFlake \"/etc/nixos\").homeConfigurations.${vars.userName}.options";
              };
              userSettings = {
                # ... ваши существующие настройки ...

                "workbench.colorCustomizations" = {
                  # Выделение при поиске
                  "editor.findMatchHighlightBackground" = "#00000000";
                  "editor.findMatchHighlightBorder" = "1px solid ${vars.colors.orange}";
                  "editor.findMatchBackground" = "#00000000";
                  "editor.findMatchBorder" = "1px solid ${vars.colors.yellow}";

                  # Выделение выбранного текста
                  "editor.selectionBackground" = "#40${vars.colors.blue}"; # 40 = 25% прозрачности
                  "editor.selectionBorder" = "1px solid ${vars.colors.blue}";
                  "editor.selectionHighlightBackground" = "#20${vars.colors.green}"; # 20 = 12.5% прозрачности
                  "editor.selectionHighlightBorder" = "1px solid ${vars.colors.green}";

                  # Подсветка текущей строки
                  "editor.lineHighlightBackground" = "#10${vars.colors.base03}"; # легкая подсветка
                  "editor.lineHighlightBorder" = "1px solid ${vars.colors.base03}";

                  # Подсветка скобок
                  "editorBracketMatch.background" = "#20${vars.colors.yellow}";
                  "editorBracketMatch.border" = "1px solid ${vars.colors.yellow}";

                  # Подсветка слова под курсором
                  "editor.wordHighlightBackground" = "#20${vars.colors.blue}";
                  "editor.wordHighlightBorder" = "1px solid ${vars.colors.blue}";
                  "editor.wordHighlightStrongBackground" = "#30${vars.colors.orange}";
                  "editor.wordHighlightStrongBorder" = "1px solid ${vars.colors.orange}";
                };
              };
            };
          };
        };
      };
  };
}
