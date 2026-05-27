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

      servers = {
        gcs-vanilla = {
          enable = true;
          package = pkgs.vanillaServers.vanilla-26_1_2;

          openFirewall = true;

          serverProperties = {
            motd = "Khoi's Vanilla Server";
            gamemode = "survival";
            difficulty = "normal";
            simulation-distance = 8;
            server-port = 25566;
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
      };
    };
  };

  flake.homeModules.nix-minecraft = {...}: {
  };
}
