{...}: {
  flake.nixosModules.youtube-tui = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [youtube-tui];
  };

  flake.homeModules.youtube-tui = {pkgs, ...}: {
    home.packages = with pkgs; [youtube-tui];
  };
}
