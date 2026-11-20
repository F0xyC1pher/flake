# Placeholder hardware configuration for a new machine.
#
# Before deploying, overwrite this file with the output of:
#   sudo nixos-generate-config --show-hardware-config
#
# The import in ./default.nix points at this file, so no path changes are
# needed after you paste the generated configuration.
{...}: {
  nixpkgs.hostPlatform = "x86_64-linux";
}
