{inputs, ...}: {
  # Home Manager System configuration
  flake.nixosModules.home-manager = {pkgs, ...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];
    # Home Manager system configurations.
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = {inherit inputs;};
    };

    environment.systemPackages = with pkgs; [
      home-manager
    ];
  };
}
