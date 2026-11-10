#!/usr/bin/env bash
# Copy the portable part of ~/.claude/settings.json into this repo
# (claude/claude-settings.json).
#
# Why a filtered copy instead of a symlink: installers (herdr, attyx, Orca,
# herdr-agent-usage, claudeup) write machine-specific state into settings.json
# — generated hook scripts, absolute paths, statusLine binaries, plugin
# versions. That state is reinstalled by those tools on a new machine and
# must not land in this public repo.
#
# Kept:    everything except the keys and hooks listed below.
# Dropped: statusLine, installedPluginVersions, autoMode (mentions local work
#          repos), and hooks whose command matches an installer pattern.
#
# Usage: claude/sync-settings.sh            # write claude/claude-settings.json
#        claude/sync-settings.sh --check    # exit 1 if the repo copy is stale
set -euo pipefail

src="${CLAUDE_SETTINGS:-$HOME/.claude/settings.json}"
dst="$(cd "$(dirname "$0")" && pwd)/claude-settings.json"

# Hook commands containing any of these are installer-managed.
installer_hooks='attyx|herdr-agent-state|herdr-agent-usage|\.orca/|OSTYPE|claudeup hook'

filtered="$(jq --arg skip "$installer_hooks" '
  del(.statusLine, .installedPluginVersions, .autoMode)
  | if .hooks then
      .hooks |= (
        with_entries(
          .value |= (
            map(.hooks |= map(select(.command | test($skip) | not)))
            | map(select(.hooks | length > 0))
          )
        )
        | with_entries(select(.value | length > 0))
      )
    else . end
' "$src")"

if [[ "${1-}" == "--check" ]]; then
  if [[ "$filtered" == "$(jq . "$dst")" ]]; then
    echo "claude-settings.json is up to date"
  else
    echo "claude-settings.json is stale; run $0" >&2
    exit 1
  fi
  exit 0
fi

printf '%s\n' "$filtered" > "$dst"
echo "Wrote $dst"
