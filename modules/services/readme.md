# Service modules

Daemons and background services. Names come from a user profile's `services`
list and are resolved under `modules/services` (see [modules](../readme.md)).

## Available services

- **Session / display**: `display-manager/` (currently only `tuigreet.nix` is
  imported; cosmic-greeter, dms-greeter, ly and sddm are kept as alternatives),
  `dbus`, `seatd`, `xserver`, `userborn`, `logind`, `earlyloom`.
- **Audio / media**: `pipewire`, `playerctld`, `mpd`.
- **Network / proxy**: `resolved`, `openssh`, `proxy-suite`, `sing-box`,
  `xray-client`, `dnscrypt-proxy`, `logmein-hamachi`, `dropbox`.
- **Polkit**: `polkit-service/` with `rofi-polkit-service.nix` and
  `fuzzel-polkit-service.nix` (choose one).
- **Desktop helpers**: `cliphist`, `wl-clip-persist`, `swayidle`, `swaync`,
  `flatpak`, `gvfs`, `locate`, `udev`, `arrpc`, `awww`, `scx-loader`,
  `accounts-daemon`.
- **Power / system**: `no-cups`, `tlp`, `upower`, `ppd`, `irqbalance`,
  `envfs`, `ollama`, `asusd`.

`f@p` enables tuigreet, rofi-polkit, pipewire, mpd, openssh, flatpak, udev,
swayidle, swaync and others — see `users/f/default.nix`.

Enabling `proxy-suite` also adds its NixOS module through `vars.hasService` in
`system-imports.nix`.
