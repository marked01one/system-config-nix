{...}: {
  flake.nixosModules.ltspice = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [ltspice];
  };

  flake.homeModules.ltspice = {pkgs, ...}: {
    home.packages = with pkgs; [ltspice];
  };
}
