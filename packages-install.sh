#!/usr/bin/env zsh
# Reinstalls everything captured by packages-export.sh. Run after
# repos-add-3rdparty.sh (so the apt-manual list's third-party packages
# have somewhere to come from) and before zshrc-setup.sh.
set -euo pipefail

REPO_DIR="${0:A:h}"
LISTS="$REPO_DIR/package-lists"

sudo apt update

# steam/discord/amdgpu-top get marked "manual" by apt-mark once installed via
# a local .deb, so they show up in apt-manual.txt but aren't apt-installable
# by name - pull them out and handle them as direct .deb downloads instead.
MANUAL_DEB_PACKAGES=(steam discord amdgpu-top)
APT_PKGS=("${(@f)$(comm -23 <(sort "$LISTS/apt-manual.txt") <(printf '%s\n' "${MANUAL_DEB_PACKAGES[@]}" | sort))}")
sudo apt install -y "${APT_PKGS[@]}"

mkdir -p ~/Downloads
wget -qO ~/Downloads/steam_latest.deb https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb
wget -qO ~/Downloads/discord_latest.deb "https://discord.com/api/download?platform=linux&format=deb"
# TODO: amdgpu-top has no known download URL - this was already missing from
# the original apt-install.sh. Find the real source (likely a GitHub release
# .deb asset) and add a wget line here before relying on this script.
sudo apt install -y ~/Downloads/steam_latest.deb ~/Downloads/discord_latest.deb

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub $(cat "$LISTS/flatpak-apps.txt")

# nvm (not apt-installable) + global npm packages
if [[ ! -d "$HOME/.nvm" ]]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh)"
fi
\. "$HOME/.nvm/nvm.sh"
nvm install --lts
while read -r pkg; do
  [[ -z "$pkg" ]] || npm install -g "$pkg"
done < "$LISTS/npm-global.txt"

# pip packages installed outside apt's control (see packages-export.sh for
# why this isn't a --user list). --break-system-packages matches how these
# got installed originally on this externally-managed system.
pip install --break-system-packages -r "$LISTS/pip-packages.txt"
