{...}: {
  flake.nixosModules.ani-cli = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [ani-cli];
  };

  flake.homeModules.ani-cli = {pkgs, ...}: {
    home.packages = with pkgs; [ani-cli];
  };
}
