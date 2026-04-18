{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			programs.rmpc = {
				enable = true;
				package = pkgs.rmpc;
				config = "
					(
						keybinds: [
							// === YouTube / yt-dlp бинды через \"y\" как лидер ===

							// y a  →  добавить URL (addyt)
							(key: \"ya\", command: \"Command\", args: [\"addyt \"]),

							// Пример: добавить после текущей песни
							(key: \"yA\", command: \"Command\", args: [\"addyt --position +1 \"]),
							
							// y s  →  поиск на YouTube (searchyt)
							(key: \"ys\", command: \"Command\", args: [\"searchyt \"]),

							// y S  →  поиск на SoundCloud
							(key: \"yS\", command: \"Command\", args: [\"searchyt -s \"]),

							// y i  →  интерактивный поиск (самый удобный вариант)
							(key: \"yi\", command: \"Command\", args: [\"searchyt --interactive \"]),

							// y I  →  интерактивный поиск с лимитом 10
							(key: \"yI\", command: \"Command\", args: [\"searchyt --interactive --limit 10 \"]),

						],
					)
				";
			};
		};
	};
}
