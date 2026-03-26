# Terminal EPUB Book Reader
# NOTE: We opted to build from source instead of using the existing binary or
# download the crate from cargo, since we would like to be able to make changes
# on where config files are sourced from in the code.
{...}: {
  perSystem = {pkgs, ...}: let
    owner = "bugzmanov";
    pname = "bookokrat";
    version = "0.2.2";
  in {
    packages.bookokrat = pkgs.rustPlatform.buildRustPackage rec {
      # Docs for Rust usage in NixOS: https://nixos.org/manual/nixpkgs/stable#rust
      inherit pname version;

      src = pkgs.fetchFromGitHub {
        owner = "${owner}";
        repo = "${pname}";
        rev = "v${version}";
        sha256 = "sha256-V+QiqjJ9eSMRH05KWMifEV4i2bbuj81fXXCY4WdGoBY=";
      };

      # We opted to link an pre-generated Cargo.lock instead of using `cargoHash`
      # since the original repository does not contain a Cargo.lock
      cargoLock.lockFile = ./Cargo.lock;
      postPatch = ''
        ln -s ${./Cargo.lock} Cargo.lock
      '';

      buildInputs = with pkgs; [
        glib
        openssl
        sqlite
      ];

      nativeBuildInputs = [pkgs.pkg-config];

      # Disable automated tests when building.
      doCheck = false;

      meta = with pkgs.lib; {
        description = "Terminal EPUB Book Reader";
        homepage = "https://github.com/${owner}/${pname}";
        maintainers = [
          "marked01one"
        ];
        license = licenses.mit;
        platforms = ["x86_64-linux"];
      };
    };
  };
}
