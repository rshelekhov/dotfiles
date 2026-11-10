#!/bin/sh
# Лимиты Claude для строки вкладок herdr (tab_bar_right).
# Данные берёт из кэша плагина herdr-agent-usage (его наполняет statusLine Claude Code).
f="$HOME/.local/state/herdr/plugins/herdr-agent-usage/claude-statusline.json"
[ -r "$f" ] || exit 1
exec jq -r --argjson now "$(date +%s)" '
  def left: (. - $now) as $s
    | if $s <= 0 then "сейчас"
      elif $s >= 86400 then "\($s / 86400 | floor)d \($s % 86400 / 3600 | floor)h"
      else "\($s / 3600 | floor)h\($s % 3600 / 60 | floor)m" end;
  def wlabel: {"five_hour": "5h", "weekly": "week", "monthly": "30d"}[.] // .;
  [.windows[]? | "\(.kind | wlabel) \(.used_percent)% · \(.resets_at | left)"]
  | if length == 0 then empty else "Claude  " + join("  │  ") end
' "$f"
