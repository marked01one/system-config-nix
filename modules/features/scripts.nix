{self, ...}: let
in {
  flake.nixosModules.scripts = {pkgs, ...}: let
    local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    environment.systemPackages = with local-pkgs; [
      fcp
    ];
  };

  flake.homeModules.scripts = {pkgs, ...}: let
    local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    home.packages = with local-pkgs; [
      fcp
    ];
  };
}
