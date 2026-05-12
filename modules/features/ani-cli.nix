{self, ...}: let
in {
  flake.nixosModules.ani-cli = {pkgs, ...}: let
    local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    environment.systemPackages = with local-pkgs; [ani-cli];
  };

  flake.homeModules.ani-cli = {pkgs, ...}: let
    local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    home.packages = with local-pkgs; [ani-cli];
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.ani-cli = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
      pname = "ani-cli";
      version = "4.14";

      src = pkgs.fetchurl {
        url = "https://github.com/pystardust/ani-cli/archive/refs/tags/v${finalAttrs.version}.tar.gz";
        sha256 = "sha256-vkDHeWBbm160wJ5jofRgvMadc6OrbnByeVSPuFE8lsA=";
      };

      nativeBuildInputs = [pkgs.makeWrapper];

      runtimeInputs = with pkgs; [
        gnugrep
        gnused
        curl
        fzf
        ffmpeg
        aria2
        mpv
        yt-dlp
        openssl
      ];

      installPhase = ''
        runHook preInstall

        install -Dm755 ani-cli $out/bin/ani-cli

        wrapProgram $out/bin/ani-cli \
          --prefix PATH : ${lib.makeBinPath finalAttrs.runtimeInputs}

        runHook postInstall
      '';
    });
  };
}
