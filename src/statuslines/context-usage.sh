#!/bin/bash
# Claude Code status line. Shows the session's context-window usage and nothing else.

input=$(cat)

RESET=$'\033[0m'
DIM=$'\033[38;5;8m'
GREEN=$'\033[38;5;10m'
YELLOW=$'\033[38;5;11m'
RED=$'\033[38;5;9m'

# Compact token counts: 54670 -> 54k, 1000000 -> 1M, 200000 -> 200k.
format_tokens() {
  local n=$1
  case $n in
    '' | *[!0-9]*) printf '?'; return ;;
  esac
  if [ "$n" -ge 1000000 ]; then
    awk -v n="$n" 'BEGIN { v = n / 1000000; printf (v == int(v) ? "%dM" : "%.1fM"), v }'
  elif [ "$n" -ge 1000 ]; then
    awk -v n="$n" 'BEGIN { printf "%dk", int(n / 1000) }'
  else
    printf '%s' "$n"
  fi
}

fields=$(printf '%s' "$input" | jq -r '
  .context_window
  | select(. != null)
  | [(.used_percentage // 0), (.total_input_tokens // 0), (.context_window_size // "")]
  | join("|")
' 2>/dev/null)

if [ -z "$fields" ]; then
  printf '%sctx --%s' "$DIM" "$RESET"
  exit 0
fi

IFS='|' read -r used_pct used_tokens window_size <<< "$fields"

# Round used_pct to a whole number in case it arrives as a decimal.
used_pct=$(awk -v n="$used_pct" 'BEGIN { if (n ~ /^[0-9]+(\.[0-9]+)?$/) printf "%.0f", n; else print "" }')

if [ -z "$used_pct" ]; then
  printf '%sctx --%s' "$DIM" "$RESET"
  exit 0
fi

if [ "$used_pct" -ge 80 ]; then
  color=$RED
elif [ "$used_pct" -ge 50 ]; then
  color=$YELLOW
else
  color=$GREEN
fi

printf '%sctx %s%s%%%s %s(%s/%s)%s' \
  "$DIM" "$color" "$used_pct" "$RESET" \
  "$DIM" "$(format_tokens "$used_tokens")" "$(format_tokens "$window_size")" "$RESET"
