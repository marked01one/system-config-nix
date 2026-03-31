{...}: {
  flake.homeModules.vesktop = {pkgs, ...}: {
    programs.vesktop = {
      enable = true;
      package = pkgs.vesktop;
    };
  };
}
