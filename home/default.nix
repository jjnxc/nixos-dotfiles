{ config, pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/foot.nix
    ./programs/zsh.nix
  ];

  home.username = "jinx";
  home.homeDirectory = "/home/jinx";
  home.stateVersion = "26.05";

  home.packages = import ./packages.nix { inherit pkgs; };
}
