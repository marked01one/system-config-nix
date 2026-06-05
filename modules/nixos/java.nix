{...}: {
  flake.nixosModules.java = {pkgs, ...}: {
    programs.java = {
      enable = true;
      package = pkgs.jdk25;
    };

    environment.systemPackages = with pkgs; [
      jdk21
    ];
  };
}
