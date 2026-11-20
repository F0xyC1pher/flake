# Program modules

Applications and CLI tools, grouped by category. A name from a user profile's
`programs` list is resolved to one or more files under `modules/programs`
(see [modules](../readme.md)). Names can point to a single `.nix` file, a
directory with `default.nix`, or be found by a recursive search.

## Categories

- **browser** — `firefox` (`default.nix`, extensions, policies, userChrome,
  userContent, userJS).
- **cli** — `bat`, `fastfetch`, `gh`, `git`, `micro`, `neovim`, `nh`, `nixvim`,
  `tmux`, `zoxide`, `yazi`.
- **desktop** — `niri`, `hyprland`, `umbriel`, `scroll`, `uwsm`, `xwayland`,
  `no-gnome`, `driftwm`, `dusk`, `shojiwm`. Compositors keep their config under
  `<name>/config/`.
- **dev** — `zed-editor`.
- **gayming** — `gamemode`, `mangohud`, `steam` (including Balatro).
- **gui** — `fonts`, `qt`, `gtk`, `dconf`, `rofi`, `fuzzel`, `dms`, `noctalia`,
  `waybar`. Waybar modules live in `gui/waybar/modules/`; `шаблон.nix` there is
  a stub for writing new modules.
- **media** — `mpv`, `obs-studio`, `rmpc`, `nixcord`.
- **misc** — `appimage`, `throne`, `swaylock`, `skwd-wall`, `nix-ld`, and
  terminal emulator families under `misc/terminal/` (`kitty`, `ghostty`, `rio`,
  `wezterm`).

Shells live under `cli/shell/`: `fish`, `zsh`, `bash`, `nushell`, `xonsh`,
`nix-your-shell`.

Some programs are backed by flake inputs and are wired into Home Manager's
`sharedModules` only when `vars.hasProgram` is true — `nixvim`, `umbriel`,
`noctalia`, `nixcord`, `dms`, `driftwm`, `shojiwm`, `skwd-wall` (see
`system-imports.nix`).

`f@p` enables niri, hyprland, waybar, rofi, yazi, kitty, fish, zsh, firefox,
mpv, obs-studio, rmpc and others; see `users/f/default.nix` for the full list.
