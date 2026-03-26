{inputs, ...}: {
  flake.homeModules.zen-browser =
    # Nix Flake for the Zen Browser.
    # Homepage: https://github.com/0xc000022070/zen-browser-flake
    {
      config,
      pkgs,
      cwd,
      ...
    }: {
      imports = [inputs.zen-browser.homeModules.beta];

      programs.zen-browser = {
        enable = true;

        nativeMessagingHosts = [pkgs.firefoxpwa];

        # Full list of policies: https://mozilla.github.io/policy-templates/
        policies = {
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;

          BlockAboutConfig = false;
          DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";

          DisableTelemetry = true;

          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };

          # Extensions
          ExtensionSettings = let
            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
          in {
            # Block downloads of all undeclared extensions by default.
            "*" = {
              blocked_install_message = ''
                All Firefox extensions are blocked from download via the Firefox UI.
                To add extensions, open and edit: `${cwd}/homes/firefox.nix`
              '';
              installation_mode = "blocked";
              "allowed_types" = ["extension"];
            };

            # UBlock Origin.
            "uBlock0@raymondhill.net" = {
              default_area = "menupanel";
              install_url = moz "ublock-origin";
              installation_mode = "force_installed";
              private_browsing = true;
              updates_disabled = true;
            };

            # AO3 Enhancements.
            "ao3-enhancements@jsmnbom" = {
              default_area = "menupanel";
              install_url = moz "ao3-enhancements";
              installation_mode = "normal_installed";
              private_browsing = true;
              updates_disabled = false;
            };

            # Return YouTube Dislikes.
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
              default_area = "menupanel";
              install_url = moz "return-youtube-dislikes";
              installation_mode = "normal_installed";
              private_browsing = true;
              updates_disabled = false;
            };
          };
        };

        profiles.marked01one = {
          settings = {
            "zen.tabs.vertical" = true;
            "zen.tabs.vertical.right-side" = true;
            "zen.widget.linux.transparency" = true;
            "browser.tabs.allow_transparent_browser" = false;

            # AI blocking settings
            "browser.ai.control.default" = "blocked";
            "browser.ai.control.linkPreviewKeyPoints" = "blocked";
            "browser.ai.control.pdfjsAltText" = "blocked";
            "browser.ai.control.sidebarChatbot" = "blocked";
            "browser.ai.control.smartTabGroups" = "blocked";
            "browser.ml.chat.enabled" = false;
            "browser.ml.chat.page" = false;
            "browser.ml.linkPreview.enabled" = false;
            "browser.tabs.groups.smart.enabled" = false;
            "browser.tabs.groups.smart.userEnabled" = false;
            "extensions.ml.enabled" = false;
            "pdfjs.enableAltText" = false;
          };
        };
      };
    };
}
