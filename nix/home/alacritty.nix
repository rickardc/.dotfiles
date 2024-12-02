{pkgs, ...}: {
  enable = true;
  package = pkgs.unstable.alacritty;

  settings = {
    window = {
      padding = {
        x = 2;
        y = 4;
      };
      dimensions = {
        lines = 60;
        columns = 120;
      };
      decorations = "none";
      opacity = 1.0;
      startup_mode = "Windowed";
      title = "Alacritty";
      dynamic_title = true;
      decorations_theme_variant = "None";
    };

    general = {
      import = [
        pkgs.alacritty-theme.tokyo_night
      ];
      live_config_reload = true;
    };

    font = let
      jetbrainsMono = style: {
        family = "FiraCode Nerd Font";
        inherit style;
      };
    in {
      normal = jetbrainsMono "Regular";
      bold = jetbrainsMono "Bold";
      italic = jetbrainsMono "Italic";
      bold_italic = jetbrainsMono "Bold Italic";
      size = 14;
    };

    #mouse.hide_when_typing = true;

    cursor = {
      style = "Block";
      unfocused_hollow = true;
    };

    env = {
      TERM = "xterm-256color";
    };

    keyboard.bindings = [
      {
        key = "N";
        mods = "Control|Shift";
        action = "CreateNewWindow";
      }
      {
        key = "+";
        mods = "Control|Shift";
        action = "IncreaseFontSize";
      }
      {
        key = "_";
        mods = "Control|Shift";
        action = "DecreaseFontSize";
      }
      {
        key = "q";
        mods = "Control";
        action = "Quit";
      }
    ];
  };
}
