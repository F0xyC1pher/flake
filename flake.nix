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

	outputs = { self, nixpkgs, home-manager, stylix, niri, mango, freesmlauncher, ... }@inputs: {
		nixosConfigurations.p = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";  # Укажите вашу архитектуру, если отличается
			specialArgs = { inherit inputs; };  # Передаём inputs в модули
			modules = [
				./configuration.nix  # Основная системная конфигурация
				./hardware-configuration.nix  # Основная хардваре конфигурация

				stylix.nixosModules.stylix #собственно stylix
				home-manager.nixosModules.home-manager # home-manager как NixOS модуль
				{
					home-manager = {
						extraSpecialArgs = { inherit inputs; };
						useGlobalPkgs = true; # Используем глобальные пакеты из системы
						useUserPackages = true; # Устанавливаем пакеты в пользовательский профиль
						sharedModules = [ stylix.homeModules.default ];
						users.f = import ./home.nix;
					};
				}
				niri.nixosModules.niri # niri как NixOS модуль
				mango.nixosModules.mango
			];
		};
	};
}
