{...}: {
  perSystem = {pkgs, ...}: {
    packages.obsidian-theme-anuppiccin = let
      pname = "AnuPpuccin";
      version = "v1.5.0";
      owner = "AnubisNekhet";
    in
      pkgs.stdenv.mkDerivation rec {
        inherit pname version;

        manifest = pkgs.fetchurl {
          url = "https://github.com/${owner}/${pname}/releases/download/${version}/manifest.json";
        };

        theme = pkgs.fetchurl {
          url = "https://github.com/${owner}/${pname}/releases/download/${version}/theme.css";
        };

        # No need to unpack since we fetched raw files
        phases = ["installPhase"];

        installPhase = ''
          # shell
          mkdir -p $out
          cp $manifest $out/manifest.json
          cp $theme $out/theme.css
        '';
      };
  };
}
