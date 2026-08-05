# NixOS Setup TODO

## Done
- [x] `/home` moved to second NVMe (btrfs, `@home` subvolume, zstd compression)
- [x] zram swap enabled (50% of RAM, priority over disk swap)
- [x] Confirmed `/home` data intact and mounted correctly
- [x] btrfs autoscrub + snapper timeline snapshots for `/home`
- [x] Docker + libvirtd (with swtpm) already enabled, user in both groups —
      containers available now for distro-hopping instead of slow VMs;
      GPU-passthrough VMs available via libvirtd when actually needed
- [x] direnv + nix-direnv + zsh integration set up via home-manager

## Still to do

### Cleanup
- [ ] Old disk swap partition (`/dev/nvme0n1p2`, 16G) is inactive but not removed —
      decide whether to wipe it and reclaim the space, or leave it
- [ ] Stale `/etc/nixos/` directory (dated June 20, unrelated to the real flake
      config in `~/nixos-dotfiles`) — clean up to avoid future confusion, e.g.
      if `nixos-rebuild` is ever run without `--flake` by accident
- [ ] Double check no other uncommitted changes are lingering
      (`git status` in `nixos-dotfiles`)

### Investigate
- [ ] `xdg-desktop-portal` coredump seen in `journalctl -b -p err` — possibly
      related to the brief black-screen/lockscreen flashes during rebuilds.
      Not confirmed as the cause; worth checking if it recurs on future rebuilds
      or independently of them

### Dev workflow
- [ ] Try direnv on a real project: add `.envrc` with `use flake` (or plain env
      vars), run `direnv allow`, confirm auto-load/unload on `cd`
- [ ] Add `.envrc` to global gitignore so it's not accidentally committed to
      shared repos

### Dotfiles / config organization
- [ ] Consider symlinking `/etc/nixos` -> dotfiles repo (or removing the stale
      dir entirely) so system config and dotfiles are unified
- [ ] Decide where NixOS flake config itself should live relative to dotfiles
      long-term, so a full reinstall recovers the whole setup, not just data

### Real backups
- [ ] Btrfs snapshots protect against *mistakes*, not drive failure - set up an
      actual backup to separate physical media (external drive, cloud, etc.)
      for anything irreplaceable (e.g. KeePass)
