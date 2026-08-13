# NixOS Setup TODO

## Done
- [x] `/home` moved to second NVMe (btrfs, `@home` subvolume, zstd compression)
- [x] zram swap enabled (50% of RAM, priority over disk swap)
- [x] Confirmed `/home` data intact and mounted correctly
- [x] btrfs autoscrub + snapper timeline snapshots for `/home` — hit a real bug
      (declarative snapper config doesn't fix `.snapshots` ACLs; timeline
      silently failed for a week) — fixed via activation script, see RECOVERY.md
- [x] Docker + libvirtd (with swtpm) already enabled, user in both groups —
      containers available now for distro-hopping instead of slow VMs;
      GPU-passthrough VMs available via libvirtd when actually needed
- [x] direnv + nix-direnv + zsh integration set up via home-manager, tested on
      a real project (hello_c) with a flake-based dev shell
- [x] Verified old pre-migration `/home` data on main drive matched the new
      copy (spot-checked `.ssh`), then removed it — reclaimed ~30G on root
- [x] Terminal glow-up: kitty (Catppuccin Mocha + Hyprland blur), yazi
      (replaced ranger — faster, native kitty image preview), starship themed
      with Catppuccin palette (kept default format/modules)
- [x] Automatic weekly nix-gc (14 day retention) + nix-optimise
- [x] Cleanup pass: deleted old disk swap partition (nvme0n1p2), removed stale
      /etc/nixos, deleted orphaned @snapshots btrfs subvolume
- [x] Set explicit xdg-portal priority (hyprland then gtk) instead of ambiguous
      default — real improvement, though not confirmed as the root cause of
      the earlier portal coredump (which hasn't recurred)
- [x] Added nh (Nix Helper) with NH_FLAKE set — cleaner diffed rebuild output
      instead of raw nixos-rebuild logs

## Still to do

### Real backups
- [ ] Interim: KeePass copied to USB (done/in progress) as a stopgap
- [ ] Longer-term: set up NAS-based backup for `/home` — snapshots protect
      against *mistakes*, not drive failure, and the snapshot pipeline itself
      has already been shown to fail silently once, so this is still the
      biggest real gap in the setup

### Nice to know
- [ ] Global git ignore (`.envrc`, `.direnv/`) is managed via
      `programs.git.ignores` in home-manager, not `git config --global`
      directly — that file is read-only (symlinked into the Nix store)
- [ ] home-manager session variables (`hm-session-vars.sh`) have a
      double-source guard (`__HM_SESS_VARS_SOURCED`) — if a variable seems
      "not set" despite being correctly built, check for a stale guard in a
      long-lived shell before assuming the config is broken; a genuinely new
      terminal process resets it
