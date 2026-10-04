# Sourced from ~/.zshrc by zshrc-setup.sh. Edit here, not in .zshrc directly,
# so changes are versioned and survive a wipe automatically once this repo
# is re-cloned.

# Created by `pipx` on 2025-01-31 06:13:23
export PATH="$PATH:$HOME/.local/bin"

# dotnet install
export PATH="$PATH:$HOME/.dotnet"

export LD_LIBRARY_PATH=/usr/local/lib

export EDITOR=vim
export VISUAL=vim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
