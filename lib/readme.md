# Core library (`lib/`)

`lib/default.nix` is the flake's internal library. `flake.nix` imports it with
`lib`, `inputs`, `system` and `flakeRoot`, and exposes it as the flake's `lib`
output. It provides:

| Export | Source | Purpose |
| --- | --- | --- |
| `colorUtils` | `colors/` | hex/RGB/HSL conversion, validation, arithmetic, contrast helpers |
| `paletteBuilder` | `theme-engine/palette.nix` | builds base16 slots plus accent variants |
| `defaultThemeStyle` | `theme-engine/style.nix` | default mapping from colors to UI roles |
| `themeBuilder` | `theme-engine/theme.nix` | discovers palettes, resolves a theme and its accents |
| `moduleResolver` | `modules/finder.nix`, `modules/analyzer.nix` | name → module file resolution and package detection |
| `pkgsOverlay` | `overlays/custom-pkgs.nix` | exposes `modules/custom-packages/*.nix` as `pkgs.custom.<name>` |
| `varsBuilder` | `builder/vars.nix` | builds `vars` from a host and a user profile |
| `mkHost` | `builder/host.nix` | assembles and returns a `nixosSystem` |

## Build pipeline

`mkHost {hostName}` performs these steps:

1. Read `hosts/<hostName>/meta.nix` and take `host` plus `host.user`.
2. Import `users/<userName>/default.nix` as the user profile.
3. Resolve the theme: `themeBuilder.resolve` with the profile's `theme.name`,
   `accentLevel` and `accentColor` (defaults: `the-me`, `normal`, `red`).
4. Build `vars` with `varsBuilder` (see [users](../users/readme.md)).
5. Resolve the profile's program/service/package name lists through
   `moduleResolver`.
6. Call `system-imports.nix` with all of the above to build the module list,
   then return `lib.nixosSystem` with `vars`, `inputs` and `pkgsOverlay` in
   `specialArgs`.

## Theme discovery

`themes/*.nix` register a palette under its filename (e.g. `the-me.nix` →
`the-me`); `themes/<dir>/*.nix` register as `<dir>-<file>` (e.g.
`themes/catppuccin/mocha.nix` → `catppuccin-mocha`). `themes/default.nix` and
a palette directory's `default.nix` provide default accent settings. An unknown
theme name throws an error listing all available names.

Resolved palettes expose `vars.theme.colors` (base16 + accent slots) and
`vars.theme.style` (UI roles, accents with automatic contrast). See
[themes](../themes/readme.md).
