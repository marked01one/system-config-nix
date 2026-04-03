# Note-taking app and text editor.
# Options: https://home-manager-options.extranix.com/?query=obsidian&release=master
{self, ...}: {
  flake.nixosModules.obsidian = {...}: {
  };

  flake.homeModules.obsidian = {pkgs, ...}: let
    local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};

    # Obsidian community plugins declarations.
    plugins = {
      dataview = {
        pkg = local-pkgs.obsidian-dataview;
        enable = true;
        settings = {
          enableDataviewJs = true;
          enableInlineDataviewJs = true;
          warnOnEmptyResult = true;
          defaultDateFormat = "dd/MM/yyyy";
          defaultDateTimeFormat = "HH:mm - dd/MM/yyyy";
        };
      };

      calendar = {
        pkg = local-pkgs.obsidian-calendar;
        enable = true;
        settings = {
          shouldConfirmBeforeCreate = true;
          weekStart = "locale";
          wordsPerDot = 250;
          showWeeklyNote = false;
        };
      };

      excalidraw = {
        pkg = local-pkgs.obsidian-excalidraw-plugin;
        enable = true;
        settings = {};
      };

      better-export-pdf = {
        pkg = local-pkgs.obsidian-better-export-pdf;
        enable = true;
        settings = {};
      };
    };

    # Obsidian themes declarations.
    themes = {
      tokyonight = {
        pkg = local-pkgs.obsidian-theme.tokyo-night;
        enable = true;
      };
    };
  in {
    # Obsidian is classified as an `unfree` package.
    nixpkgs.config.allowUnfree = true;
    # General settings for Obsidian.
    programs.obsidian.enable = true;
    programs.obsidian.package = pkgs.obsidian;

    programs.obsidian = {
      defaultSettings.corePlugins = [
        "backlink"
        "bookmarks"
        "canvas"
        "command-palette"
        "daily-notes"
        "editor-status"
        "file-explorer"
        "file-recovery"
        "global-search"
        "graph"
        "note-composer"
        "outgoing-link"
        "outline"
        "page-preview"
        "switcher"
        "tag-pane"
        "templates"
        "word-count"
      ];

      defaultSettings.cssSnippets = [
        ./css/center-image.css
        ./css/readable-pdf.css
      ];

      defaultSettings.app = {
        showInlineTitle = false;
        vimMode = true;
        strictLineBreaks = true;
        showLineNumber = true;
        readableLineLength = true;
        alwaysUpdateLinks = true;
        pdfExportSettings = {
          pageSize = "letter";
          landscape = false;
          margin = "0";
          downscalePercent = 75;
        };
        tabSize = 2;
      };

      defaultSettings.appearance = {
        interfaceFontFamily = "JetBrainsMono Nerd Font";
        textFontFamily = "JetBrainsMono Nerd Font";
        monospaceFontFamily = "JetBrainsMono Nerd Font";
        showViewHeader = true;
        baseFontSize = 12;
        nativeMenus = false;
      };

      vaults = {
        Notes = {
          enable = true;
          target = "/Documents/Obsidian/Notes";
          settings = {
            communityPlugins = with plugins; [
              dataview
              calendar
              better-export-pdf
            ];

            themes = with themes; [
              tokyonight
            ];
          };
        };
        NixOS = {
          enable = true;
          target = "/Documents/Obsidian/NixOS";
          settings = {
            communityPlugins = with plugins; [
              dataview
            ];
          };
        };
      };
    };
  };
}
