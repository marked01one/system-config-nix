{...}: {
  flake.nixosModules.unityhub = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [unityhub];
  };

  flake.homeModules.unityhub = {pkgs, ...}: {
    home.packages = with pkgs; [unityhub];
  };
}
