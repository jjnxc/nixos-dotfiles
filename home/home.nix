{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    nvim = "nvim";
    lf = "lf";
    starship = "starship";
  };

  wallpapers = "${config.home.homeDirectory}/Pictures/Wallpapers";
in
{
  home.username = "jinx";
  home.homeDirectory = "/home/jinx";
  programs.git.enable = true;
  home.stateVersion = "26.05";

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        "gtk-theme" = "Adwaita-dark";
        "color-scheme" = "prefer-dark";
      };
    };
  };

  # environment.sessionVariables = {
  #   ADW_DISABLE_PORTAL = "1";
  # };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];

    config = {
      common.default = "*";
    };
  };

  
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=11";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -la";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
    };
    
    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];

    initContent = ''
      eval "$(starship init zsh)"
    '';
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;


  home.packages = with pkgs; [
    rofi
    thunar
    awww
    grim
    slurp

    openssl
    docker
    python3
    unzip

    swift
    swiftpm

    nerd-fonts.jetbrains-mono

    neovim
    # emacs

    obsidian
    vscode

    gcc
    gnumake

    adwaita-icon-theme
    gnome-themes-extra

    keepassxc
    # blender
    # gimp

    # godot

    fzf
    starship
    tmux
    ripgrep
    bat
    eza
    file

    lf

    btop
    ncdu

    p7zip
    unrar
  ];
}
