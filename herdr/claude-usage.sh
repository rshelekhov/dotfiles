#!/bin/sh
# Claude limits for the herdr tab bar (tab_bar_right).
# Reads the herdr-agent-usage plugin cache, which the Claude Code statusLine fills.
# Trailing "  \u2800" keeps a gap at the right edge: herdr trims whitespace, and
# U+2800 (braille blank) is not whitespace, so the spaces before it survive.
f="$HOME/.local/state/herdr/plugins/herdr-agent-usage/claude-statusline.json"
[ -r "$f" ] || exit 1
exec jq -r --argjson now "$(date +%s)" '
  def left: (. - $now) as $s
    | if $s <= 0 then "now"
      elif $s >= 86400 then "\($s / 86400 | floor)d \($s % 86400 / 3600 | floor)h"
      else "\($s / 3600 | floor)h\($s % 3600 / 60 | floor)m" end;
  def wlabel: {"five_hour": "5h", "weekly": "week", "monthly": "30d"}[.] // .;
  [.windows[]? | "\(.kind | wlabel) \(.used_percent)% · \(.resets_at | left)"]
  | if length == 0 then empty else "Claude  " + join("  │  ") + "  \u2800" end
' "$f"
