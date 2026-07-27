{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Santo_Domingo";

  i18n.defaultLocale = "en_US.UTF-8";

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

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
