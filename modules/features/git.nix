{...}: {
  flake.nixosModules.git = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
    ];
  };

  flake.homeModules.git = {...}: {
    programs.git.enable = true;
    programs.git.lfs.enable = true;
    programs.git.settings = {
      user.name = "marked01one";
      user.email = "mnihkhoitran2k3@gmail.com";
    };
  };
}
