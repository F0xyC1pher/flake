{
	description = "foxyflake";
	
	inputs = {
		
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Актуальная unstable ветка
		
		hardware-configuration = { url = "path:/etc/nixos/hardware-configuration.nix"; flake = false; };
		
		home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; }; # Следуем за nixpkgs 
		
		stylix = { url = "github:nix-community/stylix"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		niri = { url = "github:sodiboo/niri-flake"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		awww = { url = "git+https://codeberg.org/LGFae/awww"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		firefox-addons = { url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		freesmlauncher = { url = "github:FreesmTeam/FreesmLauncher"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		rmpc = { url = "github:mierak/rmpc"; inputs.nixpkgs.follows = "nixpkgs"; };
		
		ayugram-desktop = { url = "https://github.com/ndfined-crp/ayugram-desktop/"; type = "git"; submodules = true; };
	};
	
	outputs = { 
		self, nixpkgs, hardware-configuration, freesmlauncher, 
		home-manager, stylix, niri, awww, firefox-addons, rmpc,
		... 
	}@inputs: let
		
		system = "x86_64-linux"; 
		vars = import ./vars.nix; # Выбор нужных компонентов через изменение переменных
		
	in {
		nixosConfigurations = {
			"${vars.hostName}" = nixpkgs.lib.nixosSystem {
				inherit system; specialArgs = { inherit inputs vars; };  # Передаём inputs в модули
				
				
				modules = [
					./modules hardware-configuration.outPath stylix.nixosModules.stylix
					home-manager.nixosModules.home-manager niri.nixosModules.niri
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
