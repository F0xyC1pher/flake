# ── Kitty terminal ────────────────────────────────────────────────────────────
{vars, ...}: {
  # imports = [
  # ./keybinds.nix
  # ./tab_bar.nix
  # ./theme.nix
  # ];
  hjem = {
    users.${vars.user.name}.xdg.config.files = {
      "kitty/kitty.conf".text = let
        t = vars.theme.style;
        c.a = {
          n = vars.theme.colors.accent.bg.normal;
          b = vars.theme.colors.accent.bg.bright;
        };
        c.b = vars.theme.colors.base;
      in ''
        font_family ${vars.theme.font.name}
        font_size ${toString vars.theme.font.size}
        # font_features ${vars.theme.font.name} +liga +calt
        sync_to_monitor yes
        pixel_scroll yes
        mouse_hide_wait 0
        detect_urls yes
        show_hyperlink_targets yes
        repaint_delay 10
        input_delay 3
        enable_audio_bell yes
        remember_window_size no
        remember_window_position no

        window_border_width 1
        draw_minimal_borders no
        draw_window_borders_for_single_window no
        window_margin_width 15 20 15 20
        single_window_margin_width -1
        placement_strategy center
        hide_window_decorations yes
        confirm_os_window_close 0

        background_opacity ${toString vars.theme.opacity}
        background_blur 0

        # ── Tab bar ────────────────────────────────────────────────────────
        tab_bar_edge top
        tab_bar_align left
        tab_bar_style custom
        tab_bar_min_tabs 1
        tab_activity_symbol none
        bell_on_tab no
        tab_bar_margin_width 0.0
        tab_bar_margin_height 0.0 0.0
        # tab_title_template {f'{title[:30]}…' if title.rindex(title[-1]) + 1 > 30 else (title.center(6) if (title.rindex(title[-1]) + 1) % 2 == 0 else title.center(5))}
        active_tab_font_style bold

        # ── UI chrome ──────────────────────────────────────────────────────────
        background ${t.ui.bg}
        foreground ${t.text.main}
        selection_background ${t.text.dimmed}
        selection_foreground ${t.text.main}
        url_color ${t.text.syntax.info}
        cursor ${t.text.main}
        cursor_text_color ${t.ui.bg}

        active_border_color ${t.ui.border.active}
        inactive_border_color ${t.ui.border.inactive}

        active_tab_background ${t.accent}
        active_tab_foreground ${t.ui.bg}
        inactive_tab_background ${t.ui.overlay}
        inactive_tab_foreground ${t.text.dimmed}
        tab_bar_background ${t.ui.bg}

        wayland_titlebar_color ${t.ui.bg}
        macos_titlebar_color ${t.ui.bg}

        # ── Normal (0-7) ───────────────────────────────────────────────────────
        color0 ${t.ui.bg}
        color1 ${c.a.n.red}
        color2 ${c.a.n.green}
        color3 ${c.a.n.yellow}
        color4 ${c.a.n.blue}
        color5 ${c.a.n.magenta}
        color6 ${c.a.n.cyan}
        color7 ${t.text.main}

        # ── Bright (8-15) ──────────────────────────────────────────────────────
        color8 ${t.ui.overlay}
        color9 ${c.a.b.red}
        color10 ${c.a.b.green}
        color11 ${c.a.b.yellow}
        color12 ${c.a.b.blue}
        color13 ${c.a.b.magenta}
        color14 ${c.a.b.cyan}
        color15 ${t.text.heading}
      '';
    };
  };
}
