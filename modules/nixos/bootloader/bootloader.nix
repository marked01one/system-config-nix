{...}: {
  # Bootloader module config for GRUB.
  flake.nixosModules.grub = {lib, ...}: {
    boot.loader.efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };

    # Prevent keyboard latency bug by disabling autosuspending.
    boot.kernelParams = ["usbcore.autosuspend=-1"];

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      extraEntriesBeforeNixOS = true;
      efiInstallAsRemovable = true;
      device = "nodev";

      # Splash wallpaper for GRUB bootloader.
      splashImage = ./assets/tumblr-fishbloc-001.jpg;

      font = ./assets/nerdfont-jetbrainsmono.pf2;
      fontSize = 24;
    };

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.loader.limine.enable = lib.mkForce false;
  };

  # Bootloader module config for Limine.
  flake.nixosModules.limine = {...}: {
    boot.loader.efi.canTouchEfiVariables = true;

    # Prevent keyboard latency bug by disabling autosuspending.
    boot.kernelParams = ["usbcore.autosuspend=-1"];

    boot.loader.limine = {
      enable = true;

      style = {
        wallpapers = [./assets/tumblr-fishbloc-001.jpg];
        wallpaperStyle = "stretched";

        interface = {
          branding = "Khoi's Digital Portal...";
          brandingColor = 7;
        };

        graphicalTerminal = {
          font.spacing = 0;
          font.scale = "2x2";

          # Using Catpuccin Frappe color scheme as a default.
          palette = "303446;e78284;a6d189;e5c890;8caaee;f4b8e4;81c8be;c6d0f5";
          brightPalette = "626880;e78284;a6d189;e5c890;8caaee;f4b8e4;81c8be;c6d0f5";

          background = "99303446";
          foreground = "c6d0f5";

          margin = 10;
          marginGradient = 4;
        };
      };
    };
  };
}
