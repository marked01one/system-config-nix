{inputs, ...}: {
  flake.nixosModules.nix-minecraft = {pkgs, ...}: {
    imports = [
      inputs.nix-minecraft.nixosModules.minecraft-servers
    ];
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    environment.systemPackages = with pkgs; [ngrok];

    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers.gcs-vanilla = {
        enable = true;
        package = pkgs.vanillaServers.vanilla-26_1_2;
        openFirewall = true;

        serverProperties = {
          motd = "Khoi's Vanilla Server";
          gamemode = "survival";
          difficulty = "normal";
          simulation-distance = 8;
          server-port = 25565;
          white-list = true;
          enforce-secure-profile = false;
          view-distance = 32;
        };

        jvmOpts = "-Xms4G -Xmx4G";

        whitelist = {
          realnamesurname = "f7280f43-8832-436f-9e1b-a4b3c69b3505";
          jathpor = "c620fe38-f8d6-4216-985d-f9bc5d300b91";
          leaversa = "dc7891fe-bef2-42a3-a1da-d335d46455bb";
        };
      };

      services.gcs-modded = {
        enable = true;
        package = pkgs.neoforgeServers.neoforge-1_21_1;
        openFirewall = true;

        whitelist = {
          realnamesurname = "f7280f43-8832-436f-9e1b-a4b3c69b3505";
          jathpor = "c620fe38-f8d6-4216-985d-f9bc5d300b91";
          leaversa = "dc7891fe-bef2-42a3-a1da-d335d46455bb";
        };

        serverProperties = {
          motd = "Khoi's Minecraft Server";
          gamemode = "survival";
          difficulty = "normal";
          simulation-distance = 8;
          server-port = 25566;
          white-list = true;
          enforce-secure-profile = false;
          view-distance = 32;
        };

        jvmOpts = "-Xms4G -Xmx4G";

        symlinks = {
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            # Performance mods.
            FerriteCore = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/uXXizFIs/versions/x7kQWVju/ferritecore-7.0.3-neoforge.jar";};
            Krypton = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/JkxWVYwU/versions/SUeOFygw/krypton_fnp-neoforge-1.21.1-0.2.28.1-1.21.1.jar";};
            LazyDFU = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/OmQzuQFa/versions/WHSBfR8W/LazyDFU-%5BUNOFFICIAL%5D%2B1.21.jar";};
            Noisium = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/hasdd01q/versions/VviuomrA/noisium-neoforge-2.7.0%2Bmc1.21-1.21.1.jar";};
            ScalableLux = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/j10HNoNf/ScalableLux-0.1.0.1%2Bneoforge.1cb1e91-all.jar";};
            Chunky = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/fALzjamp/versions/LuFhm4eU/Chunky-NeoForge-1.4.23.jar";};
            C2ME = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/COlSi5iR/versions/KmfiVd28/c2me-neoforge-mc1.21.1-0.3.0%2Balpha.0.93.jar";};

            # Terrain generation.
            Terralith = pkgs.fetchurl {url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/MuJMtPGQ/Terralith_1.21.x_v2.5.8.jar";};
          });
        };
      };
    };
  };

  flake.homeModules.nix-minecraft = {...}: {
  };
}
