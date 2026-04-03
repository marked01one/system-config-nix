{...}: {
  flake.nixosModules.teams-for-linux = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [teams-for-linux];
  };

  flake.homeModules.teams-for-linux = {pkgs, ...}: {
    home.packages = with pkgs; [teams-for-linux];
  };
}
