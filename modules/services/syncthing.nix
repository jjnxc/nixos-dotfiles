{ ... }:

{
  services.syncthing = {
    enable = true;

    user = "jinx";
    group = "users";

    dataDir = "/home/jinx/.local/share/syncthing";
    configDir = "/home/jinx/.config/syncthing";

    openDefaultPorts = true;
  };
}
