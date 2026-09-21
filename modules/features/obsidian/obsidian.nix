## ========================================================================== ##
##
## Note-taking app and text editor.
## Options: https://home-manager-options.extranix.com/?query=obsidian&release=master
##
## ========================================================================== ##
{self, ...}: {
  flake.nixosModules.obsidian = {...}: {
  };

  flake.homeModules.obsidian = {
    pkgs,
    lib,
    ...
  }: let
    local-pkgs = self.packages.${pkgs.stdenv.hostPlatform.system};

    ## ======== OBSIDIAN PLUGINS ============================================ ##

    plugins.dataview = {
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

    plugins.calendar = {
      pkg = local-pkgs.obsidian-calendar;
      enable = true;
      settings = {
        shouldConfirmBeforeCreate = true;
        weekStart = "locale";
        wordsPerDot = 250;
        showWeeklyNote = false;
      };
    };

    plugins.excalidraw = {
      pkg = local-pkgs.obsidian-excalidraw-plugin;
      enable = true;
      settings = {};
    };

    plugins.better-export-pdf = {
      pkg = local-pkgs.obsidian-better-export-pdf;
      enable = true;
      settings = {};
    };

    plugins.relative-line-numbers = {
      pkg = local-pkgs.obsidian-relative-line-numbers;
      enable = true;
      settings = {};
    };

    plugins.style-settings = {
      anuppuccin-dark = {
        pkg = local-pkgs.obsidian-style-settings;
        enable = true;
        settings = {
          "anuppuccin-theme-settings@@anp-active-line" = "anp-current-line";
          "anuppuccin-theme-settings@@anp-alt-rainbow-style" = "anp-full-rainbow-color-toggle";
          "anuppuccin-theme-settings@@anp-codeblock-numbers" = true;
          "anuppuccin-theme-settings@@anp-header-color-toggle" = true;
          "anuppuccin-theme-settings@@anuppuccin-accent-toggle" = true;
          "anuppuccin-theme-settings@@anuppuccin-light-theme-accents" = "ctp-accent-light-rosewater";
          "anuppuccin-theme-settings@@anuppuccin-theme-accents" = "ctp-accent-lavender";
          "anuppuccin-theme-settings@@anuppuccin-theme-dark" = "ctp-mocha-old";
          "anuppuccin-theme-settings@@anp-decoration-toggle" = true;
        };
      };
    };

    ## ======== OBSIDIAN THEMES ============================================= ##

    themes.tokyonight = {
      pkg = local-pkgs.obsidian-theme-tokyo-night;
      enable = true;
    };

    themes.anuppuccin = {
      pkg = local-pkgs.obsidian-theme-anuppuccin;
      enable = true;
    };

    ## ======== FUNCTIONS =================================================== ##

    # Embed files from a given directory into a new Obsidian vault.
    filesFrom = dir: let
      removeSuffix = f: let
        m = builtins.match "(.*)\\.[^.]+" f;
      in
        if m == null
        then f
        else builtins.head m;

      folder = baseNameOf dir;
      regular = lib.filterAttrs (_: t: t == "regular") (builtins.readDir dir);
    in
      lib.mapAttrs' (file: _:
        lib.nameValuePair
        "${folder}__${removeSuffix file}"
        {
          source = dir + "/${file}";
          target = "../${lib.toSentenceCase folder}/${file}";
        })
      regular;
    ## ======== CONFIGURATIONS ============================================== ##
  in {
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
        "word-count"
        {
          name = "templates";
          settings.folder = "Templates";
        }
      ];

      defaultSettings.cssSnippets = [
        ./css/center-image.css
        ./css/readable-pdf.css
      ];

      # Default Obsidian app settings
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

      # Appareance settings for Obsidian.
      defaultSettings.appearance = {
        interfaceFontFamily = "JetBrainsMono Nerd Font";
        textFontFamily = "JetBrainsMono Nerd Font";
        monospaceFontFamily = "JetBrainsMono Nerd Font";
        showViewHeader = true;
        baseFontSize = 12;
        nativeMenus = false;
      };

      # For self-written notes.
      vaults.notes = {
        enable = true;
        target = "/Documents/Obsidian/Notes";
        settings.extraFiles = filesFrom ./templates;
        settings = {
          communityPlugins = with plugins; [
            dataview
            calendar
            better-export-pdf
            relative-line-numbers
            style-settings.anuppuccin-dark
          ];

          themes = with themes; [
            anuppuccin
          ];
        };
      };
      # For all NixOS related documentation and online text based resources.
      vaults.nixos = {
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
}
