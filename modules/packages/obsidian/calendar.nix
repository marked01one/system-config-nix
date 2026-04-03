{...}: {
  perSystem = {...}: {
    packages.obsidian-calendar = {pkgs, ...}: let
      pname = "obsidian-calendar-plugin";
      version = "1.5.10";
      owner = "liamcain";

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
        main = fetchAsset "main.js" "sha256-f7M56c+f2+WoAforirhbNmtbN3f70ZPLyHKLwncR0SU=";
        manifest = fetchAsset "manifest.json" "sha256-8+lYEzhkhRK6oS1bRYSQ9/02eRj3vba9hhcc5Xvn0Is=";

        # We don't need to unpack anything since we fetched raw files
        phases = ["installPhase"];

        installPhase = ''
          mkdir -p $out
          cp $main $out/main.js
          cp $manifest $out/manifest.json
        '';
      };
  };
}
