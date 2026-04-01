{...}: {
  flake.nixosModules.fonts = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    fonts.fontconfig = {
      enable = true;
      # Enable emoji rendering on Firefox-based browsers.
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = ["Noto Serif Light"];
        sansSerif = ["Noto Sans Light"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Sans Mono CJK SC"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
