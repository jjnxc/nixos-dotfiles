{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system
    ../../modules/hardware
    ../../modules/services
    ../../modules/desktop
    ../../modules/development
    ../../modules/virtualization
  ];

  networking.hostName = "nixos-btw";

  system.stateVersion = "26.05";
}
