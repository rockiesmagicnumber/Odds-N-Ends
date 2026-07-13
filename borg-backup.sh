#!/usr/bin/env zsh
# Wraps `borg create` with the patterns-from file, so this can just be
# aliased as `borg-backup` (see aliases.sh) instead of growing a one-liner
# alias in .zshrc forever.
#
# BORG_REPO is hardcoded rather than derived from `hostname`/`{hostname}`:
# the real repo on network storage is its own directory per machine
# (/mnt/network-storage/borg-backups/DESTRUCTOTRON-mint-22_1-cinnamon,
# already encrypted+initialized), not a single shared repo with the
# hostname baked into the archive name the way the old .bashrc alias
# assumed. Keep using this exact path post-reinstall so new archives land
# in the same repo (same dedup history) rather than starting a new one.
set -euo pipefail

REPO_DIR="${0:A:h}"
BORG_REPO_PATH="/mnt/network-storage/borg-backups/DESTRUCTOTRON-mint-22_1-cinnamon"
PATTERNS_TMP="$(mktemp)"
trap 'rm -f "$PATTERNS_TMP"' EXIT

# Order matters (patterns-from is first-match-wins): junk excludes first so
# they always win even inside a carved-out repo, then the extra-includes
# carve-outs, then the blanket Repos exclude last so it only catches
# whatever wasn't specifically carved back in.
cat "$REPO_DIR/borg-patterns.txt" "$REPO_DIR/borg-extra-includes.txt" > "$PATTERNS_TMP"
echo '- re:(^|/)Repos(/|$)' >> "$PATTERNS_TMP"

cd "$HOME"
borg create --patterns-from "$PATTERNS_TMP" --list \
  "$BORG_REPO_PATH::archive-{now}" .
