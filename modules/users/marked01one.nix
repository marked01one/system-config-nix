{...}: {
  flake.nixosModules.username-marked01one = {...}: {
    users.users.marked01one = {
      isNormalUser = true;
      description = "marked01one";
      extraGroups = ["networkmanager" "wheel"];
    };
  };


  flake.homeModules.marked01one = {
    pkgs,
    config,
    ...
  }: let
    username = "marked01one";
  in {
    # Username for the user of this home manager
    home.username = username;

    # The path to the home directory
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "26.05";
    home.enableNixpkgsReleaseCheck = false;

    # Enable specific environment variables.
    home.sessionVariables = {
      EDITOR =
        if config.programs.neovim.enable
        then "nvim"
        else "";
      VISUAL =
        if config.programs.vscode.enable
        then "code --wait"
        else "";
    };

    # Enable Home Manager
    programs.home-manager.enable = true;

    # Enable unfree packages.
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
      "ventoy-1.1.10"
      "ventoy-1.1.07"
    ];

    imports = [
      # Home configuration files.
      ./../home/bat.nix
      ./../home/btop.nix
      ./../home/eww.nix
      ./../home/eza.nix
      ./../home/fastfetch.nix
      ./../home/firefox.nix
      ./../home/gnome.nix
      ./../home/gtk.nix
      ./../home/neovim.nix
      ./../home/niri.nix
      ./../home/obsidian.nix
      ./../home/pandoc.nix
      ./../home/prismlauncher.nix
      ./../home/qt.nix
      ./../home/quickshell.nix
      ./../home/qutebrowser.nix
      ./../home/rmpc.nix
      ./../home/starship.nix
      ./../home/stylix.nix
      ./../home/wezterm.nix
      ./../home/yazi.nix
      ./../home/yt-dlp.nix
      ./../home/zen-browser.nix
      ./../home/zoxide.nix
      ./../home/zsh.nix
    ];

    # Packages that does not have declarative configuration.
    home.packages = with pkgs;
      [
        # Regular packages
        ani-cli
        chromium
        drawio
        efibootmgr
        git
        git-lfs
        jq
        kew
        libreoffice
        ltspice
        presenterm
        reaper
        spotdl
        teams-for-linux
        tokei
        unityhub
        vscode
        youtube-music
        zoom-us
        ventoy
        vesktop
        rustdesk

        # Nix IDE Tools.
        alejandra
        nil
        nixd
        nix-search
        optinix
        unixtools.ifconfig
      ]
      # Custom packages.
      ++ (
        map (x: (pkgs.callPackage ./../packages/${x}/default.nix {})) [
          "bookokrat"
          "soundthread"
        ]
      );
  };
}
