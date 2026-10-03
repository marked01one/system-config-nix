{...}: {
  perSystem = {pkgs, ...}: {
    packages.obsidian-style-settings = let
      pname = "obsidian-style-settings";
      version = "1.0.9";
      owner = "community-archive";

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
        main = fetchAsset "main.js" "sha256-GCirqs2rTFV4twWmJcWFswUS+O+tTHz8WhjnDMNVdGg=";
        manifest = fetchAsset "manifest.json" "sha256-nP/cIM8qoTVIIOAFC2lLD5tXZEbj1dRKNq6LAYflv7g=";
        styles = fetchAsset "styles.css" "sha256-7nk30r5QZTqJzLMK5fBXKyNQfVt/EyjQBScaNjB1v9g=";

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
