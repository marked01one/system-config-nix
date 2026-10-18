{self, ...}: {
  flake.nixosModules.marked01one-admin = {...}: {
    users.users."marked01one.admin" = {
      enable = true;
      isNormalUser = true;
      description = "marked01one.admin";
      extraGroups = ["networkmanager" "wheel"];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpfYtWCQeQbYDAwvQtlpIGeX84DiRMIvmUoR+9MTTh marked01one@carbon"
      ];
    };

    # Home Manager module imports.
    home-manager.users."marked01one.admin".imports = with self.homeModules; [
      # Core user home module.
      marked01one-admin

      neovim
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
