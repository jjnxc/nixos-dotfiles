{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system
    ../../modules/hardware
    ../../modules/desktop
    ../../modules/services
    ../../modules/development
    ../../modules/virtualization
  ];

  networking.hostName = "desktop-nvidia";

  system.stateVersion = "26.05";
}
