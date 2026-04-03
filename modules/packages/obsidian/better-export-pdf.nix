{...}: {
  perSystem = {pkgs, ...}: {
    packages.obsidian-better-export-pdf = let
      pname = "obsidian-better-export-pdf";
      version = "1.11.0";
      owner = "l1xnan";

      # Helper to fetch assets from the GitHub release
      fetchAsset = name: hash:
        pkgs.fetchurl {
          url = "https://github.com/${owner}/${pname}/releases/download/${version}/${name}";
          sha256 = hash;
        };
    in
      pkgs.stdenv.mkDerivation {
        inherit version pname;

        # Define the three files as separate inputs
        main = fetchAsset "main.js" "sha256-xfMMRUjHezoygaEzcbHvMBCpoA7XkAMAz7MvYBCMOrE=";
        manifest = fetchAsset "manifest.json" "sha256-oscicmMtRGrEaffUzma9cecLiiexWEFsWmmlOs2EUdg=";
        styles = fetchAsset "styles.css" "sha256-I9RHS0vlLlyb2ZJRhkLaQFPjBgHi4Jzg8PpEqQP54Q4=";

        # We don't need to unpack anything since we fetched raw files
        phases = ["installPhase"];

        installPhase = ''
          mkdir -p $out
          cp $main $out/main.js
          cp $manifest $out/manifest.json
          cp $styles $out/styles.css
        '';
      };
  };
}
