# Jinx's NixOS Configuration

My personal NixOS + Home Manager configuration.

Built around:
- Nix flakes
- Home Manager
- Hyprland
- NVIDIA graphics
- Modular NixOS configuration

## System

### Host
`desktop-nvidia`

### Desktop
- Hyprland
- Ly display manager
- PipeWire audio

### Hardware
- NVIDIA GPU, open kernel modules (`hardware.nvidia.open = true`)
- Hardware acceleration via VA-API (`nvidia-vaapi-driver`)

### Storage
- Root (`/`) on primary NVMe, ext4
- `/home` on a dedicated second NVMe, btrfs (`@home` subvolume, zstd compression)
  — kept separate so the system drive can be wiped/reinstalled without touching
  personal data
- zram swap (compressed RAM swap) instead of a disk swap partition
- btrfs autoscrub (monthly) + snapper timeline snapshots on `/home` for rollback
  of accidental deletions/mistakes — not a substitute for real backups

### Virtualization
- Docker
- libvirtd (with swtpm for TPM-dependent guests)
- User is in the `docker` and `libvirtd` groups

### Services
- Ollama, CUDA-accelerated. Pulls two models on activation (~4.4 GB):
  `qwen3.5:4b` and `qwen3.5:0.8b` (see `lib/local-models.nix`) — both fit
  in the RTX 3070's 8 GB at once, so neither offloads to CPU
- Open WebUI at `http://127.0.0.1:8080` — localhost-only on purpose (the
  first account to sign up becomes admin, so listening on the LAN would let
  anyone on the network claim it first); to expose it, set `host = "0.0.0.0"`
  and `openFirewall = true` in `modules/services/ollama.nix`
- herdr (terminal workspace manager for coding agents), built from its
  pinned flake input (`github:herdrdev/herdr/v0.9.0`) — upgrade by bumping
  the tag in `flake.nix`; `herdr update` won't work since the binary comes
  from the Nix store
- opencode, configured against the local Ollama models above (default
  `qwen3.5:4b`, small `qwen3.5:0.8b`, 32k context) — herdr's opencode
  integration is installed declaratively, so `herdr agent start <name>
  --kind opencode` runs fully local
- Syncthing — sync ports 22000/tcp+udp and 21027/udp open, GUI on
  `127.0.0.1:8384`; devices and folders are managed in the GUI
  (`overrideDevices`/`overrideFolders = false`, so anything set declaratively
  here would get wiped on restart instead)
- Steam, OBS (CUDA build), Bluetooth (blueman), Thunar, Docker, libvirtd,
  fwupd
- Catppuccin Mocha theming throughout, via `catppuccin/nix` pinned to its
  `release-26.05` branch

### Dev workflow
- direnv + nix-direnv, with zsh integration — per-project environments via
  `.envrc` (`use flake`, etc.)

## Installation

Clone the repository:
```bash
git clone https://github.com/jjnxc/nixos-dotfiles
cd nixos-dotfiles
```

Apply the configuration:
```bash
sudo nixos-rebuild switch --flake .#desktop-nvidia
```

(Day-to-day, use the `update` shell alias instead, which points at this repo.)

**Note:** `hardware-configuration.nix` under `hosts/desktop-nvidia/` is
machine-specific (drive UUIDs, etc.) — on new hardware you'll need to regenerate
or adjust it, particularly the `/home` mount, rather than using it as-is.

## Updating

Inputs are pinned: nixpkgs (`nixos-26.05`), home-manager (`release-26.05`),
catppuccin (`release-26.05`, follows nixpkgs), herdr (`v0.9.0`, follows
nixpkgs). To update:
```bash
nix flake update
update
```
(`update` is the `nh os switch` alias mentioned above.) To bump a single
input instead of all of them, use `nix flake update <input-name>`. herdr in
particular is pinned to a release tag, not a branch — bump the tag in
`flake.nix` to move to a newer herdr release.

## CI

`.github/workflows/check.yml` runs on every push to `main` and every PR:
`nix flake check -L`, `nix fmt -- --ci` (formatter is `nixfmt-tree`),
`statix check .`, and `deadnix`. Workflow actions are pinned to commit SHAs
and kept current by Dependabot (`.github/dependabot.yml`).

Run the same checks locally:
```bash
nix flake check
nix fmt
nix develop -c statix check .
nix develop -c deadnix --fail --exclude hosts/desktop-nvidia/hardware-configuration.nix .
```
Note: `nix flake check` can't be run with `--no-build` here — catppuccin
reads theme files from derivations at evaluation time (IFD), so evaluation
itself needs to build things.

## Other docs in this repo

- `TODO.md` — outstanding setup tasks and known follow-ups
- `RECOVERY.md` — step-by-step recovery instructions for boot failures, drive
  failure, accidental deletions, and lockouts
