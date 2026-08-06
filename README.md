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
- NVIDIA GPU
- Hardware acceleration enabled

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

### Dev workflow
- direnv + nix-direnv, with zsh integration — per-project environments via
  `.envrc` (`use flake`, etc.)

## Installation

Clone the repository:
```bash
git clone <repository-url>
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

## Other docs in this repo

- `TODO.md` — outstanding setup tasks and known follow-ups
- `RECOVERY.md` — step-by-step recovery instructions for boot failures, drive
  failure, accidental deletions, and lockouts
