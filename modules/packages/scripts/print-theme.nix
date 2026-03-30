# Shell script to retrieve the base16 colorscheme for the current theme.
{...}: {
  perSystem = {pkgs, ...}: {
    packages.print-theme = pkgs.writeShellApplication {
      name = "print-theme";
      text = ''
        # syntax: shell

        BASE16=\$(printenv | grep -oE 'STYLIX_BASE_0[0-9A-F]{1}=#[0-9a-fA-F]{6}' | sort)

        function process_color() {
          # Extract the hex code values.
          local hex_code index
          hex_code=\$(echo "$1" | grep -oE '[0-9a-fA-F]{6}')
          index=\$(echo "$1" | grep -oE '_0[0-9A-F]{1}=')

          # Retrieve RGB values from extracted hex code.
          local R_hex="\$\{hex_code:0:2\}"
          local G_hex="\$\{hex_code:2:2\}"
          local B_hex="\$\{hex_code:4:2\}"

          # Convert hex components to decimal (RGB values)
          # The '16#' prefix tells the shell to interpret the string as base-16 (hex)
          local R_dec=\$((0x$R_hex))
          local G_dec=\$((0x$G_hex))
          local B_dec=\$((0x$B_hex))

          # ANSI escape code for True Color (24-bit):
          # \033[48;2;R;G;Bm - Sets the background color
          # \033[0m - Resets all attributes (color and background)
          local ANSI_COLOR_START="\033[48;2;\$\{R_dec\};\$\{G_dec\};\$\{B_dec\}m"
          local ANSI_COLOR_END="\033[0m"
          local COLOR_BLOCK="| \$\{index:1:2\} \$\{ANSI_COLOR_START\}    \$\{ANSI_COLOR_END\} |"

          # Output the color block and the original hex values.
          echo -e "$COLOR_BLOCK" "#$hex_code |"
        }

        # Print the color-hex table.
        echo ""
        echo "+---------+---------+"
        echo "|  COLOR  |   HEX   |"
        echo "+---------+---------+"

        while read -r color; do
          process_color "$color"
        done <<< "$BASE16"

        echo "+---------+---------+"
      '';
    };
  };
}
