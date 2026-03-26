{...}: {
  perSystem = {pkgs, ...}: {
    # Shell script to copy text from a file input into the clipboard.
    packages.fcp = pkgs.writeShellApplication {
      name = "fcp";
      runtimeInputs = with pkgs; [xclip];
      text = ''
        # syntax: shell
        cat "$1" | xclip -selection clipboard
      '';
    };
  };
}
