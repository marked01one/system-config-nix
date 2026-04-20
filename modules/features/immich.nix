{...}: {
  flake.nixosModules.immich = {...}: {
    services.immich = {
      enable = true;
      port = 2283;
      host = "0.0.0.0";
      openFirewall = true;

      machine-learning.enable = true;
    };

  };
}
