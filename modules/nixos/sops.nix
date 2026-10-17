{inputs, ...}: {
  flake.nixosModules.sops = {...}: let
    sops = inputs.spos-nix.nixosModules.sops;
  in {
  };
}
