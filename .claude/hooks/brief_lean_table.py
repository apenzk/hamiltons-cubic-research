#!/usr/bin/env python3
"""PreToolUse gate: a Gate 2 brief names a Lean declaration per claim, or the reason none can exist.

THE FAILURE THIS ADDRESSES.  The skill already says "EVERY GATE 2 BRIEF NAMES THE LEAN
DECLARATION THAT TYPES THE CLAIM, OR SAYS WHY NONE CAN EXIST", and "before dispatching,
ask of every item on the list whether the kernel could answer it".  That rule was stated
and was violated in writing three times in one session, in these words:

    "Claims 4, 6, 7, 8, 9 and 10 are typed nowhere"
    "Claims 2, 5 and 8 could all be typed cheaply"
    "Parts A and B are typed nowhere; say for each claim whether a Lean statement could carry it"

Each reads as disclosure and passes the eye.  Each spent two readers on what the kernel
answers, and in the first case both readers came back saying the claim should be typed.
The defect is not that the rule was missing.  It is that PROSE NAMING SIX UNTYPED CLAIMS
AT ONCE IS INVISIBLE, while six empty cells in a table are not.

WHAT IT REQUIRES.  A dispatch whose prompt names a `reviews/BRIEF_*.md` is a Gate 2
round.  That brief must carry a markdown table with a column headed `Lean` (or
`declaration`), with

  * at least as many data rows as the brief's claim table, so no claim is omitted, and
  * no empty cell in that column: each holds a declaration name, or the reason no
    declaration can exist.

WHY A TABLE AND NOT A SENTENCE.  A sentence can name six claims at once and still read
as compliance.  A table cannot: the omission is a blank, and a blank is greppable.  This
hook is the reason the skill's rule is phrased as a table rather than as an obligation.

Inert unless .claude/research-loop-active names THIS session -- see loop_flag.py -- so a
dispatch from any other thread, or an Agent call that is not a Gate 2 round, is untouched.
"""
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from loop_flag import armed_for  # noqa: E402

MSG = """A Gate 2 brief must name, per claim, the Lean declaration that types it or the reason
none can exist -- as a TABLE, not prose.

  {problem}

  brief: {brief}

Add a table with a column headed `Lean`, one row per claim, every cell filled:

  | # | claim | Lean |
  |---|---|---|
  | 1 | ... | `theorem_name` |
  | 2 | ... | none: quantifies over maximisers, no constraint surface in the layer |

The rule this enforces is in research-loop/SKILL.md, under "type the theorem before
deriving it". It was stated for many cycles and violated in writing three times, because
one sentence naming six untyped claims reads as disclosure and passes the eye. Typing is
the only check the kernel performs and it is cheaper than the readers it replaces, so the
gap is made visible per claim at the moment those readers are spent."""

HEAD = re.compile(r"\b(lean|declaration)\b", re.I)


def rows(table):
    """data rows of a markdown table block, as lists of cells"""
    out = []
    for line in table:
        if not line.strip().startswith("|"):
            continue
        cells = [c.strip() for c in line.strip().strip("|").split("|")]
        if all(set(c) <= set("-: ") for c in cells):   # the separator row
            continue
        out.append(cells)
    return out


def tables(text):
    """every contiguous run of markdown table lines"""
    blocks, cur = [], []
    for line in text.split("\n"):
        if line.strip().startswith("|"):
            cur.append(line)
        else:
            if cur:
                blocks.append(cur)
            cur = []
    if cur:
        blocks.append(cur)
    return blocks


def check(brief_text):
    """returns a problem string, or None when the brief passes"""
    blocks = [rows(b) for b in tables(brief_text)]
    blocks = [b for b in blocks if len(b) >= 2]
    if not blocks:
        return "the brief carries no table at all, so no claim names a declaration"

    lean_tables, claim_tables = [], []
    for b in blocks:
        header = b[0]
        idx = next((i for i, h in enumerate(header) if HEAD.search(h)), None)
        if idx is not None:
            lean_tables.append((b, idx))
        elif any(re.search(r"\bclaim\b", h, re.I) for h in header):
            claim_tables.append(b)

    if not lean_tables:
        return "no table has a column headed `Lean` or `declaration`"

    body, idx = max(lean_tables, key=lambda t: len(t[0]))
    data = body[1:]
    blanks = [i + 1 for i, r in enumerate(data) if idx >= len(r) or not r[idx]]
    if blanks:
        return f"the `Lean` column has {len(blanks)} empty cell(s), at row(s) {blanks}"

    if claim_tables:
        n_claims = max(len(c) - 1 for c in claim_tables)
        if len(data) < n_claims:
            return (f"the claim table has {n_claims} claims but the `Lean` table has "
                    f"{len(data)} rows, so {n_claims - len(data)} claim(s) name nothing")
    return None


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0
    if payload.get("tool_name") != "Agent":
        return 0
    cwd = os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or os.getcwd()
    if not armed_for(payload, cwd):
        return 0

    prompt = str(payload.get("tool_input", {}).get("prompt", ""))
    m = re.search(r"[\w/.\-]*reviews/(BRIEF_[\w.\-]+\.md)", prompt)
    if not m:
        return 0                      # not a Gate 2 dispatch
    brief = os.path.join(cwd, "reviews", m.group(1))
    if not os.path.exists(brief):
        return 0                      # nothing to check against

    try:
        text = open(brief, encoding="utf-8").read()
    except Exception:
        return 0

    problem = check(text)
    if problem:
        print(MSG.format(problem=problem, brief=os.path.relpath(brief, cwd)), file=sys.stderr)
        sys.exit(2)
    return 0


if __name__ == "__main__":
    sys.exit(main())
