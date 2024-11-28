{pkgs, ...}: {
  enable = true;
  package = pkgs.unstable.librewolf;

  settings = {
    "privacy.resistFingerprinting.letterboxing" = true;
    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown.downloads" = false;
    "identity.fxaccounts.enabled" = true;
  };
}
