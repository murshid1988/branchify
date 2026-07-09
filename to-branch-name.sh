#!/usr/bin/env bash
#
# to-branch-name.sh
# Convert an arbitrary string into a valid, sane git branch name.
#
# Usage:
#   ./to-branch-name.sh "Fix bug: user login fails!!"
#   echo "Some Title" | ./to-branch-name.sh
#
# Or source it and call the function directly:
#   source to-branch-name.sh
#   to_branch_name "Add OAuth2 support (v2)"
#
# Rules enforced (per `git check-ref-format`, plus common conventions):
#   - lowercased
#   - spaces/underscores -> hyphens
#   - strips characters git rejects: space ~ ^ : ? * [ \ and ASCII control chars
#   - no consecutive dots ".."
#   - no "@{" sequence
#   - can't start/end with "." or "/"
#   - no leading/trailing/duplicate hyphens or slashes
#   - not ".lock" suffix, not a lone "@"
#   - truncated to 100 chars (branch names can be long, but keep it usable)

set -euo pipefail

to_branch_name() {
  local input="${1:-}"
  local s="$input"

  # lowercase
  s=$(printf '%s' "$s" | tr '[:upper:]' '[:lower:]')

  # replace whitespace/underscores with hyphens
  s=$(printf '%s' "$s" | tr -s '[:space:]_' '-')

  # remove characters git disallows in refs: space(handled) ~ ^ : ? * [ \ and control chars
  s=$(printf '%s' "$s" | tr -d '~^:?*[\\' | tr -d '\000-\037\177')

  # drop "@{" sequences
  s=$(printf '%s' "$s" | sed 's/@{/-/g')

  # anything not alnum, dot, hyphen, slash -> hyphen
  s=$(printf '%s' "$s" | sed -E 's/[^a-z0-9.\/-]+/-/g')

  # collapse consecutive dots ".." -> "."
  s=$(printf '%s' "$s" | sed -E 's/\.{2,}/./g')

  # collapse consecutive slashes and hyphens
  s=$(printf '%s' "$s" | sed -E 's/\/{2,}/\//g; s/-{2,}/-/g')

  # strip leading/trailing dots, slashes, hyphens (repeat until stable)
  local prev=""
  while [ "$prev" != "$s" ]; do
    prev="$s"
    s=$(printf '%s' "$s" | sed -E 's#^[./-]+##; s#[./-]+$##')
  done

  # strip ".lock" suffix if present
  s=$(printf '%s' "$s" | sed -E 's/\.lock$//')

  # guard against empty or reserved "@"
  if [ -z "$s" ] || [ "$s" = "@" ]; then
    s="branch"
  fi

  # truncate to 100 chars, then re-strip trailing separators from the cut
  s=$(printf '%s' "$s" | cut -c1-100 | sed -E 's#[./-]+$##')

  printf '%s\n' "$s"
}

# If executed directly (not sourced), run it on argv or stdin.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  if [ "$#" -gt 0 ]; then
    to_branch_name "$*"
  else
    to_branch_name "$(cat)"
  fi
fi
