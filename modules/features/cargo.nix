{...}: {
  flake.nixosModules.cargo = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      cargo
      gcc
    ];
  };

  flake.homeModules.cargo = {...}: {
  };
}
