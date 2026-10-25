{
  inputs,
  pkgs,
  ...
}:
pkgs.rustPlatform.buildRustPackage {
  pname = "r2modman-tui";
  version = "latest";
  src = inputs.r2modman-tui;
}
