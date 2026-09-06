{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.nixvim = {
				enable = true;
				# defaultEditor = true;

				opts = {
					mouse = "a";
					number = true;
					relativenumber = true;
					termguicolors = true;
					tabstop = 2;
					shiftwidth = 2;
					expandtab = true;
					clipboard = "unnamedplus";
				};

				opts.langmap = "";
				autoCmd = [
					{
						event = ["VimEnter"];
						command = "language ru_RU.UTF-8";
					}
				];

				plugins = {
					cmp = {
						enable = true;
						settings = {
							mapping = {
								"<C-Space>" = "cmp.mapping.complete()";
								"<CR>" = "cmp.mapping.confirm({ select = true })";
								"<Tab>" = "cmp.mapping.select_next_item()";
								"<S-Tab>" = "cmp.mapping.select_prev_item()";
							};
							sources = [
								{name = "nvim_lsp";}
								{name = "buffer";}
								{name = "path";}
							];
						};
					};

					lsp = {
						enable = true;
						servers = {
							nixd = {
								enable = true;
								settings.formatting.command = ["alejandra"];
							};
						};
					};

					conform-nvim = {
						enable = true;
						settings = {
							format_on_save = {
								timeout_ms = 2000;
								lsp_fallback = true;
							};
							formatters_by_ft = {
								nix = ["alejandra"];
							};
						};
					};

					yazi = {
						enable = true;
						settings = {
							open_for_directories = true;
						};
					};

					highlight-colors = {
						enable = true;
						settings = {
							render = "square";
							enable_hex = true;
							enable_rgb = true;
						};
					};
				};

				keymaps = [
					{
						mode = "n";
						key = "<leader>y";
						action = "<cmd>Yazi<cr>";
						options.desc = "Открыть Yazi";
					}
				];
			};
		};
	};
}
