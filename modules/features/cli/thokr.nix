{...}: {
  flake.nixosModules.thokr = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [thokr];
  };

  flake.homeModules.thokr = {pkgs, ...}: {
    home.packages = with pkgs; [thokr];
  };
}
