{ ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;

      # transparency (paired with a Hyprland blur rule)
      background_opacity = "0.85";
      dynamic_background_opacity = true;

      # spacing / cursor
      window_padding_width = 12;
      cursor_shape = "beam";
      cursor_blink_interval = 0;

      # tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # Catppuccin Mocha
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      cursor = "#F5E0DC";
      cursor_text_color = "#1E1E2E";

      color0  = "#45475A";
      color8  = "#585B70";
      color1  = "#F38BA8";
      color9  = "#F38BA8";
      color2  = "#A6E3A1";
      color10 = "#A6E3A1";
      color3  = "#F9E2AF";
      color11 = "#F9E2AF";
      color4  = "#89B4FA";
      color12 = "#89B4FA";
      color5  = "#F5C2E7";
      color13 = "#F5C2E7";
      color6  = "#94E2D5";
      color14 = "#94E2D5";
      color7  = "#BAC2DE";
      color15 = "#A6ADC8";

      active_tab_foreground   = "#11111B";
      active_tab_background   = "#CBA6F7";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#181825";
    };
  };
}
