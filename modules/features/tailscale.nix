{...}: {
  flake.nixosModules.tailscale = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      tailscale
      tailscalesd
    ];

    services.tailscale.enable = true;
  };

  flake.homeModules.tailscale = {pkgs, ...}: {
    home.packages = with pkgs; [
      tailscale
      tailscalesd
    ];
  };
}
