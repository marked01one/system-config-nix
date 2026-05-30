{inputs, ...}: {
  flake.nixosModules.helium-browser = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  flake.homeModules.helium-browser = {...}: {
  };
}
