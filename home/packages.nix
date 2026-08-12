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
  # playerctl

  # --- Core crypto / tooling ---
  openssl
  claude-code
  ollama
  # gnupg
  # pinentry

  # --- Dev runtime / languages ---
  docker
  python3
  unzip
  qemu
  virt-manager
  # swift
  # swiftpm

  # --- Editors / apps ---
  neovim
  obsidian
  vscode
  gimp
  blender
  geeqie
  # bambu-studio
  # prusa-slicer

  # --- Build toolchain ---
  gcc
  gnumake

  # --- Fonts ---
  nerd-fonts.jetbrains-mono
  # nerdfonts

  # --- Themes / icons (cosmetic) ---
  adwaita-icon-theme
  gnome-themes-extra

  # --- Password manager ---
  keepassxc

  # --- CLI productivity ---
  fzf
  starship
  tmux
  ripgrep
  bat
  eza
  file

  # --- File manager / utilities (optional) ---
  # lf
  # imv

  # --- System monitors (optional) ---
  btop
  # ncdu

  # --- Archives ---
  p7zip
  unrar

  # --- Optional dev UX helpers ---
  # direnv
  nixfmt
  # zoxide
]
