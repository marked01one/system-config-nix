{...}: {
  flake.nixosModules.obs-studio = {...}: {
    programs.obs-studio.enable = true;
  };

  flake.homeModules.obs-studio = {...}: {
  };
}
