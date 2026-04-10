{...}: {
  flake.nixosModules.globalprotect = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gpclient
    ];
  };

  flake.homeModules.globalprotect = {...}: {
  };
}
