# foxyflake

A personal NixOS flake. One flake builds several machines; each machine is a
directory in `hosts/`, each human is a profile in `users/`. Host metadata and
user preferences are turned into a single `vars` attribute set, which all
modules consume. Themes are generated from Base16-derived palettes.

## Available machines

| Host | User | Kernel | Bootloader | GPU | Notes |
| --- | --- | --- | --- | --- | --- |
| `p` | `f` | `xanmod_latest` | Limine | NVIDIA `legacy_580` (proprietary) | Desktop, 16 GB RAM, 192 kHz output, 60 Hz HDMI-A-1 |
| `terminal` | `cicada` | `latest` | GRUB | NVIDIA `latest` (open modules) | Laptop, 8 GB RAM, Parallels guest, `nixos-hardware` modules + `battery.nix` |
| `wonderland` | `alice` | `latest` | GRUB (placeholder) | NVIDIA `latest` (open modules) | **Template for new machines**, 16 GB RAM, 96 kHz output |

The flake builds `nixosConfigurations.<host>` automatically for every `hosts/*`
directory containing a `meta.nix` — there is no manual list to maintain in
`flake.nix`.

### Current desktop: `f@p`

- **Shell:** zsh; terminal kitty; launcher rofi; file manager yazi; browser Firefox; editors micro / Zed.
- **Desktop:** niri compositor with waybar, swaylock, uwsm; `no-gnome`.
- **Theme:** `the-me`, accent `normal`/`purple`, font Cascadia Code 12, Posy_Cursor_Black, no blur/shadows/liquid-glass.
- **Audio:** PipeWire with input S16/48 kHz + RNNoise, output F32/192 kHz.
- **Memory:** zRAM + swapfile, 16 GB RAM, `performance` governor.
- **Kernel:** Xanmod with `acpi-cpufreq`, `intel_pstate=disable`.
- **Services:** tuigreet, rofi-polkit, pipewire, mpd, openssh, flatpak, swaync, udev and others.
- **Packages:** `base`, `jdk`, `session-packages`, `wine`, `r2modman-tui`.
- `system.stateVersion` / `home.stateVersion`: `26.11`.

## Usage

```bash
# Build and switch the main machine
sudo nixos-rebuild switch --flake .#p

# Test a configuration without making it the boot default
sudo nixos-rebuild test --flake .#p

# Build only (no switch)
nix build .#nixosConfigurations.p.config.system.build.toplevel

# Update all inputs
nix flake update

# Format Nix sources (alejandra.toml sets two-space indentation)
alejandra .
```

## Architecture

```text
flake.nix                 inputs + automatic host discovery -> mylib.mkHost
system-imports.nix        common NixOS/Home-Manager module list shared by all hosts
lib/
  builder/host.nix        host + user + theme -> nixosSystem
  builder/vars.nix        builds vars.{host,user,app,theme} and has* helpers
  modules/finder.nix      resolves program/service/package names to module files
  modules/analyzer.nix    detects packages referenced inside package modules
  theme-engine/           palettes, style mapping, hex/RGB/HSL math
  colors/                 color converters, validators, arithmetic
  overlays/custom-pkgs.nix  every modules/custom-packages/*.nix -> pkgs.custom.<name>
hosts/<host>/             machine-specific hardware and metadata
users/<user>/             theme, apps, user data, program/service/package lists
modules/                  reusable system and user modules
themes/                   Base16 palettes and derived style trees
```

### How a host is assembled

1. `flake.nix` scans `hosts/`, imports every `<host>/meta.nix` and calls `mylib.mkHost`.
2. `lib/builder/host.nix` reads `meta.nix`, picks `users/<host.user>/default.nix`,
   resolves the theme named in the user profile and builds `vars`.
3. The user profile's `programs`, `services` and `packages` lists are resolved by
   `lib/modules/finder.nix`, which accepts a file, a directory with `default.nix`,
   or a category directory.
4. `system-imports.nix` adds the base modules plus optional input modules selected
   through `vars.hasProgram` / `vars.hasService`.
5. Everything is passed to `lib.nixosSystem` with `vars`, `inputs` and
   `pkgsOverlay` in `specialArgs`.

Modules read `vars.theme.style.*` for colors, `vars.app.*` for default
applications, and `vars.host.*` for hardware decisions.

## Adding a new machine

`wonderland` + `alice` is the template pair. Copy both, then fill in the blanks:

```bash
cp -r hosts/wonderland hosts/<new-host>
cp -r users/alice     users/<new-user>
```

1. Overwrite `hosts/<new-host>/place-hardware-configuration-here.nix` with the
   output of `sudo nixos-generate-config --show-hardware-config` on the new
   machine. The import in `default.nix` already points at that file.
2. Replace the `XX.YY` placeholder in `system.stateVersion` and
   `home.stateVersion` in `hosts/<new-host>/default.nix` with the NixOS release
   you first installed on that machine (`26.11` on `p`).
3. Edit `hosts/<new-host>/meta.nix`: bootloader `device`, kernel, RAM, CPU
   governor, audio rates/formats, display connector and GPU driver. Point
   `host.user` at the user profile you just copied.
4. Edit `users/<new-user>/default.nix`: identity, shell, theme, application
   defaults and the program/service/package lists.
5. Deploy: `sudo nixos-rebuild switch --flake .#<new-host>`.

See [hosts/readme.md](./hosts/readme.md) for every `meta.nix` option.

## Secrets

Do **not** store API tokens or passwords in tracked files. A user profile may
contain a `hashedPassword`, but treat it as a secret too. The flake includes
`sops-nix` (`modules/core/security/sops.nix`) for encrypted secrets; use that
or an external secret manager.

## Documentation

- [Hosts architecture](./hosts/readme.md) — host metadata, hardware and entrypoints.
- [Users](./users/readme.md) — user profiles, theme picking and software suites.
- [Modules](./modules/readme.md) — module tree and name resolution:
  [core](./modules/core/readme.md) · [hardware](./modules/hardware/readme.md) ·
  [packages](./modules/packages/readme.md) · [programs](./modules/programs/readme.md) ·
  [services](./modules/services/readme.md).
- [Themes](./themes/readme.md) — Base16 extension into Base56.
- [Core library (`lib/`)](./lib/readme.md) — builders, color math, module resolver.
- [Squashed commit history](./HISTORY.md) — maps each squashed commit to the original steps it replaced.
