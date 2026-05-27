{inputs, ...}: {
  flake.nixosModules.nix-minecraft = {pkgs, ...}: {
    imports = [
      inputs.nix-minecraft.nixosModules.minecraft-servers
    ];
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    services.minecraft-servers = {
      enable = true;
      eula = true;

      # servers.gcs-mc = {
      #   enable = false;
      #   package = pkgs.neoforgeServers.neoforge-26_1_2;
      #   openFirewall = true;

      #   whitelist = {
      #     realnamesurname = "f7280f43-8832-436f-9e1b-a4b3c69b3505";
      #     jathpor = "c620fe38-f8d6-4216-985d-f9bc5d300b91";
      #     leaversa = "dc7891fe-bef2-42a3-a1da-d335d46455bb";
      #   };

      #   serverProperties = {
      #     motd = "Khoi's GCS Minecraft Server";
      #     gamemode = "survival";
      #     difficulty = "hard";
      #     simulation-distance = 8;
      #     server-port = 25566;
      #     white-list = true;
      #     enforce-secure-profile = false;
      #     view-distance = 32;
      #     level-name = "New World";
      #     level-seed = "67";

      #     # enable-rcon = true;
      #     # rcon.port = 25577;
      #   };

      #   jvmOpts = "-Xms4G -Xmx4G";

      #   symlinks = {
      #     # Symlinking mods to the "mods" folder in the server.
      #     "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
      #       # Performance mods.
      #       FerriteCore = pkgs.fetchurl {
      #         url = "https://cdn.modrinth.com/data/uXXizFIs/versions/LtVvw4uS/ferritecore-9.0.0-neoforge.jar";
      #         sha256 = "sha256-oyktrbHK960iDTpLaKv/KtWFkt3TchYPnPZsV9FZtTk=";
      #       };
      #       Lithium = pkgs.fetchurl {
      #         url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/ZVNWRJdi/lithium-neoforge-0.24.2%2Bmc26.1.2.jar";
      #         sha256 = "sha256-41KUIXVJdR+cIz1xWskCjVJvKzF1s29SlHB/3iWw818=";
      #       };
      #       Chunky = pkgs.fetchurl {
      #         url = "https://cdn.modrinth.com/data/fALzjamp/versions/hEXc6nbN/Chunky-NeoForge-1.5.3.jar";
      #         sha256 = "sha256-YWYCPj1q6DIs7+/BhvSHVVBsT717Pem9czputmirq2Y=";
      #       };

      #       # Custom terrain generation.
      #       Terralith = pkgs.fetchurl {
      #         url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/4xxRkKvw/Terralith_26.1_v2.6.2_Neoforge.jar";
      #         sha256 = "sha256-PijGKOss/P6Gs2t/J8gh8H6Y+vrJfnd0A4yoaMPx58c=";
      #       };
      #       Incendium = pkgs.fetchurl {
      #         url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/dmD183NM/Incendium_26.1_v5.4.12.jar";
      #         sha256 = "sha256-1Teuth1+OqPKGMFYVx9oCdPjrs+3DeKTn5Lbx6tIRLE=";
      #       };
      #       Continents = pkgs.fetchurl {
      #         url = "https://cdn.modrinth.com/data/bQ5TJA1E/versions/WxCjDRzw/Continents_26.1_v1.1.13.jar";
      #         sha256 = "sha256-qfzMz9NRYYFTgpDx6N9OR+eU7WnE8LJqp9crRs+F634=";
      #       };
      #       Stellarity = pkgs.fetchurl {
      #         url = "https://cdn.modrinth.com/data/bZgeDzN8/versions/aeg7hKnF/Stellarity-5.4.3.jar";
      #         sha256 = "sha256-2H7vSBC/Gx/u3FOFXs8vhqmx14Fj/YPtmb9gSiwKl9Y=";
      #       };
      #     });
      #   };
      # };

      servers.gcs-1_21_1 = {
        enable = true;
        package = pkgs.neoforgeServers.neoforge-1_21_1;
        openFirewall = true;

        whitelist = {
          realnamesurname = "f7280f43-8832-436f-9e1b-a4b3c69b3505";
          jathpor = "c620fe38-f8d6-4216-985d-f9bc5d300b91";
          leaversa = "dc7891fe-bef2-42a3-a1da-d335d46455bb";
          plainolsoapbar = "5ab005ff-aaa3-4a06-855f-1a7fa724dce7";
          feniren = "c4cd6e4b-6d65-4b81-aa81-435739afb3ac";
          hotflare = "3abc73cc-23ab-4cf3-962e-fa6479a764c5";
          deerkektive = "ee074209-3c6e-49ef-bf99-d246a36c62d5";
        };

        serverProperties = {
          motd = "Khoi's GCS Minecraft Server";
          gamemode = "survival";
          difficulty = "hard";
          simulation-distance = 8;
          server-port = 25567;
          white-list = true;
          enforce-secure-profile = false;
          view-distance = 32;
          level-name = "New World";
          level-seed = "67";
        };

        jvmOpts = "-Xms4G -Xmx4G";

        symlinks = {
          # Symlinking mods to the "mods" folder in the server.
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            # Performance mods.
            FerriteCore = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/x7kQWVju/ferritecore-7.0.3-neoforge.jar";
              sha256 = "sha256-2H6igmJxXr/0W4qC1JPmtGjnpFIbwCHfXYgwIZbQMKg=";
            };
            Krypton = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/JkxWVYwU/versions/SUeOFygw/krypton_fnp-neoforge-1.21.1-0.2.28.1-1.21.1.jar";
              sha256 = "sha256-BevoSWEdqv5TP8V+2bUVbt+pFXztBNOKeGCx4gdZhLk=";
            };
            Noisium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/hasdd01q/versions/VviuomrA/noisium-neoforge-2.7.0%2Bmc1.21-1.21.1.jar";
              sha256 = "sha256-ygl81T/Nq+y8vyLiUV6xlW8xPwlM06BQaADr8jniVfk=";
            };
            ScalableLux = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/j10HNoNf/ScalableLux-0.1.0.1%2Bneoforge.1cb1e91-all.jar";
              sha256 = "sha256-dDQKN6+FgBTs9mBoBUvtOrd4si0klW00ii7CvDxYXLU=";
            };
            Chunky = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fALzjamp/versions/LuFhm4eU/Chunky-NeoForge-1.4.23.jar";
              sha256 = "sha256-1y8jXPH1byw3T1LAC92lA0UksoFCMFqEz8Ejo/kq0nQ=";
            };
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/RXHf27Wv/lithium-neoforge-0.15.3%2Bmc1.21.1.jar";
              sha256 = "sha256-plSIYr0T/47qZ0fPYd9QyDdKFqItBnYU5BTtYA7ubYM=";
            };

            # Terrain generation.
            Terralith = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/MuJMtPGQ/Terralith_1.21.x_v2.5.8.jar";
              sha256 = "sha256-ADM6EwrDi3ucqTcACY1eAuBhK9wtNSKq2i825WAGIb8=";
            };
            Incendium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/7mVvV9Th/Incendium_1.21.x_v5.4.4.jar";
              sha256 = "sha256-KFpPaf4jkfIXX3/JMW1yejnHm90hSSPFkoTVabzmVvQ=";
            };
            YungsBetterNetherFortress = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Z2mXHnxP/versions/iopJiJQp/YungsBetterNetherFortresses-1.21.1-NeoForge-3.1.5.jar";
              sha256 = "sha256-VFCmSnA2I39ElJaDfgjz5bOqHXl0oQ30OUQXLe912P8=";
            };
            YungsBetterEndIsland = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/2BwBOmBQ/versions/I52NZ1qK/YungsBetterEndIsland-1.21.1-NeoForge-3.1.2.jar";
              sha256 = "sha256-gAXx6nmNCfwF2tB6Ie0fOTpSOnGBl829N7HObZoX5KQ=";
            };
            YungsBetterStrongholds = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/kidLKymU/versions/8U0dIfSM/YungsBetterStrongholds-1.21.1-NeoForge-5.1.3.jar";
              sha256 = "sha256-qcqy/AFTg2iGI2VpH30hUwmAGu0LOQNRaBtrYKHbe1g=";
            };

            # Dependencies
            YungsApi = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ua7DFN59/versions/ZB22DE9q/YungsApi-1.21.1-NeoForge-5.1.6.jar";
              sha256 = "sha256-COHSFpDTITpMYt5rbPefNSevsucuDK0OGEjUbrj2gso=";
            };
          });
        };
      };
    };
  };

  flake.homeModules.nix-minecraft = {...}: {
  };
}
