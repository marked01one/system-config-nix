{...}: {
  flake.nixosModules.python = {pkgs, ...}: {
    # Using nix-ld to run Python scripts.
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd
      ];
    };

    environment.localBinInPath = true;
    # https://github.com/nix-community/nix-ld?tab=readme-ov-file#my-pythonnodejsrubyinterpreter-libraries-do-not-find-the-libraries-configured-by-nix-ld
    environment.systemPackages = with pkgs; [
      (pkgs.writeShellScriptBin "python" ''
        export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
        exec ${pkgs.python3}/bin/python "$@"
      '')
      uv # Using `uv` to generate Python virtual environments.
      python313Packages.jupyterlab
    ];
  };

  flake.homeModules.python = {...}: {
  };
}
