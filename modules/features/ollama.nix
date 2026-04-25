{...}: {
  flake.nixosModules.ollama = {...}: {
    services.ollama = {
      enable = true;
      loadModels = [
        "gemma3:270m"
      ];
      # Remove any models not declared in `loadModels`
      syncModels = true;
    };
  };
}
