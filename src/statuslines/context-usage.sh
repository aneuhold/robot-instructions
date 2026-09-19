#!/bin/bash
# Claude Code status line. Shows the session's context-window usage and prompt cache warmth.

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

# Whole minutes left, or <1m under a minute: 2530 -> 42m.
format_remaining() {
  if [ "$1" -ge 60 ]; then
    printf '%dm' $(($1 / 60))
  else
    printf '<1m'
  fi
}

fields=$(printf '%s' "$input" | jq -r '
  [
    (.context_window | if . then .used_percentage // 0 else "" end),
    (.context_window.total_input_tokens // 0),
    (.context_window.context_window_size // ""),
    (.prompt_cache | if . == null then "" elif .warm and (.expires_at // 0) > now then "warm" else "stale" end),
    ((.prompt_cache.expires_at // now) - now | floor)
  ]
  | join("|")
' 2>/dev/null)

IFS='|' read -r used_pct used_tokens window_size cache_state cache_seconds_left <<< "$fields"

ctx_segment() {
  # Round used_pct to a whole number in case it arrives as a decimal.
  local pct color
  pct=$(awk -v n="$used_pct" 'BEGIN { if (n ~ /^[0-9]+(\.[0-9]+)?$/) printf "%.0f", n; else print "" }')

  if [ -z "$pct" ]; then
    printf '%sctx --%s' "$DIM" "$RESET"
    return
  fi

  if [ "$pct" -ge 80 ]; then
    color=$RED
  elif [ "$pct" -ge 50 ]; then
    color=$YELLOW
  else
    color=$GREEN
  fi

  printf '%sctx %s%s%%%s %s(%s/%s)%s' \
    "$DIM" "$color" "$pct" "$RESET" \
    "$DIM" "$(format_tokens "$used_tokens")" "$(format_tokens "$window_size")" "$RESET"
}

cache_segment() {
  case $cache_state in
    warm) printf '%scache %swarm%s %s(%s)%s' "$DIM" "$GREEN" "$RESET" "$DIM" "$(format_remaining "$cache_seconds_left")" "$RESET" ;;
    stale) printf '%scache %sstale%s' "$DIM" "$RED" "$RESET" ;;
    *) printf '%scache --%s' "$DIM" "$RESET" ;;
  esac
}

printf '%s %s·%s %s' "$(ctx_segment)" "$DIM" "$RESET" "$(cache_segment)"
