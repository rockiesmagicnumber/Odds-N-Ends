#!/usr/bin/env zsh
# Flags git repos under ~/Repos and ~/gitbackup that have anything git alone
# won't save across a wipe: uncommitted/staged changes, untracked files,
# stashes, or commits that were never pushed anywhere. Run before a wipe;
# push/stash what you can, and add anything still flagged to
# borg-extra-includes.txt so borg-backup.sh actually captures it.
set -euo pipefail

ROOTS=("$HOME/Repos" "$HOME/gitbackup")

for root in "${ROOTS[@]}"; do
  [[ -d "$root" ]] || continue
  while IFS= read -r -d '' gitdir; do
    repo="${gitdir:h}"

    if [[ "$(git -C "$repo" rev-parse --is-bare-repository 2>/dev/null)" == "true" ]]; then
      echo "BARE:    $repo (no working tree - skipping status checks)"
      continue
    fi

    porcelain="$(git -C "$repo" status --porcelain)"
    untracked=$(grep -c '^??' <<< "$porcelain" || true)
    changed=$(grep -vc '^??' <<< "$porcelain" || true)
    [[ -z "$porcelain" ]] && { untracked=0; changed=0; }
    stashes=$(git -C "$repo" stash list | wc -l | tr -d ' ')

    if upstream=$(git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null); then
      ahead=$(git -C "$repo" log '@{u}..HEAD' --oneline | wc -l | tr -d ' ')
    else
      ahead="NO-UPSTREAM"
    fi

    if [[ "$changed" -gt 0 || "$untracked" -gt 0 || "$stashes" -gt 0 || "$ahead" != "0" ]]; then
      printf 'FLAGGED: %-60s changed=%s untracked=%s stashes=%s ahead=%s\n' \
        "$repo" "$changed" "$untracked" "$stashes" "$ahead"
    fi
  done < <(find "$root" -type d -name .git -prune -print0 2>/dev/null)
done
