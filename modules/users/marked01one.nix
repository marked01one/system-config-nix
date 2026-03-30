{
  self,
  inputs,
  ...
}: {
  # Import Home Manager input.
  # We're using importing rules specific to `flake-parts`.
  # https://flake.parts/options/home-manager.html
  imports = [inputs.home-manager.flakeModules.home-manager];

  # NixOS Module for `username: marked01one`
  flake.nixosModules.marked01one = {...}: {
    # NixOS-side user declaration.
    users.users.marked01one = {
      enable = true;
      isNormalUser = true;
      description = "marked01one";
      extraGroups = ["networkmanager" "wheel"];
    };

    # Home Manager module imports.
    home-manager.users.marked01one.imports = with self.homeModules; [
      # core user home module.
      marked01one

      # feature modules
      yt-dlp
      wezterm
      anydesk
      scripts
      yazi
      stylix
    ];
  };

  # Core user homeModules for `username: marked01one`
  flake.homeModules.marked01one = {...}: let
    username = "marked01one";
  in {
    # Username for the user of this home manager
    home.username = username;

    # The path to the home directory
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "26.05";
    home.enableNixpkgsReleaseCheck = false;
  };
}
