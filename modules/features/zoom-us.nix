{...}: {
  flake.nixosModules.zoom-us = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [zoom-us];
  };

  flake.homeModules.zoom-us = {...}: {
  };
}
