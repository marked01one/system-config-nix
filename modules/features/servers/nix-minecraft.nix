{inputs, ...}: {
  flake.nixosModules.nix-minecraft = {pkgs, ...}: {
    imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    environment.systemPackages = with pkgs; [mcrcon];

    services.minecraft-servers = {
      enable = true;
      eula = true;

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
          level-name = "Very New World";
          level-seed = "42067";

          # Remote console.
          enable-rcon = true;
          "rcon.password" = "password";
          "rcon.port" = 25577;
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

            # World generation.
            Terralith = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/MuJMtPGQ/Terralith_1.21.x_v2.5.8.jar";
              sha256 = "sha256-ADM6EwrDi3ucqTcACY1eAuBhK9wtNSKq2i825WAGIb8=";
            };
            Incendium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/7mVvV9Th/Incendium_1.21.x_v5.4.4.jar";
              sha256 = "sha256-KFpPaf4jkfIXX3/JMW1yejnHm90hSSPFkoTVabzmVvQ=";
            };
            BetterEnd = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/IcERKldh/versions/QWW9Gwwf/BetterEnd-21.0.24.jar";
              sha256 = "sha256-EAWi9mYvmnaWKmvavfEIoA7QOWtd0hc8ScHL8C7ViRs=";
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
            YungsBetterOceanMonuments = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/3dT9sgt4/versions/yFjEcj2g/YungsBetterOceanMonuments-1.21.1-NeoForge-4.1.2.jar";
              sha256 = "sha256-zc+P4OCMdSYQSNQ8btSJiXLSPglt0EolJME28GQWqwI=";
            };
            YungsBetterWitchHuts = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/t5FRdP87/versions/AvedwcIe/YungsBetterWitchHuts-1.21.1-NeoForge-4.1.1.jar";
              sha256 = "sha256-iIsebRraIZgqdav7SvsEDJvCzGh3fsX80Rmbl449T40=";
            };
            YungsBetterDesertTemples = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/XNlO7sBv/versions/GQ9iNWkI/YungsBetterDesertTemples-1.21.1-NeoForge-4.1.5.jar";
              sha256 = "sha256-LDGRrURwksx4c6BukvFr0+L/ncMekyaLiJPQbdieH9Y=";
            };
            YungsBetterMineshafts = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/HjmxVlSr/versions/Go3nbneL/YungsBetterMineshafts-1.21.1-NeoForge-5.1.1.jar";
              sha256 = "sha256-ViWTDfsyQIINbk7PVf/ww59wzngvrRF6TUGCURhMe+A=";
            };
            YungsBetterJungleTemples = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/z9Ve58Ih/versions/P00i2hJn/YungsBetterJungleTemples-1.21.1-NeoForge-3.1.2.jar";
              sha256 = "sha256-oNV7eMehiReW80Kx8JwhS8J77fCjqJTwKd/bLbn4E9A=";
            };

            # Gamplay tweaks.
            EnderDragonFightRemastered = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/HQsBdHGd/versions/mCpyMtM9/edf-remastered-5.0.0.jar";
              sha256 = "sha256-t7hPsOdiFD8unXFEsMpkRpDLqw2HSOg0sUz27Y7dQgQ=";
            };
            FarmersDelight = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/R2OftAxM/versions/GbNuOZ4S/FarmersDelight-1.21.1-1.3.2.jar";
              sha256 = "sha256-j/Q41i4fzmFUKUX6rkWXXYI+BL1uc6B6Eh6gXOLwPec=";
            };
            NethersDelight = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/O53VhQoZ/versions/qBUSJw5Z/MyNethersDelight-1.21.1-1.10.2.jar";
              sha256 = "sha256-ACZ48Vrg5hgF07vQvIx9f2g9Y+arR5/4+yUYUUE0xMI=";
            };
            ChefsDelight = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/pvcsfne4/versions/csBO1q5h/chefsdelight-1.0.5-neoforge-1.21.1.jar";
              sha256 = "sha256-n9eSCkzO0ARDwQfBrAUAKzVUNzTHbgXvHR6/XxfOmcg=";
            };

            # Mobs.
            GuardVillagers = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/H1sntfo8/versions/p8QpwGZ2/guardvillagers-2.4.8-1.21.1.jar";
              sha256 = "sha256-l9uQcKax9U8EkfOxrDP0wOuj5Qrm8fGf3tvf8PCnmKQ=";
            };
            Ribbits = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/8YcE8y4T/versions/XrUKaWrw/Ribbits-1.21.1-NeoForge-4.1.6.jar";
              sha256 = "sha256-eUIj9akbi4CpYnVLUYDsPiRy22lB6bbBzdSTJN9ig4k=";
            };

            # Decorations.
            Supplementaries = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fFEIiSDQ/versions/4XwZg5Dq/supplementaries-neoforge-1.21.1-3.6.5.jar";
              sha256 = "sha256-yFloUY/4IusxO17IKS9/VNDMm0/gRq5eej5KQPbI52s=";
            };
            SupplementariesSquared = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/dCCkNFwE/versions/6LgMCeqW/suppsquared-1.21-1.2.17-neoforge.jar";
              sha256 = "sha256-SRIKLO3/WlG5JX7kTHKp04BY6hP+mNP8uerSwu313Uk=";
            };

            # Dependencies
            YungsApi = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ua7DFN59/versions/ZB22DE9q/YungsApi-1.21.1-NeoForge-5.1.6.jar";
              sha256 = "sha256-COHSFpDTITpMYt5rbPefNSevsucuDK0OGEjUbrj2gso=";
            };
            BCLib = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/7bdKEtKC/versions/sH6onskf/bclib-21.0.20.jar";
              sha256 = "sha256-QScj+WqhldnZYCjrl/o2fx88QweOUE9MVFrYK8N+SbI=";
            };
            WunderLib = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/HZmhgdJk/versions/5db3GZzg/wunderlib-21.0.10.jar";
              sha256 = "sha256-tJx6BA+HreHj9zvXM16NaP96MokZwZKm0sAiuuZ4ai8=";
            };
            WorldWeaver = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/R8uGDQpB/versions/IWU5Ih3g/worldweaver-21.0.18.jar";
              sha256 = "sha256-mnW5fM2T3TSEA1JrjySzTlW6+WR3iZRos7q3Hjd5qbI=";
            };
            MoonlightLib = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/twkfQtEc/versions/er7S98Q1/moonlight-neoforge-1.21.1-3.0.14.jar";
              sha256 = "sha256-fsJX7c4dR4PTpRQ/PyN90GDTFAot/PRlIqUFIREHKs0=";
            };
          });
        };
      };
    };
  };

  flake.homeModules.nix-minecraft = {...}: {
  };
}
