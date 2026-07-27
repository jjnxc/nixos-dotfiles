{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.ly.enable = true;

  programs.hyprland.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
