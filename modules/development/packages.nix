{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    tree
    curl
    wget
    vim
  ];
}
