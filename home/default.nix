{ config, pkgs, ... }:
{
  imports = [
    ./programs/git.nix
    # ./programs/foot.nix
    ./programs/zsh.nix
    ./programs/direnv.nix
    ./programs/kitty.nix
    ./programs/starship.nix
    ./programs/yazi.nix
    ./programs/dunst.nix
    ./desktop/dconf.nix
    ./desktop/portals.nix
    ./desktop/dotfiles.nix
  ];
  home.username = "jinx";
  home.homeDirectory = "/home/jinx";
  home.stateVersion = "26.05";
  home.packages = import ./packages { inherit pkgs; };
  home.file."Pictures/Screenshots/.keep".text = "";
  home.file."Pictures/Wallpapers/drawn.jpg".source = ./assets/wallpapers/drawn.jpg;

  home.sessionVariables = {
    NH_FLAKE = "/home/jinx/nixos-dotfiles";
  };
}
