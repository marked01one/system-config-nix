{inputs, ...}: {
  # Import Home Manager input.
  # We're using importing rules specific to `flake-parts`.
  # https://flake.parts/options/home-manager.html
  imports = [inputs.home-manager.flakeModules.home-manager];

  # Home Manager System configuration
  flake.nixosModules.home-manager = {
    inputs,
    pkgs,
    ...
  }: {
    # Import Home Manager input.
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    # Home Manager system configurations.
    home-manager = {
      useGlobalPkgs = false;
      useUserPackages = true;
      users.marked01one.imports = [inputs.flakeModules.marked01one];
    };
    # Add Home Manager to system packages.
    environment.systemPackages = [pkgs.home-manager];
  };
}
