# GPU-accelerated cross-platform terminal emulator and multiplexer written by
# @wez and implemented in Rust
# https://wezterm.org/
{...}: {
  flake.nixosModules.wezterm = {pkgs, ...}: {
    # NOTE: we only import the package, since we want to delegate as much of the
    # configuration to Home Manager as possible.
    environment.systemPackages = with pkgs; [
      wezterm
    ];
  };

  flake.homeModules.wezterm = {pkgs, ...}: {
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.wezterm;
    };

    home.file.".config/wezterm" = {
      source = ./lua;
      recursive = true;
    };

    home.sessionVariables.TERMINAL = "wezterm";
  };
}
