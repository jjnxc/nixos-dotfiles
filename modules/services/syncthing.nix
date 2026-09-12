{
  services.syncthing = {
    enable = true;

    user = "jinx";
    group = "users";

    dataDir = "/home/jinx/.local/share/syncthing";
    configDir = "/home/jinx/.config/syncthing";

    openDefaultPorts = true;

    # Devices and folders are managed in the web UI. With the defaults (true),
    # adding any `settings` here would make the module delete them on restart.
    overrideDevices = false;
    overrideFolders = false;
  };
}
