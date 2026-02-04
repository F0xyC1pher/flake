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

		mango = {
		      url = "github:DreamMaoMao/mango";
		      inputs.nixpkgs.follows = "nixpkgs";
		    };

		hyprland.url = "github:hyprwm/Hyprland";
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland"; # Prevents version mismatch.
		};
		
		freesmlauncher = {
			url = "github:FreesmTeam/FreesmLauncher";
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
		mango,
		hyprland,
		hyprland-plugins,
		freesmlauncher,
		... 
	}@inputs: let
	
	vars = import ./vars.nix; # Выбор нужных модулей через абстрактные названия и проверку в самих модулях
	
	in	{
		nixosConfigurations = {
			"{$vars.hostName}" = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";  # Укажите вашу архитектуру, если отличается
				specialArgs = { inherit inputs vars; };  # Передаём inputs в модули
				modules = [
					./modules  # Модульная системная конфигурация
					./hardware-configuration.nix # Основная хардваре конфигурация (автогенерация)
					
					stylix.nixosModules.stylix #собственно stylix
					home-manager.nixosModules.home-manager # home-manager как NixOS модуль
					niri.nixosModules.niri # niri как NixOS модуль
					mango.nixosModules.mango
					{
						home-manager = {
							extraSpecialArgs = { inherit inputs vars; };
							useGlobalPkgs = true; # Используем глобальные пакеты из системы
							useUserPackages = true; # Устанавливаем пакеты в пользовательский профиль
							sharedModules = [ mango.hmModules.mango ];
							backupFileExtension = "backup"; # заодно поможет при конфликтах файлов
							users.{$vars.userName} = import ./home; 
						};
					}
				];
			};
		};
	};
}
