# Hosts Architecture

The `hosts/` directory contains machine-specific definitions, hardware drivers, file system configurations, and user assignments. Each subdirectory represents a standalone NixOS system target.

## Directory Structure

```text
hosts/
├── <hostname>/
    ├── default.nix                 # System entrypoint and state version definitions
    ├── meta.nix                    # Machine hardware specs, driver options, and user mapping
    ├── hardware-configuration.nix  # Generated disk mounts, kernel modules, and platform specs
    └── battery.nix                 # (Optional) Hardware-specific tweaks or power management scripts
```

## Host Configuration Breakdown

### 1. Host Entrypoint (`default.nix`)

Defines system-level imports, enables hardware modules (such as `nixos-hardware`), sets system state versions, and passes global `vars` into Home-Manager.

```nix
{ vars, inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    ./battery.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "26.11";

  home-manager = {
    extraSpecialArgs = { inherit vars; };
    users.${vars.user.name} = { ... }: {
      home.stateVersion = "26.11";
    };
  };
}
```

### 2. Machine Metadata (`meta.nix`)

Configures system options including bootloaders, GPU drivers, audio sample rates, memory scaling, and binds the machine to a user profile in `users/`.

```nix
{
  host = {
    user = "alice"; # Target username matching a profile in users/ :String
    host = "WonderLand"; # Target system hostname :String

    parallels.enable = true; # Enable Parallels Desktop guest integrations :Boolean

    boot = {
      loader = "grub"; # Options: "grub", "limine", "GRUB", "LIMINE" :String
      device = "/dev/disk/by-id/"; # Disk path for bootloader :String
    };

    kernel = {
      name = "latest"; # Options: "xanmod_latest", "zen_latest", "hardened", "latest" :String
      # modules = []; # Extra out-of-tree kernel modules :List(String)
    };

    # Dynamic Memory Allocation (Automated paging & compression)
    swap = {
      enable = true; # Enable disk swapfile (/var/lib/swapfile) :Boolean
      # size = 16; # (Optional) Explicit GB size; defaults to hardware.ram :Integer
    };

    zram = {
      enable = true; # Enable compressed RAM block device :Boolean
      # percent = 100; # (Optional) Override adaptive calculation :Integer
    };

    hardware = {
      ram = 16; # System RAM in GB (used for zRAM & Swap calculation) :Integer
      bluetooth.enable = true; # Enable Bluetooth hardware stack :Boolean
      wifi.enable = true; # Enable Wireless networking support :Boolean
      cpu.governor = "performance"; # Options: "performance", "powersave", "ondemand", "schedutil" :String

      audio = {
        input = {
          noiseCancellation = true; # Enable LADSPA RNNoise filter chain on mic :Boolean
          rate.value = 48000; # Options: (48000), 96000, 192000 :Integer
          format = {
            prefix = "S"; # Options: "F", "S" :String
            value = 16; # Bit depth (16, 24, 32) :Integer
            suffix = "LE"; # Endianness: "LE", "BE", "P" :String
          };
        };
        output = {
          rate.value = 48000; # Options: 48000, (96000), 192000 :Integer
          format = {
            prefix = "S"; # Options: "F", "S" :String
            value = 32; # Options: 16, 24, 32 :Integer
            suffix = "LE"; # Options: "LE", "BE", "P" :String
          };
        };
      };

      video = {
        output = {
          name = "HDMI-A-1"; # Display connector identifier :String
          resolution = "1920x1080"; # Options: "YxZ" :IntegerxInteger-in-String
          framerate = "60.000"; # Options: "XXX.YYY" :Float-in-String
        };
        driver = {
          amd = {
            enable = false; # Enable AMD GPU driver stack :Boolean
            # type = "modern"; # Options: "modern" (RX+), "legacy" (Radeon<) :String
          };
          nvidia = {
            enable = true; # Enable NVIDIA GPU driver stack :Boolean
            package = "latest"; # Options: "latest", "legacy_580", "legacy_470" :String
            open = true; # Use open-source kernel modules (Turing+) :Boolean
            perf = {
              value = true; # Options: true for maximum | Watts :Integer | "%" :String | false | null
              persistence = true; # Enable nvidia-persistenced daemon :Boolean
            };
          };
        };
      };
    };
  };
}
```
### 3. Memory & Swap Scaling Logic

The `swap.nix` module automates compressed memory and disk paging based on `hardware.ram` and explicit blocks:

* **zRAM Dynamic Scale**: Calculates percentage automatically if `zram` is declared ($\le 4\text{ GB} \rightarrow 200\%$, $\le 8\text{ GB} \rightarrow 150\%$, $\le 16\text{ GB} \rightarrow 100\%$, $\le 32\text{ GB} \rightarrow 50\%$).
* **Swap Sizing**: If `swap` is declared without `size`, it falls back to matching `hardware.ram`. Applies `noCoW = true` for Btrfs safety.
* **zSwap Conflict Control**: `boot.zswap` is automatically disabled when zRAM is active to avoid double-compression overhead, but conditionally enables for standalone disk swap.

### 4. Hardware Configuration (`hardware-configuration.nix`)

Standard NixOS configuration file generated via `nixos-generate-config`. Specifies available kernel modules, file system mount points, and swap spaces.

```nix
{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ea645b4d-a6ec-49cf-9cdf-7cd712c385a9";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7286-DEB5";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
```

## Adding a New Host

1. Create a new directory under `hosts/` named after your hostname: `hosts/<new-hostname>/`.
2. Copy your system's generated `/etc/nixos/hardware-configuration.nix` into `hosts/<new-hostname>/hardware-configuration.nix`.
3. Create `default.nix` and `meta.nix` files inside the new directory.
4. Set the `user` attribute inside `host` in `meta.nix` to point to a valid profile in `users/`.
5. Deploy the new target:
   ```bash
   sudo nixos-rebuild switch --flake .#<new-hostname>
   ```
