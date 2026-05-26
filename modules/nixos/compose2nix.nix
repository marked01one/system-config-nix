{inputs, ...}: {
  flake.nixosModules.compose2nix = {...}: {
    environment.systemPackages = [
      inputs.compose2nix.packages.x86_64-linux.default
    ];
  };
}
