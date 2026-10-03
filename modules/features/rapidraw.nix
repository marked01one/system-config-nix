{...}: {
  flake.nixosModules.rapidraw = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [rapidraw];
  };

  flake.homeModules.rapidraw = {...}: {
  };
}
