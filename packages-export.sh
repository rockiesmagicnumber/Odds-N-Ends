#!/usr/bin/env zsh
# Regenerates package-lists/* from the current machine and commits them.
# Run this before a wipe so the lists in git reflect what's actually installed.
set -euo pipefail

REPO_DIR="${0:A:h}"
LISTS="$REPO_DIR/package-lists"
mkdir -p "$LISTS"

apt-mark showmanual > "$LISTS/apt-manual.txt"

flatpak list --app --columns=application > "$LISTS/flatpak-apps.txt"

npm ls -g --depth=0 | tail -n +2 \
  | sed -E 's/^[├└]── //; s/@[0-9].*$//' \
  > "$LISTS/npm-global.txt"

# This machine is externally-managed (PEP 668): `pip list --user` is
# always empty here since nothing gets installed to --user, and most of
# `pip list` (plain) is actually apt-owned python3-* packages living in the
# same dist-packages dir. Only packages installed outside apt's control -
# i.e. under /usr/local's dist-packages - are genuinely pip-managed.
LOCAL_SITE=$(python3 -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'base': '/usr/local'}))")
pip list --format=freeze --path "$LOCAL_SITE" > "$LISTS/pip-packages.txt"

cd "$REPO_DIR"
git add package-lists
if ! git diff --cached --quiet; then
  git commit -m "update package lists $(date +%F)"
  echo "Committed updated package lists. Remember to 'git push'."
else
  echo "Package lists unchanged, nothing to commit."
fi
