#!/usr/bin/env python3
"""Stop hook: while a research-loop cycle is active, continuation is the default.

PROTOCOL. To end a turn, first write the reason to .claude/stop-declared, bound to
this session by its first line, e.g.

    printf 'session: %s\neffort: the escalated derivation is on disk, the drop is owed\n' "$CLAUDE_CODE_SESSION_ID" > .claude/stop-declared

The hook consumes that file and allows the stop. With no such file it exits 2,
which blocks the ending and feeds a message back, so the next cycle action is
taken instead.

Two things it decides for itself rather than trusting memory:

  * If any file in the research-loop skill folder is modified or
    staged-but-uncommitted, the cycle changed the
    skill and owes the user an approval pause.  The hook says so and blocks
    the RESUMPTION rather than the stop -- this is the one case where being
    pushed onward is the wrong outcome, and it is objectively detectable.

  * If the cycle owes a Gate 2 -- feat/fix commits have accumulated since the last
    reviews/REVIEW_r*.md landed -- it says so and blocks the RESUMPTION rather than the stop,
    like the SKILL.md case.  This is the second thing it decides rather than trusting
    memory, and it was added because the hook itself caused the failure: enforcing
    continuation alone, it named the next plan.md item after every commit and pushed
    "start it NOW", routing past step 2 every time a unit closed.  Seventeen feat/fix
    commits went by in one session against a single review, and that review found four
    claims that were wrong rather than overstated.

  * Otherwise it reads the top live item out of plan.md and names it, so the
    block hands over a concrete task instead of a rule to re-derive.  The
    failure this addresses is not forgetting the rule; it is that a clean
    commit or a tidy record feels like a finished unit, and a reminder to
    "take the next action" loses to that feeling while a named task does not.

Inert unless .claude/research-loop-active names THIS session -- see loop_flag.py;
a bare marker used to arm the hook in every session in the repository, so threads
doing unrelated work were told to start the next plan.md item.  Enforcement is counted rather
than capped at one: .claude/stop-blocks tracks how many continuations have been
forced since the last user message, and the hook stands down once they stop producing
work so a genuine ending stays reachable.  WHAT IS CAPPED IS FUTILITY RATHER THAN
LENGTH: the counter resets on a new commit, so a loop closing rounds runs on, and one
spinning on a task it cannot finish is stood down after MAX_BLOCKS.  Trusting
stop_hook_active alone allowed exactly one block per user message, leaving every later
ending in a long turn unchecked.
"""
import json
import os
import re
import subprocess
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import loop_flag

MAX_BLOCKS = 6      # FUTILE continuations allowed before standing down
MAX_BLOCKS_HARD = 60   # continuations allowed in total, however much progress lands


def _head(cwd):
    """The current commit, or "" when git cannot answer."""
    try:
        out = subprocess.run(["git", "rev-parse", "HEAD"],
                             cwd=cwd, capture_output=True, text=True, timeout=10)
        return out.stdout.strip()
    except Exception:
        return ""


_UNBOUND_NOTE = ""


def _counter_name():
    """The block counter is PER SESSION: a shared one let one session's blocks and
    resets decide another's stand-down."""
    return "stop-blocks-" + _SESSION if _SESSION else "stop-blocks"


def _bump(claude_dir, blocks, head="", total=0):
    """Record the block, the commit it was forced at, and the running total.

    THE COUNTER BOUNDS FUTILE CONTINUATIONS, NOT PRODUCTIVE ONES.  A flat cap per
    user message treats a loop closing rounds and a loop spinning on a task it
    cannot finish as the same thing, and stands down on both -- so an unattended
    run ends after a handful of blocks while it is working.  What separates the two
    is whether work LANDS: a commit is this record's unit of work, so the counter
    resets whenever HEAD has moved since the last block, and climbs only while
    nothing does.  A hard ceiling still bounds the pathological case where the
    session commits repeatedly without advancing.
    """
    try:
        with open(os.path.join(claude_dir, _counter_name()), "w") as fh:
            fh.write("%d\n%s\n%d\n" % (blocks + 1, head, total + 1))
    except OSError:
        pass


CONDITIONS = (
    "the user interrupted or said to stop; a strategic fact fired (step 9's "
    "reach gate on a census or single-value reach); a decision belongs to "
    "the user and has an open entry in DECISIONS-TO-MAKE.md; a task has "
    "stalled across five cycles; or the conjecture is proven."
)


def _skill_dirty(cwd):
    """Names of files anywhere in the research-loop skill folder with uncommitted
    changes -- staged or not.  The whole folder counts, not SKILL.md alone: the
    guidance a cycle actually follows is spread across every file in it, so a
    change to any of them is a change to the skill and owes the same approval.

    EVERY SKILL COUNTS, NOT ONLY THE ONE DRIVING THE RUN.  Naming one folder let
    the other six be rewritten with nothing owed to the user, and the rules for
    editing any of them live in a skill of their own -- so a change to that one
    silently changes how all the rest may be changed."""
    try:
        out = subprocess.run(
            ["git", "status", "--porcelain", "--", ".claude/skills/"],
            cwd=cwd, capture_output=True, text=True, timeout=10,
        )
        names = []
        for line in out.stdout.splitlines():
            path = line[3:].strip().strip('"')
            if path:
                names.append(path.rsplit("/", 1)[-1])
        return names
    except Exception:
        return []


MAX_SKILL_WORDS = 120   # words a single cycle may ADD to the skill folder


def _skill_diff_words(cwd):
    """Words ADDED in the skill folder, staged and unstaged together, counted at
    word granularity.

    A ceiling rather than a review, because the failure it catches is not a wrong
    rule but a long one: a cycle writes the lesson, then the reasoning behind the
    lesson, then the incident that produced it, and the result is three paragraphs
    where the rule is one sentence.  Length is the one property of a skill edit a
    hook can judge, and it correlates well enough with the problem to be worth
    gating on.

    THE COUNT IS WORD-LEVEL BECAUSE THESE FILES ARE NEVER HARD-WRAPPED.  A line
    diff scores a paragraph as wholly added when a single clause inside it changed,
    so a six-word sharpening of a long sentence read as three hundred words and was
    refused, while appending a short new paragraph passed.  That inverts the rule
    this gate serves, which asks for compression rather than accretion -- so the
    measure has to see the words that actually arrived.

    AND AN UNTRACKED FILE COUNTS ITS WHOLE CONTENT, BECAUSE `git diff` CANNOT SEE ONE.
    The dirty check reads `git status`, which reports a new file, while the measure read
    `git diff HEAD`, which does not -- so a wholly new file in the skill folder measured
    zero words and walked past the ceiling.  That is exactly the shape a promotion into
    a new practice file takes, which is the case the ceiling most needs to hold.
    """
    total = 0
    try:
        out = subprocess.run(
            ["git", "diff", "HEAD", "--word-diff=porcelain", "--",
             ".claude/skills/"],
            cwd=cwd, capture_output=True, text=True, timeout=10,
        )
        added = sum(len(l[1:].split()) for l in out.stdout.splitlines()
                    if l.startswith("+") and not l.startswith("+++"))
        removed = sum(len(l[1:].split()) for l in out.stdout.splitlines()
                      if l.startswith("-") and not l.startswith("---"))
        # A REWRITE IS NOT ACCRETION, AND THE CEILING IS AIMED AT ACCRETION.
        # Repunctuating a paragraph replaces a word with a word: every clause that
        # loses a dash gains a comma, so the added and removed counts move together
        # and the file says exactly what it said before.  Counting gross additions
        # scores such a pass in the hundreds and refuses it, which reads to the next
        # cycle as a rule it may not write when no rule changed at all.  The NET is
        # what a reader of the rules pays for, so that is what is gated.
        total += max(0, added - removed)
    except Exception:
        return 0
    try:
        out = subprocess.run(
            ["git", "ls-files", "--others", "--exclude-standard", "--",
             ".claude/skills/"],
            cwd=cwd, capture_output=True, text=True, timeout=10,
        )
        for rel in out.stdout.split():
            try:
                with open(os.path.join(cwd, rel), encoding="utf-8") as fh:
                    total += len(fh.read().split())
            except OSError:
                pass
    except Exception:
        pass
    return total


PROMOTE_AT = 80   # proposal total that authorises a skill edit in LOCKED mode


def _promotable(cwd):
    """The highest proposal total that authorises an unreviewed skill edit, or None.

    A row qualifies at `PROMOTE_AT` or above with no `HOLD` in its action column,
    which is column 6 of the table and is read as that cell rather than as a
    substring of the line: the marker is a word that occurs innocently in prose
    (`threshold`, `placeholder`) and is spelled `held` elsewhere in the same file,
    so a line-wide search both over-vetoes and under-vetoes.

    THE THRESHOLD SITS AT THE WIDEST GAP IN THE DISTRIBUTION, 72 TO 81, AND THAT IS
    THE WHOLE OF ITS JUSTIFICATION.  A bar at 70 lands five rows tied at exactly 72
    and sits two points from them, so a one-point re-score flips an irreversible
    action; 80 sits nine points clear.  What it does NOT do is require a critical
    occurrence: impact 10 with importance 8, or impact 8 with importance 10, reaches
    exactly 80 without one, so the incident-grouping route the raise was meant to
    narrow is reduced rather than closed.

    `HOLD` VETOES REGARDLESS OF SCORE.  It marks a total whose occurrence count or
    critical mark is not yet trustworthy, so a row carrying it has not earned the
    edit however high it scores, and without this the number becomes decoration
    while `HOLD` does the real work.

    The hook cannot check that the staged edit is the rule that row describes, and
    does not pretend to: what it enforces is that some rule has earned promotion
    and that the edit stays inside the word ceiling.  The correspondence is the
    author's to get right and the user's to see, which is why the edit is reported
    verbatim."""
    path = os.path.join(cwd, ".claude", "skill-proposals.md")
    try:
        with open(path, encoding="utf-8") as fh:
            best = None
            for line in fh:
                m = re.match(r"^\|\s*\d+\s*\|\s*\*\*(\d+)\*\*\s*\|", line)
                if not m:
                    continue
                cells = line.split("|")
                action = cells[6] if len(cells) > 6 else ""
                if any(k in action.upper() for k in ("HOLD", "PROMOTED", "RETIRED")):
                    continue  # a ledger row records a finished promotion and earns nothing
                total = int(m.group(1))
                if total >= PROMOTE_AT and (best is None or total > best):
                    best = total
            return best
    except Exception:
        return None


MAX_UNREVIEWED = 3   # feat/fix commits allowed before Gate 2 is owed


def _unreviewed_commits(cwd):
    """How many feat/fix commits since the newest reviews/REVIEW_r*.md was added.

    Both pathspecs are passed: reviewer files moved from the repo root into reviews/
    on 2026-08-24, and the old path must stay so the history still counts.

    Returns (count, last_review) with last_review the newest reviewer file seen, or
    None if there is none.  Housekeeping commits -- docs, chore, refactor, test -- do
    not count, matching the cycle_deliverable trailer rule.
    """
    try:
        out = subprocess.run(
            ["git", "log", "--diff-filter=A", "--format=%H", "-1", "--",
             "reviews/REVIEW_r*.md", "REVIEW_r*.md"],
            cwd=cwd, capture_output=True, text=True, timeout=10,
        )
        sha = out.stdout.strip().split("\n")[0] if out.stdout.strip() else ""
        rng = [sha + "..HEAD"] if sha else []
        out = subprocess.run(
            ["git", "log", "--format=%s"] + rng,
            cwd=cwd, capture_output=True, text=True, timeout=10,
        )
        subjects = [l for l in out.stdout.split("\n") if l.strip()]
        n = sum(1 for l in subjects if l.startswith("feat(") or l.startswith("fix("))
        return n, (sha[:7] if sha else None)
    except Exception:
        return 0, None


def _next_verify_task(cwd):
    """The In-flight line, or the first unchecked id, from plan-verification.md.

    The verification loop's own queue -- never plan.md, which belongs to the
    research loop and would hand this loop a SECTION 1 item after every round.
    """
    try:
        with open(os.path.join(cwd, "plan-verification.md"), encoding="utf-8") as fh:
            text = fh.read()
    except OSError:
        return None
    for line in text.split("\n"):
        if line.startswith("**In flight:**") and "none" not in line[:40]:
            return line[len("**In flight:**"):].strip().rstrip(".")[:160]
    # Ids carry suffixes -- "L148-r2" for a corrected text, "L149-F" for a
    # carried-findings round -- and a parser that reads only "L\d+" walks past
    # those rows silently and names a tier 0 id instead. That happened to
    # "F7, F9, ..." for six rounds and to every "-r2" row.
    m = re.search(r"^- \[ \] \*\*([A-Z]\d+(?:-[A-Za-z0-9]+)?)\*\*", text, re.M)
    return m.group(1) if m else None


PLAN_BUDGET_KB = 60   # a net for a plan that escaped step 7, not the step's definition


def _plan_overrun(cwd):
    """The plan's size against its budget, and the items carrying mathematics.

    The rule that the plan holds the task and not the record is in step 6 and was
    correct for as long as the plan took to reach seven times its budget with one
    item at 18 kB. A plan that grows by a paragraph a cycle looks the same at the
    head of the next one, so the breach is named as the task rather than left to be
    noticed."""
    try:
        with open(os.path.join(cwd, "plan.md"), encoding="utf-8") as fh:
            lines = fh.read().split("\n")
    except OSError:
        return None
    total = len("\n".join(lines)) / 1024.0
    if total <= PLAN_BUDGET_KB:
        return None
    # The ITEM LINE is the signal, not the block. An item written to spec runs to
    # several lines -- status, route, what is owed, a pointer -- and measuring the
    # block penalises exactly that while a paragraph crammed onto one line passes.
    fat = [re.sub(r"\*\*|\[|\]\([^)]*\)|\$", "", l[6:])[:52]
           for l in lines if l.startswith("- [ ] ") and len(l) > 700]
    return (total, fat)


def _unreachable_top(cwd):
    """Does the TOP of the graded table touch the remaining open statement?

    Step 1's rubric grades `closes` against one named statement and nothing else, and
    a 3 there means the item would close it outright.  An item can score well on the
    PRODUCT while scoring 2 or less on `closes`, and a plan whose top item does that
    is honest, correctly ordered, and unable to reach the goal by being worked.

    The skill's answer is explicit -- invent a route, which is step 9 -- and it was
    walked past for a whole session because nothing measures it.  The grade table is
    rewritten every cycle, so the condition is checked there rather than remembered.

    Returns (top_label, top_value, top_closes, [(id, value) for closes==3]) or None."""
    try:
        with open(os.path.join(cwd, "plan.md"), encoding="utf-8") as fh:
            text = fh.read()
    except OSError:
        return None
    rows = []
    for m in re.finditer(
            r"^\|\s*\*\*(I[0-9a-z]+)\*\*\s*\|(?:[^|]*\|){1}\s*\**(\d)\**\s*\|"
            r"\s*\**(\d)\**\s*\|\s*\**(\d)\**\s*\|\s*\**(\d)\**\s*\|"
            r"\s*\**(\d+)\**\s*\|", text, re.M):
        ident, closes, attack, margin, analytic, value = m.groups()
        rows.append((ident, int(closes), int(attack), int(value),
                     int(margin), int(analytic)))
    # A MIS-PARSE THAT PRODUCES PLAUSIBLE NUMBERS IS WORSE THAN NO PARSE, and silence
    # on a drifted table is how a gate stops working without anyone noticing.  Two
    # checks, both using the table's own redundancy rather than a second source:
    #   * the regex must find as many rows as the table HAS item lines;
    #   * every row's `value` must equal the product of its four factors.
    # Either failing means the columns moved, so the gate says so LOUDLY instead of
    # passing.  An extra numeric column silently shifted every field by one and the
    # value was being read from `analytic` (r1080).
    item_lines = len(re.findall(r"^\|\s*\*\*I[0-9a-z]+\*\*\s*\|", text, re.M))
    # AND A ROW AGAINST ITS ITEM'S OWN PROSE.  The arithmetic check above compares the
    # table to ITSELF, so one self-consistent fabricated row steers the verdict with no
    # complaint -- and the live table held an instance, I36's row reading 6 while its
    # bullet read 3 (r1081).  The plan already writes the grade twice; compare them.
    prose = {}
    for m in re.finditer(r"^- \[[ x]\] \*\*(I[0-9a-z]+),.*?Grade \*\*(\d+)\*\*", text, re.M):
        prose[m.group(1)] = int(m.group(2))
    mismatch = [r[0] for r in rows if r[0] in prose and prose[r[0]] != r[3]]
    bad = [r[0] for r in rows if r[3] != r[1] * r[2] * r[4] * r[5]]
    if not rows or len(rows) != item_lines or bad or mismatch:
        return ("PARSE", item_lines, len(rows), (bad + mismatch)[:5])
    # TIE-BREAK ON `closes`, NOT ON ROW ORDER.  `max` on value alone returns the FIRST
    # maximal row, so two items tied at the top with one of them closing the statement
    # made the gate fire or not depending on which was typed first (r1080).
    top = max(rows, key=lambda r: (r[3], r[1]))
    # A CLOSER WITH A ROUTE AND A CLOSER WITHOUT ONE NEED OPPOSITE ACTIONS, and a gate
    # that says "invent a route" while one is already built wastes the step it names.
    # `attackable` >= 2 IS the route existing: 3 untried, 2 partly spent, 1 must be
    # invented, 0 every named route closed.
    closers = [(r[0], r[3], r[2]) for r in rows if r[1] >= 3]
    routed = [c for c in closers if c[2] >= 2]
    if top[1] >= 3:
        # A CLOSER THAT NOBODY CAN START IS NOT A REACHABLE TOP, and reading `closes`
        # alone made the gate quiet in exactly that state.  Worse, it made the gate
        # REWARD downgrading the only startable non-closer: drop that row's value below
        # an unstartable closer's and the check goes silent (r1082).  `attackable` is
        # already computed three lines up; the test now consults it.
        if top[2] >= 2:
            return None                  # closes the statement AND can be started
        return ("STALLED", top[0], top[3], top[2], closers, routed)
    return (top[0], top[3], top[1], closers, routed)


def _next_task(cwd):
    """The top live item from plan.md's 'Live work' section, as a short label."""
    try:
        with open(os.path.join(cwd, "plan.md"), encoding="utf-8") as fh:
            text = fh.read()
    except OSError:
        return None
    m = re.search(r"^##+ Live work.*?$", text, re.M)
    if not m:
        return None
    for line in text[m.end():].split("\n"):
        line = line.strip()
        if line.startswith("##"):
            break
        if line.startswith("- **"):
            label = re.sub(r"\*\*|\[|\]\([^)]*\)|\$", "", line[2:]).strip()
            if any(w in label[:60] for w in ("CLOSED", "DONE", "OUT OF SCOPE", "RETIRED")):
                continue
            return label[:180]
    return None


_waiting = []


# A THRESHOLD HERE IS A GUESS AND IS SET GENEROUSLY RATHER THAN FITTED.  45 min rested on
# a stale "worst measured 39", and replacing it with 140 fitted the worst observed 135.7,
# which is the same mistake one sample later (r906, r907).  Gaps are unbounded above, and
# the two errors are asymmetric: calling a working reviewer dead loses its round, waiting
# costs a later turn.  So this is deliberately past any gap the record has seen.
def _agents_running(cwd, max_age=21600):   # 6 h
    """True when a REVIEWER log was written to recently and has not closed.

    The glob is deliberately narrow.  It once matched every ``agent_logs/*.log``,
    which swept in the background-job logs written by scripts/job.sh -- raw program
    output that never ends in DONE or FAILED.  Any job touched in the last fifteen
    minutes therefore read as a reviewer in flight and silenced the hook.  Match
    only files a reviewer writes, so a convention change elsewhere cannot mute it.

    All THREE reviewer naming conventions are matched, the third added after the
    same failure recurred.  The third is ``rNNN.log`` -- digits and nothing else --
    matched by regex rather than by glob, because every glob wide enough to catch it
    also catches the job logs ``r182_n10.log`` and ``r208_hunt.log`` and so rebuilds
    the breakage the paragraph above records.  **A FOURTH FORM, ``rNNN-topic.log``,
    was missed for the same reason and is now matched: the separator is the whole of
    the distinction, since the job logs this docstring names use an underscore and
    every reviewer log uses a hyphen.**

    CLOSURE IS ANCHORED TO THE START OF THE LINE.  Testing ``"DONE" in tail`` reads
    a heartbeat of ``phase3 DICKSON DONE, f=5 running`` as a closed reviewer, which
    is the opposite of what that line reports -- the protocol puts DONE or FAILED
    FIRST on the closing line, so that is where it is looked for.  Narrowing to ``reviewer*.log`` alone missed every
    ``gate2_NNN.log``; adding that still missed ``rNNN.log``, which is what the
    record's own ``r#`` convention produces and what reviewers now write.  Either
    miss makes a running Gate 2 read as an unstarted one, and the hook then demands
    reviewers that are already working -- once per turn, indefinitely, with the
    turn's only available action being to re-launch them.
    """
    import glob
    import re
    import time
    # EVERY open log is collected, not the first, so the silence test below sees them all.
    del _waiting[:]
    # A FIFTH form, ``verify-<id>-v<N>.log``, is the verification loop's -- added after
    # it silenced this hook while three verifiers were mid-derivation.  The pattern is
    # verified against a filename the loop actually writes, which is what the four
    # earlier misses recorded above did not do.
    # A SIXTH FORM, ``gate2-<id>-<N>.log``, is the Gate 2 a verification round runs on a
    # debt it discharges itself -- hyphenated where the older form used an underscore, and
    # so invisible to a pattern list carrying only the underscore. That is the same miss the
    # four notes above record, committed once more by the loop that wrote them; both
    # separators are matched now.
    patterns = ("reviewer*.log", "gate2_*.log", "gate2-*.log", "derive-*.log", "lit-*.log",
                "canon-*.log", "plan-*.log", "verify-*.log")
    paths = [q for pat in patterns
             for q in glob.glob(os.path.join(cwd, "agent_logs", pat))]
    paths += [q for q in glob.glob(os.path.join(cwd, "agent_logs", "r*.log"))
              if re.fullmatch(r"r\d+(-[^.]*)?\.log", os.path.basename(q))]
    # AND THE NAMES ARE MATCHED BY CONTENT AS WELL, WHICH RETIRES THE WHOLE CLASS
    # OF MISS THE DOCSTRING ABOVE RECORDS SEVEN TIMES.  Every entry in that list was
    # added after a reviewer log went unmatched and the hook demanded reviewers that
    # were already working -- because the pattern list enumerates conventions while
    # the launcher chooses them freely, so a new prefix defeats it by existing.
    # The protocol mandates the FIRST LINE, `PID ... | <who> | phase plan: ...`, and a
    # job log carries raw program output there instead.  So a log whose first line
    # says `phase plan` is a reviewer's whatever it is called, and one that does not
    # is not a reviewer's however it is named.
    seen = set(paths)
    for q in glob.glob(os.path.join(cwd, "agent_logs", "*.log")):
        if q in seen:
            continue
        try:
            with open(q, "r", errors="replace") as fh:
                # EITHER SPELLING, because the protocol asks for "a phase plan" and a
                # reviewer writing "phases:" satisfies it in substance while defeating a
                # test for the exact words.  That miss cost a whole session of turns: the
                # log was unmatched by name AND by content, so every turn was told to
                # launch a reviewer that was already working.  Widening the CONTENT test
                # is safe where widening the name list is the treadmill the notes above
                # record, since a job log carries program output on its first line and
                # neither spelling appears there.
                first = fh.readline(4096)
                if "phase plan" in first or "phases:" in first:
                    paths.append(q)
        except Exception:
            continue
    # ONLY THIS SESSION'S REVIEWERS COUNT.  The logs above are recognised by name and first
    # line, which carries no owner, so another session's reviewer in flight silenced this
    # session's Stop for the whole of its run: with the Lean loop reviewing back to back in
    # a sibling session, this loop's continuation check was off for most of a day.  The
    # dispatch registers each log with its session in .claude/reviewers-in-flight (done by
    # scripts/misc/reviewer_watchdog.sh, which every dispatch arms), and a log counts here
    # only when this session registered it.  An unregistered reviewer of this session makes
    # the hook speak rather than wait, which is the loud direction.
    mine = set()
    try:
        with open(os.path.join(cwd, ".claude", "reviewers-in-flight"), encoding="utf-8") as fh:
            for line in fh:
                parts = line.rstrip("\n").split("\t")
                if len(parts) == 2 and _SESSION and parts[0] == _SESSION:
                    mine.add(os.path.realpath(parts[1]))
    except OSError:
        pass
    paths = [q for q in paths if os.path.realpath(q) in mine]
    for path in paths:
        try:
            if time.time() - os.path.getmtime(path) > max_age:
                continue
            # A KILLED OR CRASHED AGENT LEAVES A LOG WITH NO CLOSING LINE, and
            # while it stays warm it reads as in flight -- which SILENCES this
            # hook rather than blocking it, so the loop stops with no message.
            # That is handled where it arises: the loop appends a FAILED line when
            # it kills an agent, which is what the protocol asks of an agent that
            # cannot close itself.
            #
            # NEITHER THE PID NOR A SHORT WINDOW CAN DO THAT JOB, and both were
            # tried here.  The logged PID is the shell that wrote the first line
            # and exits at once, so a dead PID marked every healthy reviewer
            # finished.  A 300-second grace then looked safe because the protocol
            # asks for a heartbeat every ~3 minutes -- but MEASURED GAPS IN REAL
            # REVIEWER LOGS run far past that whenever an agent starts a long
            # computation: 39.3 minutes in one case, 14.1 in another, with five of
            # eight logs exceeding five minutes.  A reviewer timing a heavy script
            # is working, not dead, and the protocol's cadence is an instruction to
            # the agent rather than a property of its logs.
            #
            # So the window is generous and the closing line is what actually
            # decides -- but NOT unboundedly generous, because the two failure
            # directions are not symmetric.  A window too SHORT makes the hook fire
            # against a working reviewer, which is loud and self-correcting.  A
            # window too LONG makes a corpse silence the loop, which produces no
            # message at all: the loop simply stops, and only the user notices.
            # A 90-minute window did exactly that when a reviewer's log was left
            # ending in a heartbeat after its background job was killed.
            #
            # So the window sits just past the worst measured gap (39 min) rather
            # than far past it, and the residual risk is taken in the loud
            # direction on purpose.
            #
            # BUT THE WINDOW BOUNDS NOTHING BY ITSELF.  Stop fires only at the end
            # of a turn, so a single silenced Stop halts the session until the user
            # speaks -- there is no later event at which a cooled log gets caught.
            # The window shortens the exposure of the NEXT session, not this one.
            # What actually protects the loop is closing the log at the moment an
            # agent is stopped, which scripts/lib/salvage_reviewer.py now does on every
            # path.
            with open(path, encoding="utf-8", errors="replace") as fh:
                lines = fh.readlines()
            recent = [l for l in lines[-6:] if l.strip()]
            tail = recent[-1] if recent else ""
        except OSError:
            continue
        # A leading timestamp is allowed before the closing word: the same protocol
        # that asks for DONE first also asks for timestamped lines, so reviewers write
        # "02:06 DONE - ..." and every properly closed log then read as still running.
        # Anchored still -- the word must be the first thing after an optional stamp --
        # so a heartbeat like "phase3 DICKSON DONE, f=5 running" is not mistaken for one.
        #
        # THE STAMP IS MATCHED BY ITS ALPHABET RATHER THAN BY A FORMAT, because every
        # format enumerated here has been wrong.  A reviewer closed with
        # "2026-09-04 DONE ..." -- a DATE where the pattern accepted only a clock --
        # so a healthy, correctly closed log read as a reviewer still in flight, and
        # since that reading SILENCES this hook rather than blocking it, the loop
        # stopped with no message for two and a half hours.  Anything built from
        # digits, colons, hyphens, dots, brackets, T and Z is a stamp; a heartbeat's
        # prose is not, since its letters fall outside that set.
        #
        # CLOSURE IS LOOKED FOR IN THE LAST FEW LINES, NOT ONLY THE LAST ONE.  An agent
        # that writes its closing line and then appends one more remark -- a note about
        # a commit collision, a caveat for the caller -- leaves DONE on the second-to-last
        # line, and a tail-only test then reads a finished agent as still in flight.  That
        # silences this hook rather than blocking it, so the loop stops with no message:
        # it happened to verify-L02-v95.log, whose "note: v96 swept my staged file into
        # commit ..." sat below its "DONE GAP".  The anchoring still does the real work --
        # the closing word must open its line, so a heartbeat mentioning DONE mid-sentence
        # is not mistaken for one -- and widening from one line to six costs nothing that
        # anchoring was buying.
        #
        # A CLOSING LINE MAY ALSO CARRY A SHORT NOTE BEFORE THE WORD, as in "07:38:40 report
        # committed. DONE r1797: ...", which silenced this hook for six hours. The word followed
        # by the reviewer's own id closes the log wherever it stands, since a heartbeat never
        # names its id after DONE. A committed REVIEW_rN.md is no completion signal: every
        # reviewer commits a skeleton report in its first phase.
        if not any(re.match(r"[\s\[\]0-9:.\-TZ]*(DONE|FAILED)\b", l)
                   or re.search(r"\b(DONE|FAILED)\s+r\d+\b", l) for l in recent):
            _waiting.append((os.path.basename(path), tail.strip()[:60],
                             int(time.time() - os.path.getmtime(path))))
    return bool(_waiting)


# PAST THE WORST MEASURED GAP IN A WORKING REVIEWER'S LOG (39 min), for the reason the
# threshold note above gives: firing against a working reviewer is loud and costs a turn,
# while a corpse read as in flight silences the loop with no message at all.
STALE_WAIT = 3600


def _stale_wait():
    """Block, naming the logs, when every log read as in flight has been silent past STALE_WAIT.

    An exit 0 here is the one silent path out of this hook, so a log whose closing line the
    tests above cannot read keeps the loop unsupervised for the whole of max_age. Past an
    hour of silence the hook speaks instead, and the loop closes or salvages the log.
    """
    if _waiting and all(age > STALE_WAIT for _, _, age in _waiting):
        print("Stop hook: " + ", ".join("%s (silent %d min, last line: %s)" % (n, age // 60, t)
                                        for n, t, age in _waiting)
              + " read as reviewers in flight but have written nothing for over an hour. "
              "For a finished reviewer append a closing line 'HH:MM DONE rN: <verdict>' to its log, "
              "for a dead one 'HH:MM FAILED rN: stopped' (or run scripts/lib/salvage_reviewer.py N "
              "--stopped), and for one still working carry on.", file=sys.stderr)
        sys.exit(2)


VERIFY_CONDITIONS = (
    "the user interrupted or said to stop; an adjudication split and the loop could not settle "
    "it by derivation; a finding is UNRESOLVED -- needs computation and the user must "
    "decide whether to route it to the research loop; or a repair would need new "
    "mathematics rather than a correction."
)

AUDIT_CONDITIONS = (
    "the user interrupts or says to stop; nothing is awaiting audit; every "
    "remaining result depends on one marked BROKEN; this skill changed, which "
    "owes an approval pause; or a result has been through two full pairs without "
    "a verdict"
)


def _audit_skill_dirty(cwd):
    try:
        out = subprocess.run(
            ["git", "status", "--porcelain", ".claude/skills/"],
            cwd=cwd, capture_output=True, text=True, timeout=30).stdout
    except Exception:
        return []
    return [l[3:].strip() for l in out.splitlines() if l.strip()]


def _awaiting_audit(cwd):
    """Read the count from structure-check rather than recomputing it: two
    definitions of one number drift, and the check's is the one the skill cites."""
    try:
        out = subprocess.run(
            [sys.executable, ".claude/skills/structure-check/check.py"],
            cwd=cwd, capture_output=True, text=True, timeout=60).stdout
    except Exception:
        return None
    m = re.search(r"results awaiting audit:\s*(\d+)", out)
    return int(m.group(1)) if m else None


def _audit_turn(cwd, claude_dir, blocks, head, total):
    """The audit's own continuation, reached only when its flag names this session.
    Everything before this point -- the block counter, stop-declared, the session
    binding -- is shared, which is why the two loops share a file."""
    dirty = _audit_skill_dirty(cwd)
    if dirty:
        print(
            ", ".join(sorted(set(dirty))) + " has uncommitted changes, so this audit "
            "changed its own skill and owes the user an approval pause. Report the "
            "edit verbatim -- opening 'the skill has changed', the altered text quoted "
            "as a blockquote with the changed words in CAPITALS -- then write it to "
            ".claude/stop-declared and end the turn.",
            file=sys.stderr,
        )
        _bump(claude_dir, blocks, head, total)
        sys.exit(2)

    left = _awaiting_audit(cwd)
    if left == 0:
        sys.exit(0)
    print(
        "Continuation is the default and no stop condition was declared. Take the "
        "next result whose own inputs are audited and none of them marked BROKEN, "
        "and start it NOW with a tool call rather than a message about it"
        + ("" if left is None else " -- " + str(left) + " results are awaiting audit")
        + ". A closed result is not a stopping point, and neither is a status summary "
        "or an answered question. If instead one of these genuinely applies -- "
        + AUDIT_CONDITIONS + " -- write it to .claude/stop-declared, first line `session: $CLAUDE_CODE_SESSION_ID`, and end the turn, "
        "stating it as 'STOP: <condition>'." + _UNBOUND_NOTE,
        file=sys.stderr,
    )
    _bump(claude_dir, blocks, head, total)
    sys.exit(2)


_SESSION = ""   # set in main from the Stop payload; read by _agents_running


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        sys.exit(0)

    global _SESSION
    _SESSION = str(payload.get("session_id") or os.environ.get("CLAUDE_CODE_SESSION_ID", "")).strip()
    cwd = os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or os.getcwd()
    claude_dir = os.path.join(cwd, ".claude")
    auditing = loop_flag.armed_for(payload, cwd, loop_flag.AUDIT_FLAG)
    verifying = loop_flag.armed_for(payload, cwd, loop_flag.VERIFY_FLAG)
    if not auditing and not verifying and not loop_flag.armed_for(payload, cwd):
        sys.exit(0)
    active_flag = (loop_flag.AUDIT_FLAG if auditing else
                   loop_flag.VERIFY_FLAG if verifying else loop_flag.FLAG)

    # stop_hook_active alone would cap enforcement at ONE block per user message:
    # after the first block the model continues, and every later ending in the same
    # turn goes unchecked -- which is exactly where the drift happens, since a long
    # turn ends on prose many times.  So keep a counter instead, reset whenever a
    # fresh user message arrives (stop_hook_active false), and stand down once
    # continuations stop producing work.  The cap is what keeps a genuine ending
    # reachable; without it a turn that cannot satisfy the hook would never finish.
    #
    # WHAT IS CAPPED IS FUTILITY, NOT LENGTH.  The counter resets on a new commit,
    # so a loop that keeps closing rounds is never stood down for having run long,
    # and one spinning on a task it cannot finish is stood down after MAX_BLOCKS.
    # A flat per-message cap conflated the two and ended unattended runs while they
    # were working; MAX_BLOCKS_HARD still bounds a session that commits without
    # advancing.
    counter = os.path.join(claude_dir, _counter_name())
    head = _head(cwd)
    if not payload.get("stop_hook_active"):
        try:
            os.remove(counter)
        except OSError:
            pass
        blocks, total = 0, 0
    else:
        blocks, last_head, total = 0, "", 0
        try:
            with open(counter) as fh:
                parts = fh.read().split("\n")
            blocks = int(parts[0].strip() or 0)
            last_head = parts[1].strip() if len(parts) > 1 else ""
            total = int(parts[2].strip() or 0) if len(parts) > 2 else blocks
        except (OSError, ValueError, IndexError):
            blocks, last_head, total = 0, "", 0
        if head and last_head and head != last_head:
            blocks = 0   # work landed since the last block -- the run is productive
        if blocks >= MAX_BLOCKS or total >= MAX_BLOCKS_HARD:
            sys.exit(0)

    import loop_flag as _lf
    _state, _reason = _lf.declaration_for(os.path.dirname(claude_dir), payload)
    # HONOUR A DECLARATION ANOTHER HOOK OF THIS SESSION HAS ALREADY CONSUMED.  The file
    # is removed by whichever hook reads it first; the sentinel records the session, so
    # another session's consumed declaration never reads as this session's stop.
    if _state != "mine" and _lf.stop_seen_this_event(os.path.dirname(claude_dir), payload):
        sys.exit(0)
    if _state == "mine":
        declared = os.path.join(claude_dir, "stop-declared")
        _ok, _msg = _lf.check_stop_reason(_reason)
        if not _ok:
            try:
                os.remove(declared)
            except OSError:
                pass
            print(_msg, file=sys.stderr)
            sys.exit(2)
        try:
            # LEAVE A SENTINEL FOR THE HOOKS THAT RUN AFTER THIS ONE (r1037, r1038).
            _lf.mark_stop_seen(os.path.dirname(claude_dir), payload)
            os.remove(declared)
        except OSError:
            pass
        sys.exit(0)
    # "other" and "unbound" declarations are LEFT IN PLACE: the first belongs to another
    # session, and the second may, so neither is this session's stop.
    global _UNBOUND_NOTE
    if _state == "unbound":
        _UNBOUND_NOTE = (" An UNBOUND .claude/stop-declared is present and was ignored: "
                         "a declaration now opens with `session: <id>`; " + _lf.DECLARE_HOW + ".")

    # A compaction drops the loop's skill while leaving its flag armed, so the loop
    # reads as set up on guidance it no longer holds. skill_reread.py writes the marker
    # at SessionStart; reading the skill and deleting it is one act, which is what makes
    # the read observable instead of recalled. Blocks the RESUMPTION, like the skill-dirty
    # case below, because the reread is owed BEFORE the next cycle action rather than after.
    owed = os.path.join(claude_dir, "skill-reread-owed")
    marker = ""
    if os.path.exists(owed):
        try:
            marker = open(owed).read()
        except OSError:
            marker = ""
    # Bound at READ as well as at write. A marker left by a session that ended
    # without clearing it would otherwise block every later session in the repo,
    # which is the failure the loop flag's own session line exists to prevent.
    owner = re.search(r"^session:\s*(\S+)\s*$", marker, re.M)
    mine = payload.get("session_id") or os.environ.get("CLAUDE_CODE_SESSION_ID", "")
    if marker and owner and str(mine).strip() and owner.group(1) == str(mine).strip():
        skill = marker.splitlines()[0].strip() or "the running loop's SKILL.md"
        print(
            "This session was compacted, so the loop's guidance was summarised away "
            "while its flag stayed armed. Read " + skill + " IN FULL before the next "
            "cycle action, then delete .claude/skill-reread-owed. A summary preserves "
            "the mathematics and drops the process, so the loop would otherwise continue "
            "on memory of the rules rather than the rules.",
            file=sys.stderr,
        )
        _bump(claude_dir, blocks, head, total)
        sys.exit(2)

    # The one case where continuing is the wrong outcome, checked rather than recalled.
    # What it does depends on the mode, which the ACTIVE loop's flag file carries.
    # It runs before the branch dispatch: the verification branch exits without
    # returning, so a guard placed after it reached the research cycle alone.
    dirty = _skill_dirty(cwd)
    if dirty:
        names = ", ".join(sorted(set(dirty)))
        earned = _promotable(cwd)
        if loop_flag.mode(cwd, active_flag) == "locked" and earned is None:
            print(
                names + " has uncommitted changes, and this cycle is running in "
                "LOCKED mode, where the skill folder is read-only unless a proposal "
                "has earned the edit: a total of " + str(PROMOTE_AT) + " or more with "
                "no HOLD, which no row currently carries. Revert them with "
                "'git checkout -- .claude/skills/'. If the change was "
                "a lesson worth keeping, append it to .claude/skill-proposals.md "
                "FIRST -- at most three sentences, stating the rule and the failure "
                "it came from -- and the user will promote it when they choose to. "
                "Then carry on with the cycle.",
                file=sys.stderr,
            )
            _bump(claude_dir, blocks, head, total)
            sys.exit(2)

        added = _skill_diff_words(cwd)
        if added > MAX_SKILL_WORDS:
            print(
                "The skill edit in " + names + " adds " + str(added) + " words, over "
                "the " + str(MAX_SKILL_WORDS) + "-word ceiling a single cycle may add. "
                "A rule that needs more than that is not yet understood well enough to "
                "write down. Cut it to the rule and the failure it came from, or move "
                "it to .claude/skill-proposals.md and revert the skill folder.",
                file=sys.stderr,
            )
            _bump(claude_dir, blocks, head, total)
            sys.exit(2)

        if earned is not None:
            # AN EARNED PROMOTION COMMITS ITSELF, WHICH IS THE WHOLE POINT OF THE
            # THRESHOLD, SO IT MUST NOT FALL INTO THE APPROVAL PAUSE BELOW.  Skipping
            # only the revert demand left the edit blocked by this block instead, one
            # branch further down, which changed the message and not the outcome.
            print(
                names + " carries a skill edit a proposal has EARNED, at a total of "
                + str(earned) + " with no HOLD, and it is inside the "
                + str(MAX_SKILL_WORDS) + "-word ceiling. Commit it, report the new text "
                "VERBATIM per the editing-skills skill, then move the incident to "
                "ATTEMPTS.md and delete the promoted row from "
                ".claude/skill-proposals.md. Then carry on with the cycle.",
                file=sys.stderr,
            )
            _bump(claude_dir, blocks, head, total)
            sys.exit(2)

        print(
            names + " has uncommitted changes in the "
            "skill folder, so this loop changed the skill and owes the "
            "user an approval pause -- do NOT start the next task. Produce the "
            "handoff: what the cycle established, what changed in the skill and the "
            "failure it came from, the files ready to commit, the proposed commit "
            "message in full, and the explicit ask. Then write "
            "'the cycle changed the skill and is waiting for commit approval' to "
            ".claude/stop-declared and end the turn.",
            file=sys.stderr,
        )
        _bump(claude_dir, blocks, head, total)
        sys.exit(2)

    if auditing:
        # Reviewers in flight: ending the turn IS waiting for them, and the audit
        # takes one result at a time, so starting a second is the error this guards.
        #
        # THIS BRANCH IS THE ONE THAT CAN STALL THE LOOP INVISIBLY.  Every other exit
        # from this hook either blocks with a message or lets a declared stop through,
        # so the user sees why.  Here the loop simply goes quiet, and a log misread as
        # in-flight is indistinguishable from a reviewer that is genuinely thinking.
        # So the reason is written where it can be read: the wait is silent to the
        # session, never silent to the repository.
        if _agents_running(cwd):
            try:
                with open(os.path.join(claude_dir, "loop-waiting"), "w",
                          encoding="utf-8") as fh:
                    fh.write("waiting since %s on:\n" % time.strftime("%Y-%m-%d %H:%M:%S"))
                    for name, tail, _age in _waiting:
                        fh.write("  %s -- last line: %s\n" % (name, tail))
            except OSError:
                pass
            _stale_wait()
            sys.exit(0)
        try:
            os.remove(os.path.join(claude_dir, "loop-waiting"))
        except OSError:
            pass
        _audit_turn(cwd, claude_dir, blocks, head, total)

    if verifying:
        # The verification loop's own continuation rule.  Same machinery as the
        # research branch -- skill-folder guard, agents in flight, declared stops --
        # but it reads plan-verification.md, because handing this loop a plan.md
        # item is what arming the research flag here would wrongly do.
        # A SILENT WAIT IS WRITTEN DOWN, exactly as the audit branch does it.  This
        # exit is the one path out of this hook that produces no message anywhere, so
        # a log misread as in-flight is indistinguishable from a verifier still
        # thinking -- and the loop simply goes quiet until the user notices.  The wait
        # is silent to the session; it is never silent to the repository.
        if _agents_running(cwd):
            try:
                with open(os.path.join(claude_dir, "loop-waiting"), "w",
                          encoding="utf-8") as fh:
                    fh.write("waiting since %s on:\n" % time.strftime("%Y-%m-%d %H:%M:%S"))
                    for name, tail, _age in _waiting:
                        fh.write("  %s -- last line: %s\n" % (name, tail))
            except OSError:
                pass
            _stale_wait()
            sys.exit(0)
        try:
            os.remove(os.path.join(claude_dir, "loop-waiting"))
        except OSError:
            pass
        task = _next_verify_task(cwd)
        nxt = ("The round in flight is: " + task + " -- continue it NOW, in this turn, "
               "with a tool call rather than a message about it.") if task else (
               "Read plan-verification.md, take its first unchecked id, and open its "
               "round NOW, in this turn, with a tool call.")
        print(
            "Continuation is the default and no stop condition was declared. " + nxt +
            " A filed verdict is not a stopping point, and neither is a clean commit, "
            "a phase boundary or an answered question. If instead one of these applies "
            "-- " + VERIFY_CONDITIONS + " -- write it to .claude/stop-declared, first line `session: $CLAUDE_CODE_SESSION_ID`, and end "
            "the turn, stating it as 'STOP: <condition>'.",
            file=sys.stderr,
        )
        _bump(claude_dir, blocks, head, total)
        sys.exit(2)

    # Reviewers in flight: ending the turn IS waiting for them.
    if _agents_running(cwd):
        _stale_wait()
        sys.exit(0)

    # Gate 2 owed.  Checked rather than recalled, for the same reason as the skill folder:
    # the model reliably knows the rule and reliably skips it, because this hook keeps
    # handing it the next task.
    n_unrev, last = _unreviewed_commits(cwd)
    if n_unrev >= MAX_UNREVIEWED:
        print(
            "GATE 2 IS OWED and takes priority over the next task. There are "
            + str(n_unrev) + " feat/fix commits since the last reviewer file"
            + (" (" + last + ")" if last else " (none on record)")
            + ". Do NOT start another plan.md item. Launch the reviewers on identical "
            "briefs covering that unreviewed work, per step 2 of the skill, and wait "
            "for all of them. THE COUNT IS STEP 2'S JUDGEMENT AND NOT THIS HOOK'S: two "
            "where the round checks an argument being made, one where it compares text "
            "against something already fixed, such as a Lean file against the result it "
            "claims, an index row against the declarations it names, a fold against the "
            "findings it answers, or a hook against the behaviour it asserts. A round "
            "has been consumed by defects a script "
            "decides, so run the commit gate's checks rather than briefing a reader for "
            "them. If the user has explicitly told you to hold, write that to "
            ".claude/stop-declared and end the turn.",
            file=sys.stderr,
        )
        _bump(claude_dir, blocks, head, total)
        sys.exit(2)

    # THE TOP OF THE TABLE MAY NOT TOUCH THE GOAL, AND WORKING IT IS THEN CORRECT AND
    # USELESS.  `closes` is graded against one named statement; an item can top the table
    # on the PRODUCT while scoring 2 there.  The skill says invent a route (step 9) in
    # exactly that case, and a whole session went to the top item instead, because the
    # condition lived in prose and nothing read the grade table back.
    unreach = _unreachable_top(cwd)
    # A DECLARED CONTINUATION ON THE TOP ITEM.  The messages below once told the cycle to
    # "write that to .claude/stop-declared, first line `session: $CLAUDE_CODE_SESSION_ID`," to work the top anyway, but that file is the
    # stop channel: an untagged reason was refused and a tagged one ended the turn, so the
    # only exit left was a stop for the user's choice.  .claude/work-top is the separate
    # channel: it names this session and the item, and silences this check for that item.
    if unreach and unreach[0] != "PARSE":
        top_id = unreach[1] if unreach[0] == "STALLED" else unreach[0]
        try:
            with open(os.path.join(claude_dir, "work-top"), encoding="utf-8") as fh:
                wt = fh.read()
        except OSError:
            wt = ""
        ws = re.search(r"^session:\s*(\S+)\s*$", wt, re.M)
        wi = re.search(r"^item:\s*(\S+)\s*$", wt, re.M)
        me = {str(payload.get("session_id") or "").strip(),
              os.environ.get("CLAUDE_CODE_SESSION_ID", "").strip()} - {""}
        if ws and wi and ws.group(1) in me and wi.group(1).strip("*") == str(top_id).strip("*"):
            unreach = None
    if unreach and unreach[0] == "PARSE":
        _, want, got, bad = unreach
        print(
            "THE GRADE TABLE NO LONGER PARSES, so the check that the top item can reach "
            "the goal is NOT RUNNING and this stop is refused until it does. Found " +
            str(got) + " rows against " + str(want) + " item lines" +
            (", and these rows' value does not equal closes x attackable x margin x "
             "analytic: " + ", ".join(bad) if bad else "") +
            ". The columns have moved or an id lost its bold. Fix plan.md's table, or "
            "fix the pattern in _unreachable_top to match it -- a gate that reads a "
            "drifted table silently passes, which is how it stops working without "
            "anyone noticing.",
            file=sys.stderr)
        _bump(claude_dir, blocks, head, total)
        sys.exit(2)
    if unreach and unreach[0] == "STALLED":
        _, top, val, attack, closers, routed = unreach
        print(
            "THE TOP OF THE GRADED TABLE CLOSES THE OPEN STATEMENT AND NOBODY CAN START "
            "IT. " + top + " grades " + str(val) + " and scores " + str(attack) +
            " on `attackable`, which on the rubric's scale means a route must be invented"
            + (" (0 means every named route is already closed)" if attack == 0 else "") +
            ". " +
            ("Other closers: " +
             ", ".join(i + " (value " + str(v) + ", attackable " + str(a) + ")"
                       for i, v, a in closers if i != top) + ". " if len(closers) > 1 else "") +
            ("A ROUTE ALREADY EXISTS on " + ", ".join(i for i, _, _ in routed) +
             ", so the next action is to WORK THAT ITEM rather than step 9. "
             if routed else
             "NO item on the list both closes the statement and has a route, so STEP 9 "
             "is the next action: the literature sweep and the route proposal, scored on "
             "this same rubric; TAKE THE TOP CANDIDATE AND START IT, recording the table in "
             "routes.md and STATUS.md. Only a top candidate whose reach is a single parameter "
             "value or a census goes to the user, as a `strategy: reach gate` stop. ") +
            "DOWNGRADING A ROW DOES NOT DISCHARGE THIS: the check reads `attackable` on "
            "the top closer, so lowering some other row's value only changes which item "
            "is named. To work the top anyway, write .claude/work-top (lines "
            "`session: <id>`, `item: <the top id>`, `reason: <why>`) and continue: this "
            "check then passes for that item in this session. .claude/stop-declared is the "
            "STOP channel and is not how a continuation is declared.",
            file=sys.stderr)
        _bump(claude_dir, blocks, head, total)
        sys.exit(2)
    if unreach:
        top, val, closes, closers, routed = unreach
        print(
            "THE TOP OF THE GRADED TABLE DOES NOT TOUCH THE OPEN STATEMENT. " + top + " grades " + str(val) +
            " but scores " + str(closes) + " on `closes`, which means a named step on a "
            "path to the statement rather than the statement itself. " +
            ("The only items that would close it outright are " +
             ", ".join(i + " (value " + str(v) + ", attackable " + str(a) + ")"
                       for i, v, a in closers) + ". " if closers else
             "NO item on the list would close it outright. ") +
            ("A ROUTE ALREADY EXISTS on " +
             ", ".join(i for i, _, _ in routed) + ", which scores 2 or more on "
             "`attackable`, so the next action is to WORK THAT ITEM and NOT step 9: "
             "inventing a route that is already built is the one way this gate can waste "
             "the step it names. The ranking put a step above a closer because the product "
             "hid it, and the fix is to take the closer. "
             if routed else
             "Every closer needs a route invented, so STEP 9 is the next action: the "
             "literature sweep and the route proposal. Read the field for the open "
             "statement in its own objects, score two to four candidate routes on this same "
             "rubric, TAKE THE TOP ONE AND START IT, recording the table in routes.md and "
             "STATUS.md. Only a top candidate whose reach is a single parameter value or a "
             "census goes to the user, as a `strategy: reach gate` stop. ") +
            "To work the top anyway, write .claude/work-top (lines `session: <id>`, "
            "`item: <the top id>`, `reason: <why>`) and continue: this check then passes "
            "for that item in this session. .claude/stop-declared is the STOP channel and "
            "is not how a continuation is declared.",
            file=sys.stderr)
        _bump(claude_dir, blocks, head, total)
        sys.exit(2)

    task = _next_task(cwd)
    if task:
        nxt = ("The next task is: " + task + " -- start it NOW, in this turn, with a tool "
               "call rather than a message about it.")
    else:
        over = _plan_overrun(cwd)
        if over:
            plan_kb, fat = over
            print(
                "plan.md is " + ("%.0f" % plan_kb) + " kB, past the " + str(PLAN_BUDGET_KB) +
                " kB backstop, so STEP 7 is the next task and not the top item. Ask its "
                "three questions of each item: what the record already holds on its "
                "subject, what in it is mathematics rather than task state, and what is "
                "repeated where a link would do. " +
                (str(len(fat)) + " items carry more than 1 kB, the largest being: "
                 + "; ".join(fat[:3]) + ". " if fat else "") +
                "Move each one's mathematics to the file that owns its subject, leave the "
                "identifier, status, route and what is owed, and link to the block rather "
                "than restating it.",
                file=sys.stderr)
            _bump(claude_dir, blocks, head, total)
            sys.exit(2)
        nxt = ("Read plan.md, take its top live item, and start it NOW, in this turn, "
               "with a tool call rather than a message about it.")

    print(
        "Continuation is the default and no stop condition was declared. " + nxt +
        " A clean commit is not a stopping point, and neither is a limitation written "
        "into the record, a status summary, or an answered question -- all of them make "
        "a unit feel finished while the task list is unchanged. If instead one of these "
        "genuinely applies -- " + CONDITIONS + " -- write it to .claude/stop-declared, first line `session: $CLAUDE_CODE_SESSION_ID`, "
        "and end the turn, stating it as 'STOP: <condition>'.",
        file=sys.stderr,
    )
    _bump(claude_dir, blocks, head, total)
    sys.exit(2)


if __name__ == "__main__":
    main()
