{...}: {
  perSystem = {pkgs, ...}: {
    packages.grub-night = let
      # 1. Fetch the background image
      backgroundImage = pkgs.fetchurl {
        url = "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=1920&auto=format&fit=crop";
        sha256 = "sha256-RbeC/7j6Y/Y2p3pU6p7Y7r8r9A0B1C2D3E4F5G6H7I8="; # Replace with actual hash
      };

      # 2. Define the inlined theme.txt
      themeTxt = pkgs.writeText "theme.txt" ''
        title-text: ""
        desktop-image: "background.png"
        terminal-font: "DejaVuSans-Bold 14"

        + boot_menu {
          left = 5%
          top = 5%
          width = 40%
          height = 60%
          item_font = "DejaVuSans 12"
          item_color = "#cccccc"
          selected_item_color = "#ffffff"
          item_spacing = 10
          icon_width = 32
          icon_height = 32
          item_icon_space = 15
        }
      '';
    in
      pkgs.stdenv.mkDerivation {
        name = "custom-grub-theme";

        # We pull in grub2 for the 'grub-mkfont' utility to convert fonts to .pf2
        nativeBuildInputs = [pkgs.grub2];

        phases = ["installPhase"];

        installPhase = ''
          mkdir -p $out

          # Copy the inlined config and background
          cp ${themeTxt} $out/theme.txt
          cp ${backgroundImage} $out/background.png

          # Convert a system font to the .pf2 format GRUB requires
          grub-mkfont -s 12 -o $out/DejaVuSans12.pf2 ${pkgs.dejavu_fonts}/share/fonts/truetype/DejaVuSans.ttf
          grub-mkfont -s 14 -o $out/DejaVuSans-Bold14.pf2 ${pkgs.dejavu_fonts}/share/fonts/truetype/DejaVuSans-Bold.ttf
        '';
      };
  };
}
