# Modules

Reusable NixOS modules. `modules/default.nix` always imports `core` and `hardware`;
everything else is selected by name from a user profile.

```text
modules/
├── default.nix          # imports ./core and ./hardware
├── core/                # base system settings (always active)
├── hardware/            # drivers, boot, swap, power (always active, partly conditional)
├── programs/            # desktop applications and CLI tools
├── services/            # system services and daemons
├── packages/            # package bundles (environment.systemPackages)
└── custom-packages/     # derivations exposed as pkgs.custom.<name>
```

## Name resolution

`lib/modules/finder.nix` resolves each name in `userCfg.programs`,
`userCfg.services` and `userCfg.packages` (see [users](../users/readme.md)):

1. `<category>/<name>.nix` — a single file.
2. `<category>/<name>/default.nix` — a module directory.
3. `<category>/<name>/` without `default.nix` — every `*.nix` file in that
   category directory is imported (directories with their own `default.nix` are
   imported as modules).
4. Otherwise a recursive search is performed under the category.

`resolveActiveNames` also records derived names, so `vars.hasProgram "bat"`
becomes true when `programs/cli/bat/default.nix` was imported via `bat`.

Duplicate paths are removed with `lib.unique`. Files starting with `_` and
`default.nix` are skipped where appropriate.

## Adding a module

Put a `.nix` file (or a directory with `default.nix`) under the right category
and add its name to the user profile's list. Modules receive `vars`, `inputs`,
`pkgs`, `lib` and `config` through `specialArgs`/module args. Prefer colors from
`vars.theme.style.*` and application names from `vars.app.*` so the module
follows the active theme and profile.

Custom derivations live in `custom-packages/`: `lib/overlays/custom-pkgs.nix`
turns every `*.nix` file there into `pkgs.custom.<filename>`, available to all
modules through the overlay `pkgsOverlay`.

## Subsystem docs

- [core](./core/readme.md)
- [hardware](./hardware/readme.md)
- [packages](./packages/readme.md)
- [programs](./programs/readme.md)
- [services](./services/readme.md)
