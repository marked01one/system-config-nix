{...}: {
  perSystem = {pkgs, ...}: {
    # Node based GUI for The Composers Desktop Project.
    packages."x86_64-linux".soundthread = let
      dot2hyphen = x: builtins.replaceStrings ["."] ["-"] x;
      github-link = "https://github.com/j-p-higgins/SoundThread";
    in
      pkgs.stdenv.mkDerivation rec {
        pname = "soundthread";
        version = "0.4.0-beta";

        src = pkgs.fetchurl {
          url = "${github-link}/releases/download/v${version}/SoundThread_v${dot2hyphen version}_linux_x86_64.tar.gz";
          sha256 = "sha256-aJlpMVXElBMWuvVGsPe0BufeAWPjKoFcxOhlrMkbHwk=";
        };

        installPhase = ''
          tar -xvzf cdprogs_linux.tar.gz
          mkdir -p $out/bin
          cp SoundThread.x86_64 $out/bin
          mv $out/bin/SoundThread.x86_64 $out/bin/soundthread
        '';

        meta = with pkgs.lib; {
          description = "Node based GUI for The Composers Desktop Project.";
          homepage = github-link;
          license = licenses.mit;
          platforms = ["x86_64-linux"];
        };
      };
  };
}
