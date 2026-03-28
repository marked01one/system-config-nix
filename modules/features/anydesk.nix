{...}: {
  flake.nixosModules.anydesk = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [anydesk];
  };

  flake.homeModules.anydesk = {pkgs, ...}: {
    home.packages = with pkgs; [anydesk];
  };
}
