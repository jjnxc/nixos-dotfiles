{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users."jinx" = {
    shell = pkgs.zsh;
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];

    packages = [ ];
  };
}
