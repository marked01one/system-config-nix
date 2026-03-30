{...}: {
  flake.homeModules.gnome = {config, ...}: {
    # Default applications settings.
    dconf.settings = {
      "org/gnome/desktop/default-applications" = {
        terminal =
          if (config.programs.wezterm.enable)
          then "wezterm"
          else "xterm";
      };
    };
  };

  flake.nixosModules.gnome = {pkgs, ...}: {
    # As of 25.11
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # To disable installing GNOME's suite of applications
    # and only be left with GNOME shell and core apps.
    services.gnome.core-apps.enable = true;
    services.gnome.core-developer-tools.enable = false;
    services.gnome.games.enable = false;
    environment.gnome.excludePackages = with pkgs; [
      atomix
      cheese # webcam tool
      epiphany # web browser
      geary
      gedit # text editor
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-console
      gnome-contacts
      gnome-initial-setup
      gnome-maps
      gnome-music
      gnome-photos
      gnome-text-editor
      gnome-tour
      gnome-user-docs
      gnome-weather
      hitori
      iagno
      tali
      yelp
    ];

    # Enable dconf for gnome configuration.
    programs.dconf.enable = true;

    # Workaround for GNOME autologin
    # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
  };
}
