{ inputs, pkgs, ... }:
{
  environment.systemPackages = with inputs.neu-nix.packages.${pkgs.stdenv.hostPlatform.system}; [
    neuwld
    neuswc
    neumenu
    shko
    hevel
    slgro
    howl
    hack
    swclock
    swiv
    mojito
    hst
    tohu
    neuwm
    wsxwm
    klatka
    wawa
  ];
}
