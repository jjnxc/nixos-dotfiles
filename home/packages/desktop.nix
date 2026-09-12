{ pkgs, ... }:
with pkgs;
[
  # --- Wayland / capture / clipboard ---
  rofi
  awww
  grim
  slurp
  wl-clipboard
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
  godot
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
