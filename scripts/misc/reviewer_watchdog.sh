#!/bin/sh
# Watchdog over reviewer subagents, armed by the dispatch.
#
# A completion notification is the normal return path and not a guarantee: an agent
# that dies mid-write sends nothing, and its log simply stops. Silence from a dead
# reviewer is indistinguishable from silence from a thinking one, and the loop's own
# liveness test reads any log touched recently as alive -- so a dead agent SILENCES
# the supervisor rather than tripping it, and the round waits on a corpse.
#
# This exits, and so notifies, the moment either is true of a watched reviewer:
#   * its log has not been written for STALE seconds, or
#   * every watched reviewer has closed its log with DONE or FAILED.
#
# COMPLETION IS THE CLOSING LINE AND NOTHING ELSE. An earlier version also treated the
# existence of reviews/REVIEW_<r>.md as completion, which the skeleton-report rule made
# true in every reviewer's FIRST phase: the watchdog then exited seconds after every
# dispatch, reporting success, and no round has been supervised since. Two rules each
# right, and their interaction disarmed the supervisor.
#
# Usage:  reviewer_watchdog.sh <stale-seconds> <log> [<log> ...]
# Registers each log with $CLAUDE_CODE_SESSION_ID in .claude/reviewers-in-flight first.
set -u
STALE="$1"; shift
# REGISTER THE WATCHED LOGS WITH THIS SESSION, so loop_stop.py counts them as in flight for
# this session only and a sibling session's reviewers never silence this session's Stop.
REPO=$(cd "$(dirname "$0")/../.." && pwd)
if [ -n "${CLAUDE_CODE_SESSION_ID:-}" ]; then
  for log in "$@"; do
    case "$log" in /*) abs="$log" ;; *) abs="$REPO/$log" ;; esac
    printf '%s\t%s\n' "$CLAUDE_CODE_SESSION_ID" "$abs" >> "$REPO/.claude/reviewers-in-flight"
  done
fi
while :; do
  alive=0
  for log in "$@"; do
    name=$(basename "$log" .log | sed 's/.*-//')
    # A reviewer commits a SKELETON report in its first phase, so the report file exists from
    # phase 0 onward and its presence says nothing about completion. The closing line is the
    # only completion signal, anchored so a heartbeat naming the word mid-line is not one.
    # The prefix class matches loop_stop.py and salvage_reviewer.py: a date and a time separated by a space,
    # or a bracketed stamp, may precede the word, and the word may be lowercase. A narrower class read a
    # correctly closed "YYYY-MM-DD HH:MM:SS DONE" log as silent and reported a finished reviewer dead.
    # A closing line may also carry a note before the word ("07:38:40 report committed. DONE r1797: ..."),
    # so the word followed by the reviewer's own id closes the log wherever it stands, as in loop_stop.py.
    last=$(tail -n 1 "$log" 2>/dev/null)
    printf '%s' "$last" | grep -qiE '^[][[:space:]0-9:.TZ+-]*(DONE|FAILED)' && continue
    printf '%s' "$last" | grep -qE '(DONE|FAILED)[[:space:]]+r[0-9]+' && continue
    if [ ! -f "$log" ]; then alive=1; continue; fi
    age=$(( $(date +%s) - $(stat -f %m "$log" 2>/dev/null || stat -c %Y "$log") ))
    if [ "$age" -gt "$STALE" ]; then
      echo "WATCHDOG: $name looks dead -- log silent ${age}s, no report, no DONE line."
      echo "Treat it as lost, or resume it with SendMessage before folding the round."
      exit 1
    fi
    alive=1
  done
  if [ "$alive" -eq 0 ]; then
    # DEREGISTER WHAT IT REPORTS FINISHED, so loop_stop.py stops reading these logs as in flight.
    # Left registered, a log whose closing line the hook cannot read silences the Stop hook for hours.
    reg="$REPO/.claude/reviewers-in-flight"
    if [ -n "${CLAUDE_CODE_SESSION_ID:-}" ] && [ -f "$reg" ]; then
      for log in "$@"; do
        case "$log" in /*) abs="$log" ;; *) abs="$REPO/$log" ;; esac
        grep -v -F -x "$(printf '%s\t%s' "$CLAUDE_CODE_SESSION_ID" "$abs")" "$reg" > "$reg.tmp.$$"
        mv "$reg.tmp.$$" "$reg"
      done
    fi
    echo "WATCHDOG: every watched reviewer has finished."
    exit 0
  fi
  sleep 20
done
