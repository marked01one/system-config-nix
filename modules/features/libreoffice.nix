{...}: {
  flake.nixosModules.libreoffice = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [libreoffice];
  };

  flake.homeModules.libreoffice = {...}: {
  };
}
