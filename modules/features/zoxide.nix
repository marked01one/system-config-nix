# Fast cd command that learns your habits
# https://github.com/ajeetdsouza/zoxide
{...}: {
  # Install and configure `zoxide` using Home Manager.
  flake.homeModules.zoxide = {pkgs, ...}: {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.zoxide;
      options = [
        "--cmd cd" # Replace `cd` with zoxide commands.
        "--hook pwd" # Change a directory's score whenever the `pwd` changes.
      ];
    };
  };
}
