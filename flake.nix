{
  description = "flake";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Актуальная unstable ветка

    hardware-configuration = {
      url = "path:/etc/nixos/hardware-configuration.nix";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # Следуем за nixpkgs

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:FlameFlag/nixcord";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.niri-unstable.follows = "niri-blur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-blur = {
      url = "github:niri-wm/niri/wip/branch";
      flake = false;
    }; # пример ветки с blur

    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";

    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    freesmlauncher = {
      url = "github:FreesmTeam/FreesmLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rmpc = {
      url = "github:mierak/rmpc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ayugram-desktop = {
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
      type = "git";
      submodules = true;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      hardware-configuration,
      home-manager,
      sops-nix,
      stylix,
      niri,
      nixcord,
      awww,
      firefox-addons,
      rmpc,
      freesmlauncher,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      vars = import ./vars;

      # Оверлей: автоматически подхватывает все пакеты из packages/*.nix
      overlay =
        final: prev:
        let
          files = lib.filterAttrs (
            name: type: type == "regular" && builtins.match "^[^_].*\\.nix$" name != null
          ) (builtins.readDir ./packages);
        in
        builtins.foldl' (
          acc: name:
          let
            pkgName = lib.removeSuffix ".nix" name;
            value = final.callPackage ./packages/${name} { };
          in
          acc // { "${pkgName}" = value; }
        ) { } (builtins.attrNames files);

      # Вспомогательная функция: создаёт nixosConfiguration для хоста
      mkHost =
        hostName:
        lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs vars; };
          modules = [
            ./modules
            ./hosts/${hostName}
            inputs.hardware-configuration.outPath
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            niri.nixosModules.niri
            sops-nix.nixosModules.sops
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
                ];
                users.${vars.userName} =
                  { ... }:
                  {
                    home.username = "${vars.userName}";
                    home.homeDirectory = "/home/${vars.userName}";
                    home.stateVersion = "26.05";
                  };
              };
            }
          ];
        };

    in
    {
      nixosConfigurations =
        # Автоматически подхватывает все поддиректории из hosts/
        # Чтобы добавить хост — создай hosts/имяхоста/default.nix, больше ничего не нужно
        let
          hostDirs = builtins.readDir ./hosts;
          hostNames = builtins.filter (
            name: (hostDirs.${name} == "directory") && (builtins.pathExists (./hosts + "/${name}/default.nix"))
          ) (builtins.attrNames hostDirs);
        in
        builtins.listToAttrs (
          map (hostName: {
            name = hostName;
            value = mkHost hostName;
          }) hostNames
        );
    };
}
