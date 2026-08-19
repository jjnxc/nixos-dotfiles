{ pkgs, ... }:
with pkgs;
[
  # --- Wayland / capture / clipboard ---
  rofi
  thunar
  awww
  grim
  slurp
  wl-clipboard
  dunst

  # --- Media ---
  ffmpeg
  playerctl
  brightnessctl

  # --- Virtualization (GUI) ---
  qemu
  virt-manager

  # --- Apps ---
  obsidian
  vscode
  gimp
  blender
  geeqie
  # bambu-studio
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
