{...}: {
  flake.homeModules.neovim = {...}: {
    programs.neovim = {
      enable = true;

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
