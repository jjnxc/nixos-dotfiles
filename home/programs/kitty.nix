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
    };
  };
}
