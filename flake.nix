{
	description = "flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		flake-utils.url = "github:numtide/flake-utils";

		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-gaming.url = "github:fufexan/nix-gaming";
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

		lsfg-vk-flake = {
			url = "github:pabloaul/lsfg-vk-flake/main";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		noctalia = {
			url = "github:noctalia-dev/noctalia-shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		betterfox = {
			url = "github:yokoffing/Betterfox";
			flake = false;
		};

		vimium-options.url = "github:uimataso/vimium-nixos";
		lunar-client.url = "github:clonidine/lunar-client-flake";

		zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
		zapret2.url = "github:dmfrpro/zapret2-flake";
		tg-ws-proxy.url = "github:pialtor/tg-ws-proxy-flake";

		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-cursors = {
			url = "github:LilleAila/nix-cursors";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixcord.url = "github:FlameFlag/nixcord";

		niri = {
			url = "github:sodiboo/niri-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		system76-scheduler-niri.url = "github:Kirottu/system76-scheduler-niri";
		niri-float-sticky.url = "github:probeldev/niri-float-sticky";

		scroll-flake = {
			url = "github:Diax170/scroll-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";

		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};

		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-firefox-addons.url = "github:osipog/nix-firefox-addons";

		freesmlauncher = {
			url = "github:FreesmTeam/FreesmLauncher";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-ld = {
			url = "github:Mic92/nix-ld";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		awww = {
			url = "git+https://codeberg.org/LGFae/awww";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# ── Non-flake sources ────────────────────────────────────────────────────
		yazi-plugins = {
			url = "github:yazi-rs/plugins";
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
		queercat = {
			url = "https://github.com/Elsa002/queercat";
			type = "git";
			submodules = true;
		};
		pawbar = {
			url = "https://github.com/nekorg/pawbar";
			type = "git";
			submodules = true;
		};
		ayugram-desktop = {
			url = "https://github.com/ndfined-crp/ayugram-desktop/";
			type = "git";
			submodules = true;
		};
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
		nekobox = {
			url = "https://github.com/qr243vbi/nekobox/releases/download/5.11.2/nekobox-5.11.2-linux-amd64.tar.gz";
			flake = false;
		};
		nekobox-git = {
			url = "https://github.com/qr243vbi/nekobox";
			type = "git";
			flake = false;
			submodules = true;
		};

		jbr-wayland-nix.url = "github:BananchickPasha/jbr-wayland-nix";
	};

	outputs = {
		self,
		nixpkgs,
		...
	} @ inputs: let
		system = "x86_64-linux";
		lib = nixpkgs.lib;

		# Pure helpers — no side effects, safe to call at eval time
		themes = import ./lib/themes/lib.nix {inherit lib;};
		overlay = import ./lib/overlay.nix {inherit lib inputs;};
		mkHost = import ./lib/mkHost.nix {inherit lib inputs system themes overlay;};

		# Auto-discover every subdirectory of hosts/ that has a default.nix
		hostDirs = builtins.readDir ./hosts;
		hostNames =
			builtins.filter
			(name:
					hostDirs.${name}
					== "directory"
					&& builtins.pathExists (./hosts + "/${name}/default.nix"))
			(builtins.attrNames hostDirs);
	in {
		nixosConfigurations =
			builtins.listToAttrs
			(map (name: {
						inherit name;
						value = mkHost name;
					})
				hostNames);
	};
}
