# GPU-accelerated cross-platform terminal emulator and multiplexer written by
# @wez and implemented in Rust
# https://wezterm.org/
{self, ...}: {
  flake.homeModules.wezterm = {pkgs, ...}: {
    imports = [
      self.homeModules.starship
    ];

    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.wezterm;
    };

    home.file = {
      ".config/wezterm" = {
        source = ./lua;
        recursive = true;
      };
    };

    home.sessionVariables.TERMINAL = "wezterm";
  };
}
