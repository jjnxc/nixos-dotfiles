{ pkgs, ... }:

{
  programs.zsh.enable = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    git
    tree
    curl
    wget
    vim
  ];
}
