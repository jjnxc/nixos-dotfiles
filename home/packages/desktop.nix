{ pkgs, ... }:
with pkgs;
[
  # --- Wayland / capture / clipboard ---
  rofi
  awww
  grim
  slurp
  wl-clipboard
  dunst
  libnotify

  # --- Media ---
  ffmpeg
  playerctl
  brightnessctl

  # --- Virtualization (GUI) ---

  # --- Apps ---
  obsidian
  vscode
  gimp
  blender
  geeqie
  bambu-studio
  proton-vpn
  # prusa-slicer

  # --- Themes / icons (cosmetic) ---
  adwaita-icon-theme
  gnome-themes-extra

  # --- Password manager ---
  keepassxc

  # --- File manager / utilities (optional) ---
  # lf
  # imv
]
