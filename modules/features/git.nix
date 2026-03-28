{...}: {
  flake.nixosModules.git = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git
    ];
  };

  flake.homeModules.git = {...}: {
    programs.git = {
      enable = true;
    };
  };
}
