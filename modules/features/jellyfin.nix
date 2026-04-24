{...}: {
  flake.nixosModules.jellyfin = {pkgs, ...}: {
    services.jellyfin = {
      enable = true;

      cacheDir = "/var/cache/jellyfin";
      dataDir = "/var/lib/jellyfin";
    };
  };
}
