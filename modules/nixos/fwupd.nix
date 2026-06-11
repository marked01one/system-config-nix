{...}: {
  flake.nixosModules.fwupd = {pkgs, ...}: {
    services.fwupd = {
      enable = true;
    };
  };
}
