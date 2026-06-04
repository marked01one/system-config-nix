{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nix-minecraft = {pkgs, ...}: {
    imports = [inputs.nix-minecraft.nixosModules.minecraft-servers self.nixosModules.podman-spark-bytes];
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
          pigjawa = "5b796499-d53f-4784-b842-d35251b47ced";
          kiyonetcat = "6d59a749-6523-4097-9aff-63e08566b1e9";
          xmona_ = "c295b318-689b-4aab-b456-568f175a3b6f";
          taffykat = "448eca8b-b531-4b54-a8e8-e24f3dfb8202";
          jo_spaghetti = "437c63b1-9974-49fb-9e79-52f2ebf5e3c2";
          steve_funky = "46afa971-0673-4346-9e2e-777f36dce491";
        };

        operators = {
          realnamesurname = "f7280f43-8832-436f-9e1b-a4b3c69b3505";
          jathpor = "c620fe38-f8d6-4216-985d-f9bc5d300b91";
        };

        serverProperties = {
          motd = "GCS and Friends!";
          gamemode = "survival";
          difficulty = "hard";
          simulation-distance = 8;
          server-port = 25567;
          white-list = true;
          enforce-secure-profile = false;
          view-distance = 32;
          level-name = "GCS and Friends (2)";
          level-seed = "67";

          spawn-protection = 0;

          # Remote console.
          enable-rcon = true;
          "rcon.password" = "password";
          "rcon.port" = 25577;
        };

        jvmOpts = "-Xms6G -Xmx6G";

        # Symlinking mods to the "mods" folder in the server.
        symlinks."mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
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
          Clumps = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/jo7lDoK4/Clumps-neoforge-1.21.1-19.0.0.1.jar";
            sha256 = "sha256-tSTM2s4u+P0Z9bIHT33hEDrFBlxSVT8GTADgmDRsKT4=";
          };
          Spark = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/l6YH9Als/versions/v5qtqRQi/spark-1.10.124-neoforge.jar";
            sha256 = "sha256-ZH6Kga++QU26HfS6Ff0GxdMtTLVE5ogoQF6OB0wuFts=";
          };

          # World generation.
          Terralith = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/MuJMtPGQ/Terralith_1.21.x_v2.5.8.jar";
            sha256 = "sha256-ADM6EwrDi3ucqTcACY1eAuBhK9wtNSKq2i825WAGIb8=";
          };
          Atmospheric = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/U9sJOFmJ/versions/XIvPRE4O/atmospheric-1.21.1-7.0.1.jar";
            sha256 = "sha256-i27I5QKfChiyxXMBiHNCIA8lz2V7jN9v3UDwj0rSBEQ=";
          };
          Environmental = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/OqtiAZcV/versions/NdDV1AM8/environmental-1.21.1-5.0.1.jar";
            sha256 = "sha256-0FeKuWFGG8Je5Z2GxE87kFZeR4LKtDHf2Jf1AIDVmIs=";
          };
          Autumnity = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/cRh6MJ6n/versions/9jUNvDKx/autumnity-1.21.1-6.0.1.jar";
            sha256 = "sha256-b2PBlhCpc+HcGsZ3FMeqbFSEjWLRCZ7tE4U6vA4DQQQ=";
          };
          Terrabnormals = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/Cm5PuZjY/versions/78celQi3/Terrabnormals-v1.3.0%20-%201.21.1.jar";
            sha256 = "sha256-pUPfc9oL6MjpCtxSx0vFzpMUw0+x62QF6i6jf12GbuI=";
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
          CTOV = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/fgmhI8kH/versions/ztzRUnQ7/%5BNeoforge%5Dctov-3.6.3.jar";
            sha256 = "sha256-SBWxm4NUHwnLpVbiImErxd3MMffEuiGY9LTWN2zKiy4=";
          };

          # Gameplay tweaks.
          JEI = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/u6dRKJwZ/versions/YAcQ6elZ/jei-1.21.1-neoforge-19.27.0.340.jar";
            sha256 = "sha256-iq9UdDLxtJWCObA2NWuRBpL+QPhYwwc9mW9Wu/fJmCY=";
          };
          SimpleVoiceChat = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/eFhbQnrh/voicechat-neoforge-1.21.1-2.6.18.jar";
            sha256 = "sha256-+w3B9Ls29HH6/Ib+4SuWPwNt341GImU1CdiEu+2WseU=";
          };
          Corpse = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/WrpuIfhw/versions/Zwf8nv8y/corpse-neoforge-1.21.1-1.1.13.jar";
            sha256 = "sha256-gNmE8KF9loIgEpzFjt1cnyil9hqE7GfcxBIopG36S7E=";
          };
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
          AbnormalsDelight = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/ts3qjo5t/versions/FTg86KNz/abnormals_delight-1.21.1-6.0.2.jar";
            sha256 = "sha256-oVpr6moNKQcx8aQ3jTp765f660XVnLmO06pNFL9EIus=";
          };
          Neapolitan = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/InYMuiQt/versions/RQ5qgaUC/neapolitan-1.21.1-6.0.1.jar";
            sha256 = "sha256-guEEr8SYhxNPsPdOaz07yCf+H4jqPRSDbCcBIYoQcdk=";
          };
          BuzzierBees = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/b7vOFSIp/versions/Y12rtT96/buzzier_bees-1.21.1-7.0.1.jar";
            sha256 = "sha256-xEJWo0M63V6xtfZYeq07A9wp1Yb3VJ3zu+G4GhVoPqc=";
          };
          Allurement = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/eIO12l2t/versions/LPWZjZvj/allurement-1.21.1-5.0.2.jar";
            sha256 = "sha256-VMCLs8gbMieKepW/3+fEJguckeSMIL2lcj6yP8R5NvA=";
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
          UpgradeAquatic = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/gTuTFFyz/versions/3ZycbXog/upgrade_aquatic-1.21.1-7.0.1.jar";
            sha256 = "sha256-rE7ezDQUNcOIk9hZZAdKLgnjIuP7Mr6T0I8qMWXA6+c=";
          };
          AlexsMobs = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/EmNhnNnt/versions/KSgki4uc/alexsmobs-1.22.17.jar";
            sha256 = "sha256-blAoVfeeTJ8qEdVgqbiKOrKVqjeMRLDwoN2V+V0DAaY=";
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

          # Create (with Addons).
          Create = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/LNytGWDc/versions/UjX6dr61/create-1.21.1-6.0.10.jar";
            sha256 = "sha256-74f+Vwnxuh9bi7IKKSW1r7RmnheP1ti/EMFndZ7v43o=";
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
          GeckoLib = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/8BmcQJ2H/versions/gFmrC8Ru/geckolib-neoforge-1.21.1-4.8.4.jar";
            sha256 = "sha256-obbOJehieqfnSGcu7ba3GvaOCZNGIxNknCWfOOQrysk=";
          };
          Blueprint = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/VsM5EDoI/versions/5JOCYuQM/blueprint-1.21.1-8.1.0.jar";
            sha256 = "sha256-PZVATouRyZ8SzAjRT/Q12Ro7B5mv+jP8YqDK+nguP6c=";
          };
          Lithostitched = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/XaDC71GB/versions/wiffJSbz/lithostitched-1.7.9-neoforge-21.1.jar";
            sha256 = "sha256-naWCbjSfiljcpSb3r87JzdfWkGV3lFJCyHRiqm3rze4=";
          };
          Citadel = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/XjY0RcQj/versions/mIylVpkN/citadel-1.21.1-2.7.6.jar";
            sha256 = "sha256-nhJGjEnlqVt62/IrO00FvFVWWYm4nEC5hc1zvf5jw8I=";
          };
        });

        # Server configs for Alex's Mobs.
        symlinks."config/alexsmobs-common.toml".value = {
          general = {
            giveBookOnStartup = false;
          };

          spawning = {
            straddlerSpawnWeight = 30;
            sunbirdSpawnRolls = 18;
            murmurSpawnWeight = 0;
            caveCentipedeSpawnWeight = 0;
          };
        };

        # Voice chat server configs.
        symlinks."config/voicechat/voicechat-server.properties".value = {
          port = 24467;
          voice_host = "gcs.mc.marked01one.live:24467";
          max_voice_distance = 90;
          whisper_distance = 36;
        };

        symlinks."config/spark/config.json".value = {
          backgroundProfiler = true;
          backgroundProfilerInterval = 10;
          backgroundProfilerEngine = "java";
        };
      };
    };
  };

  flake.homeModules.nix-minecraft = {...}: {
  };
}
