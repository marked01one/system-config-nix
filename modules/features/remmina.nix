{...}: {
  flake.nixosModules.remmina = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [remmina];
  };

  flake.homeModules.remmina = {pkgs, ...}: {
    home.packages = with pkgs; [remmina];
  };
}
