{
	description = "flake";
	
	inputs = {
		
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Актуальная unstable ветка
		
		hardware-configuration = { url = "path:/etc/nixos/hardware-configuration.nix"; flake = false; };
		
		home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; }; # Следуем за nixpkgs 
		
		stylix = { url = "github:nix-community/stylix"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		niri = { url = "github:sodiboo/niri-flake"; inputs.niri-unstable.follows = "niri-blur"; inputs.nixpkgs.follows = "nixpkgs"; };
		niri-blur = { url = "github:niri-wm/niri/wip/branch"; flake = false; }; # пример ветки с blur
		
		awww = { url = "git+https://codeberg.org/LGFae/awww"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		firefox-addons = { url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		freesmlauncher = { url = "github:FreesmTeam/FreesmLauncher"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		rmpc = { url = "github:mierak/rmpc"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		ayugram-desktop = { url = "https://github.com/ndfined-crp/ayugram-desktop/"; type = "git"; submodules = true; };
	};
	
	outputs = { self, nixpkgs, hardware-configuration, home-manager, stylix, niri, awww, firefox-addons, rmpc, freesmlauncher, ... }@inputs:
	let
		
		system = "x86_64-linux"; 
		vars = import ./vars; # Выбор нужных компонентов через изменение переменных
		
	in {
		nixosConfigurations = {
			"${vars.hostName}" = nixpkgs.lib.nixosSystem {
				inherit system; specialArgs = { inherit inputs vars; hwModule = hardware-configuration.outPath; };  # Передаём inputs в модули
				modules = [
					./modules
					inputs.hardware-configuration.outPath
					home-manager.nixosModules.home-manager
					stylix.nixosModules.stylix
					niri.nixosModules.niri
					{ 
						home-manager = {
							extraSpecialArgs = { inherit inputs vars; };
							useGlobalPkgs = true; # Используем глобальные пакеты из системы
							useUserPackages = true; # Устанавливаем пакеты в пользовательский профиль
							backupFileExtension = "backup"; # заодно поможет при конфликтах файлов
							users.${vars.userName} = { ... }: {
								# imports = [
								# ];
							};
						};
					}
				];
			};
		};
	};
}
