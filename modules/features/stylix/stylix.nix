{inputs, ...}: {
  flake.homeModules.stylix = {
    config,
    pkgs,
    lib,
    ...
  }: let
    colors = config.lib.stylix.colors.withHashtag;
  in {
    imports = [inputs.stylix.homeModules.stylix];

    stylix = {
      # Base configs.
      enable = true;
      enableReleaseChecks = false;
      autoEnable = false;

      # Image configs.
      image = ./assets/tumblr-luminousslime-003.jpg;

      # Disable stylings for specific target apps.
      targets = {
        gtk = {
          enable = true;
          # Disable fonts since we're using the system-provided fonts in
          # {PROJECT_ROOT}/system/fonts.nix
          fonts.enable = false;
        };

        btop.enable = true;

        # Disable fontconfig inheritance of Stylix default fonts.
        fontconfig.enable = true;
        fontconfig.fonts.enable = false;

        # Enable stylix themeing for Obsidian.
        obsidian.enable = false;

        # Enable stylix themeing for bat.
        bat.enable = true;
      };

      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans Light";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans Light";
        };
      };
    };

    # WezTerm.
    stylix.targets.wezterm.enable = true;

    # GNOME.
    stylix.targets.gnome = {
      enable = true;
      # Disable fonts since we're using the system-provided fonts in
      # {PROJECT_ROOT}/system/fonts.nix

      polarity.enable = true;
      polarity.override = "dark";

      useWallpaper = true;
    };

    # Declare all 16 base16 colors as session variables to be used by applications
    # not controlled by Home Manager.
    home.sessionVariables = builtins.listToAttrs (
      builtins.genList (x: {
        name = "STYLIX_BASE_0${lib.toHexString x}";
        value = colors."base0${lib.toHexString x}";
      })
      15
    );
  };
}
