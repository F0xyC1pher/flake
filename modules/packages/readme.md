# Package modules

Each module adds a group of packages to `environment.systemPackages`. Names are
listed in a user profile's `packages` list (see [users](../../users/readme.md))
and resolved by `lib/modules/finder.nix`.

| Name | Purpose |
| --- | --- |
| `base` | General system utilities (core shell tools, archive/network helpers) |
| `session-packages` | Desktop-session and Wayland utilities |
| `jdk` | Java development kit |
| `wine` | Wine/Proton related utilities |
| `creamlinux` | Optional creamlinux bundle |
| `google-antigravity` | Optional Google Antigravity tools |
| `neu-nix` | Optional neu-nix package set |

`f@p` currently uses `base`, `jdk`, `session-packages` and `wine`. The
`r2modman-tui` entry in the profile is a custom package from
`modules/custom-packages/`, exposed as `pkgs.custom.r2modman-tui` by the
overlay rather than by a module in this directory.

`vars.hasPackage` combines the active package names with a source scan performed
by `lib/modules/analyzer.nix`; it reports whether a package is referenced even
when a bundle installs it indirectly.

Custom derivations from `modules/custom-packages/` are available as
`pkgs.custom.<name>` through the overlay — see [modules](../readme.md).
