{...}: {
  flake.nixosModules.backlight = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [brightnessctl]; 
  };
}
