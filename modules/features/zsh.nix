{...}: {
  # Install and configure `zsh` as a NixOS package.
  flake.nixosModules.zsh = {pkgs, ...}: let
    # logo = ./../../../assets/fastfetch/luminousslime-002.jpg;
    graphical-terminals = [
      "WezTerm"
      "Alacritty"
      "kitty"
      "Ghostty"
    ];
    # Generate the regex for the shell check
    term-regex = builtins.concatStringsSep "|" graphical-terminals;
  in {
    programs.zsh.enable = true;
    environment.pathsToLink = ["/share/zsh"];
    users.defaultUserShell = pkgs.zsh;

    # Shell script code called during zsh shell initialisation.
    programs.zsh.shellInit = ''
      # syntax: shell
      # Matches any terminal in the list via a single regex check
      if [[ "$TERM_PROGRAM" =~ ^(${term-regex})$ ]]; then
        ${pkgs.fastfetch}/bin/fastfetch
      else
        ${pkgs.fastfetch}/bin/fastfetch
      fi
    '';
  };

  # Configure `zsh` using Home Manager.
  flake.homeModules.zsh = {config, ...}: {
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
