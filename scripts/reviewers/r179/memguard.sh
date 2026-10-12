#!/bin/sh
# memguard.sh <pid> <limit_kb> -- kill pid if RSS exceeds limit
PID=$1; LIM=$2
while kill -0 "$PID" 2>/dev/null; do
  R=$(ps -o rss= -p "$PID" 2>/dev/null | tr -d ' ')
  [ -z "$R" ] && break
  if [ "$R" -gt "$LIM" ]; then echo "MEMGUARD killing $PID at ${R}KB"; kill -9 "$PID"; break; fi
  sleep 5
done
