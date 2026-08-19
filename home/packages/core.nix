{ pkgs, ... }:
with pkgs;
[
  # --- Core crypto / tooling ---
  openssl
  claude-code
  ollama
  # gnupg
  # pinentry

  # --- Dev runtime / languages ---
  python3
  unzip
  # swift
  # swiftpm

  # --- Editors ---
  nh
  neovim

  # --- Build toolchain ---
  gcc
  gnumake

  # --- Fonts ---
  nerd-fonts.jetbrains-mono
  # nerdfonts

  # --- CLI productivity ---
  fzf
  starship
  tmux
  ripgrep
  bat
  eza
  file

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
