{
  imports = [
    ./syncthing.nix
    ./ollama.nix
    ./herdr.nix
  ];

  security.rtkit.enable = true;

  services = {
    dbus.enable = true;
    fwupd.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
  };
}
