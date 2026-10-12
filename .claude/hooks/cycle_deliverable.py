#!/usr/bin/env python3
"""PreToolUse gate: a research cycle closes on a deliverable, not on a measurement.

THE FAILURE THIS ADDRESSES.  On 2026-08-23 a five-hour run produced 51 commits and
one derivation.  Every individual step was legal -- the skill endorses writing a
script to falsify a candidate fast -- so no per-step rule and no amount of rereading
could catch it.  The drift lives in the RATIO, and a ratio is only visible where
cycles close.  A commit is where a cycle closes, so that is where this looks.

WHAT IT REQUIRES.  A `feat(` or `fix(` commit must carry a trailer

    Deliverable: derivation | refutation | dead-end | none

  derivation  an identity, inequality, closed form or reduction, proved
  refutation  a claim on the record disproved, with the witness that does it
  dead-end    a route shown unable to work -- a fence post
  none        measurement only: numbers produced, nothing settled

Numerics stay fully available as instruments: a run that kills a candidate is a
refutation or a dead end and passes.  What the trailer costs is the ability to
close a cycle on numbers while calling it progress, because naming it `none` is
the honest option and it is meant to be uncomfortable.

THE AGGREGATE GATE.  Three consecutive `none` cycles is refused outright.  Two in
a row is the warning shape; the third is where the session stopped moving toward a
proof and started collecting data.

`docs(`, `chore(`, `refactor(` and `test(` are housekeeping and pass untouched.
Inert unless .claude/research-loop-active names THIS session -- see loop_flag.py --
so ordinary work, in this session or any other, is unaffected.
"""
import json
import os
import re
import shutil
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import loop_flag

VALUES = ("derivation", "refutation", "dead-end", "none")
GATED = ("feat(", "fix(")
RUN_LIMIT = 3          # consecutive `none` cycles refused at this count
REFUTATION_RUN_LIMIT = 3   # consecutive `refutation` results refused at this count

SEARCH_MSG = """This commit OPENS or REOPENS a plan item, so it must name its search:

    Searched: <what was searched> -> references/<slug>/
    Searched: none -- <why>

The rule it enforces already exists in the skill -- search before deriving. It gets
skipped anyway, and the omission is invisible step by step: reopening an item is
legitimate, deriving is legitimate, and nothing in between is where a search
visibly failed to happen. The item's status changing is the only place it shows.

A cycle once reopened an item and went straight to deriving; the search, run only
when the user asked whether one had happened, returned the classical NAME for the
operation in a single query -- a name the record had been paraphrasing for cycles.

Writing `Searched: none -- <why>` is allowed and meant to be uncomfortable."""

MSG = """A cycle closes on a deliverable. Add a trailer to the commit message:

    Deliverable: derivation | refutation | dead-end | none

  derivation  an identity, inequality, closed form or reduction, proved
  refutation  a claim on the record disproved, with the witness
  dead-end    a route shown unable to work -- a fence post
  none        measurement only: numbers produced, nothing settled

A run that kills a candidate is a refutation or a dead end, so numerics used as an
instrument pass. Naming a measuring cycle `none` is the honest option."""


# The vocabulary a subject line actually uses when an item's status changes.  The
# first version matched only "reopen", and the record's own history has counter-
# examples: 475c32e ("the n=12 sextic count is OPEN") and 62ccb44 ("its reduction
# REFUTED") both reopen work and say neither word.  A refutation reopens whatever
# it refutes, so it belongs here too.
REOPEN = re.compile(
    r"\b(reopen\w*|re-open\w*|refut\w+|withdraw\w*|retract\w*|unclos\w+)\b|"
    r"\bis (?:now )?open\b|\bback open\b|\brestor\w+\b|\bnot closed\b|"
    r"\bstill open\b|\bopens?\b(?=[^\n]*\bitem\b)", re.I)

# `Searched: <value>` must be a LINE of its own carrying a real value: either a
# references/ path, or `none` with a reason after it.  The first version accepted
# any non-space run, so a full stop passed, `yes` passed, and the word appearing
# anywhere in the shell command -- an echo outside the message -- passed.
SEARCHED = re.compile(
    r"^[ \t]*Searched:[ \t]*(references/\S+|"
    r"none\b[ \t]*[-—:]{0,2}[ \t]*(?=[^\W\d_])[\w\s,;'()./-]{12,}|"
    r"\S.*?->[ \t]*references/\S+)[ \t]*$", re.M)


def _opens_an_item(command, cwd):
    """True when this commit stages plan.md AND its subject says an item opened.

    A TRIPWIRE, NOT A PROOF, and it is worth saying which.  It cannot detect an
    item quietly reopened in a body paragraph under a subject that mentions
    something else, and it is not meant to: a gate wide enough to catch that would
    fire on every plan.md touch, and a trailer that fires on everything gets pasted
    in unread.  The rule itself lives in SKILL.md; this catches the common shape.

    plan.md is matched as a whole path, not as a substring -- `docs/plan.md` and
    `old-plan.md` are different files.
    """
    subject = command.split("\n", 1)[0]
    if not REOPEN.search(subject):
        return False
    try:
        out = subprocess.run(["git", "diff", "--cached", "--name-only"],
                             cwd=cwd, capture_output=True, text=True, timeout=10)
        return any(line.strip() == "plan.md" for line in out.stdout.splitlines())
    except Exception:
        return False


def _searched(text):
    """The Searched trailer's value, if a well-formed one is present."""
    m = SEARCHED.search(text)
    return m.group(1).strip() if m else None


def _trailer(text):
    """The trailer's value, read out of raw text.

    The command string still carries its shell quoting, so the line reads
    `Deliverable: derivation"` with the closing quote attached -- anchoring on
    end-of-line silently matches nothing.  Match the word and stop there."""
    m = re.search(r"Deliverable:[ \t]*([A-Za-z-]+)", text)
    return m.group(1).lower() if m else None


def _recent_none(cwd, limit):
    """How many of the most recent gated commits in a row were `none`."""
    try:
        out = subprocess.run(
            ["git", "log", "-30", "--pretty=format:%s%n%b%n@@@"],
            cwd=cwd, capture_output=True, text=True, timeout=10,
        ).stdout
    except Exception:
        return 0
    run = 0
    for block in out.split("@@@"):
        block = block.strip()
        if not block:
            continue
        subject = block.splitlines()[0]
        if not subject.startswith(GATED):
            continue
        if _trailer(block) == "none":
            run += 1
        else:
            break
    return run


SEARCH_RUN_LIMIT = 25   # consecutive searchless commits before a real search is owed


def _recent_searchless(cwd, limit):
    """How many of the most recent commits in a row cited no outside source.

    A `Searched:` value counts as searchless when it is `none` or names only this
    repository -- "the record first", "the record by mechanism", and the like.
    Those are legitimate individually and were never the problem; the problem is
    only visible as a RUN, which no per-commit check can see.  A programme that
    has not opened a source in dozens of commits is deriving in ignorance of its
    own field, and the cost of that is invisible until something already known is
    rediscovered."""
    try:
        out = subprocess.run(
            ["git", "log", "-60", "--pretty=format:%s%n%b%n@@@"],
            cwd=cwd, capture_output=True, text=True, timeout=10,
        ).stdout
    except Exception:
        return 0
    run = 0
    for block in out.split("@@@"):
        block = block.strip()
        if not block:
            continue
        val = _searched(block)
        if val is None:
            continue
        low = val.lower()
        if low.startswith("none") or "the record" in low or "this repository" in low:
            run += 1
        else:
            break
        if run >= limit + 5:
            break
    return run


LEAN_MSG = """This commit NUMBERS {ids}, so each needs its Lean proof COMPLETE: its row in
lean/INDEX.md reads **proved** with `statement: typed.` unqualified, and no file the row
names contains `sorry`. A claim whose proof has not closed stays unnumbered, in the
working note, until it does. There is no trailer that lets a result be numbered as debt.

The skill already says a number obliges a Lean file in the same change, and asks
for the theorem restated with `sorry` where the proof goes. It gets skipped, and
the omission is invisible step by step: deriving is legal, numbering is legal,
indexing is legal. The number's creation is the only place it shows, and that is
the commit.

Six results were once numbered in a single run with no file and no note. A missing
toolchain makes the debt invisible rather than absent, and a debt nobody can see is
one a compaction erases -- so `Lean: blocked -- <reason>` is allowed, records the
debt where a later reader meets it, and is meant to be uncomfortable."""

# A NUMBERED RESULT'S ROW MUST READ **proved**, DECLARE ITS OWN STATEMENT TYPED, UNQUALIFIED, AND NAME NO
# FILE HOLDING A `sorry`: the research loop produces Lean, not debt.
# (The statement check alone:)  A substring test passed
# "statement: typed for (2)" and "statement: typed (scalar steps)", so fifteen results reached the index with
# only their scalar cores typed while every row carried the marker.
STATEMENT_TYPED = re.compile(r"statement:\s*typed(?=\s*[.*,;]|\s*$)", re.I)
PROVED = re.compile(r"\|\s*\*\*proved\*\*\s*\|", re.I)
LEAN_FILE = re.compile(r"\((HamiltonsCubic/[^)\s]+\.lean)\)")
SORRY = re.compile(r"\bsorry\b")
LEAN_BLOCKED_ONLY = re.compile(r"^[ \t]*Lean:[ \t]*blocked\b", re.M)
INDEX_ROW = re.compile(
    r"^\|[ \t]*\*\*(\d+)\*\*[ \t]*\|[ \t]*(Lemma|Observation|Conjecture|Theorem|Corollary)\b", re.M | re.I)

LEAN_TRAILER = re.compile(
    r"^[ \t]*Lean:[ \t]*(blocked\b[ \t]*[-\u2014:]{0,2}[ \t]*(?=[^\W\d_])"
    r"[\w\s,;'()./-]{12,}|lean/\S+)[ \t]*$", re.M)


DERIV_MSG = """`Deliverable: derivation` now requires the statement in Lean.

Stage a `.lean` file in the same commit, or carry

    Lean: blocked -- <reason>

A PROSE PROOF THAT NEVER GETS TYPED IS A CLAIM, NOT A RESULT.  This programme's
solution counts only if it is machine-checked, and the second step was owed
forever because nothing made it the same event as the first.  Typing one day's
worth of already-audited results found six errors in the record that two
independent reviewers had passed -- a false constant, a percentage band its own
figures contradicted, a decimal wrong in the fifth place, a measure-zero set
called generic, an unnoticed collision, and a definition that admitted objects
the conjecture is false on.

Deriving in prose first is the right METHOD -- you cannot type what you have not
worked out, and Lean is far slower to think in.  Stopping there is what this
refuses.  Three honest outcomes:

  typed and proved            -> derivation
  typed with a named `sorry`  -> derivation, and the gap is visible
  not typed                   -> `none`, which is what it is

`Lean: blocked -- <reason>` stays available for the case the toolchain or the
base layer genuinely cannot reach, and records the debt where a later reader
meets it."""


BLOCKED_RUN_LIMIT = 3   # consecutive `Lean: blocked` results refused at this count

# A declaration NAME, as opposed to a word of English.  Lean names in this layer
# carry an internal capital, a digit, an underscore or a dot -- `foxProd`,
# `IsOrth`, `inner2`, `weyl_basis`, `Nat.choose` -- and prose nouns carry none of
# those.  That is the whole discrimination, and it is why the reason is required to
# contain one: `the layer carries no trace` is unfalsifiable, `the layer carries no
# weylBasis` is one grep.
DECL_NAME = re.compile(r"\b(?=[A-Za-z_][A-Za-z0-9_.']*"
                       r"(?:[A-Z0-9_.]|'))([A-Za-z_][A-Za-z0-9_.']{3,})\b")

BASE_LAYER = "lean/HamiltonsCubic"

BLOCKED_NAME_MSG = """`Lean: blocked` must name a MISSING DECLARATION, and this reason names none.

    Lean: blocked -- no `weylBasis`, so no trace on the operators of the module

A reason naming a concept cannot be checked by anyone, including its author, and it
passes while the base layer holds the object under another name. A reason naming a
declaration is one grep: the name is in {layer}/ or it is not.

Write the name of the Lean declaration the statement would need and does not have.
Names are recognised by their shape -- an internal capital, a digit, an underscore
or a dot -- which is what separates `foxProd` from `the fox product`."""

BLOCKED_PRESENT_MSG = """`Lean: blocked` names {names}, and the base layer already has {verb}:

{hits}
A blocker that is present is not a blocker. Read the declaration, state the claim
with it, and where it is the wrong shape, say which declaration of the right shape
is missing instead -- a layer is built for the results it has served rather than
for the next one, so the object needed is usually one contraction or one
specialisation from something already there."""

REFUTATION_RUN_MSG = """This would be {n} `refutation` results in a row with no `derivation`
between them, and the limit is {limit}.

`refutation` is the one value that demands no Lean, and the easiest of the four to
earn honestly, since every screen that kills a candidate genuinely is one.  So it
is where a numerics ratio escapes while every commit stays individually correct
and every gate passes.  That ratio is invisible to a per-commit check and shows
only in the run, which is what this counts.

The run so far:

{subjects}
Break it by typing one of them.  A refutation that types its replacement carries
`derivation`, and the escape stays open wherever it is honest."""


BLOCKED_RUN_MSG = """This would be {n} numbered results in a row carrying `Lean: blocked`, and the
limit is {limit}.

At the third, the cycle BUILDS the named declaration instead of recording the debt
again. The debt is already recorded {n} times and nothing reads a trailer back, so
another record of it changes nothing while everything downstream is briefed on an
absence that has never been tested.

The named blockers of the run are:

{reasons}
Add the declaration to {layer}/, or state this result's claim with
what the layer already carries."""


def _lean_blocked_reason(text):
    """The reason text of a `Lean: blocked` trailer, if that is the form used."""
    m = LEAN_TRAILER.search(text)
    if not m:
        return None
    val = m.group(1)
    if not val.lower().startswith("blocked"):
        return None
    return re.sub(r"^blocked[ \t]*[-\u2014:]{0,2}[ \t]*", "", val, flags=re.I)


def _declared_in_layer(cwd, names):
    """Which of these names the base layer DECLARES, as {name: file}.

    A DECLARATION, NOT A MENTION.  `-w` alone counts any word-boundary occurrence, so a
    name written in a docstring -- including one saying the declaration does NOT exist --
    satisfied this check and the trailer naming it was refused as "already present".
    That is how a blocker becomes unrecordable: the very act of documenting the absence
    creates the evidence of presence.  Requiring a declaration keyword in front
    distinguishes the two, and the sibling gate lean_blocked_debt.py carries the same
    fix for the same reason (r1039, probe E)."""
    hits = {}
    for name in names:
        try:
            out = subprocess.run(
                ["git", "grep", "-lE",
                 r"(theorem|lemma|def|abbrev|structure|instance)[[:space:]]+"
                 + re.escape(name) + r"\b",
                 "--", BASE_LAYER],
                cwd=cwd, capture_output=True, text=True, timeout=15)
        except Exception:
            continue
        files = [l.strip() for l in out.stdout.splitlines() if l.strip()]
        if files:
            hits[name] = files[0]
    return hits


def _recent_refutations(cwd, limit):
    """The most recent gated commits in a row whose Deliverable was `refutation`.

    Returns their subjects, newest first.  A commit carrying any other value ends
    the run, which is the point: the drift this counts lives in the ratio, and a
    ratio is invisible to any per-commit check because every commit in the run is
    individually correct."""
    try:
        out = subprocess.run(
            ["git", "log", "-40", "--pretty=format:%s%n%b%n@@@"],
            cwd=cwd, capture_output=True, text=True, timeout=10,
        ).stdout
    except Exception:
        return []
    subjects = []
    for block in out.split("@@@"):
        block = block.strip()
        if not block:
            continue
        lines = block.splitlines()
        if not lines[0].startswith(GATED):
            continue
        m = re.search(r"^Deliverable:\s*(\S+)", block, re.M)
        if m is None:
            continue
        if m.group(1).strip() != "refutation":
            break
        subjects.append(lines[0][:72])
        if len(subjects) >= limit + 2:
            break
    return subjects


def _recent_lean_blocked(cwd, limit):
    """The most recent gated commits in a row whose Lean trailer was `blocked`.

    Returns their reasons, newest first.  A commit that typed its statement ends
    the run, which is the only thing that does: the run is what the per-commit
    check cannot see, and it is where a layer stops growing while the record keeps
    numbering results against it."""
    try:
        out = subprocess.run(
            ["git", "log", "-40", "--pretty=format:%s%n%b%n@@@"],
            cwd=cwd, capture_output=True, text=True, timeout=10,
        ).stdout
    except Exception:
        return []
    reasons = []
    for block in out.split("@@@"):
        block = block.strip()
        if not block:
            continue
        if not block.splitlines()[0].startswith(GATED):
            continue
        if not LEAN_TRAILER.search(block):
            continue
        reason = _lean_blocked_reason(block)
        if reason is None:
            break
        reasons.append(reason)
        if len(reasons) >= limit + 2:
            break
    return reasons


def _stages_lean(cwd):
    """True when the staged diff touches any `.lean` file."""
    try:
        out = subprocess.run(["git", "diff", "--cached", "--name-only"],
                             cwd=cwd, capture_output=True, text=True, timeout=10)
    except Exception:
        return True
    return any(line.strip().endswith(".lean") for line in out.stdout.splitlines())


def _committed_text(cwd, command, path):
    """The text of `path` as this commit will record it.

    `git commit -- <paths>` records the WORKING-TREE copy of each named path, not the index, so a check that
    reads only the index misses a row added and committed by path.  Otherwise the index is what is recorded.
    """
    named = " -- " in command and path in command.split(" -- ", 1)[1]
    try:
        if named:
            with open(os.path.join(cwd, path), encoding="utf-8") as fh:
                return fh.read()
        out = subprocess.run(["git", "show", ":" + path], cwd=cwd, capture_output=True, text=True, timeout=10)
        return out.stdout if out.returncode == 0 else ""
    except Exception:
        return ""


def _numbers_a_result(cwd, command=""):
    """The ids this commit NUMBERS: rows of the results index absent from HEAD's copy.

    AN EDITED ROW IS NOT A NEWLY NUMBERED ONE.  Reading added diff lines counted every rewritten row (a Gate 2
    status updated at a fold) as a new number, which forced an unrelated lean/INDEX.md touch or an escape
    trailer on every fold.  Comparing id sets sees only the numbers that are new.
    """
    try:
        head = subprocess.run(["git", "show", "HEAD:findings/INDEX-results.md"], cwd=cwd,
                              capture_output=True, text=True, timeout=10).stdout
    except Exception:
        return []
    new = _committed_text(cwd, command, "findings/INDEX-results.md")
    old_ids = {m.group(1) for m in INDEX_ROW.finditer(head)}
    return sorted({m.group(1) for m in INDEX_ROW.finditer(new)} - old_ids, key=int)


def _declares_statement(cwd, ids, command=""):
    """True when the lean/INDEX.md this commit records declares `statement: typed`, unqualified, for every id.

    THE WHOLE ROW IS READ, NOT THE DIFF: a row typed in an earlier commit satisfies it.  It is a declaration,
    not a proof: what it buys is that the claim is in the index, where one row can be checked.
    """
    if not ids:
        return True
    text = _committed_text(cwd, command, "lean/INDEX.md")
    for i in ids:
        rows = [l for l in text.splitlines() if re.match(r"^\|\s*\[?L" + i + r"\b", l)]
        if not rows or not all(STATEMENT_TYPED.search(r) and PROVED.search(r) for r in rows):
            return False
        for r in rows:
            for path in LEAN_FILE.findall(r):
                if SORRY.search(_committed_text(cwd, command, "lean/" + path)):
                    return False
    return True


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        sys.exit(0)
    if payload.get("tool_name") != "Bash":
        sys.exit(0)
    command = payload.get("tool_input", {}).get("command", "")
    if "git commit" not in command:
        sys.exit(0)
    cwd = os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or os.getcwd()

    # NUMBERING A RESULT IS GATED IN EVERY SESSION AND ON EVERY COMMIT TYPE.  The check ran only on feat(/fix(
    # commits in the research session, so a result numbered in a docs( commit, or from another session, reached
    # the index with its row reading "statement: not typed".  Only a **proved** row with an unqualified
    # `statement: typed` and no `sorry` in its files passes; no trailer waives it.
    _ids = _numbers_a_result(cwd, command)
    if _ids and not _declares_statement(cwd, _ids, command):
        print(LEAN_MSG.replace("{ids}", ", ".join("L" + i for i in _ids)), file=sys.stderr)
        sys.exit(2)

    if not loop_flag.armed_for(payload, cwd):
        sys.exit(0)

    subjects = re.findall(r"(?:feat|fix|docs|chore|refactor|test)\([^)]*\):", command)
    gated = any(s.startswith(GATED) for s in subjects)

    # The search gate runs on ANY commit type.  Restricting it to feat(/fix( left
    # `docs(plan): reopen ...` as a clean bypass of a rule about reopening items.
    if _opens_an_item(command, cwd) and not _searched(command):
        print(SEARCH_MSG, file=sys.stderr)
        sys.exit(2)

    if not gated:
        sys.exit(0)


    # `Lean: blocked` is a debt, and a debt has to name what would discharge it.
    # The naming and the run cap are both waived when the toolchain itself is gone,
    # since there is then no layer to name a declaration in and no way to grow one.
    _reason = _lean_blocked_reason(command)
    if _reason is not None and shutil.which("lake"):
        _names = sorted(set(DECL_NAME.findall(_reason)))
        if not _names:
            print(BLOCKED_NAME_MSG.format(layer=BASE_LAYER), file=sys.stderr)
            sys.exit(2)
        _hits = _declared_in_layer(cwd, _names)
        if _hits:
            print(BLOCKED_PRESENT_MSG.format(
                names=", ".join(sorted(_hits)),
                verb="them" if len(_hits) > 1 else "it",
                hits="".join(f"    {n}  ->  {f}\n" for n, f in sorted(_hits.items())),
            ), file=sys.stderr)
            sys.exit(2)
        _run = _recent_lean_blocked(cwd, BLOCKED_RUN_LIMIT)
        if len(_run) >= BLOCKED_RUN_LIMIT - 1:
            print(BLOCKED_RUN_MSG.format(
                n=len(_run) + 1, limit=BLOCKED_RUN_LIMIT, layer=BASE_LAYER,
                reasons="".join(f"    {r}\n" for r in _run),
            ), file=sys.stderr)
            sys.exit(2)

    value = _trailer(command)
    if value is None:
        print(MSG, file=sys.stderr)
        sys.exit(2)
    if value not in VALUES:
        print(f"`Deliverable: {value}` is not one of {', '.join(VALUES)}.\n\n{MSG}",
              file=sys.stderr)
        sys.exit(2)
    if (value == "derivation" and not _stages_lean(cwd)
            and not LEAN_TRAILER.search(command)):
        print(DERIV_MSG, file=sys.stderr)
        sys.exit(2)
    if value == "refutation":
        _rrun = _recent_refutations(cwd, REFUTATION_RUN_LIMIT)
        if len(_rrun) >= REFUTATION_RUN_LIMIT - 1:
            print(REFUTATION_RUN_MSG.format(
                n=len(_rrun) + 1, limit=REFUTATION_RUN_LIMIT,
                subjects="".join(f"    {t}\n" for t in _rrun),
            ), file=sys.stderr)
            sys.exit(2)
    if value == "none":
        # THE COMMIT IN HAND COUNTS, AND READING ONLY HISTORY MADE IT INVISIBLE.
        # `_recent_searchless` walks `git log`, so the commit being written is not in
        # it.  A run of searchless commits is therefore still a run at the moment the
        # author finally does the search and cites it, and this refused the very
        # commit that fixes the condition it is complaining about -- the one state
        # where the message's instruction has already been carried out.  So a real
        # `Searched:` value here, naming a references/ path rather than `none` or this
        # repository, clears the run before it is measured.
        _here = _searched(command) or ""
        # SKIPS THIS CHECK ONLY.  The first version RETURNED from main, which also
        # cleared the consecutive-`none` cap below, so a sixth `none` in a row passed
        # on the strength of a citation (r1037).  A guard for one check must not
        # silence its neighbours.
        _cited = "references/" in _here and not _here.lower().startswith("none")
        # AND THE SLUG MUST EXIST.  A path that names no directory is a citation of
        # nothing, and a guard any commit can trip on demand is not a guard.
        if _cited:
            slug = re.search(r"references/([A-Za-z0-9._-]+)", _here)
            _cited = bool(slug) and os.path.isdir(
                os.path.join(cwd, "references", slug.group(1)))
        srun = 0 if _cited else _recent_searchless(cwd, SEARCH_RUN_LIMIT)
        if srun >= SEARCH_RUN_LIMIT:
            print(
                f"{srun} commits in a row have cited no outside source -- every "
                "`Searched:` value has been `none` or `the record`. Each was "
                "defensible alone; the run is not. Before the next commit, run a "
                "real literature search on what this programme is currently "
                "deriving, file what it returns under references/<slug>/, and cite "
                "it. If the search genuinely returns nothing usable, say so in the "
                "trailer with what was queried -- that is a search, and it resets "
                "this counter. A programme that has not opened a source in "
                f"{srun} commits is deriving in ignorance of its own field.",
                file=sys.stderr,
            )
            sys.exit(2)
        run = _recent_none(cwd, RUN_LIMIT)
        if run >= RUN_LIMIT - 1:
            print(
                f"This would be {run + 1} measuring cycles in a row, and the limit "
                f"is {RUN_LIMIT}.\n\n"
                "The route is collecting data rather than moving toward a proof. "
                "Before closing another cycle, state the identity, inequality or "
                "reduction being derived and derive it, or name the route a dead "
                "end and rank the next one.\n\n"
                "The numbers already in hand are the screen; the deliverable is "
                "the statement they were screening for.",
                file=sys.stderr)
            sys.exit(2)
    sys.exit(0)


if __name__ == "__main__":
    main()
