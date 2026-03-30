{self, ...}: {
  # Install and configure `zsh` as a NixOS package.
  flake.nixosModules.zsh = {
    pkgs,
    lib,
    config,
    ...
  }: let
    # Access the value of the user via this config.
    usernameConfig = config.local.username;
    defaultUser = "marked01one"; # Repo owner used as default username.

    # Graphical terminals compatible with Fastfetch image-based logos.
    terminals = ["WezTerm" "Alacritty" "kitty" "Ghostty"];

    # Generate the regex for the shell check
    term-regex = builtins.concatStringsSep "|" terminals;
  in {
    # Locally declared options for `zsh` NixOS module.
    options.local.username = lib.mkOption {
      default = defaultUser;
      type = lib.types.str;
      description = "The primary username for zsh and home-manager config.";
    };

    # The configuration of the `zsh` NixOS module.
    config = {
      # Must include these packages.
      environment.systemPackages = with pkgs; [bat starship];

      programs.zsh.enable = true;
      environment.pathsToLink = ["/share/zsh"];
      users.defaultUserShell = pkgs.zsh;

      # Shell script code called during zsh shell initialisation.
      programs.zsh.shellInit = ''
        # syntax: shell
        # Matches any terminal in the list via a single regex check
        if [[ "$TERM_PROGRAM" =~ ^(${term-regex})$ ]]; then
          ${pkgs.fastfetch}/bin/fastfetch
        fi
      '';

      # Importing `zsh` Home Manager configs.
      home-manager.users.${usernameConfig}.imports = [self.homeModules.zsh];
    };
  };

  # Configure `zsh` using Home Manager.
  flake.homeModules.zsh = {config, ...}: {
    imports = [
      self.homeModules.bat
      self.homeModules.starship
      self.homeModules.zoxide
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;

      # Auto-suggestion settings.
      autosuggestion = {
        enable = true;
        strategy = ["history" "completion"];
      };

      # Zsh shell aliases.
      shellAliases = {
        nurse = "sudo nixos-rebuild switch --flake .#$(hostname)";
        homes = "home-manager switch --flake .#$(whoami)@$(hostname)";
        cat =
          if config.programs.bat.enable
          then "bat"
          else "cat";
      };

      # Syntax highlighting settings.
      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "brackets" "pattern"];
        patterns = {
          "rm -rf *" = "fg=white,bold,bg=red";
        };
      };

      # Oh My Zsh plugins configuration.
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "zoxide"
          "starship"
        ];
      };

      # Zsh history.
      history = {
        size = 10000;
        path = "${config.home.homeDirectory}/.zsh_history";
        share = true;
      };
    };
  };
}
