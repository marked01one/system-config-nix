{inputs, ...}: {
  flake.nixosModules.nix-minecraft = {pkgs, ...}: {
    imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers = {
        gcs-vanilla = {
          enable = true;
          package = pkgs.vanillaServers.vanilla-26_1_2;

          serverProperties = {
            gamemode = "survival";
            difficulty = "normal";
            simulation-distance = 8;
            server-port = 25566;
          };

          jvmOpts = "-Xms4G -Xmx4G";

          # whitelist = {
          #
          # };
        };
      };
    };
  };

  flake.homeModules.nix-minecraft = {...}: {
  };
}
