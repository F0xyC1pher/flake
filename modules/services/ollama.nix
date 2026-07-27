{
	pkgs,
	config,
	lib,
	...
}: let
	# Список моделей, которые мы хотим декларативно иметь в системе
	# Можно указывать как стандартные из реестра, так и по прямой ссылке на GGUF
	models = [
		# "qwen2.5:1.5b"
		"hf.co/bartowski/Llama-3.2-3B-Instruct-Abliterated-GGUF:Q4_K_M"
	];
in {
	services.ollama = {
		enable = true;
		package = pkgs.ollama-cuda;
		# Ограничиваем контекст по умолчанию, чтобы не вылезти за 3 ГБ VRAM
		environmentVariables = {
			OLLAMA_NUM_PARALLEL = "1";
			OLLAMA_MAX_LOADED_MODELS = "1";
		};
	};
}
