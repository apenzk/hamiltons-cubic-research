#!/usr/bin/env python3
"""PreToolUse gate: every tool call runs at the effort level the current stage declares.

THE FAILURE THIS ADDRESSES.  research-loop/SKILL.md runs a derivation that warrants it
at the escalated level and everything else at the standing level.  EVERY LEVEL IS SET IN
`.claude/effort-levels.json`: per loop under `research` and `lean`, a `main` pair
(`standing`, `escalated`) for the loop's own session and a `subagent` level for the
reviewers it dispatches.  The pair in force is the research pair when the research loop is
armed for this session, else the lean pair.  A missing file, key or invalid value falls back
to `medium` and `xhigh`; the older shapes (the pair directly under the loop with a top-level
`reviewer`, or top-level `standing`/`escalated`) are still read.  Both transitions were
checks the cycle could skip in silence: a derivation begun before the raise landed runs
route-deciding work at the standing level, and a drop back nobody asks for bills recording, typing
and review at the derivation's rate.  Neither leaves a trace the user would ever see.

WHAT IT REQUIRES.  The stage declares its level in `.claude/effort-expect`:

    session: <session id>
    class: escalated

The cycle writes it BEFORE asking the user for the raise, and deletes it once the
derivation is on disk.  With no file, or one naming another session, the expected level
is the standing one.  A `level:` line naming a level outright is honoured as well.  The file's session line may carry either the payload's session id or
$CLAUDE_CODE_SESSION_ID, which can differ, exactly as loop_flag.py accepts both.  While
the research loop is armed for this session, a main-thread tool call whose live level
differs from the expected one is blocked.  The live level comes from the payload's
`effort.level`, falling back to $CLAUDE_EFFORT.

SUBAGENT CALLS ARE EXEMPT.  A subagent shares its parent's session id but may run at the
level its own definition sets, so gating its calls against the stage's level would pit
the two threads against one marker, each clearing it for the other.  The dispatch that
starts a subagent is a main-thread call, so it is still checked.

A GATE THAT CANNOT SEE THE LEVEL SAYS SO.  When the loop is armed and neither source
carries a level, the first call of the session is blocked with a notice rather than every
call passing in silence, since a silently inert gate is the failure it exists to prevent.

WHY THE ORDER WORKS.  The write happens at the standing level with no file present, and
the delete happens at the escalated level with the file present, so neither call is
itself blocked.  After the delete, the next call finds the escalated level running
against the standing one expected, which is exactly the drop back being enforced.  When
the two levels are equal, nothing is ever a mismatch and the gate only checks the level.

WHY ONCE PER MISMATCH.  A block records the session and the mismatch it saw, and the
same mismatch passes on the next call, so a level the user chose deliberately stays
usable and the gate cannot loop.  A call at the expected level clears the record, so the
next slip is caught afresh.

Every failure of the protocol is loud: a forgotten write turns the user's raise into a
block, and a forgotten delete turns the drop back into one.  The remaining gap is a
warranted raise the cycle never asks for, which is a judgement no hook can make.

THE REVIEWER LEVEL IS COPIED INTO THE AGENT DEFINITION AT DISPATCH.  The harness reads a
subagent's effort only from its definition's frontmatter (`.claude/agents/reviewer.md`,
key `effort`), and an Agent call cannot override it.  So every main-thread Agent call
rewrites that line from the dispatching loop's `subagent` level before the dispatch
proceeds, which keeps the JSON the one place a level is set.

THE ONCE-PER-MISMATCH MARKER IS PER SESSION.  A single shared marker was deleted by every
matching call of ANY session, so with two sessions armed (research here, lean elsewhere)
the other session's routine calls kept clearing this one's record and a deliberate level
was blocked on every call instead of once.

THE LEAN LOOP ARMS IT TOO.  lean-loop/SKILL.md runs at the standing level throughout and
declares no escalation, so while only the lean loop is armed the expected level is always
the standing one.
Inert unless .claude/research-loop-active or .claude/lean-loop-active names THIS session,
see loop_flag.py.
"""
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from loop_flag import armed_for  # noqa: E402

LEVELS_FILE = "effort-levels.json"
DEFAULTS = {"standing": "medium", "escalated": "xhigh"}
VALID = {"low", "medium", "high", "xhigh", "max"}
EXPECT = "effort-expect"
MARKER = "effort-gate-blocked"
BLIND = "effort-gate-blind"

MSG = """This {tool} call runs at effort `{live}`, and the current stage expects `{expected}`.

{advice}

The protocol is in research-loop/SKILL.md, under "Effort discipline": write
.claude/effort-expect before asking for the raise, delete it once the derivation is on
disk.  The lean loop runs at its standing level throughout.  Every level, per loop and
for reviewers, is set in .claude/effort-levels.json.  If the user deliberately chose `{live}`, retry: this gate
blocks each mismatch once."""

ADVICE_RAISE = ("The stage declared the escalated level and the session is not at it. Stop and ask "
                "the user to run `/effort {expected}` before the derivation starts.")
ADVICE_DROP = ("The session differs from the standing level with no derivation declared. If the "
               "derivation is on disk, stop and ask the user to run `/effort {expected}` before any "
               "recording, typing or dispatch. If the user raised the level for a derivation, "
               "the stage never declared it: write .claude/effort-expect first.")


def levels(claude_dir, loop):
    """The (standing, escalated) pair for `loop` ('research' or 'lean'), and the reviewer level."""
    try:
        with open(os.path.join(claude_dir, LEVELS_FILE), encoding="utf-8") as fh:
            data = json.load(fh)
    except (OSError, ValueError):
        data = {}
    if not isinstance(data, dict):
        data = {}
    node = data.get(loop) if isinstance(data.get(loop), dict) else {}
    src = node.get("main") if isinstance(node.get("main"), dict) else (node or data)
    out = dict(DEFAULTS)
    for key in out:
        value = str(src.get(key, "")).strip().lower()
        if value in VALID:
            out[key] = value
    sub = node.get("subagent") if isinstance(node.get("subagent"), dict) else {}
    rev = str(sub.get("effort", data.get("reviewer", ""))).strip().lower()
    out["reviewer"] = rev if rev in VALID else None
    return out


def sync_reviewer(cwd, level):
    """Rewrite the reviewer agent's `effort:` frontmatter line to the JSON's reviewer level."""
    if not level:
        return
    path = os.path.join(cwd, ".claude", "agents", "reviewer.md")
    try:
        with open(path, encoding="utf-8") as fh:
            text = fh.read()
    except OSError:
        return
    head = re.match(r"(---\n.*?\n---\n)", text, re.S)
    if not head:
        return
    new_head = re.sub(r"^effort:\s*\S+\s*$", "effort: " + level, head.group(1), flags=re.M)
    if "effort:" not in new_head:
        new_head = new_head[:-4] + "effort: " + level + "\n---\n"
    if new_head != head.group(1):
        try:
            with open(path, "w", encoding="utf-8") as fh:
                fh.write(new_head + text[len(head.group(1)):])
        except OSError:
            pass


def live_level(payload):
    effort = payload.get("effort")
    if isinstance(effort, dict) and effort.get("level"):
        return str(effort["level"])
    return os.environ.get("CLAUDE_EFFORT") or None


BLIND_MSG = """The effort gate cannot see this session's effort level: the hook payload carries no
`effort.level` and $CLAUDE_EFFORT is unset.  Every stage transition is therefore unchecked.
Tell the user, and confirm levels with `echo $CLAUDE_EFFORT` by hand until it is fixed.
This notice blocks once per session."""


def expected_level(claude_dir, ids, lv):
    try:
        with open(os.path.join(claude_dir, EXPECT), encoding="utf-8") as fh:
            text = fh.read()
    except OSError:
        return lv["standing"]
    s = re.search(r"^session:\s*(\S+)\s*$", text, re.M)
    if not s or s.group(1) not in ids:
        return lv["standing"]
    c = re.search(r"^class:\s*(\S+)\s*$", text, re.M)
    if c and c.group(1) in lv:
        return lv[c.group(1)]
    named = re.search(r"^level:\s*(\S+)\s*$", text, re.M)
    if named and named.group(1) in VALID:
        return named.group(1)
    return lv["standing"]


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0
    cwd = os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or os.getcwd()
    research = armed_for(payload, cwd, "research-loop-active")
    if not (research or armed_for(payload, cwd, "lean-loop-active")):
        return 0

    if payload.get("agent_id"):
        return 0                      # a subagent call, see the docstring
    claude_dir = os.path.join(cwd, ".claude")
    ids = {i for i in (str(payload.get("session_id") or "").strip(),
                       os.environ.get("CLAUDE_CODE_SESSION_ID", "").strip()) if i}
    session = min(ids) if ids else ""

    live = live_level(payload)
    if live is None:
        blind = os.path.join(claude_dir, BLIND)
        try:
            with open(blind, encoding="utf-8") as fh:
                if fh.read().strip() == session:
                    return 0
        except OSError:
            pass
        try:
            with open(blind, "w", encoding="utf-8") as fh:
                fh.write(session + "\n")
        except OSError:
            return 0
        print(BLIND_MSG, file=sys.stderr)
        sys.exit(2)

    lv = levels(claude_dir, "research" if research else "lean")
    if payload.get("tool_name") == "Agent":
        sync_reviewer(cwd, lv["reviewer"])
    expected = expected_level(claude_dir, ids, lv)
    marker = os.path.join(claude_dir, MARKER + "." + (session or "unknown"))

    if live == expected:
        try:
            os.remove(marker)
        except OSError:
            pass
        return 0

    seen = f"{session} {live} {expected}"
    try:
        with open(marker, encoding="utf-8") as fh:
            if fh.read().strip() == seen:
                return 0              # the same mismatch, already raised once
    except OSError:
        pass
    try:
        with open(marker, "w", encoding="utf-8") as fh:
            fh.write(seen + "\n")
    except OSError:
        return 0                      # cannot record the block, so never block blind

    advice = (ADVICE_RAISE if expected != lv["standing"] else ADVICE_DROP).format(expected=expected)
    print(MSG.format(tool=payload.get("tool_name", "tool"), live=live, expected=expected,
                     advice=advice), file=sys.stderr)
    sys.exit(2)


if __name__ == "__main__":
    sys.exit(main())
