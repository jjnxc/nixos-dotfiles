# Emergency Recovery Guide — desktop-nvidia
Your setup, for reference:
- **Main drive** (`nvme0n1`): NixOS root (`/`, ext4) + `/boot` (vfat) + zram swap (no disk swap in use)
- **Second drive** (`nvme1n1`): `/home` only (btrfs, `@home` subvolume, snapper snapshots)
- **Config**: flake-based, lives at `~/nixos-dotfiles`, pushed to a git remote (`origin`)
- **Hostname**: `desktop-nvidia`
Keep a copy of this file somewhere OUTSIDE the machine too (phone, printed, another device) —
if the main drive is the thing that's dead, you can't read this off it.
---
## Scenario 1: Bad rebuild — system boots but something's broken
Most common, least scary. NixOS keeps old generations; you're never stuck with a bad one.
1. Reboot.
2. At the boot menu (systemd-boot), you'll see a list of generations — pick the one
   **before** your last change.
3. System boots into the working generation. Nothing about `/home` or your data changes.
4. Once booted, fix the config, commit, and `update` again — or just roll back
   permanently:
```bash
   sudo nixos-rebuild switch --rollback --flake ~/nixos-dotfiles#desktop-nvidia
```
---
## Scenario 2: System won't boot at all
1. At the boot menu, try booting an **older generation** first (same as Scenario 1,
   just done blind before you can log in). This fixes most cases.
2. If no generation boots, boot from a **NixOS live USB**.
3. Mount your drives (adjust UUIDs if the layout changed — check with `lsblk -f`
   from the live USB):
```bash
   sudo mount /dev/nvme0n1p3 /mnt
   sudo mount /dev/nvme0n1p1 /mnt/boot
   sudo mount /dev/nvme1n1   /mnt/home -o subvol=@home
```
4. Chroot in and roll back or fix config:
```bash
   sudo nixos-enter --root /mnt
   nixos-rebuild switch --rollback --flake /home/jinx/nixos-dotfiles#desktop-nvidia
```
5. Reboot normally.
---
## Scenario 3: Accidentally deleted/overwrote files in `/home`
This is exactly what snapper is for.
```bash
snapper -c home list
```
Find the snapshot from before the mistake, then either:
**Restore a single file/folder** (safest — copy it back manually):
```bash
sudo cp -a /home/.snapshots/<NUMBER>/snapshot/path/to/file ~/path/to/file
```
**Roll back the whole subvolume to that point** (more drastic):
```bash
snapper -c home undochange <OLD_NUMBER>..<NEW_NUMBER>
```
Snapshots only protect against mistakes — they live on the *same* physical drive.
They will NOT help if the drive itself fails (see Scenario 5).
---
## Scenario 4: Main drive dies or gets corrupted (nvme0n1 — the OS drive)
Your `/home` drive is physically separate and untouched. Your actual files, KeePass,
dotfiles repo working copy — all safe. What you're rebuilding is just the OS.
1. Replace/repair the failed drive.
2. Boot a NixOS live USB, partition the new drive the same way (root + boot).
3. Format and mount the new root/boot partitions.
4. Mount your **existing, intact** `/home` drive alongside it:
```bash
   sudo mount /dev/nvme1n1 /mnt/home -o subvol=@home
```
5. Clone your config from git (this is why pushing to a remote matters):
```bash
   git clone <your-repo-url> /mnt/home/jinx/nixos-dotfiles
```
   (If `/mnt/home/jinx/nixos-dotfiles` already exists from the old drive, skip
   cloning — it's already there.)
6. Generate a fresh `hardware-configuration.nix` for the new hardware:
```bash
   nixos-generate-config --root /mnt
```
   This writes to `/mnt/etc/nixos/hardware-configuration.nix` — **but the flake
   does not read from there.** It imports the copy inside the repo, at
   `hosts/desktop-nvidia/hardware-configuration.nix`. Copy the freshly detected
   file into that location:
```bash
   cp /mnt/etc/nixos/hardware-configuration.nix \
      /mnt/home/jinx/nixos-dotfiles/hosts/desktop-nvidia/hardware-configuration.nix
```
   Then edit that copied file and **manually re-add your `/home` fileSystems
   block** (UUID may differ if it's a new physical drive — check with `blkid`).
7. Install using your flake:
```bash
   nixos-install --flake /mnt/home/jinx/nixos-dotfiles#desktop-nvidia
```
8. Reboot. Your whole setup — packages, Hyprland config, dev tools — comes back in
   one shot, because it was all declared in the flake, not just installed ad hoc.
---
## Scenario 5: Second drive dies or gets corrupted (nvme1n1 — the `/home` drive)
This is the scenario your current setup does **not** protect against on its own.
Snapshots live on this same drive — if it fails, snapshots are gone too.
**This is why the "real backups" TODO item matters** — an external drive or cloud
backup of `/home` (or at minimum your KeePass file, SSH keys, and project work) is
the only thing that saves you here. If you haven't set that up yet, treat it as
higher priority than anything else on the TODO list.
If it does happen with no backup:
1. Your OS drive and NixOS config are unaffected — you can boot fine.
2. Replace the failed drive, format it the same way (see the original setup steps
   in your dotfiles history / this conversation).
3. Update the UUID in `hardware-configuration.nix` to match the new drive.
4. `/home` will be empty on the new drive — restore from backup if you have one.
   Without a backup, this data is not recoverable.
---
## Scenario 6: Locked out (forgot password, broken user config)
1. Boot an older generation (Scenario 1) if the lockout is from a recent config
   change (e.g. broke your user/auth config).
2. If it's a genuinely forgotten password: boot a live USB, chroot in
   (Scenario 2, step 4), then:
```bash
   passwd jinx
```
   Set a new password, exit chroot, reboot.
---
## Quick reference — commands you'll actually reach for
| Situation | Command |
|---|---|
| Roll back one generation | `sudo nixos-rebuild switch --rollback --flake ~/nixos-dotfiles#desktop-nvidia` |
| List generations | `nixos-rebuild list-generations` |
| List home snapshots | `snapper -c home list` |
| Check what's mounted | `lsblk -f` |
| Rebuild normally | `update` (your alias) |
## Before you actually need this
- [ ] Confirm your git remote is real and reachable (`git remote -v` in
      `~/nixos-dotfiles`) — this whole recovery plan depends on it
- [ ] Set up the external/cloud backup for `/home` (Scenario 5 has no other fix)
- [ ] Keep this file somewhere other than this machine
---
## Known gotcha: snapper timeline silently failing (`.snapshots` ACL)
**Symptom:** `snapper-timeline.timer` shows active and "working" in
`systemctl status`, but `snapper -c home list` never grows past the initial
baseline snapshot (`0`). No obvious error unless you go looking.
**Cause:** Configuring `services.snapper.configs.home` declaratively in NixOS
creates the config file, but does NOT correctly set up permissions on the
`.snapshots` subvolume that snapper actually writes into. The systemd timer
runs as root and needs `.snapshots` owned by `root:root` — but your user also
needs write access to browse/manage snapshots without `sudo`, which normal
Unix ownership can't do for two different accounts at once. This needs a
POSIX ACL, not a chown, and the declarative module doesn't set one for you.
**How to check if this is happening to you:**
```bash
journalctl -u snapper-timeline.service --no-pager | tail -20
```
Look for `IO Error (.snapshots must have owner root)` or
`IO Error (open failed path:/home/.snapshots errno:2 ...)`.
**The fix** (already applied in this repo's `modules/hardware/snapshots.nix`
as of the commit "Persist snapper .snapshots ACL fix via activation script"):
```nix
system.activationScripts.snapperAcl = ''
  if [ -d /home/.snapshots ]; then
    ${pkgs.acl}/bin/setfacl -m u:jinx:rwx /home/.snapshots
  fi
'';
```
This re-applies the correct ACL on every rebuild/boot, so it's self-healing.
**If setting this up fresh on a new install:** the subvolume needs to exist
before the ACL can be applied. If `/home/.snapshots` doesn't exist yet:
```bash
sudo btrfs subvolume create /home/.snapshots
sudo chmod 750 /home/.snapshots
sudo setfacl -m u:jinx:rwx /home/.snapshots
```
Then rebuild — the activation script takes over from there on every boot after.
**Lesson:** a systemd timer showing "active" doesn't mean the thing it's
supposed to do is actually succeeding. Worth an occasional `snapper -c home
list` spot-check rather than trusting the timer status alone.
