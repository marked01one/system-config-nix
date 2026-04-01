{self, ...}: {
  flake.nixosModules.default-apps = {lib, ...}: let
    defaultUser = "marked01one";
  in {
    # Locally declared options for NixOS module.
    options.local.username = lib.mkOption {
      default = defaultUser;
      type = lib.types.str;
      description = "The primary username for default apps config.";
    };

    # NOTE: We only import the homeModule here, since we want to delegate
    # configuration to Home Manager as much as possible.
    config = {
      home-manager.users.${defaultUser}.imports = [
        self.homeModules.default-apps
      ];
    };
  };

  flake.homeModules.default-apps = {
    pkgs,
    config,
    lib,
    ...
  }: {
    home.packages = (
      # Only add a default if Firefox is not already available
      lib.optionals (!config.programs.firefox.enable) [pkgs.firefox-devedition]
    );

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = [
        "firefox-devedition.desktop"
      ];
    };
  };
}
