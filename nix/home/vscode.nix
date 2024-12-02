{pkgs, ...}: {
  enable = true;
  enableUpdateCheck = false;

  userSettings = {
    # "telemetry.enableTelemetry" = false;
    "telemetry.telemetryLevel" = "off";
    "workbench.preferredDarkColorTheme" = "Tokyo Night"; # "Default Dark Modern";
    "workbench.colorTheme" = "Tokyo Night";
  };
}
