{...}: {
  flake.nixosModules.git = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
    ];
  };

  flake.homeModules.git = {...}: {
    programs.git = {
      enable = true;
    };
  };
}
