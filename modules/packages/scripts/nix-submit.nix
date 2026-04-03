{...}: {
  perSystem = {pkgs, ...}: {
    packages.nix-submit = pkgs.writeShellApplication {
      name = "nix-submit";
      runtimeInputs = with pkgs; [git neovim alejandra];
      text = ''
        # syntax: shell
        pushd "~/.nixos"
        echo "Flake directory: $(pwd)"
        git diff
        echo "Running 'nixos-rebuild switch' ..."
        popd
      '';
    };
  };
}
