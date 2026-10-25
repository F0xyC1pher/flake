{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-logo-svg = {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-colours.svg";
      flake = false;
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    import-tree.url = "github:denful/import-tree";
    matugen = {
      url = "github:InioX/Matugen";
    };
    # hjem = {
    #   url = "github:feel-co/hjem";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hjem.follows = "hjem-rum/hjem";
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      # You may want hjem-rum to use your defined nixpkgs input to
      # minimize redundancies.
      inputs.nixpkgs.follows = "nixpkgs";
      # Same goes for hjem, to avoid discrepancies between the version
      # you use directly and the one hjem-rum uses.
      # inputs.hjem.follows = "hjem";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      # these are only required for internal tests,
      # hence you can set em to nothing
      inputs.nixpkgs.follows = "";
      inputs.hjem.follows = "";
    };

    ksv-cachyos-settings-nixos = {
      url = "github:vivekanandan-ks/ksv-cachyos-settings-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    # birdee = {};
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    proxy-suite.url = "github:FUFSoB/proxy-suite-flake";
    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cursors = {
      url = "github:LilleAila/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-dusk-pr = {
      url = "github:NixOS/nixpkgs/pull/558209/head";
      flake = false;
    };
    hyprland.url = "github:hyprwm/Hyprland";
    mark-shot = {
      url = "github:jswysnemc/mark-shot";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    biri = {
      url = "github:barrulus/biri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-screenshare.url = "github:pantarune/niri-screenshare";
    niri-glass.url = "github:yigexuanmu/Niri-glass";

    scroll-flake = {
      url = "github:Diax170/scroll-flake";
      inputs.nixpkgs.follows = "nixpkgs"; # this assumes nixos unstable
    };
    amethyst = {
      url = "github:ChrisDKN/Amethyst-Mod-Manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Чтобы не тянул второй nixpkgs
    };
    driftwm = {
      url = "github:malbiruk/driftwm";
    };
    neu-nix = {
      url = "github:ricardomaps/neu-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    shojiwm.url = "github:bea4dev/ShojiWM";
    umbriel.url = "git+https://github.com/noctalia-dev/umbriel";
    xdg-desktop-portal-umbriel.url = "git+https://github.com/noctalia-dev/xdg-desktop-portal-umbriel";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia.url = "github:noctalia-dev/noctalia";

    nixcord.url = "github:FlameFlag/nixcord";

    vimium-options.url = "github:uimataso/vimium-nixos";
    nixvim.url = "github:nix-community/nixvim";

    # lunar-client.url = "github:clonidine/lunar-client-flake";

    # zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    zapret2.url = "github:dmfrpro/zapret2-flake";
    tg-ws-proxy.url = "github:pialtor/tg-ws-proxy-flake";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # firefox-addons = {
    # 	url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    # 	inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    nix-firefox-addons.url = "github:osipog/nix-firefox-addons";

    nyoom = {
      #странный менеджер ксс для лисы
      url = "github:ryanccn/nyoom";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lovely-bin = {
      url = "https://github.com/ethangreen-dev/lovely-injector/releases/latest/download/lovely-x86_64-unknown-linux-gnu.tar.gz";
      flake = false;
    };
    luasteam-bin = {
      url = "https://github.com/uspgamedev/luasteam/releases/download/v1.2.0/linux64_luasteam.so";
      flake = false;
    };
    steam-api-bin = {
      url = "https://github.com/rlabrecque/Steamworks.NET/releases/download/2025.164.1/Steamworks.NET-Standalone_2025.164.1.zip";
      flake = false;
    };
    freesmlauncher = {
      url = "github:FreesmTeam/FreesmLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    skwd-wall.url = "github:liixini/skwd-wall";
    rmpc = {
      url = "github:mierak/rmpc";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
    # ── Non-flake sources ────────────────────────────────────────────────────
    r2modman-tui = {
      url = "github:Amar1729/r2modman-tui";
      flake = false;
    };

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    yatline-foxy = {
      url = "github:F0xyC1pher/yatline.yazi";
      flake = false;
    };
    fuse-archive-fork = {
      url = "github:boydaihungst/fuse-archive.yazi";
      flake = false;
    };

    powerlevel10k = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };
    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };
    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };
    fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
    fzf-zsh-completions = {
      url = "github:chitoku-k/fzf-zsh-completions";
      flake = false;
    };
    zsh-history-substring-search = {
      url = "github:zsh-users/zsh-history-substring-search";
      flake = false;
    };
    zsh-auto-notify = {
      url = "github:MichaelAquilina/zsh-auto-notify";
      flake = false;
    };
    zsh-autopair = {
      url = "github:hlissner/zsh-autopair";
      flake = false;
    };
    tmux-tilish = {
      url = "github:farzadmf/tmux-tilish";
      flake = false;
    };
    tmux-continuum = {
      url = "github:tmux-plugins/tmux-continuum";
      flake = false;
    };

    # ── Git sources with submodules ──────────────────────────────────────────
    # pawbar = {
    #   url = "https://github.com/nekorg/pawbar";
    #   type = "git";
    #   submodules = true;
    # };
    rofi-polkit-agent = {
      url = "https://github.com/Zebra2711/rofi-polkit-agent";
      type = "git";
      submodules = true;
      flake = false;
    };
    fuzzel-polkit-agent = {
      url = "https://codeberg.org/lukeflo/fuzzel-polkit-agent";
      type = "git";
      submodules = true;
      flake = false;
    };
    cliphist = {
      url = "https://github.com/sentriz/cliphist";
      type = "git";
      submodules = true;
      flake = false;
    };

    # ── Binary tarballs ──────────────────────────────────────────────────────
    # husi = {
    #   url = "https://codeberg.org/xchacha20-poly1305/husi/releases/download/v1.2.2/fr.husi-1.2.2-1-x86_64.pkg.tar.zst";
    #   flake = false;
    # };
    # nekobox = {
    #   url = "https://github.com/qr243vbi/nekobox/releases/download/5.11.15/nekobox-5.11.15-linux-amd64.tar.gz";
    #   flake = false;
    # };
    # nekobox-git = {
    #   url = "https://github.com/qr243vbi/nekobox";
    #   type = "git";
    #   flake = false;
    #   submodules = true;
    # };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    # Инициализация библиотеки с явной передачей корня флейка
    mylib = import ./lib {
      inherit lib inputs system;
      flakeRoot = ./.;
    };

    # Сканирование директории хостов
    hostDirs = builtins.readDir ./hosts;
    hostNames = builtins.filter (
      name: hostDirs.${name} == "directory" && builtins.pathExists (./hosts + "/${name}/meta.nix")
    ) (builtins.attrNames hostDirs);
  in {
    lib = mylib;

    nixosConfigurations = builtins.listToAttrs (
      map (hostName: {
        name = hostName;
        value = mylib.mkHost {
          inherit hostName;
        };
      })
      hostNames
    );
  };
}
