{self, ...}: {
  flake.nixosModules.git = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
    ];

    home-manager.users.marked01one.imports = [
      self.homeModules.git
    ];
  };

  flake.homeModules.git = {...}: {
    programs.git.enable = true;
    programs.git.lfs.enable = true;

    # Syntax highlighter for git diffs.
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {};
    };

    # Git config in ~/.config/git/config
    programs.git.settings = {
      user.name = "marked01one";
      user.email = "mnihkhoitran2k3@gmail.com";
      init.defaultBranch = "main";
    };
  };
}
