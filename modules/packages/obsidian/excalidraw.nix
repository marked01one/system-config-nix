{...}: {
  perSystem = {...}: {
    packages.obsidian-excalidraw-plugin = {pkgs, ...}: let
      pname = "obsidian-excalidraw-plugin";
      version = "2.20.3";
      owner = "zsviczian";

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
        main = fetchAsset "main.js" "sha256-eU6ert5zkgu41UsO2k9d4hgtaYzGOHdFAPJPFLzU2gs=";
        manifest = fetchAsset "manifest.json" "sha256-kjXbRxEtqBuFWRx57LmuJXTl5yIHBW6XZHL5BhYoYYU=";
        styles = fetchAsset "styles.css" "sha256-MwbdkDLgD5ibpyM6N/0lW8TT9DQM7mYXYulS8/aqHek=";

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
