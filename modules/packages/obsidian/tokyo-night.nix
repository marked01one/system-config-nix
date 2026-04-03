{...}: {
  perSystem = {pkgs, ...}: {
    packages.obsidian-theme.tokyo-night = let
      pname = "obsidian-tokyonight";
      version = "main";
      owner = "tcmmichaelb139";
    in
      pkgs.stdenv.mkDerivation rec {
        inherit pname version;

        src = pkgs.fetchurl {
          url = "https://github.com/${owner}/${pname}/archive/refs/heads/${version}.zip";
          sha256 = "sha256-lE+mqD8hdNUr8A7PmmCa8wBpQB5ZKXXPiZaZHKRQAVE=";
        };

        nativeBuildInputs = [pkgs.unzip];

        installPhase = ''
          unzip $src
          mkdir -p $out
          cp obsidian-tokyonight-main/manifest.json $out/manifest.json
          cp obsidian-tokyonight-main/theme.css $out/theme.css
        '';
      };
  };
}
