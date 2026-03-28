{...}: {
  flake.nixosModules.vscode = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vscode

      # IDE things for vscode.
      alejandra
      nixd
    ];
  };
}
