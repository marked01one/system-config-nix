{self, ...}: {
  flake.nixosModules.neovim = {pkgs, ...}: let
    defaultUser = "marked01one";
  in {
    environment.systemPackages = with pkgs; [
      neovim
    ];

    home-manager.users.${defaultUser}.imports = [
      self.homeModules.neovim
    ];
  };

  flake.homeModules.neovim = {...}: {
    programs.neovim = {
      withRuby = true;
      withPython3 = true;
      withNodeJs = true;

      # Symlink `vim` and `vi` to `nvim` binary.
      vimAlias = true;
      viAlias = true;
    };

    home.file.".config/nvim" = {
      source = ./lua;
      recursive = true;
    };

    # Do not display `Neovim wrapper` as a desktop application.
    xdg.desktopEntries.neovim = {
      name = "Neovim wrapper";
      noDisplay = true;
    };
  };
}
