#!/usr/bin/env bash
#
# install-skills.sh — symlink dotfiles-native Claude skills into ~/.claude/skills
#
# Links every skill that lives in this repo's claude/skills/ directory into
# ~/.claude/skills/ so Claude Code picks it up. Safe to re-run: it refreshes
# stale links, skips correct ones, and never clobbers real directories or
# symlinks that point outside this repo.
#
# The live gstack install (~/.claude/skills/gstack + gstack-* links) is managed
# separately by gstack itself, NOT by this repo. The vendored gstack snapshots
# under claude/skills/ are therefore excluded via DENYLIST below so we don't
# create duplicate, unprefixed copies that shadow the real install.
#
# Usage:
#   ./claude/install-skills.sh           # link skills
#   ./claude/install-skills.sh --dry-run # show what would change, do nothing

set -euo pipefail

REPO_SKILLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/skills" && pwd)"
TARGET_DIR="${HOME}/.claude/skills"

# Skills provided by the separate gstack install — do not link the vendored
# snapshots from this repo. Keep in sync with what `gstack` installs.
DENYLIST=(
  browse
  design-consultation
  document-release
  gstack
  gstack-upgrade
  plan-ceo-review
  plan-design-review
  plan-eng-review
  qa
  qa-design-review
  qa-only
  retro
  review
  setup-browser-cookies
  ship
)

DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

is_denied() {
  local name="$1"
  for d in "${DENYLIST[@]}"; do
    [[ "$d" == "$name" ]] && return 0
  done
  return 1
}

# link_skill <name> <absolute-source-path>
link_skill() {
  local name="$1" src="$2"
  local dst="${TARGET_DIR}/${name}"

  if [[ -L "$dst" ]]; then
    local current
    current="$(readlink "$dst")"
    if [[ "$current" == "$src" ]]; then
      echo "  ok      ${name}"
      return
    fi
    case "$current" in
      "$REPO_SKILLS_DIR"/*)
        echo "  relink  ${name}  (${current} -> ${src})"
        [[ $DRY_RUN -eq 1 ]] && return
        ln -sfn "$src" "$dst"
        ;;
      *)
        echo "  SKIP    ${name}  (symlink points outside repo: ${current})"
        ;;
    esac
    return
  fi

  if [[ -e "$dst" ]]; then
    echo "  SKIP    ${name}  (real path exists, not a symlink — leaving untouched)"
    return
  fi

  echo "  link    ${name}  -> ${src}"
  [[ $DRY_RUN -eq 1 ]] && return
  ln -s "$src" "$dst"
}

main() {
  [[ $DRY_RUN -eq 1 ]] && echo "(dry run — no changes will be made)"
  echo "Source: ${REPO_SKILLS_DIR}"
  echo "Target: ${TARGET_DIR}"
  echo

  [[ $DRY_RUN -eq 1 ]] || mkdir -p "$TARGET_DIR"

  for entry in "$REPO_SKILLS_DIR"/*/; do
    entry="${entry%/}"
    local name
    name="$(basename "$entry")"

    if is_denied "$name"; then
      echo "  denied  ${name}  (managed by gstack install)"
      continue
    fi

    if [[ -f "${entry}/SKILL.md" ]]; then
      # A single skill: link the directory by its own name.
      link_skill "$name" "$entry"
    else
      # A collection (e.g. the greptile submodule): link each nested skill.
      local found=0
      for nested in "$entry"/*/; do
        nested="${nested%/}"
        if [[ -f "${nested}/SKILL.md" ]]; then
          found=1
          link_skill "$(basename "$nested")" "$nested"
        fi
      done
      [[ $found -eq 0 ]] && echo "  no-op   ${name}  (no SKILL.md found)"
    fi
  done

  echo
  echo "Done."
}

main "$@"
