{...}: {
  flake.nixosModules.btop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [btop];
  };

  flake.homeModules.btop = {...}: {
  };
}
