{
	description = "foxyflake";
	
	inputs = {
		
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Актуальная unstable ветка
		
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";  # Следуем за nixpkgs для совместимости
		};
		
		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
		niri = {
			url = "github:sodiboo/niri-flake";
			inputs.nixpkgs.follows = "nixpkgs";  # Следуем за nixpkgs
		};

		awww.url = "git+https://codeberg.org/LGFae/awww";
		
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
		
		zarumet = {
			url = "github:Immelancholy/zarumet";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
	# ayugram-desktop = {
	# 	type = "git";
	# 	submodules = true;
	# 	url = "https://github.com/ndfined-crp/ayugram-desktop/";
	# };
	
	};
	
	outputs = { 
		self,
		nixpkgs,
		home-manager,
		stylix,
		niri,
		awww,
		firefox-addons,
		freesmlauncher,
		zarumet,
		rmpc,
		... 
	}@inputs: let
		
		system = "x86_64-linux"; 
		
		vars = import ./vars.nix; # Выбор нужных модулей через абстрактные названия и проверку в самих модулях
		
	in {
		nixosConfigurations = {
			"${vars.hostName}" = nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = { inherit inputs vars; };  # Передаём inputs в модули
				modules = [
					./modules  # Модульная системная конфигурация
					./hardware-configuration.nix # Основная хардваре конфигурация (автогенерация)
					
					home-manager.nixosModules.home-manager # home-manager как NixOS модуль
					stylix.nixosModules.stylix #собственно stylix
					niri.nixosModules.niri # niri как NixOS модуль
					
					{
						home-manager = {
							extraSpecialArgs = { inherit inputs vars; };
							useGlobalPkgs = true; # Используем глобальные пакеты из системы
							useUserPackages = true; # Устанавливаем пакеты в пользовательский профиль
							backupFileExtension = "backup"; # заодно поможет при конфликтах файлов
							users.${vars.userName} = { ... }: {
								imports = [
									inputs.zarumet.homeModules.default
								];
							};
						};
					}
				];
			};
		};
	};
}
