{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ btrfs-progs snapper ];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/home" ];
  };

  services.snapper.configs.home = {
    SUBVOLUME = "/home";
    ALLOW_USERS = [ "jinx" ];
    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
    TIMELINE_LIMIT_HOURLY = 5;
    TIMELINE_LIMIT_DAILY = 7;
    TIMELINE_LIMIT_WEEKLY = 4;
    TIMELINE_LIMIT_MONTHLY = 3;
    TIMELINE_LIMIT_YEARLY = 0;
  };

  systemd.tmpfiles.rules = [
    "a+ /home/.snapshots - - - - u:jinx:rwx"
  ];
}
