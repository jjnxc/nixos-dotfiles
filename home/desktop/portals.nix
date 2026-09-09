{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "hyprland" "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast".default = [ "hyprland" ];
      "org.freedesktop.impl.portal.Screenshot".default = [ "hyprland" ];
      "org.freedesktop.impl.portal.GlobalShortcuts".default = [ "hyprland" ];
    };
  };
}
