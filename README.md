# Odds-N-Ends

Personal setup/reinstall scripts for one machine. Precondition for all of
this: `/mnt/network-storage` must be reachable independent of the boot drive
being wiped (confirm with `mount | grep network-storage` / check
`/etc/fstab`) - if it's actually on the disk being reinstalled, none of the
backup steps below are worth anything.

## Pre-wipe

1. `./packages-export.sh` - regenerates `package-lists/*` and commits them.
2. `./repos-check-dirty.sh` - lists any repo under `~/Repos` or `~/gitbackup`
   with uncommitted changes, untracked files, stashes, or unpushed commits.
   Push or stash what you can.
3. For anything still flagged, add a line to `borg-extra-includes.txt`
   (format shown in that file) and commit.
4. `./borg-backup.sh` - backs up everything except cache/junk directories
   (see `borg-patterns.txt`) to `/mnt/network-storage`.
5. Wipe and reinstall Mint.

## Post-reinstall

0. Re-establish access to `/mnt/network-storage` - nothing else here works
   without it. Add this line to `/etc/fstab`, then `sudo mkdir -p
   /mnt/network-storage && sudo mount /mnt/network-storage`:
   ```
   192.168.1.5:/mnt/storage    /mnt/network-storage    nfs	 _netdev,nofail,x-systemd.automount,x-systemd.mount-timeout=15,soft,timeo=15,retrans=2    0    0
   ```
   Then:
   ```
   sudo apt update && sudo apt install -y git
   git clone <this repo's remote> ~/Repos/Odds-N-Ends
   cd ~/Repos/Odds-N-Ends
   ```
1. `./repos-add-3rdparty.sh` - adds the Brave/Sublime/VSCodium APT repos and
   installs Calibre.
2. `./packages-install.sh` - installs everything from `package-lists/*`,
   plus the handful of things that aren't in any package manager
   (Steam/Discord .debs, nvm, npm globals, pip user packages). Note:
   `amdgpu-top` currently has no known download URL - see the TODO in the
   script.
3. `./zshrc-setup.sh` - installs oh-my-zsh and wires `aliases.sh` into
   `~/.zshrc`.
4. Mount `/mnt/network-storage`, `borg list /mnt/network-storage/borg-backups`
   to find the right archive, then extract it to a staging directory (e.g.
   `borg extract ...::archive-name --target /tmp/restore`) and selectively
   copy back what you actually want (Documents, epubLibrary, any repos that
   were flagged dirty, etc.) rather than overwriting the fresh home
   directory wholesale.

- `apt-mark showmanual` currently returns ~2,000 packages on this machine
  (vs. ~3,500 total installed) — far more than you'd expect from years of
  intentional `apt install`s. A lot of it is clearly dependency-library
  cruft (`libgomp1`, `libcap2`, `gir1.2-glib-2.0`, ...) that should be
  "auto", not "manual" - likely drift from distro upgrades or PPA
  installs over time. It's harmless to reinstall from as-is (apt just
  no-ops on things already satisfied), but it makes `packages-install.sh`
  slower and noisier than necessary. Worth an occasional
  `apt-mark auto $(apt-mark showmanual)` + `apt-mark manual <the packages
  you actually chose>` cleanup pass on the *current* machine if you want a
  tighter list before the next `packages-export.sh` run - not something
  this script tries to fix automatically.

## Notes

- Excluding `.var` from the borg backup means flatpak app *state/login
  data* doesn't come back automatically - only the app itself, via
  `flatpak install`. Expect to re-log-in to things like TIDAL Hi-Fi and
  ONLYOFFICE after restore.
- No orchestrator script ties all of this together on purpose - this is a
  run-once-every-year-or-two process, and a checklist is more robust than
  a script that has to handle resuming after a failure mid-chain.
