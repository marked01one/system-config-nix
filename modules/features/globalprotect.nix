{...}: {
  flake.nixosModules.globalprotect = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      globalprotect-openconnect
    ];
  };

  flake.homeModules.globalprotect = {...}: {
  };
}
