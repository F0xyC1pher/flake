# Hosts Architecture

`hosts/` contains machine-specific definitions. Every subdirectory with a
`meta.nix` becomes a `nixosConfigurations.<name>` output automatically
(`flake.nix` scans this directory — no manual host list).

## Hosts in this flake

| Host | User | Bootloader / kernel | RAM | Audio out | GPU |
| --- | --- | --- | --- | --- | --- |
| `p` | `f` | Limine / `xanmod_latest` | 16 GB | F32 / 192000 | NVIDIA `legacy_580`, proprietary |
| `terminal` | `cicada` | GRUB / `latest` | 8 GB | S32 / 48000 | NVIDIA `latest`, open modules |
| `wonderland` | `alice` | GRUB / `latest` | 16 GB | S32 / 96000 | NVIDIA `latest`, open modules (**template**) |

## Directory structure

```text
hosts/
├── <hostname>/
│   ├── default.nix                 # entrypoint, state version, hardware imports
│   ├── meta.nix                    # machine metadata: bootloader, GPU, audio, user
│   ├── hardware-configuration.nix  # generated mounts/kernel modules (real hosts)
│   └── battery.nix                 # optional hardware tweaks (terminal)
└── wonderland/                     # template
    ├── default.nix
    ├── meta.nix
    └── place-hardware-configuration-here.nix  # replace with generated config
```

## 1. Host entrypoint (`default.nix`)

Imports the hardware configuration, sets the NixOS state version and passes
`vars` into Home Manager. Real example (`hosts/p/default.nix`):

```nix
{vars, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];
  system.stateVersion = "26.11";
  home-manager = {
    extraSpecialArgs = {inherit vars;};
    users.${vars.user.name} = {...}: {
      home.stateVersion = "26.11";
    };
  };
}
```

`hosts/terminal/default.nix` additionally imports `nixos-hardware` modules
(`common-cpu-amd`, `common-cpu-amd-pstate`, `common-hidpi`, `common-pc-laptop`,
`common-pc-ssd`) and `./battery.nix`.

## 2. Machine metadata (`meta.nix`)

Everything under `host` ends up as `vars.host` in modules.

```nix
{
  host = {
    user = "f";                       # profile in users/ :String

    parallels.enable = false;         # Parallels guest integrations :Bool

    boot = {
      loader = "limine";              # grub | limine | GRUB | LIMINE :String
      device = "/dev/disk/by-id/ata-Smartbuy_SSD_128GB_LCN263R001798";
      # find yours: ls -la /dev/disk/by-id/ | grep -v part
    };

    kernel = {
      name = "xanmod_latest";         # latest | zen_latest | hardened | xanmod_latest
      modules = ["acpi-cpufreq"];     # extra kernel modules :List(String)
      params = ["intel_pstate=disable"]; # kernel command line params
    };

    swap = {enable = true;};          # /var/lib/swapfile; optional `size` in GB
    zram = {enable = true;};          # compressed RAM; optional `percent`

    hardware = {
      ram = 16;                       # GB, used for zRAM/swap sizing
      bluetooth.enable = true;
      wifi.enable = true;
      cpu.governor = "performance";   # performance | powersave | ondemand | schedutil

      rom = [                         # optional ROM/game library paths (host p)
        {name = "Games"; path = "";}
        {name = "CoolStuff"; path = "";}
      ];

      audio = {
        input = {
          noiseCancellation = true;   # LADSPA RNNoise chain on the mic
          rate.value = 48000;         # 48000 | 96000 | 192000
          format = {prefix = "S"; value = 16; suffix = "LE";}; # F|S, 16|24|32, LE|BE|P
        };
        output = {
          rate.value = 192000;
          format = {prefix = "F"; value = 32; suffix = "LE";};
        };
      };

      video = {
        output = {                    # host p values
          name = "HDMI-A-1";
          resolution = "1920x1080";
          framerate = 60;             # template uses "60.000"
          scale = 1;
        };
        driver = {
          amd = {enable = false; type = "modern";}; # modern | legacy
          nvidia = {
            enable = true;
            open = false;             # open kernel modules (Turing+)
            package = "legacy_580";   # latest | legacy_580 | legacy_470
            perf = {
              value = true;           # true=max | Watts | "percent" | false | null
              persistence = true;     # nvidia-persistenced
            };
          };
        };
      };
    };
  };
}
```

## 3. Memory and swap scaling

`modules/hardware/swap.nix` derives sizes from `hardware.ram`:

- zRAM percentage scales with RAM (≤4 GB → 200%, ≤8 GB → 150%, ≤16 GB → 100%, ≤32 GB → 50%) unless `zram.percent` is set.
- `swap.size` defaults to `hardware.ram` when omitted; `noCoW = true` for Btrfs safety.
- `boot.zswap` is disabled while zRAM is active to avoid double compression.

## 4. Hardware configuration

`hardware-configuration.nix` is generated on the target machine:

```bash
sudo nixos-generate-config --show-hardware-config
```

Paste the output into the host directory (see the template note below). It holds
kernel modules, file system mounts and `nixpkgs.hostPlatform`.

## Adding a new machine — `alice@Wonderland` template

`hosts/wonderland` and `users/alice` form a ready-to-copy pair. `wonderland`
already declares a full `meta.nix` and a valid, minimal entrypoint; the only
placeholder is the hardware configuration.

```bash
cp -r hosts/wonderland hosts/<new-host>
cp -r users/alice     users/<new-user>
```

1. Replace the contents of
   `hosts/<new-host>/place-hardware-configuration-here.nix` with the output of
   `sudo nixos-generate-config --show-hardware-config`. `default.nix` already
   imports that file.
2. Replace the `XX.YY` placeholder in `system.stateVersion` and
   `home.stateVersion` in `default.nix` with the NixOS release you first
   installed on the new machine (`26.11` on `p`).
3. Edit `meta.nix`: real bootloader `device`, kernel, RAM, audio/video,
   GPU driver, and `host.user` pointing at your copied user profile.
4. Edit `users/<new-user>/default.nix`: identity, theme, apps and software lists.
5. Deploy: `sudo nixos-rebuild switch --flake .#<new-host>`.
