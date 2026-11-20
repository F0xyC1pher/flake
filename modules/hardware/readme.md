# Hardware modules

`modules/hardware/default.nix` always imports `video`, `boot`, `power.nix`,
`redist.nix` and `ssd.nix`. Optional imports are driven by host metadata:

| Condition (`vars.host`) | Module |
| --- | --- |
| `hardware.bluetooth.enable` | `bluetooth.nix` |
| `parallels.enable` | `parallels.nix` |
| `swap` or `zram` declared | `swap.nix` |

## Layout

- `boot/default.nix`, `boot/loader.nix` — bootloader selection (GRUB or Limine)
  from `host.boot.loader` / `host.boot.device`.
- `boot/kernel/` — `default.nix` plus `modules.nix`, `packages.nix`,
  `params.nix`, `sysctl.nix`, `sysfs.nix`: kernel name from `host.kernel.name`,
  extra modules and command-line params, sysctl/sysfs tweaks.
- `video/default.nix`, `video/nvidia/` and `video/amd/` — GPU driver stacks;
  NVIDIA package (`latest`, `legacy_580`, `legacy_470`), open modules,
  application profiles and persistence mode. AMD uses `modern` or `legacy`.
  Display output comes from `host.hardware.video.output`.
- `power.nix` — CPU governor (`performance`, `powersave`, `ondemand`,
  `schedutil`).
- `swap.nix` — zRAM percentage and swapfile sizing derived from
  `hardware.ram`; disables `boot.zswap` when zRAM is in use.
- `ssd.nix`, `redist.nix`, `bluetooth.nix`, `parallels.nix` — periodic TRIM,
  redistributable extra paths, Bluetooth stack and Parallels guest tools.

Per-host generated disk mounts live in `hosts/<host>/hardware-configuration.nix`,
not here. See [hosts](../../hosts/readme.md).
