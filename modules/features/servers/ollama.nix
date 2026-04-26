{...}: {
  flake.nixosModules.ollama = {...}: {
    services.ollama = {
      enable = true;
      loadModels = [
        "gemma3:270m"
        "gemma3:1b"
        "qwen2.5:0.5b"
        "gpt-oss:20b"
      ];
      # Remove any models not declared in `loadModels`
      syncModels = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = 11434;
    };
  };
}
