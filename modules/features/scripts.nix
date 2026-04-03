{self, ...}: let
in {
  flake.nixosModules.scripts = {pkgs, ...}: let
    local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    environment.systemPackages = with local-pkgs; [
      fcp
      eza-grep
      flake-parts-init
    ];
  };

  flake.homeModules.scripts = {
    pkgs,
    lib,
    config,
    ...
  }: let
    local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    home.packages = with local-pkgs;
      [
        fcp
        eza-grep
        flake-parts-init
      ]
      ++ (
        # Only include the following packages if Stylix is enabled AND defined.
        lib.optionals (config ? stylix && config.stylix.enable)
        (with local-pkgs; [print-stylix])
      );
  };
}
