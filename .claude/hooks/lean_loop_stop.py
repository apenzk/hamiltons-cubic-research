#!/usr/bin/env python3
"""Stop hook: while a lean-loop round is active, continuation is the default.

THE FAILURE THIS ADDRESSES.  A lean-loop round ends with a green build and a
committed index row, and that reads like a finishing line.  It is not one: the
queue names the next id, and the loop's own phase 5 says to open it in the same
turn.  Across the rounds run by hand, every stop had the same cause -- the round
closed cleanly and the turn ended to report it.  A clean commit is not a
stopping point.

PROTOCOL.  To end a turn, first write the reason:

    printf 'session: %s\nlean-queue-empty: <why>\n' "$CLAUDE_CODE_SESSION_ID" > .claude/stop-declared

The hook consumes that file and allows the stop.  With no such file it exits 2,
which blocks the ending and feeds the next action back.

Inert unless .claude/lean-loop-active names THIS session, so it never touches
the research loop's threads or an unrelated one in the same repository.

BYPASS.  The user interrupting always wins; this only stops the loop ending
itself out of tidiness.
"""
import os
import sys
import json

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from loop_flag import armed_for, mark_stop_seen, stop_seen_this_event, check_stop_reason, declaration_for, DECLARE_HOW  # noqa: E402

FLAG = "lean-loop-active"



def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0
    cwd = os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or os.getcwd()
    if not armed_for(payload, cwd, flag=FLAG):
        return 0

    declared = os.path.join(cwd, ".claude", "stop-declared")
    state, reason = declaration_for(cwd, payload)
    # A DECLARATION ALREADY CONSUMED UPSTREAM, BY THIS SESSION, STILL COUNTS (r1039).
    if state != "mine" and stop_seen_this_event(cwd, payload):
        print("lean loop: stop allowed -- declared and consumed upstream this turn",
              file=sys.stderr)
        return 0
    if state == "mine":
        ok, msg = check_stop_reason(reason)
        try:
            if not ok:
                os.remove(declared)
                print(msg, file=sys.stderr)
                return 2
            mark_stop_seen(cwd, payload)
            os.remove(declared)
        except OSError:
            pass
        print(f"lean loop: stop allowed -- {reason}", file=sys.stderr)
        return 0
    # "other" and "unbound" declarations are left in place for their owner.
    note = (" An UNBOUND .claude/stop-declared is present and was ignored; " + DECLARE_HOW + "."
            if state == "unbound" else "")

    print(
        "lean loop: a round closed, which is not a stopping point. Take the next "
        "row from lean/INDEX.md and open its round now -- phase 0 reads the "
        "verifying script and the stored data before the findings block, and "
        "phase 1 splits the claim before anything is formalised. "
        "A green build and a committed index row are what a round produces, not "
        "where it ends. "
        "To stop instead, write the reason to .claude/stop-declared first, its first line `session: $CLAUDE_CODE_SESSION_ID` and the reason opening with a tag (`lean-queue-empty:`, `lean-unsupported:`, `lean-disagreement:`, `waiting:`, `user:`): an "
        "empty queue, an `unsupported` verdict needing the user's call, or a "
        "Lean disagreement that survived re-statement and belongs to the "
        "verification loop." + note,
        file=sys.stderr,
    )
    return 2


if __name__ == "__main__":
    sys.exit(main())
