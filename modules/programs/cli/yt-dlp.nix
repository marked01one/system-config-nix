{...}: {
  flake.homeModules.yt-dlp = {pkgs, ...}: {
    programs.yt-dlp = {
      enable = true;
      package = pkgs.yt-dlp;

      settings = {
        # Subtitle options.
        # https://github.com/yt-dlp/yt-dlp#subtitle-options
        sub-langs = "all";

        # Post-processing options.
        # https://github.com/yt-dlp/yt-dlp#post-processing-options
        embed-thumbnail = true;
        embed-subs = true;
      };
    };
  };
}
