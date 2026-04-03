{...}: {
  flake.homeModules.yazi = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home.file = {
      # Avoid out-of-store file installation errors by specifying only Lua files
      # to be symlinked out-of-store.
      ".config/yazi/init.lua".source = ./lua/init.lua;
      ".config/yazi/plugins" = {
        source = ./lua/plugins;
        recursive = true;
      };
    };

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      # Enable support for RAR extraction.
      package = pkgs.yazi.override {
        _7zz = pkgs._7zz-rar;
      };

      # Extra packages to make available to yazi.
      # These packages will be added to the yazi wrapper's PATH.
      extraPackages = with pkgs; [
        fd
        ffmpeg
        file
        fzf
        glow
        imagemagick
        jq
        ouch
        poppler
        resvg
        ripgrep
        ueberzugpp
        wl-clipboard
        zathura
        zoxide

        tdf
        mpv
        kew
      ];

      # Settings in yazi.toml
      settings = {
        # https://yazi-rs.github.io/docs/next/configuration/yazi#mgr
        mgr = {
          linemode = "size_and_mtime";
          mouse_events = ["click" "scroll" "touch" "move" "drag"];
          ratio = [1 4 3];
          scrolloff = 100;
          show_hidden = false;
          show_symlink = false;
          sort_by = "natural";
          sort_dir_first = true;
          sort_reverse = false;
          sort_sensitive = true;
          sort_translit = true;
          title_format = "{cwd}";
        };

        # https://yazi-rs.github.io/docs/next/configuration/yazi#preview
        preview = {
          wrap = "yes";
          tab_size = 2;
          max_width = 2560;
          max_height = 5120;
          image_filter = "triangle";
          image_quality = 70;
          uberzug_scale = 1.5;
        };

        # Specific rules used to open files.
        opener = {
          media = [
            {
              run = "mpv --hwdec=vaapi \"$@\"";
              orphan = true;
              for = "unix";
            }
          ];
          edit = [
            {
              run = "$EDITOR \"$@\"";
              block = true;
              for = "unix";
            }
          ];
          pdf = [
            {
              run = "tdf \"$@\"";
              block = true;
              desc = "PDF viewer";
              for = "unix";
            }
          ];
        };

        open.rules = let
          generate-rules = {
            opener,
            filters,
          }: let
            openers =
              builtins.genList (x: {use = opener;})
              (builtins.length filters);
            zip-fn = use: filter: (lib.mergeAttrs filter use);
          in
            lib.zipListsWith zip-fn openers filters;
        in
          # Contrary to the Yazi docs, we need to use `{name = "<glob>";}` instead
          # of `{url = "<glob>";}`.
          builtins.concatLists [
            (
              generate-rules {
                opener = "pdf";
                filters = [
                  {mime = "application/pdf";}
                  {name = "*.cbz";}
                  {name = "*.pdf";}
                ];
              }
            )
            (
              generate-rules {
                opener = "edit";
                filters = [
                  {mime = "text/*";}
                ];
              }
            )
            (
              generate-rules {
                opener = "media";
                filters = [
                  {mime = "video/*";}
                  {name = "*.mp4";}
                  {mime = "audio/*";}
                  {name = "*.mp3";}
                ];
              }
            )
          ];

        plugin = {
          prepend_previewers = [];
          append_previewers = [];
        };

        input = {
          cursor_blink = false;
        };
      };

      keymap = {
      };
    };

    # Launch yazi via wezterm instead.
    xdg.desktopEntries.yazi = {
      type = "Application";
      name = "Yazi";
      exec = "wezterm -e yazi";
      icon = ./assets/yazi.png;
      # Do not make visible on desktop if wezterm is not installed!
      # TODO: Handle this error more gracefully! (i.e. display popup,...)
      noDisplay = !config.programs.wezterm.enable;
    };
  };
}
