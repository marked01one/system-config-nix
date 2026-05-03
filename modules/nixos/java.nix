{...}: {
  flake.nixosModules.java = {pkgs, ...}: {
    programs.java = {
      enable = true;
      package = pkgs.jdk21;
    };
  };
}
