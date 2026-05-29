{inputs, ...}: {
  flake.nixosModules.prismlauncher = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
    ];
  };

  flake.homeModules.prismlauncher = {pkgs, ...}: {
    home.packages = [
      inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
    ];
  };
}
