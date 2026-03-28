{self, ...}: {
  flake.nixosModules.firefox = {...}: {
    home-manager.users.marked01one.imports = [
      self.homeModules.firefox
    ];
  };

  flake.homeModules.firefox = {
    pkgs,
    config,
    ...
  }: {
    xdg.desktopEntries.firefox = {
      name = "Firefox Developer Edition";
      exec = "firefox-devedition";
      icon = "firefox-devedition";
      type = "Application";
    };

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

      profiles.dev-edition-default = {
        isDefault = true;
        id = 0;
        # Firefox browser settings in `about:config`
        settings = {
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

          # Vertical tabs
          "sidebar.verticalTabs" = true;
          "sidebar.position_start" = false; # Move vertical tabs right
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
          "sidebar.visibility" = "expand-on-hover";

          # Toolbar customizations
          "browser.uiCustomization.state" = ''
            // syntax: json
            {
              "placements":{
                "widget-overflow-fixed-list": [],
                "unified-extensions-area": [
                  "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action",
                  "ublock0_raymondhill_net-browser-action"
                ],
                "nav-bar": [
                  "back-button",
                  "forward-button",
                  "stop-reload-button",
                  "customizableui-special-spring1",
                  "vertical-spacer",
                  "urlbar-container",
                  "customizableui-special-spring2",
                  "downloads-button",
                  "unified-extensions-button",
                  "sidebar-button"
                ],
                "toolbar-menubar": ["menubar-items"],
                "TabsToolbar":[],
                "vertical-tabs":["tabbrowser-tabs"],
                "PersonalToolbar":["import-button","personal-bookmarks"]
              },
              "seen":[
                "developer-button",
                "profiler-button",
                "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action",
                "ublock0_raymondhill_net-browser-action",
                "screenshot-button"
              ],
              "dirtyAreaCache":[
                "nav-bar",
                "vertical-tabs",
                "unified-extensions-area",
                "PersonalToolbar",
                "toolbar-menubar",
                "TabsToolbar"
              ],
              "currentVersion": 23,
              "newElementCount":3
            }
          '';
        };
      };
    };
  };
}
