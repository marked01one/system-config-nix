{...}: {
  flake.nixosModules.blocky = {config, ...}: {
    services.blocky = {
      enable = true;

      # Configuration: https://0xerr0r.github.io/blocky/latest/configuration/
      settings = {
        ports.dns = 53;
        upstreams.groups.default = [
          "https://one.one.one.one/dns-query"
        ];
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = ["1.1.1.1" "0.0.0.0"];
        };
        caching = {
          minTime = "10m";
          maxTime = "30m";
          prefetching = true;
        };

        customDNS.mapping."hydrogen.lan" = "hydrogen";
        customDNS.rewrite."hydrogen.lan:${config.services.immich.port}" = "immich.hydrogen.lan";
      };
    };
  };

  flake.homeModules.blocky = {...}: {
  };
}
