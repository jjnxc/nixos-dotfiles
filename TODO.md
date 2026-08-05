# NixOS Setup TODO

## Done
- [x] `/home` moved to second NVMe (btrfs, `@home` subvolume, zstd compression)
- [x] zram swap enabled (50% of RAM, priority over disk swap)
- [x] Confirmed `/home` data intact and mounted correctly

## Still to do

### Cleanup
- [ ] Old disk swap partition (`/dev/nvme0n1p2`, 16G) is inactive but not removed —
      decide whether to wipe it and reclaim the space, or leave it
- [ ] Stale `/etc/nixos/` directory (dated June 20, unrelated to the real flake
      config in `~/nixos-dotfiles`) — clean up to avoid future confusion, e.g.
      if `nixos-rebuild` is ever run without `--flake` by accident
- [ ] Commit is done, but double check no other uncommitted changes are lingering
      (`git status` in `nixos-dotfiles`)

### Investigate
- [ ] `xdg-desktop-portal` coredump seen in `journalctl -b -p err` — possibly
      related to the brief black-screen/lockscreen flashes during rebuilds.
      Not confirmed as the cause; worth checking if it recurs on future rebuilds
      or independently of them

### Snapshots (btrfs on `/home`)
- [ ] Set up `snapper` scheduling for `/home` snapshots (rollback safety net for
      mistakes — not a substitute for real backups)
- [ ] Consider `services.btrfs.autoScrub.enable = true` for catching silent
      corruption early

### Containers / VMs
- [ ] `virtualisation.docker.enable` or `podman.enable` for distro-hopping via
      containers instead of slow VMs
- [ ] `virtualisation.libvirtd.enable` for GPU-passthrough VMs (only needed for
      actual different-OS + real GPU use, e.g. gaming in a Windows VM)

### Dev workflow
- [ ] `direnv` + `nix-direnv` for per-project reproducible dev shells

### Dotfiles / config organization
- [ ] Consider symlinking `/etc/nixos` → dotfiles repo (or removing the stale
      dir entirely) so system config and dotfiles are unified
- [ ] Decide where NixOS flake config itself should live relative to dotfiles
      long-term, so a full reinstall recovers the whole setup, not just data

### Real backups
- [ ] Btrfs snapshots protect against *mistakes*, not drive failure — set up an
      actual backup to separate physical media (external drive, cloud, etc.)
      for anything irreplaceable (e.g. KeePass)
