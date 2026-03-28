{inputs, ...}: {
  # Home Manager System configuration
  flake.nixosModules.home-manager = {...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];
    # Home Manager system configurations.
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
