{...}: {
  flake.nixosModules.cargo = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gcc
      rust-analyzer
      rustup
    ];

    environment.sessionVariables = {
      LIBTORCH_LIB = "${pkgs.libtorch-bin}";
      LIBTORCH_INCLUDE = "${pkgs.libtorch-bin.dev}";
    };
  };

  flake.homeModules.cargo = {...}: {
  };
}
