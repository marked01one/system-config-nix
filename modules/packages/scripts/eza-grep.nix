{...}: {
  perSystem = {pkgs, ...}: {
    packages.eza-grep = let
      usageText = ''

        Usage: eza-grep [DIRECTORY] [SEARCH]

        List a directory, filtered by the search query
      '';
    in
      pkgs.writeShellApplication {
        name = "eza-grep";
        runtimeInputs = with pkgs; [eza];
        text = ''
          # syntax: shell
          function usage {
            echo "${usageText}"
            exit 1
          }

          if [[ "$#" -lt 2 ]]; then
            echo "Not enough arguments! Must be exactly two (2)"
            usage
          elif [[ "$#" -gt 2 ]]; then
            echo "Too many arguments! Must be exactly two (2)"
            usage
          fi

          eza --icons=always --color=always "$1" | grep "$2"
        '';
      };
  };
}
