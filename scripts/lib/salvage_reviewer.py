"""Write a stopped reviewer's log into reviews/ as a partial report, AFTER it is stopped.

WHY THIS EXISTS.  On 2026-08-24 three reviewers -- 77, 78 and 79 -- were stopped or never
filed, and 25 log lines of real findings evaporated with them.  Reviewer 79 had
independently confirmed HP^2 after three hours; Reviewer 78's verdicts were cited twice in
findings/INDEX.md before anyone noticed its report had never been written at all.  A reviewer's
log is the only durable trace of work in flight, and stopping the agent is exactly the
moment that trace stops being recoverable.

USE:  python3 scripts/lib/salvage_reviewer.py 79 --stopped   -- AFTER the agent is stopped.

IT ALSO CLOSES THE LOG.  A reviewer killed mid-flight leaves a log ending in a
heartbeat, and the loop's Stop hook reads any log without a DONE/FAILED closing
line as a reviewer still working -- so a corpse SILENCES the loop rather than
blocking it, and nothing is emitted.  Appending the closing line here makes the
salvage and the closure one action instead of two, the second of which was
remembered only sometimes.

It writes reviews/REVIEW_rNN.md marked PARTIAL, carrying the log verbatim, and refuses to
overwrite a real report that already exists.
"""
import os
import glob
import re, sys, datetime

# THREE LEVELS, BECAUSE THIS FILE LIVES IN scripts/lib/.  Two levels reached
# scripts/ rather than the repository, so every lookup ran against
# scripts/agent_logs/ and scripts/reviews/, neither of which exists, and the tool
# answered "nothing to salvage" for every reviewer it was ever pointed at.  A path
# computed by counting directories breaks silently when the file is moved, so it is
# checked against a directory that must exist.
ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
assert os.path.isdir(os.path.join(ROOT, 'agent_logs')), (
    f"ROOT resolved to {ROOT}, which has no agent_logs/: this file has moved and the "
    "level count above is stale")



# THE CLOSING-LINE PREDICATE, COPIED FROM loop_stop.py's own.  Two hand-written copies
# of one rule drift, and this pair did: the reader allowed a leading timestamp and the
# writer did not, so a timestamped DONE was treated as an open log.
CLOSED = re.compile(r"[\s\[\]0-9:.\-TZ]*(DONE|FAILED)\b", re.I)  # re.I: a lowercase `done` closed a log and got FAILED written under it (r907)


def _close_log(log):
    """Append the closing line an interrupted reviewer never wrote.

    The loop's Stop hook reads a log without a DONE/FAILED closing line as a
    reviewer still working, so an unclosed corpse SILENCES the loop instead of
    blocking it -- the one failure mode that emits nothing.

    IT CLOSES ONLY AN OPEN LOG, and the predicate is COPIED FROM loop_stop.py rather
    than described as matching it: an anchored DONE or FAILED among the last six
    non-blank lines, with a LEADING TIMESTAMP ALLOWED.  A first version allowed only
    whitespace, so a reviewer logging `2026-09-12T18:49Z DONE ...` got FAILED written
    beneath its own success, in 350 of 1502 logs on disk, while the docstring claimed to
    use loop_stop's predicate (r905 asked for the predicate, r906 found the copy wrong).  Appending
    unconditionally stacked one line per run, and worse, put this tool's FAILED
    underneath a reviewer's own DONE -- after which the watchdog reads a successful
    reviewer as failed while the Stop hook still reads it as done (r905).
    """
    try:
        # THE WINDOW IS THE HOOK'S WINDOW TOO, non-blank lines among the last six
        # PHYSICAL ones.  Taking the last six non-blank lines is strictly wider, so a
        # `DONE` sixth from the end with a blank line beneath it reads closed here and
        # OPEN to the hook, which is the direction that silences the loop (r907, latent:
        # no log on disk sits in that split).
        physical = open(log, encoding='utf-8', errors='replace').read().split('\n')[-6:]
        tail = [l for l in physical if l.strip()]
        if any(CLOSED.match(l) for l in tail):
            return ''
    except OSError:
        return ''
    try:
        with open(log, 'a', encoding='utf-8') as fh:
            # LEADING NEWLINE IS LOAD-BEARING.  A log whose last write lacked one
            # would otherwise concatenate, leaving the closing marker inside the
            # final heartbeat -- so the corpse still silences the loop while this
            # script prints "log closed".  The earlier fix was verified only against
            # a log that happened to end in a newline.
            fh.write('\nFAILED closed by scripts/lib/salvage_reviewer.py\n')
        return ', log closed'
    except OSError:
        return ''

def salvage(n, stopped=False):
    # THE LOG NAME IS WHATEVER THE BRIEF CHOSE, SO IT IS FOUND BY SEARCH AND NEVER
    # BY A LIST OF NAMES.  A fixed list was tried twice and missed twice: first it
    # knew only reviewer<N>.log, then it learned r<N>.log and gate2_<N>.log, and the
    # loop had meanwhile moved to review-r<N>-<topic>.log.  Each time the salvage
    # reported "nothing to salvage" for a log sitting beside it, which is the worst
    # possible failure for a tool whose whole job is to run at the moment a trace
    # stops being recoverable.  A glob cannot go stale as the naming drifts.
    cands = [q for q in
             glob.glob(os.path.join(ROOT, 'agent_logs', f'*r{n}[-_.]*.log'))
             + glob.glob(os.path.join(ROOT, 'agent_logs', f'*r{n}.log'))
             + glob.glob(os.path.join(ROOT, 'agent_logs', f'*reviewer{n}.log'))
             # gate2_<N>.log was one of the three names the glob replaced, and dropping it
             # was a REGRESSION rather than a simplification: 141 logs carry it.
             + glob.glob(os.path.join(ROOT, 'agent_logs', f'*gate2_{n}.log'))
             # a watchdog names the reviewers it watches, so its log matches the same
             # glob and is usually the newer file.  It holds no findings.
             if 'watchdog' not in os.path.basename(q)]
    cands.sort(key=lambda q: -os.path.getmtime(q))
    log = cands[0] if cands else os.path.join(ROOT, 'agent_logs', f'r{n}.log')
    out = os.path.join(ROOT, 'reviews', f'REVIEW_r{n}.md')
    # THE CALLER MUST ASSERT THE REVIEWER IS STOPPED, BECAUSE NOTHING HERE CAN KNOW.
    # This tool appends a FAILED line so a supervisor stops reading a corpse as a
    # worker, and that inverts on a LIVE reviewer: the closing line says a reviewer
    # still deriving has finished, so the round is folded without it and its log is
    # corrupted.  A staleness window cannot decide it: measured gaps in real reviewer
    # logs are UNBOUNDED above, and the two errors are asymmetric: closing a live log
    # costs the round, waiting costs nothing.  Measured over 411 reviewer logs, 9.2%
    # have a gap past 900s and 3.9% past 1800s, worst 135.7 minutes, so long gaps are a
    # TAIL rather than the common case (r905, correcting the first version of this
    # comment).  A threshold set beyond the worst observed gap is still a guess about
    # the next one, which is why no threshold is used.  So the default REFUSES and the
    # caller says `--stopped`, a claim only the caller can make.
    if not stopped:
        return (f"r{n}: refusing, because this closes the log and a closed log tells the "
                f"supervisor the reviewer has finished. Silence is NOT death here, gaps in "
                f"live logs being unbounded above, so nothing this tool can read decides it. "
                f"Stop the agent first, then pass --stopped")

    if os.path.exists(out):
        # REFUSE ANY existing report, a PARTIAL included.  A second run gains nothing and
        # loses something: the first run appended a closing line to the log, so the next
        # PARTIAL carries the tool's own output as though the reviewer had logged it.
        head = open(out, encoding='utf-8').read(400)
        # THE MARKER IS THIS SCRIPT'S OWN TITLE LINE, not the word anywhere in the head:
        # a real report whose standfirst mentions a partial read as one (r905, r906).
        kind = 'PARTIAL' if 'PARTIAL (salvaged from its log)' in head else 'report'
        return (f"r{n}: reviews/REVIEW_r{n}.md already exists as a {kind}, "
                f"not overwritten{_close_log(log)}")
    if not os.path.exists(log):
        # RESTORED.  Deleting this branch turned a clean "nothing to salvage" into a
        # FileNotFoundError traceback, which is the worst answer for a tool run at the
        # moment a trace stops being recoverable (r905).
        return f"r{n}: no log matching agent_logs/*r{n}*.log, nothing to salvage"
    lines = open(log, encoding='utf-8', errors='replace').read().rstrip().split('\n')
    body = [
        f"# Reviewer {n}, PARTIAL (salvaged from its log)",
        "",
        f"**This reviewer did not file a report.** Salvaged {datetime.date.today()} from "
        f"`{os.path.relpath(log, ROOT)}` at the moment it was stopped, so the findings it had "
        "already reached are not lost. **Nothing here has been reconciled against the record, "
        "and none of it should be cited as a verdict**, a partial reviewer's numbers are "
        "exactly the kind that get propagated wrongly (see Reviewer 78, whose unverified "
        "quadric values reached findings/INDEX.md for a commit).",
        "",
        f"Its phase plan and every line it logged, verbatim, {len(lines)} lines:",
        "",
        "```",
        *lines,
        "```",
        "",
        "## What to do with this",
        "",
        "Either re-launch a reviewer on the same brief and let it finish, or rebuild any "
        "number above from the object's own definition before recording it. Do not fold it "
        "into the record as-is.",
    ]
    os.makedirs(os.path.dirname(out), exist_ok=True)
    open(out, 'w', encoding='utf-8').write('\n'.join(body) + '\n')
    # CLOSE THE LOG in the same action.  A reviewer killed mid-flight leaves a log
    # ending in a heartbeat, and the loop's Stop hook reads any log without a
    # DONE/FAILED closing line as a reviewer still working -- so a corpse SILENCES
    # the loop rather than blocking it, and nothing is emitted at all.  Closing it
    # here means the salvage and the closure cannot come apart; as two steps, the
    # second was remembered only sometimes.
    # ONE closer, used by every path.  A second inline copy of this write is how
    # the leading-newline fix reached one path and not the other.
    return (f"r{n}: salvaged {len(lines)} log lines from {os.path.relpath(log, ROOT)} -> "
            f"reviews/REVIEW_r{n}.md (PARTIAL){_close_log(log)}")


if __name__ == '__main__':
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    stopped = '--stopped' in sys.argv[1:]
    if not args:
        sys.exit(__doc__)
    for a in args:
        print(" ", salvage(int(a), stopped=stopped))
