# A scrollable-tiling Wayland compositor.
# https://niri-wm.github.io/niri/
#
# This specific module uses Nix flake for Niri which can be found here:
# https://github.com/sodiboo/niri-flake
#
# Configuration docs for both can be found here:
# + https://niri-wm.github.io/niri/Configuration%3A-Introduction.html
# + https://github.com/sodiboo/niri-flake/blob/main/docs.md
#
{
  self,
  inputs,
  ...
}: let
  # Create Niri keybinds by generating all possible prefix-suffix combinations
  # based on inputted suffixes and prefixes.
  # CODE: https://github.com/sodiboo/system/blob/main/personal/niri.mod.nix#L31
  niri-binds = {
    suffixes,
    prefixes,
    substitutions ? {},
  }: let
    # Define replacer function to replace strings defined in `substitutions`.
    replacer =
      builtins.replaceStrings
      # Substrings to replace.
      (builtins.attrNames substitutions)
      # Substrings for the replacer to replace to.
      (builtins.attrValues substitutions);

    # Format the prefixes and suffixes to generate pairings.
    format = prefix: suffix: let
      actual-suffix =
        if builtins.isList suffix.action
        then {
          action = builtins.head suffix.action;
          args = builtins.tail suffix.action;
        }
        else {
          inherit (suffix) action;
          args = [];
        };

      action = replacer "${prefix.action}-${actual-suffix.action}";
    in {
      name = "${prefix.key}+${suffix.key}";
      value.action.${action} = actual-suffix.args;
    };

    # Pair the generated attribute key with their respective actions as value.
    pairs = attrs: fn:
      builtins.concatMap (key:
        fn {
          inherit key; # `key = key;`
          action = attrs.${key};
        })
      (builtins.attrNames attrs);
  in
    builtins.listToAttrs (
      pairs
      prefixes
      (prefix: pairs suffixes (suffix: [(format prefix suffix)]))
    );
in {
  # Core NixOS Module for Niri.
  flake.nixosModules.niri = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.niri.nixosModules.niri
      {
        options.programs.niri.settings = lib.mkOption {
          type = inputs.niri.lib.settings.make-type {
            inherit lib pkgs;
            modules = [{_module.filename = "base-config.kdl";}];
          };
          default = {};
        };
      }
    ];

    # Declaring addition packages to compliment niri.
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      gamescope
      fuzzel
      xwayland-satellite # Xwayland outside your Wayland compositor.

      brightnessctl # Read and control device brightness.
    ];

    # Enable Niri.
    programs.niri.enable = true;

    # Use the unstable branch of Niri.
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri.package = pkgs.niri-unstable;

    # Importing config files.
    home-manager.users.marked01one.imports = [
      self.homeModules.niri
      self.homeModules."niri-${config.networking.hostName}"
    ];
  };

  # Core Home Manager module for Niri
  flake.homeModules.niri = {
    config,
    lib,
    ...
  }: {
    # Universal Niri settings for all hardware.
    # Check below for machine-specific configurations.
    programs.niri.settings = let
      colors = config.lib.stylix.colors.withHashtag;
      spawn = config.lib.niri.actions.spawn;
      show-hotkey-overlay = config.lib.niri.actions.show-hotkey-overlay;
      sh = spawn "sh" "-c";
    in {
      # Niri window layouts.
      layout = {
        gaps = 8;
        center-focused-column = "never";
        always-center-single-column = true;

        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
        ];

        default-column-display = "tabbed";
        # Hide the tab indicator when there's only one window in a column.
        tab-indicator.hide-when-single-tab = true;

        # Default width of new windows, proportional to window size.
        default-column-width.proportion = 1.0;

        focus-ring = {
          width = 2;

          active.color = colors.base07;
          inactive.color = colors.base00;
        };

        shadow = {
          softness = 30;
          spread = 5;
        };
      };

      # Window layout settings for Niri.
      window-rules = [
        # Global window rules.
        {
          draw-border-with-background = false;
          clip-to-geometry = true;
          geometry-corner-radius = let
            # Border radius.
            r = 8.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
          default-column-width.fixed = 480;
          default-window-height.fixed = 270;
        }
        {
          matches = [
            {
              app-id = "^firefox$";
              title = "^Private Browsing$";
            }
          ];
          border.active.color = colors.base08;
        }
      ];

      # Keybinds for Niri.
      binds = lib.attrsets.mergeAttrsList [
        # Regular keybinds, no need to generate binds for them.
        {
          "Mod+T".action = spawn "wezterm";
          "Mod+O".action = show-hotkey-overlay;

          # Audio keybinds.
          "XF86AudioRaiseVolume" = {
            action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
            allow-when-locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            allow-when-locked = true;
          };
          "XF86AudioMute" = {
            action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            allow-when-locked = true;
          };
          "XF86AudioMicMute" = {
            action = sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            allow-when-locked = false;
          };

          # Monitor brightness keybinds.
          "XF86MonBrightnessUp".action = sh "brightnessctl set 10%+";
          "XF86MonBrightnessDown".action = sh "brightnessctl set 10%-";
        }
        (
          niri-binds {
            # List of prefixes.
            prefixes."Mod" = "focus-column";
            prefixes."Mod+Ctrl" = "move-column-to";

            # List of suffixes.
            suffixes."Home" = "first";
            suffixes."End" = "last";
          }
        )
        (
          # Generate keybinds for navigation between windows and workspaces
          # iteratively.
          niri-binds {
            # List of prefixes.
            prefixes."Mod" = "focus";
            prefixes."Mod+Ctrl" = "move";
            prefixes."Mod+Shift" = "focus-monitor";
            prefixes."Mod+Shift+Ctrl" = "move-window-to-monitor";

            # List of suffixes.
            suffixes."Left" = "column-left";
            suffixes."Down" = "window-down";
            suffixes."Up" = "window-up";
            suffixes."Right" = "column-right";
            suffixes."H" = "column-left";
            suffixes."J" = "window-down";
            suffixes."K" = "window-up";
            suffixes."L" = "column-right";

            # List of substitutions.
            substitutions."monitor-column" = "monitor";
            substitutions."monitor-window" = "monitor";
          }
        )
        (
          # Generate keybinds for `Mod` and `Mod+Ctrl` for all numbered
          # workspaces (from 1 to 9).
          niri-binds {
            # List of prefixes.
            prefixes."Mod" = "focus";
            prefixes."Mod+Ctrl" = "move-window-to";

            # List of suffixes.
            suffixes = builtins.listToAttrs (
              map (n: {
                name = toString n;
                # workspace 1 is empty; workspace 2 is the logical first.
                value = ["workspace" (n + 1)];
              }) (lib.range 1 9)
            );
          }
        )
      ];

      # Miscellaneous settings for Niri.
      prefer-no-csd = true;
    };
  };

  # Machine-specific Niri configurations for `carbon`.
  flake.homeModules.niri-carbon = {...}: {
    programs.niri.settings = {
      # Machine-specific input configs.
      input = {
        keyboard.xkb.layout = "us";

        touchpad = {
          tap = true; # Enable tap-to-click.
          dwt = true; # Disable trackpad when typing.
          tap-button-map = "left-right-middle";
          click-method = "clickfinger";
          natural-scroll = false; # Disable natural scrolling.
        };

        mouse.natural-scroll = false;

        tablet.map-to-output = "eDP-1";
        touch.map-to-output = "eDP-1";
      };

      # Machine-specific display output configs.
      outputs = {
        "eDP-1" = {
          mode = {
            width = 2880;
            height = 1800;
            refresh = 120.0;
          };
          scale = 1.5;
          transform.rotation = 0;
        };
      };
    };
  };

  # Machine-specific Niri configurations for `nitrogen`.
  flake.homeModules.niri-nitrogen = {...}: {
    programs.niri.settings = {
      # Machine-specific input configs.
      input = {
        keyboard.xkb.layout = "us";

        touchpad = {
          tap = true; # Enable tap-to-click.
          dwt = true; # Disable trackpad when typing.
          tap-button-map = "left-right-middle";
          click-method = "clickfinger";
          natural-scroll = false; # Disable natural scrolling.
        };

        mouse.natural-scroll = false;

        tablet.map-to-output = "eDP-1";
        touch.map-to-output = "eDP-1";
      };

      # Machine-specific display output configs.
      outputs = {
        "eDP-1" = {
          mode = {
            width = 2560;
            height = 1600;
            refresh = 240.0;
          };
          scale = 1.5;
          transform.rotation = 0;
        };
      };
    };
  };
}
