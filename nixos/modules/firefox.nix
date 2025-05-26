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
      "browser.startup.homepage" = "https://start.duckduckgo.com";
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
    };
  };
}
