# mkHost.nix — reads host meta and user settings, resolves theme, builds vars
{
  lib,
  inputs,
  system,
  themes,
  overlay,
}:
host:
let
  hostMeta = import (../hosts + "/${host}/meta.nix");

  userSettings = import (../users + "/${vars.user.name}/default.nix") { inherit lib; };

  # resolve theme using userSettings.theme
  resolved = themes.resolve {
    name = userSettings.theme.name;
    colorOverrides = userSettings.theme.colorOverrides or { };
    roleOverrides = userSettings.theme.roleOverrides or { };
  };

  vars = {
    # user identity
    user = {
      name = hostMeta.user;
      fullName = userSettings.user.fullName;
      gitName = userSettings.user.gitName;
      mail = userSettings.user.mail;
      password = userSettings.user.password or null;
      shell = userSettings.user.shell;
    };
    app = {
      gui = {
        browser = userSettings.app.gui.browser; # firefox floorp zen ungoogled-chromium chrome
        file-manager = userSettings.app.gui.file-manager; # nautilus nemo
        launcher = userSettings.app.gui.launcher; # fuzzel rofi
        text-editor = userSettings.app.gui.text-editor; # vscodium zed
      };
      terminal = userSettings.app.terminal;
      tui = {
        browser = userSettings.app.tui.browser; # lyx
        file-manager = userSettings.app.tui.file-manager; # yazi ranger
        text-editor = userSettings.app.tui.text-editor; # micro nano
      };
    };

    # theme settings (original config + resolved style)
    theme = {
      name = userSettings.theme.name;
      dark = userSettings.theme.dark or true;
      font = userSettings.theme.font;
      blur =
        userSettings.theme.blur or {
          enable = false;
          xray.enable = false;
        };
      colorOverrides = userSettings.theme.colorOverrides or { };
      roleOverrides = userSettings.theme.roleOverrides or { };
      style = resolved.theme;
      colors = resolved.colors;
    };

    # host info
    host = hostMeta.host;
    hardware = hostMeta.hardware;
  };

  inherit (inputs)
    home-manager
    sops-nix
    nur
    nixcord
    zen-browser
    noctalia
    system76-scheduler-niri
    niri
    sysc-greet
    ;
in
lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs vars; };
  modules = [
    ../modules/default.nix
    ../users/default.nix
    ../hosts/${host}

    home-manager.nixosModules.home-manager
    niri.nixosModules.niri
    sops-nix.nixosModules.sops
    nur.modules.nixos.default
    sysc-greet.nixosModules.default
    (
      { ... }:
      {
        nixpkgs.overlays = [ overlay ];
      }
    )

    {
      home-manager = {
        extraSpecialArgs = { inherit inputs vars; };
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        sharedModules = [
          sops-nix.homeManagerModules.sops
          nixcord.homeModules.nixcord
          zen-browser.homeModules.twilight
          noctalia.homeModules.default
          system76-scheduler-niri.homeModules.default
        ];
        users.${vars.user.name} =
          { ... }:
          {
            home.username = vars.user.name;
            home.homeDirectory = "/home/${vars.user.name}";
            home.stateVersion = "26.05";
          };
      };
    }
  ];
}
