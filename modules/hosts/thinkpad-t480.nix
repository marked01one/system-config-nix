{inputs, ...}: {
  flake.nixosConfigurations.thinkpad-t480 = inputs.nixpkgs.lib.nixosSystem {
    modules = [];
  };
}
