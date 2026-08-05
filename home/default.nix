{ config, pkgs, ... }:
{
  imports = [
    ./programs/git.nix
    ./programs/foot.nix
    ./programs/zsh.nix
    ./programs/direnv.nix
    ./desktop/dconf.nix
    ./desktop/portals.nix
    ./desktop/dotfiles.nix
  ];
  home.username = "jinx";
  home.homeDirectory = "/home/jinx";
  home.stateVersion = "26.05";
  home.packages = import ./packages.nix { inherit pkgs; };
}
