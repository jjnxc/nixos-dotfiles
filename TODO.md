# NixOS Setup TODO

## Done
- [x] `/home` moved to second NVMe (btrfs, `@home` subvolume, zstd compression)
- [x] zram swap enabled (50% of RAM, priority over disk swap)
- [x] Confirmed `/home` data intact and mounted correctly
- [x] btrfs autoscrub + snapper timeline snapshots for `/home` — hit a real bug
      (declarative snapper config doesn't fix `.snapshots` ACLs; timeline
      silently failed for a week) — fixed via a `systemd.tmpfiles.rules` entry
      (read/traverse ACL only, not write — see RECOVERY.md)
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
- [x] Automatic garbage collection via `programs.nh.clean`
      (`--keep-since 14d --keep 5`) + nix-optimise
- [x] Cleanup pass: deleted old disk swap partition (nvme0n1p2), removed stale
      /etc/nixos, deleted orphaned @snapshots btrfs subvolume
- [x] Set explicit xdg-portal priority (hyprland then gtk) instead of ambiguous
      default — real improvement, though not confirmed as the root cause of
      the earlier portal coredump (which hasn't recurred)
- [x] Added nh (Nix Helper) via `programs.nh` (with `programs.nh.flake` set) —
      cleaner diffed rebuild output instead of raw nixos-rebuild logs
- [x] Security/dependency audit (Sep 2026): CI fixed and green (had been
      failing since it was added); flake.lock refreshed; catppuccin moved off
      `main` to the `release-26.05` branch; Open WebUI moved to localhost-only;
      systemd-boot menu editor disabled (blocked `init=/bin/sh` root shell);
      `/boot` masks tightened to `fmask=0077,dmask=0077`; stray duplicate
      home-manager packages removed (`ollama`, `dunst` — already provided by
      the NixOS module / elsewhere); herdr + local Ollama models (via opencode)
      added

## Still to do

### Real backups
- [ ] Interim: KeePass copied to USB (done/in progress) as a stopgap
- [ ] Longer-term: set up NAS-based backup for `/home` — snapshots protect
      against *mistakes*, not drive failure, and the snapshot pipeline itself
      has already been shown to fail silently once, so this is still the
      biggest real gap in the setup

### Hardening follow-ups
- [ ] `docker` group is root-equivalent (anyone in it can root the host via
      the daemon socket) — consider `virtualisation.docker.rootless` or
      switching to Podman
- [ ] `.gitignore` ignores `*.age`, which conflicts with adopting agenix or
      sops-nix (their encrypted secrets are meant to be committed) — revisit
      the ignore rule when secrets management actually gets added
- [ ] Sign commits (SSH signing via `programs.git.signing`) — currently
      unsigned
- [ ] CUDA builds (`ollama-cuda`, OBS with `cudaSupport`) aren't on
      cache.nixos.org and compile locally on every bump — consider the CUDA
      community binary cache, but only after checking its signing key
- [ ] `hardware.nvidia.powerManagement.enable` if suspend/resume ever shows
      graphical corruption
- [ ] Consider `nix.settings.allowed-users = [ "@wheel" ]` and
      `nix.channel.enable = false` (this is a flake-only system, channels are
      dead weight)
- [ ] Portal config is split between NixOS (`programs.hyprland`) and Home
      Manager (`home/desktop/portals.nix`) — consolidate in one layer
- [ ] `home/desktop/dotfiles.nix` sets `recursive = true` on an out-of-store
      symlink, which has no effect there — drop it next time the Hypr config
      is touched
- [ ] `home/programs/foot.nix` is not imported anywhere (dead file, commented
      out in `home/default.nix`) — delete it or re-enable the import
- [ ] Automate lockfile updates (e.g. a scheduled `update-flake-lock`
      workflow) — optional, nice-to-have

### Nice to know
- [ ] Global git ignore (`.envrc`, `.direnv/`) is managed via
      `programs.git.ignores` in home-manager, not `git config --global`
      directly — that file is read-only (symlinked into the Nix store)
- [ ] home-manager session variables (`hm-session-vars.sh`) have a
      double-source guard (`__HM_SESS_VARS_SOURCED`) — if a variable seems
      "not set" despite being correctly built, check for a stale guard in a
      long-lived shell before assuming the config is broken; a genuinely new
      terminal process resets it
