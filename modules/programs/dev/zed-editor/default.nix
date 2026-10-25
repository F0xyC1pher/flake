{
  # inputs,
  pkgs,
  vars,
  ...
}: let
  style = vars.theme.style;
in {
  hjem = {
    users.${vars.user.name}.xdg.config.files = {
      "zed/themes/theMe.json".text = ''
        {
          "$schema": "https://zed.dev/schema/themes/v0.1.0.json",
          "name": "${vars.theme.name}",
          "author": "${vars.user.fullName}",
          "themes": [
            {
              "name": "${vars.theme.name}",
              "appearance": "${
          if vars.theme.dark == true
          then "dark"
          else "light"
        }",
              "style": {
                "background.appearance": "transparent",
                "elevated_surface.background": "#00000000",
                "surface.background": "#00000000",
                "background": "${style.ui.bg}${vars.theme.opacityHex}",
                "element.background": "#00000000",
                "status_bar.background": "${style.ui.bg}${vars.theme.opacityHex}",
                "title_bar.background": "${style.ui.bg}${vars.theme.opacityHex}",
                "toolbar.background": "#00000000",
                "tab_bar.background": "#00000000",
                "tab.inactive_background": "#00000000",
                "tab.active_background": "#00000000",
                "panel.background": "#00000000",
                "editor.background": "#00000000",
                "editor.gutter.background": "#00000000",
                "editor.subheader.background": "#00000000",
                "editor.highlighted_line.background": "#00000000",
                "panel.overlay_background": "#00000000",
                "panel.overlay_hover": "${style.ui.bg}${vars.theme.opacityHex}",
                "text": "${style.text.main}",
                "text.accent": "${style.ui.border.active}",
                "text.muted": "${style.text.dimmed}",
                "syntax": {
                  "comment": {
                    "color": "${style.text.comment}",
                    "font_style": "italic"
                  },
                  "error": {
                    "color": "${style.text.syntax.error}"
                  },
                  "function": {
                    "color": "${style.text.heading}",
                    "font_style": "oblique"
                  },
                  "keyword": {
                    "color": "${style.text.syntax.error}",
                    "weight": 700
                  },
                  "number": {
                    "color": "${style.text.heading}"
                  },
                  "operator": {
                    "color": "${style.text.syntax.error}"
                  },
                  "property": {
                    "color": "${style.text.heading}"
                  },
                  "punctuation": {
                    "color": "${style.text.dimmed}"
                  },
                  "string": {
                    "color": "${style.text.light}"
                  },
                  "type": {
                    "color": "${style.text.syntax.error}"
                  },
                  "variable": {
                    "color": "${style.text.main}"
                  }
                }
              }
            }
          ]
        }
      '';

      "zed/settings.json".text = ''
        {
          "theme": {
            "mode": "${
          if vars.theme.dark
          then "dark"
          else "light"
        }",
            "light": "${vars.theme.name}",
            "dark": "${vars.theme.name}"
          },
          "buffer_font_family": "${
          if vars.theme.font.name == "Cozette"
          then "CozetteVector"
          else vars.theme.font.name
        }",
          "ui_font_family": "${
          if vars.theme.font.name == "Cozette"
          then "CozetteVector"
          else vars.theme.font.name
        }",
          "buffer_font_size": ${
          if vars.theme.font.name == "Cozette"
          then "13"
          else toString vars.theme.font.size
        },
          "ui_font_size": ${
          if vars.theme.font.name == "Cozette"
          then "15"
          else toString vars.theme.font.size
        },
          "text_rendering_mode": "platform_default",
          "ui_font_fallbacks": ["Noto Color Emoji"],
          "buffer_font_fallbacks": ["Noto Color Emoji"],
          "disable_ai": true,
          "telemetry": {
            "diagnostics": false,
            "metrics": false,
            "anthropic_retention": false
          },
          "icon_theme": "Material Icon Theme",
          "rounded_selection": false,
          "cli_default_open_behavior": "existing_window",
          "project_panel": {"dock": "left"},
          "scrollbar": {"show": "never"},
          "completion_menu_scrollbar": "never",
          "completion_menu_item_kind": "off",
          "autosave": "off",
          "hard_tabs": false,
          "colorize_brackets": true,
          "code_lens": "on",
          "snippet_sort_order": "inline",
          "show_completions_on_input": true,
          "show_completion_documentation": true,
          "auto_signature_help": false,
          "show_signature_help_after_edits": false,
          "inline_code_actions": true,
          "diagnostics_max_severity": null,
          "lsp_document_colors": "inlay",
          "lsp_document_links": true,
          "inlay_hints": {"enabled": true},
          "indent_guides": {"coloring": "indent_aware"},
          "minimap": {"show": "always"},
          "terminal": {
            "shell": {
              "program": "${vars.user.shell}"
            },
            "font_family": "${vars.theme.font.name}",
            "font_size": ${toString vars.theme.font.size}
          },
          "lsp": {
            "vscode-css-language-server": {
              "binary": {
                "path": "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server",
                "arguments": ["--stdio"]
              }
            },
            "color-lsp": {
              "binary": {
                "path": "color-lsp",
                "arguments": ["--stdio"]
              },
              "initialization_options": {
                "userLanguages": {
                  "nix": "css"
                }
              }
            },
            "nixd": {
              "binary": {"path": "nixd"},
              "settings": {
                "nixd": {
                  "formatting": {"command": ["alejandra"]},
                  "options": {
                    "nixos": {
                      "expr": "(builtins.getFlake \"/home/${vars.user.name}/flake\").nixosConfigurations.${vars.host.name}.options"
                    }
                  }
                }
              }
            }
          },
          "languages": {
            "Nix": {
              "language_servers": ["nixd", "vscode-css-language-server", "!nil"],
              "formatter": {"external": {"command": "alejandra"}},
              "format_on_save": "on"
            },
            "CSS": {"language_servers": ["color-lsp"]},
            "HTML": {"language_servers": ["color-lsp"]},
            "JavaScript": {"language_servers": ["color-lsp"]},
            "TypeScript": {"language_servers": ["color-lsp"]}
          }
        }
      '';
    };
  };
}
