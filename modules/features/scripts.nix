{
  self,
  pkgs,
  ...
}: let
  local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
in {
  flake.nixosModules.scripts = {...}: {
    environment.systemPackages = with local-pkgs; [
      fcp
      print-theme
    ];
  };

  flake.homeModules.scripts = {...}: {
    home.packages = with local-pkgs; [
      fcp
      print-theme
    ];
  };
}
