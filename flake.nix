{
	description = "flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Актуальная unstable ветка

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

		sops-nix.url = "github:Mic92/sops-nix";
		sops-nix.inputs.nixpkgs.follows = "nixpkgs";

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
			inputs.nixpkgs.follows = "nixpkgs"; # this assumes nixos unstable
		};

		nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";

		# awww = {
		# 	url = "git+https://codeberg.org/LGFae/awww";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };

		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				# IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};
		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		freesmlauncher = {
			url = "github:FreesmTeam/FreesmLauncher";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-ld = {
			url = "github:Mic92/nix-ld";
			inputs.nixpkgs.follows = "nixpkgs";
		};

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
		# rmpc = {
		# 	url = "github:mierak/rmpc";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };

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
		jbr-wayland-nix.url = "github:BananchickPasha/jbr-wayland-nix";
	};

	outputs = {
		self,
		nixpkgs,
		# hardware-configuration,
		home-manager,
		sops-nix,
		stylix,
		niri,
		nur,
		scroll-flake,
		nixcord,
		zen-browser,
		# jbr-wayland-nix,
		# awww,
		firefox-addons,
		# rmpc,
		freesmlauncher,
		rofi-polkit-agent,
		...
	} @ inputs: let
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		#vars = import ./vars;
		themes = import ./modules/themes/lib.nix {inherit lib;};
		# Оверлей: автоматически подхватывает все пакеты из packages/*.nix
		overlay = final: prev: let
			files =
				lib.filterAttrs (
					name: type: type == "regular" && builtins.match "^[^_].*\\.nix$" name != null
				) (builtins.readDir ./modules/packages/custom);
		in
			builtins.foldl' (
				acc: name: let
					pkgName = lib.removeSuffix ".nix" name;
					value = final.callPackage ./modules/packages/custom/${name} {inherit inputs;};
				in
					acc // {"${pkgName}" = value;}
			) {} (builtins.attrNames files);

		# ── mkHost ──────────────────────────────────────────────────────────────
		# Reads hosts/<name>/meta.nix and users/<mainUser>/default.nix as pure
		# data, resolves the chosen theme, and bundles everything into a single
		# `vars` attrset that gets passed to every NixOS / HM module.
		mkHost = hostName: let
			# 1. Читаем ЧИСТЫЕ данные из meta.nix (это не функция, импорт всегда успешен)
			hostMeta = import (./hosts + "/${hostName}/meta.nix");
			targetUser = hostMeta.mainUser;

			# 2. Подтягиваем настройки этого юзера (тоже вызываем как функцию)
			userSettings = import (./users + "/${targetUser}/default.nix") {inherit lib;};
			resolved =
				themes.resolve {
					name = userSettings.theme;
					colorOverrides = userSettings.colorOverrides or {};
					roleOverrides = userSettings.roleOverrides  or {};
				};
			# Формируем итоговые vars
			hostVars = {
				# identity
				userName = targetUser;
				userFullName = userSettings.userFullName;
				userPassword = userSettings.userPassword or null;

				# appearance
				fontName = userSettings.fontName;
				fontSize = userSettings.fontSize;
				shell = userSettings.shell;
				terminal = userSettings.terminal;
				blur =
					userSettings.blur or {
						enable = false;
						xray.enable = false;
					};

				# style bundle
				style = {
					colors = resolved.colors;
					theme = resolved.theme;
				};

				# host
				hostName = hostMeta.hostName;
				bootLoader = hostMeta.bootLoader or null;
				hardware = hostMeta.hardware  or {};
			};
		in
			lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit inputs;
					vars = hostVars; # Передаем сформированный объект
				};
				modules = with inputs; [
					./modules
					./hosts/${hostName}
					# inputs.hardware-configuration.outPath
					home-manager.nixosModules.home-manager
					stylix.nixosModules.stylix
					niri.nixosModules.niri
					scroll-flake.nixosModules.default
					sops-nix.nixosModules.sops
					nur.modules.nixos.default
					(
						{...}: {
							nixpkgs.overlays = [overlay];
						}
					)
					{
						home-manager = {
							extraSpecialArgs = {
								inherit inputs;
								vars = hostVars;
							};
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
							users.${targetUser} = {...}: {
								home.username = "${targetUser}";
								home.homeDirectory = "/home/${targetUser}";
								home.stateVersion = "26.05";
							};
						};
					}
				];
			};
	in {
		nixosConfigurations = let
			# Автоматически подхватывает все поддиректории из hosts/
			# Чтобы добавить хост — создай hosts/имяхоста/default.nix, больше ничего не нужно
			hostDirs = builtins.readDir ./hosts;
			hostNames =
				builtins.filter (
					name: (hostDirs.${name} == "directory") && (builtins.pathExists (./hosts + "/${name}/default.nix"))
				) (builtins.attrNames hostDirs);
		in
			builtins.listToAttrs (
				map (hostName: {
						name = hostName;
						value = mkHost hostName;
					})
				hostNames
			);
	};
}
