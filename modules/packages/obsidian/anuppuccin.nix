{...}: {
  perSystem = {pkgs, ...}: {
    packages.obsidian-theme-anuppuccin = let
      pname = "AnuPpuccin";
      version = "v1.5.0";
      owner = "AnubisNekhet";
    in
      pkgs.stdenv.mkDerivation rec {
        inherit pname version;

        manifest = pkgs.fetchurl {
          url = "https://github.com/${owner}/${pname}/releases/download/${version}/manifest.json";
          sha256 = "sha256-W8r5ZFIN6aqhKKZoc5UUmJE+bCVPFiaYza/LK7cypbo=";
        };

        theme = pkgs.fetchurl {
          url = "https://github.com/${owner}/${pname}/releases/download/${version}/theme.css";
          sha256 = "sha256-ToPbKCS6OOQjyXDRHITD5Etri6vzi6uYNkDTMNWLudw=";
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
