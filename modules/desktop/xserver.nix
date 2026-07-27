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
}
