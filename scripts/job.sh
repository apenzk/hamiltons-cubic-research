#!/bin/bash
# Launch, list and kill this project's own background jobs -- safely.
#
# The danger with "find orphans and kill them" is that a PID is not an identity:
# the operating system reuses PIDs, so a number recorded minutes ago can name an
# unrelated process by the time it is used.  So every launch records BOTH the pid
# and the exact command line, and every kill re-reads the live command line and
# refuses unless it still matches what was recorded.
#
#   scripts/job.sh run <label> <cmd...>   launch in background, register it
#   scripts/job.sh list                   registered jobs, PLUS unregistered strays
#   scripts/job.sh kill <label|all>       kill only verified-matching jobs
#   scripts/job.sh reap                   drop dead entries from the registry
#
# `list` also scans for this repo's scripts running OUTSIDE the registry, because
# the registry only knows what was launched through it and the processes that
# outlive everything are the ad-hoc ones it never saw.  A run started by hand,
# whose shell then closed, is orphaned to PID 1 and invisible here -- one sat at
# 450 MB for 21 hours while `list` reported every entry dead.  A quiet registry
# is not a quiet machine, and now `list` says so itself.
#
# The registry lives in agent_logs/, which is gitignored.

REG="agent_logs/jobs/jobs.tsv"
# Job logs live in their own directory: the stop hook scans agent_logs for
# reviewer logs, and job output sitting beside them once silenced it.
mkdir -p agent_logs/jobs
touch "$REG"

live_cmd() { ps -p "$1" -o command= 2>/dev/null; }

case "$1" in
  run)
    label="$2"; shift 2
    log="agent_logs/jobs/${label}.log"
    nohup "$@" > "$log" 2>&1 &
    pid=$!
    sleep 0.3
    cmd="$(live_cmd "$pid")"
    # A row with an empty command line can never be reaped (empty matches empty)
    # and can never be verified, so record the argv we launched instead.
    [ -z "$cmd" ] && cmd="$*"
    printf '%s\t%s\t%s\t%s\n' "$pid" "$label" "$(date +%s)" "$cmd" >> "$REG"
    echo "launched $label pid=$pid log=$log"
    ;;
  list)
    # Drop dead rows before printing: a registry that accumulates months of
    # them buries the live entries and the strays underneath.
    "$0" reap >/dev/null 2>&1
    printf '%-8s %-22s %-9s %s\n' PID LABEL AGE STATE
    while IFS=$'\t' read -r pid label t cmd; do
      [ -z "$pid" ] && continue
      now=$(date +%s); age=$(( (now - t) / 60 ))
      cur="$(live_cmd "$pid")"
      if [ -z "$cur" ]; then state="dead"
      elif [ "$cur" = "$cmd" ]; then state="ALIVE (verified)"
      else state="pid reused -- NOT ours"; fi
      printf '%-8s %-22s %-9s %s\n' "$pid" "$label" "${age}m" "$state"
    done < "$REG"
    # Strays: this repo's own scripts running outside the registry.
    reg_pids="$(cut -f1 "$REG" | tr '\n' ' ')"
    ps -eo pid,etime,command | grep -E "scripts/(runs/|reviewers/|route-b/)?[A-Za-z0-9_]+\.py" \
      | grep -v grep | while read -r pid rest; do
        case " $reg_pids " in *" $pid "*) continue;; esac
        script="$(echo "$rest" | grep -oE "scripts/[A-Za-z0-9_/-]+\.py" | head -1)"
        printf '%-8s %-22s %-9s %s\n' "$pid" "UNREGISTERED" "$(echo "$rest" | awk '{print $1}')" "${script:-?} (not in registry)"
      done
    ;;
  kill)
    want="$2"
    while IFS=$'\t' read -r pid label t cmd; do
      [ -z "$pid" ] && continue
      [ "$want" = "all" ] || [ "$want" = "$label" ] || continue
      cur="$(live_cmd "$pid")"
      if [ -z "$cur" ]; then
        echo "skip $label pid=$pid: already gone"
      elif [ "$cur" != "$cmd" ]; then
        echo "REFUSED $label pid=$pid: command line no longer matches (pid reused)"
      else
        kill "$pid" && echo "killed $label pid=$pid"
      fi
    done < "$REG"
    ;;
  reap)
    tmp="$(mktemp)"
    while IFS=$'\t' read -r pid label t cmd; do
      [ -z "$pid" ] && continue
      [ -z "$cmd" ] && continue          # unverifiable row: drop it
      [ "$(live_cmd "$pid")" = "$cmd" ] && printf '%s\t%s\t%s\t%s\n' "$pid" "$label" "$t" "$cmd" >> "$tmp"
    done < "$REG"
    mv "$tmp" "$REG"; echo "registry reaped"
    ;;
  *) echo "usage: scripts/job.sh {run <label> <cmd...>|list|kill <label|all>|reap}"; exit 2;;
esac
