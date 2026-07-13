#!/usr/bin/env zsh
# Installs oh-my-zsh and wires up aliases.sh. Safe to re-run.
set -euo pipefail

REPO_DIR="${0:A:h}"

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

MARKER="# Odds-N-Ends aliases"
if ! grep -qF "$MARKER" "$HOME/.zshrc" 2>/dev/null; then
  cat >> "$HOME/.zshrc" <<EOF
$MARKER
[ -f "$REPO_DIR/aliases.sh" ] && source "$REPO_DIR/aliases.sh"
EOF
fi
