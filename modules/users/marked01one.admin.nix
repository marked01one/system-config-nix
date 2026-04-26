{self, ...}: {
  flake.nixosModules.marked01one-admin = {...}: {
    users.users."marked01one.admin" = {
      enable = true;
      isNormalUser = true;
      description = "marked01one.admin";
      extraGroups = ["networkmanager" "wheel"];
    };

    # Home Manager module imports.
    home-manager.users."marked01one.admin".imports = with self.homeModules; [
      # Core user home module.
      marked01one-admin

      neovim
      stylix
      zsh
    ];
  };

  flake.homeModules.marked01one-admin = {...}: let
    username = "marked01one.admin";
  in {
    # Username for the user of this home manager.
    home.username = username;

    # The path to the home directory.
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "26.05";
    home.enableNixpkgsReleaseCheck = false;
  };
}
