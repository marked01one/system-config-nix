{...}: {
  flake.homeModules.fastfetch = {pkgs, ...}: let
    # For a full list of modules, run: `fastfetch --list-modules`
    modules = [
      "break"
      {
        type = "title";
        key = "name    ";
        format = "{user-name-colored}@{host-name-colored}";
      }
      {
        type = "os";
        key = "os      ";
        format = "{id} {version-id}";
      }
      {
        type = "kernel";
        key = "kernel  ";
        format = "{release} ({arch})";
      }
      {
        type = "display";
        key = "display ";
        format = "{width}x{height} @ {refresh-rate} Hz";
      }
      {
        type = "cpu";
        key = "cpu     ";
        format = "{name} ({cores-logical})";
      }
      {
        type = "memory";
        key = "memory  ";
        format = "{used} / {total}";
      }
      {
        type = "battery";
        key = "battery ";
        format = "{capacity-bar} [{capacity}]";
      }
      "break"
      {
        type = "colors";
        symbol = "circle";
        paddingLeft = 2;
      }
    ];
  in {
    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;

      # See https://github.com/fastfetch-cli/fastfetch/wiki/Configuration
      settings = {
        logo = {
          width = builtins.floor ((builtins.length modules) * 2.4);
          height = builtins.length modules;
          padding = {
            top = 1;
            left = 1;
            right = 1;
          };
        };

        display = {
          separator = "┃";
          color = {
            keys = "blue";
            title = "red";
          };
          key = {
            width = 16;
            type = "both-2";
            paddingLeft = 1;
          };

          # Set how size values should be displayed.
          size = {
            binaryPrefix = "jedec";
            ndigits = 1;
          };

          bar = {
            width = 20;
            char = {
              elapsed = "■";
              total = "-";
            };
          };

          percent.type = 3;
        };

        inherit modules; # Equals to `modules = modules;`.
      };
    };
  };
}
