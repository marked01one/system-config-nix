{...}: {
  flake.nixosModules.mysql = {...}: {
    services.mysql.enable = true;
  };

  flake.homeModules.mysql = {...}: {
  };
}
