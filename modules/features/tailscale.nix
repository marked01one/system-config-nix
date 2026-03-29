{...}: {
  flake.nixosModules.tailscale = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      tailscale
      tailscalesd
    ];
  };

  flake.homeModules.tailscale = {pkgs, ...}: {
    home.packages = with pkgs; [
      tailscale
      tailscalesd
    ];
  };
}
