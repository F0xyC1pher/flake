{
  pkgs,
  vars,
  lib,
  ...
}: let
  ui = vars.theme.style.ui;   # ui tree
  text = vars.theme.style.text; # text tree
  alpha = vars.theme.opacity;
  hexToRgba = hex: opacity: "rgba(${vars.theme.hexToRgbString hex}, ${toString opacity})";
  colorDefs = ''
    /* ── Global Theme Overrides ───────────────────────────────── */
    @define-color accent_color     ${vars.theme.style.accent};
    @define-color accent_bg_color  ${vars.theme.style.accent};
    @define-color accent_fg_color  ${text.onAccent};
    /* Libadwaita specific variable overrides */
    @define-color headerbar_bg_color        ${hexToRgba ui.bg alpha};
    @define-color headerbar_backdrop_color   ${hexToRgba ui.bg alpha};
    @define-color headerbar_shade_color      ${hexToRgba ui.bg alpha};
    @define-color headerbar_border_color     transparent;
    @define-color bg_main          ${hexToRgba ui.bg alpha};
    @define-color bg_surface       ${hexToRgba ui.surface alpha};
    @define-color bg_overlay       ${ui.overlay};
    @define-color fg_main          ${text.main};
    @define-color fg_heading       ${text.heading};
    @define-color fg_dimmed        ${text.dimmed};
    @define-color border_active    ${ui.border.active};
    @define-color border_inact     ${ui.border.inactive};
    @define-color sem_error        ${text.syntax.error};
    @define-color sem_warning      ${text.syntax.warning};
    @define-color sem_success      ${text.syntax.success};
    @define-color sem_info         ${text.syntax.info};
  '';
  baseCss = ''
    * {
      border-radius: 0;
      -gtk-outline-radius: 0;
      box-shadow: none;
      background-image: none;
    }

    /* ── Скрываем кнопки заголовка ───────────────── */
    headerbar button.titlebutton.close,
    headerbar button.titlebutton.maximize,
    headerbar button.titlebutton.minimize,
    windowcontrols button {
      display: none;
    }

    /* ── Прозрачный фон везде (через @bg_main и @bg_surface) ── */
    window, dialog, .background, .content-pane {
      background-color: @bg_main;
      color: @fg_main;
    }
    headerbar, .titlebar {
      background-color: @bg_surface;
      color: @fg_heading;
      border-bottom: 1px solid @border_inact;
      padding: 4px 8px;
    }
    headerbar:backdrop, .titlebar:backdrop {
      background-color: @bg_main;
      color: @fg_dimmed;
    }

    /* ── Sidebars, Lists & Navigation ───────────────── */
    .sidebar, sidebar, placessidebar, .navigation-sidebar,
    stacksidebar, stacksidebar list, stacksidebar row,
    list, row, treeview {
      background-color: @bg_surface;
      color: @fg_main;
    }
    list row:hover, row:hover, stacksidebar row:hover {
      background-color: @bg_overlay;
      color: @fg_heading;
    }
    list row:selected, row:selected, stacksidebar row:selected {
      background-color: @bg_overlay;
      color: @accent_color;
    }

    /* ── Checkboxes & Radio Buttons ──────────────── */
    checkbutton check, check,
    radiobutton radio, radio {
      min-width: 16px;
      min-height: 16px;
      border: 1px solid @border_active;
      background-color: @bg_surface;
      color: @fg_main;
      margin: 2px 6px;
    }
    checkbutton check:hover, check:hover,
    radiobutton radio:hover, radio:hover {
      border-color: @accent_color;
      background-color: @bg_overlay;
    }
    checkbutton check:checked, check:checked,
    radiobutton radio:checked, radio:checked {
      background-color: @accent_color;
      border-color: @accent_color;
      color: @accent_fg_color;
    }

    /* ── Buttons ──────────────────────────────────── */
    button {
      background-color: @bg_surface;
      color: @fg_main;
      border: 1px solid @border_inact;
      padding: 4px 10px;
    }
    button:hover {
      background-color: @bg_overlay;
      color: @fg_heading;
      border-color: @border_active;
    }
    button:active, button:checked {
      background-color: @accent_color;
      color: @accent_fg_color;
      border-color: @accent_color;
    }
    button:backdrop {
      background-color: @bg_main;
      color: @fg_dimmed;
      border-color: @border_inact;
    }

    /* ── Sliders, Entries, Notebooks и всё остальное ─ */
    scale trough { background-color: @bg_surface; border: 1px solid @border_inact; min-height: 4px; min-width: 4px; }
    scale highlight { background-color: @accent_color; }
    scale slider {
      background-color: @bg_overlay;
      border: 1px solid @border_active;
      min-width: 12px;
      min-height: 12px;
      margin: -4px;
    }
    scale slider:hover { background-color: @accent_color; }

    entry, combobox button {
      background-color: @bg_surface;
      color: @fg_main;
      border: 1px solid @border_inact;
    }
    entry:focus { border-color: @accent_color; }

    notebook header { background-color: @bg_surface; border-bottom: 1px solid @border_inact; }
    notebook header tab {
      background-color: @bg_surface;
      color: @fg_dimmed;
      padding: 6px 12px;
      border: none;
    }
    notebook header tab:checked {
      color: @accent_color;
      background-color: @bg_main;
      border-bottom: 2px solid @accent_color;
    }

    progressbar trough, levelbar trough {
      background-color: @bg_surface;
      border: 1px solid @border_inact;
    }
    progressbar progress, levelbar block.filled {
      background-color: @accent_color;
      border: none;
    }

    scrollbar slider {
      background-color: @bg_overlay;
      min-width: 6px;
      min-height: 6px;
    }
    scrollbar slider:hover { background-color: @accent_color; }

    /* ── Меню и Popover — прозрачный фон ─────────── */
    menu, popover, popover > contents, popover.background > contents {
      background-color: @bg_surface;
      border: 1px solid @border_inact;
    }
    menuitem:hover, popover modelbutton:hover {
      background-color: @bg_overlay;
      color: @accent_color;
    }

    /* ── Фокус и cards ───────────────────────────── */
    *:focus, *:focus-visible {
      outline: 1px solid @accent_color;
      outline-offset: -1px;
      box-shadow: none;
    }
    .card, frame, frame > border, .frame,
    box.card, .view, viewport, stack {
      background-color: transparent;
      border-color: @border_inact;
    }
  '';
  gtk4Only = ''
    navigation-view, .navigation-sidebar, split-pane, flap {
      background-color: @bg_surface;
      color: @fg_main;
    }
    .dropdown, popover list {
      background-color: @bg_surface;
    }
  '';
in {
  home-manager.users.${vars.user.name} = {
    vars,
    lib,
    ...
  }: {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = if vars.theme.dark then "prefer-dark" else "default";
      };
    };
    gtk = {
      enable = true;
      gtk2.extraConfig = "gtk-application-prefer-dark-theme = ${if vars.theme.dark then "1" else "0"}";
      font = {
        name = vars.theme.font.name;
        size = vars.theme.font.size;
      };
      theme = {
        name = if vars.theme.dark then "adw-gtk3-dark" else "adw-gtk3";
        package = pkgs.adw-gtk3;
      };
      iconTheme = {
        name = if vars.theme.dark then "Flat-Remix-Red-Dark" else "Flat-Remix-Red";
        package = pkgs.flat-remix-icon-theme;
      };
      gtk3.extraCss = lib.mkForce (colorDefs + baseCss);
      gtk4.extraCss = lib.mkForce (colorDefs + baseCss + gtk4Only);
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = if vars.theme.dark then 1 else 0;
        gtk-theme-name = if vars.theme.dark then "adw-gtk3-dark" else "adw-gtk3";
        gtk-decoration-layout = "";
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = if vars.theme.dark then 1 else 0;
        gtk-theme-name = if vars.theme.dark then "adw-gtk3-dark" else "adw-gtk3";
        gtk-decoration-layout = "";
      };
    };
  };
}
