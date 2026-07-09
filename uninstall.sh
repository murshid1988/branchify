#!/usr/bin/env bash
# Uninstalls branchify installed via the manual curl method
# (does NOT apply to Homebrew or .deb/pacman installs -- use
# `brew uninstall branchify`, `sudo apt remove branchify`, or
# `sudo pacman -R branchify` for those).

set -euo pipefail

BIN="/usr/local/bin/branchify"
MAN="/usr/local/share/man/man1/branchify.1"

for f in "$BIN" "$MAN"; do
  if [ -e "$f" ]; then
    if [ -w "$(dirname "$f")" ]; then
      rm -f "$f"
    else
      sudo rm -f "$f"
    fi
    echo "Removed $f"
  fi
done

echo "branchify uninstalled."
