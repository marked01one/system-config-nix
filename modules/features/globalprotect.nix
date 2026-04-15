{inputs, ...}: {
  flake.nixosModules.globalprotect = {pkgs, ...}: {
    environment.systemPackages =
      (with inputs.globalprotect-openconnect; [
        packages.${pkgs.stdenv.hostPlatform.system}.default
      ])
      ++ (with pkgs; [
        openconnect
      ]);
  };

  flake.homeModules.globalprotect = {...}: {
  };
}
