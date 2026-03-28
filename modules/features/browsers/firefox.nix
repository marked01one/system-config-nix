{self, ...}: {
  flake.nixosModules.firefox = {...}: {
    home-manager.users.marked01one.imports = [
      self.homeModules.firefox-marked01one
    ];
  };

  flake.homeModules.firefox-marked01one = {
    pkgs,
    config,
    ...
  }: {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;
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
              Do not install using the Zen Browser UI!
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
        name = "marked01one";
        isDefault = true;
        id = 0;

        # Firefox browser setting sin `about:config`
        settings = {
          browser.tabs.allow_transparent_browser = false;

          # AI blocking settings
          browser.ai.control.default = "blocked";
          browser.ai.control.linkPreviewKeyPoints = "blocked";
          browser.ai.control.pdfjsAltText = "blocked";
          browser.ai.control.sidebarChatbot = "blocked";
          browser.ai.control.smartTabGroups = "blocked";
          browser.ml.chat.enabled = false;
          browser.ml.chat.page = false;
          browser.ml.linkPreview.enabled = false;
          browser.tabs.groups.smart.enabled = false;
          browser.tabs.groups.smart.userEnabled = false;
          extensions.ml.enabled = false;
          pdfjs.enableAltText = false;
        };
      };
    };
  };
}
