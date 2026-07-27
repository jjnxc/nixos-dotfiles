{ pkgs, ... }:

{
  users.users."jinx" = {
    shell = pkgs.zsh;
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];

    packages = [];
  };
}
