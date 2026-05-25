{...}: {
  flake.nixosModules.prism-launcher = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [prismlauncher];
  };

  flake.homeModules.prism-launcher = {pkgs, ...}: {
    home.packages = with pkgs; [prismlauncher];
  };
}
