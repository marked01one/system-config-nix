{...}: {
  flake.nixosModules.nix-tools = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nix-search

      # Nix IDE experience
      nixd
      alejandra
    ];
  };
}
