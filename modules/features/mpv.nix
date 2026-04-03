{...}: {
  flake.nixosModules.mpv = {...}: {
    programs.mpv = {
      enable = true;
    };
  };
}
