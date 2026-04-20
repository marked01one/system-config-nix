{
  self,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.flakeModules.home-manager];

  flake.nixosConfigurations.hydrogen = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hydrogen
      self.nixosModules.hydrogen-hardware
    ];
  };

  flake.nixosModules.hydrogen = {...}: {
    imports = with self.nixosModules; [
      home-manager
    ];

    services.printing.enable = true;
  };

  flake.nixosModules.hydrogen-hardware = {};
}
