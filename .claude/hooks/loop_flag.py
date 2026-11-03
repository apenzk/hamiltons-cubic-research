#!/usr/bin/env python3
"""Whether the research-loop flag is armed for THIS session.

The flag `.claude/research-loop-active` used to be a bare marker, so every hook
in the repository read it and every session in the repository was treated as a
loop session.  A thread doing unrelated work -- updating `report/`, answering a
question -- would reach its Stop hook and be told to start the next `plan.md`
item, which is a task it was explicitly not given.

So the flag now carries the session it belongs to:

    session: 40ec1ae0-eda9-4634-81da-a5c3ae160da4

`armed_for` returns True only in that session.  A flag with no `session:` line
arms nothing: binding is deliberate, never inferred.  An earlier version of this
module claimed an unbound flag for the first session that happened to read it,
which reproduced the original bug one session at a time -- the thread that ends a
turn first is not the thread running the cycle, and it was gated for the rest of
its life.  Failing closed costs an un-gated loop session, which the user notices
and fixes with one command; failing open costs an unrelated thread being pushed
into work it was told not to do, which is what this file exists to prevent.

Matching accepts CLAUDE_CODE_SESSION_ID as well, because the shell arming the
flag and the hook reading it need not agree on which id they see -- a mismatch
there would silence the loop rather than scope it.

The flag also carries the cycle's MODE, on a second line:

    session: 40ec1ae0-eda9-4634-81da-a5c3ae160da4
    mode: locked

`locked` forbids the cycle from editing anything in the skill folder; a lesson it
wants to record goes to `.claude/skill-proposals.md` instead, which the user reads
when they choose to.  `learning` lets the cycle edit the skill and pause for
approval, as it always did.  **A flag with no `mode:` line reads as `locked`**, for
the reason the session binding fails closed: the cost of a wrongly-locked cycle is
one proposal filed in the wrong place, and the cost of a wrongly-learning cycle is
the skill growing without the user having asked for any of it.

Arm it from inside the session running the cycle:

    echo "session: $CLAUDE_CODE_SESSION_ID" > .claude/research-loop-active
    echo "mode: learning" >> .claude/research-loop-active

Delete the file to disarm.
"""
import os
import re
import time

FLAG = "research-loop-active"
AUDIT_FLAG = "audit-active"
VERIFY_FLAG = "verification-active"
TTL_HOURS = 12


def _path(claude_dir):
    return os.path.join(claude_dir, FLAG)


def armed_for(payload, cwd, flag=FLAG):
    """True when a loop is running and this session is the one running it.

    `flag` names which loop: the research cycle by default, or AUDIT_FLAG for the
    audit.  One reader for both, so the session-binding and TTL rules cannot drift
    apart between them."""
    claude_dir = os.path.join(cwd, ".claude")
    try:
        with open(os.path.join(claude_dir, flag), encoding="utf-8") as fh:
            text = fh.read()
    except OSError:
        return False

    session_id = str(payload.get("session_id") or "").strip()
    env_id = os.environ.get("CLAUDE_CODE_SESSION_ID", "").strip()

    m = re.search(r"^session:\s*(\S+)\s*$", text, re.M)
    if not m:
        return False  # unbound: arms nothing, in any session
    if m.group(1) not in {i for i in (session_id, env_id) if i}:
        return False

    path = os.path.join(claude_dir, flag)
    try:
        age_hours = (time.time() - os.path.getmtime(path)) / 3600.0
    except OSError:
        return False
    if age_hours > TTL_HOURS:
        return False  # stale: the owning session ended without disarming

    try:
        os.utime(path, None)  # heartbeat: a live cycle keeps its own flag alive
    except OSError:
        pass
    return True


def mode(cwd, flag=FLAG):
    """"locked" or "learning" -- what the cycle may do to the skill folder.

    `flag` names which loop, exactly as armed_for does.  Reading FLAG regardless of
    the caller made every loop but the research cycle read "locked" unconditionally,
    since its own flag file was never consulted."""
    try:
        with open(os.path.join(cwd, ".claude", flag), encoding="utf-8") as fh:
            text = fh.read()
    except OSError:
        return "locked"
    m = re.search(r"^mode:\s*(\S+)\s*$", text, re.M)
    return "learning" if m and m.group(1).lower() == "learning" else "locked"


SEEN = ".stop-declared-seen"


def _event_key(payload):
    """The transcript's size, which is fixed for the hooks of one Stop event.

    Every Stop hook of one event reads the same finished transcript; the next turn
    appends to it.  So the size identifies the event, where a wall-clock window
    does not: a 90-second window honoured a declaration consumed at the end of one
    turn for the undeclared stop of the NEXT turn, whenever that turn was short."""
    path = (payload or {}).get("transcript_path") or ""
    try:
        return os.path.getsize(path)
    except OSError:
        return None


def _session_ids(payload):
    return {i for i in (str((payload or {}).get("session_id") or "").strip(),
                        os.environ.get("CLAUDE_CODE_SESSION_ID", "").strip()) if i}


def declaration_for(root, payload):
    """Read .claude/stop-declared for THIS session: returns (state, reason).

    A STOP DECLARATION IS BOUND TO THE SESSION THAT WROTE IT.  The file is shared by
    every session in the repository, and an unbound one was consumed by whichever
    session's Stop hook fired next: the research session once ended its turn on the
    lean session's `waiting:` reason, written six seconds earlier, and the lean
    session was then blocked for the stop it had declared.  So a declaration opens
    with `session: <id>`, as the loop flags do.

    state is "mine" (reason follows), "other" (bound to another session; LEFT IN
    PLACE for its owner), "unbound" (no session line; left in place, since it may be
    another session's), or "none"."""
    path = os.path.join(root, ".claude", "stop-declared")
    try:
        with open(path, encoding="utf-8") as fh:
            text = fh.read()
    except OSError:
        return "none", ""
    m = re.match(r"\s*session:\s*(\S+)[ \t]*\n?(.*)\Z", text, re.S)
    if not m:
        return "unbound", text.strip()
    if m.group(1) not in _session_ids(payload):
        return "other", ""
    return "mine", m.group(2).strip()


DECLARE_HOW = ("write `session: $CLAUDE_CODE_SESSION_ID` as the first line of "
               ".claude/stop-declared and the tagged reason below it")


def mark_stop_seen(root, payload):
    """Record that a stop declaration was consumed in THIS Stop event, by THIS session."""
    import json
    try:
        with open(os.path.join(root, ".claude", SEEN), "w", encoding="utf-8") as fh:
            json.dump({"t": time.time(), "key": _event_key(payload),
                       "session": sorted(_session_ids(payload))}, fh)
    except OSError:
        pass


def stop_seen_this_event(root, payload):
    """True when another hook of this same Stop event consumed a declaration.

    Matches on the transcript size when both sides have one; without it, falls back
    to a few seconds, which covers hooks of one event and no following turn."""
    import json
    try:
        with open(os.path.join(root, ".claude", SEEN), encoding="utf-8") as fh:
            rec = json.load(fh)
    except (OSError, ValueError):
        return False
    if not isinstance(rec, dict):
        return False
    owner = rec.get("session")
    if owner is not None and not (set(owner) & _session_ids(payload)):
        return False   # another session's consumed declaration is not this one's stop
    key, now_key = rec.get("key"), _event_key(payload)
    age = time.time() - float(rec.get("t", 0))
    if key is not None and now_key is not None:
        return key == now_key and age < 600
    return age < 5


# A STOP REASON MUST NAME A LISTED CONDITION.  The hooks honoured any text in
# .claude/stop-declared, so a "checkpoint" or "report progress" reason ended the loop
# while no condition had fired: the file recorded a justification without the hook
# ever reading it.  A reason now opens with one of these tags, and anything else is
# refused and the turn blocked.
STOP_TAGS = {
    "user:": "the user interrupted, said to stop, or asked a question the turn answers",
    "waiting:": "a background task or agent is in flight and its notification will resume the turn (name it)",
    "skill-changed:": "a skill file changed and owes the user an approval pause",
    "strategy:": "a strategic fact fired: step 9's reach gate (a census or single-value reach, name it)",
    "effort:": "an effort change is owed and only the user can make it",
    "decision:": "a decision belongs to the user (name it, with a recommendation on the table)",
    "stalled:": "one task has made no movement across five cycles",
    "proven:": "the conjecture is proven and results.md carries the proof",
    "lean-queue-empty:": "the lean queue has no workable row",
    "lean-unsupported:": "an `unsupported` lean verdict needs the user's call",
    "lean-disagreement:": "a Lean disagreement survived re-statement",
    "verify:": "a verification-loop stop condition fired (name it)",
    "audit:": "an audit-loop stop condition fired (name it)",
}


def _decision_open():
    """True when DECISIONS-TO-MAKE.md holds at least one open entry."""
    import os
    root = os.environ.get("CLAUDE_PROJECT_DIR", os.getcwd())
    try:
        text = open(os.path.join(root, "DECISIONS-TO-MAKE.md")).read()
    except OSError:
        return False
    return any(line.startswith("## ") for line in text.splitlines())


# WITH AN ORCHESTRATOR SESSION RUNNING, A CALL THAT IS THE USER'S DOES NOT STOP A LOOP.  The
# orchestrator named in .claude/sessions.json puts it to the user and commits the answer, so
# the loop hands it over with SendMessage and keeps working.  `effort:` still stops:
# only the user can change a session's effort, and only in that session.
ROUTED_TO_ORCHESTRATOR = ("decision:", "skill-changed:", "strategy:", "lean-unsupported:",
                     "lean-disagreement:")


def _orchestrator():
    """The orchestrator session's name from .claude/sessions.json, or None."""
    import json
    import os
    root = os.environ.get("CLAUDE_PROJECT_DIR", os.getcwd())
    try:
        m = json.load(open(os.path.join(root, ".claude", "sessions.json"))).get("orchestrator") or {}
    except (OSError, ValueError, AttributeError):
        return None
    name = m.get("session") if isinstance(m, dict) else None
    return name if isinstance(name, str) and name.strip() else None


def check_stop_reason(reason):
    """Return (ok, message).  ok is True when the reason opens with a listed tag."""
    r = (reason or "").strip().lower()
    orchestrator = _orchestrator()
    if orchestrator and r.startswith(ROUTED_TO_ORCHESTRATOR):
        return False, (f"stop REFUSED: an orchestrator session is running ({orchestrator}, per "
                       ".claude/sessions.json). Send it this call with SendMessage, the first line "
                       "opening with its kind (DECISION, SKILL CHANGE, BLOCKED or DEFECT), then the "
                       "ask, a recommendation and what you do meanwhile, and continue with work that "
                       "does not depend on the answer.")
    # TWO TAGS ARE CHECKED AGAINST EVIDENCE, because a tag accepted as text became an exit
    # from hard work: stops were declared as a route choice with no sweep behind them.
    if r.startswith("decision:") and not _decision_open():
        return False, ("stop REFUSED: `decision:` needs an open entry (a `## ` heading) in "
                       "DECISIONS-TO-MAKE.md, carrying the ask and a recommendation. Write it first.")
    if r.startswith("strategy:") and "reach gate" not in r:
        return False, ("stop REFUSED: `strategy:` must name the fact that fired, the `reach gate`. "
                       "The churn cap redirects the cycle rather than stopping "
                       "it, and otherwise the route is the cycle's to choose.")
    # THE REACH GATE STOPS ONLY ON A NARROW REACH.  Its clause "or no path to the goal" fired
    # on every sweep once no route reached the open statement with a method, and each time
    # the stop asked the user to pick from a table the cycle had already scored.  A route
    # pick is the cycle's; the user is asked only when the top route reaches a single
    # parameter value or a census, which is the drift into certification the gate exists for.
    if (r.startswith("strategy:") and "reach gate" in r
            and not any(k in r for k in ("census", "single parameter", "single value", "single n"))):
        return False, ("stop REFUSED: the reach gate stops only when the top route's reach is a "
                       "single parameter value or a census; name which. A table whose routes reach "
                       "no further than a step is still the cycle's to choose from: take the top "
                       "route, record the table in routes.md and STATUS.md, and start it.")
    if r.startswith("decision:") and any(k in r for k in ("route", "sweep", "reach gate", "pick")):
        return False, ("stop REFUSED: a route pick is the cycle's, not a decision owed to the user. "
                       "Record it in routes.md and STATUS.md and start the route.")
    for tag in STOP_TAGS:
        if r.startswith(tag) and len(r) > len(tag) + 2:
            return True, ""
    listing = "; ".join(f"`{t}` {d}" for t, d in STOP_TAGS.items())
    return False, (
        f"stop REFUSED: the declared reason {reason!r} names no stop condition. A reason "
        f"opens with one of these tags, followed by the specifics: {listing}. A checkpoint, "
        "a progress report or a finished commit is none of them, so take the next action "
        "instead of ending the turn."
    )
