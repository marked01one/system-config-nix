{inputs, ...}: {
  flake.nixosModules.sops = {...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops.defaultSopsFile = ./../secrets/example.yaml;
    sops.age.sshKeyPath = ["/etc/ssh/host_id_ed25519"];
    sops.age.generatedKey = true;
  };
}
