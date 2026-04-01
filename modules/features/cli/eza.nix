{...}: {
  flake.nixosModules.eza = {pkgs, ...}: {
    # NOTE: we only import the package, since we want to delegate as much of the
    # configuration to Home Manager as possible.
    environment.systemPackages = with pkgs; [
      eza
    ];
  };

  flake.homeModules.eza = {...}: {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };
  };
}
