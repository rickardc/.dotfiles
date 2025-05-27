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
      "browser.startup.homepage" = "10.0.0.5:3000";
      "browser.newtabpage.enabled" = false;
      "browser.aboutConfig.showWarning" = false;
      "media.autoplay.default" = 1; # Block autoplay
    };

    # 2. Apply policies.json system-wide
    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
        Topsites = false;
      };
      Preferences = {
        "signon.rememberSignons" = {
          Value = false;
          Status = "locked";
        };
      };
      SearchEngines = {
        Default = "DuckDuckGo";
        Remove = ["Google" "Bing" "eBay"];

        PreventInstalls = true;

        Add = [
          {
            Name = "MyNixOS";
            URLTemplate = "https://mynixos.com/search?q=firefox{searchTerms}";
            Method = "GET";
            IconURL = "https://www.mynixos.com/favicon.ico";
            Alias = "@start";
          }
        ];
      };
    };
  };
}
