{inputs, ...}: {
  flake.nixosModules.prismlauncher = {pkgs, ...}: {
    environment.systemPackages = [
      # (let
      #   prism = inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system};
      # in
      #   prism.prismlauncher.override {
      #     prismlauncher-unwrapped = prism.prismlauncher-unwrapped.overrideAttrs (old: {
      #       nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.wrapGAppsHook3];
      #     });
      #   })

      pkgs.prismlauncher
    ];
  };

  flake.homeModules.prismlauncher = {pkgs, ...}: {
    home.packages = [
      inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
    ];
  };
}
