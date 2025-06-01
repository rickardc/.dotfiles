{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;

    # 1. Set user preferences (user.js)
    preferences = {
      "privacy.resistFingerprinting" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.startup.homepage" = "http://10.0.0.5:3000";
      "browser.newtabpage.enabled" = false;
      "browser.aboutConfig.showWarning" = false;
      "media.autoplay.default" = 1; # Block autoplay
    };

    # 2. Apply policies.json system-wide  https://mozilla.github.io/policy-templates/
    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
        Topsites = false;
      };
      Bookmarks = [
        {
          Title = "Nix-pills";
          URL = "https://nixos.org/nixos/nix-pills/";
          Placement = "toolbar"; # or "menu"
          Folder = "Nix Resources"; # optional group
        }
      ];

      Preferences = {
        "signon.rememberSignons" = {
          Value = false;
          Status = "locked"; # Prevents user from re-enabling it
        };
        "signon.autofillForms" = {
          Value = false;
          Status = "locked";
        };
        "signon.autologin.proxy" = {
          Value = false;
          Status = "locked";
        };
        "signon.formlessCapture.enabled" = {
          Value = false;
          Status = "locked";
        };
        "signon.generation.enabled" = {
          Value = false;
          Status = "locked";
        };
        "signon.management.page.enabled" = {
          Value = false;
          Status = "locked";
        };
      };
      SearchEngines = {
        Default = "DuckDuckGo";
        PreventInstalls = true;
        Remove = ["Google" "Bing" "eBay"];
        Add = [
          {
            Name = "DuckDuckGo";
            URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
            Method = "GET";
            IconURL = "https://duckduckgo.com/favicon.ico";
          }
          {
            Name = "MyNixOS";
            URLTemplate = "https://mynixos.com/search?q=firefox{searchTerms}";
            Method = "GET";
            IconURL = "https://www.mynixos.com/favicon.ico";
            Alias = "@start";
          }
        ];
      };

      Extensions = {
        Install = [
          # 1Password
          "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi"

          # Vimium
          "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi"

          # HTML Validator
          "https://addons.mozilla.org/firefox/downloads/latest/html-validator/latest.xpi"
        ];
      };

      NativeMessaging = {
        Allow = ["firefox@1password.com"];
        Block = [];
      };
    };
  };
}
