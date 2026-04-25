{...}: {
  flake.nixosModules.ollama = {...}: {
    services.ollama = {
      enable = true;
      loadModels = [
        "gemma3:270m"
	"gemma3:1b"
	"qwen2.5:0.5b"
      ];
      # Remove any models not declared in `loadModels`
      syncModels = true;
    };
  };
}
