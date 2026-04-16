{...}: {
  perSystem = {pkgs, ...}: {
    packages.obsidian-relative-line-numbers = let
      pname = "obsidian-relative-line-numbers";
      version = "3.1.0";
      owner = "nadavspi";

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
        main = fetchAsset "main.js" "sha256-JpufX+6TrczDl9MZmRgYrZThsC/tUT2pusVP9e7ln6U=";
        manifest = fetchAsset "manifest.json" "sha256-6ZhpsAukiZT17B+oYosLs/10+euPerkmz1pIEMvKHGs=";
        styles = fetchAsset "styles.css" "sha256-cFvcj1jC6GluwtmcQ2k42hVPQvVXkIquVLXM4PDjXAI=";

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
