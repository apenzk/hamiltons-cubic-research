#!/usr/bin/env python3
"""A `Lean: blocked` trailer names a declaration, and this reads the debt back.

THE FAILURE THIS ADDRESSES.  `Deliverable: derivation` requires a staged `.lean` file,
or the escape hatch `Lean: blocked -- <reason>`.  The hatch is legitimate: the base
layer may genuinely lack the object, or the toolchain may be held.  But NOTHING READS
A TRAILER BACK.  A cycle writes the debt, the commit lands, and the obligation ages
out of everyone's memory while the record keeps building on top of it.  The skill
states the convention that makes this checkable -- the reason NAMES a declaration and
that name must be absent from the layer when grepped for -- so the debt is a claim a
script can verify, and until now no script did.

The check: for each `Lean: blocked -- <name>` in recent history, grep the layer for
<name>.  Still absent after AGE commits means the debt has aged rather than been paid,
and the stop is blocked naming it.  Present means the debt is discharged and the
trailer is history.

Inert unless the lean loop or the research loop names this session, so an unrelated
thread never sees it.
"""

import json
import os
import sys as _sys
_sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import re
import subprocess
import sys

sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.abspath(__file__))))
import loop_flag  # noqa: E402

ROOT = os.environ.get("CLAUDE_PROJECT_DIR", ".")
LOOK = 500      # commits of history to read; the oldest live debt here is ~380 back,
                # and a window that does not reach a debt is the same as no gate
AGE = 15        # a debt older than this many commits, still unpaid, blocks
# A DECLARATION NAME, NOT THE FIRST LONG WORD.  The first version took the first
# token of four or more characters after `--`, which on a reason opening "the joint
# Gram system needs ..." extracted `joint`, grepped the layer for it, found it in
# some unrelated file, and marked the debt PAID.  A live false negative, found by
# r1037: the declaration actually named there was `sharedChannelGram`.
#
# A Lean declaration name carries an underscore or an internal capital; an English
# word in a sentence carries neither.  That is the discriminator, and where a reason
# contains no such token the trailer is reported as UNPARSEABLE rather than passing
# silently, because a debt nobody can read is the state this gate exists to end.
IDENT = re.compile(r"[A-Za-z_][A-Za-z0-9_.'!?₀-₉]{3,}")
# The capital must be INTERNAL, or there must be an underscore.  A leading capital is
# just a sentence's proper noun: on the reason above, requiring only `[_A-Z]` anywhere
# extracted `Gram` before `sharedChannelGram` and was wrong a second time in the same
# line.  `sharedChannelGram` has a capital at position six, `second_order_face` has
# underscores, and `Gram` and `joint` have neither.
DECL_LIKE = re.compile(
    r"^[A-Za-z_](?=[A-Za-z0-9_.\'!?₀-₉]*[_A-Z])[A-Za-z0-9_.\'!?₀-₉]{3,}$")
TRAILER = re.compile(r"^Lean:\s*blocked\s*--\s*(.+)$", re.M | re.I)
# A DEBT CAN BE CLOSED WITHOUT THE DECLARATION EVER EXISTING, and the first version of
# this gate could not see that.  An obligation is sometimes VOID rather than paid: the
# name was wrong, or the claim it served was refuted, so no declaration will ever
# appear and grepping for one asks a question with no right answer.  Explaining that in
# a commit body is invisible to a grep, so the closure gets its own trailer, which is
# the same discipline this gate exists to enforce -- a rule that governs an artefact
# ships with the check that reads it.
# The token must NOT begin `Lean: blocked`, because cycle_deliverable.py matches that
# as a prefix and would parse a closure as a fresh blocker naming every word in it.
VOID = re.compile(r"^Lean:\s*void\s*--\s*(.+)$", re.M | re.I)


def _armed(payload, cwd):
    """THE SHARED READER, because these gates rolled their own and drifted.

    `loop_flag.armed_for` carries the session binding AND the 12-hour TTL. A gate that
    checks only for the flag's presence keeps blocking after the loops have gone inert,
    which is a session stuck behind a rule nothing is running any more (r1037)."""
    return (loop_flag.armed_for(payload, cwd, "lean-loop-active")
            or loop_flag.armed_for(payload, cwd, "research-loop-active"))



def _stop_declared_recently(root, payload):
    """True when a stop was declared in THIS Stop event, including one another hook
    has already consumed.  `root` is the payload's cwd resolution, one for writer and
    reader.  The event, not a wall-clock window, bounds it: see loop_flag.stop_seen_this_event."""
    import loop_flag as _lf
    if os.path.exists(os.path.join(root, ".claude", "stop-declared")):
        _lf.mark_stop_seen(root, payload)
        return True
    return _lf.stop_seen_this_event(root, payload)


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        payload = {}
    cwd = os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or ROOT
    # THE ESCAPE HATCH IS CONSUMED BY WHOEVER READS IT FIRST.  loop_stop.py DELETES
    # .claude/stop-declared when it honours it, while this gate only tests for the
    # file, so in a chain where loop_stop runs first the declaration is gone before
    # this hook looks and the stop is blocked anyway (r1037).  Reading the file's
    # CONTENT rather than its existence does not fix the race; what fixes it is not
    # depending on ordering, so this gate treats a declaration made in the last few
    # seconds as still in force even when the file has since been removed.
    if not _armed(payload, cwd) or _stop_declared_recently(cwd, payload):
        return 0

    try:
        log = subprocess.run(["git", "log", f"-{LOOK}", "--format=%H%x00%b%x01"],
                             cwd=ROOT, capture_output=True, text=True, check=True).stdout
    except Exception:
        return 0

    voided = set()
    for entry in log.split("\x01"):
        if "\x00" not in entry:
            continue
        for reason in VOID.findall(entry.split("\x00", 1)[1]):
            # THE SAME EXTRACTOR AS THE DEBT SIDE, and it was not.  The debt side was
            # repaired and this twin left on the old one, so `Lean: void -- the name Foo
            # was wrong` voided `name` and closed nothing, silently (r1037).  A closure
            # that silently closes the wrong thing is worse than one that fails loudly.
            for tok in (t.rstrip(".,") for t in IDENT.findall(reason)):
                if DECL_LIKE.match(tok):
                    voided.add(tok)
                    break

    owed = []
    unparseable = []
    for pos, entry in enumerate(log.split("\x01")):
        if "\x00" not in entry:
            continue
        sha, body = entry.split("\x00", 1)
        for reason in TRAILER.findall(body):
            cands = [t.rstrip(".,") for t in IDENT.findall(reason)]
            named = [t for t in cands if DECL_LIKE.match(t)]
            # VOIDED FIRST, AND UNPARSEABLE ONLY WARNS.  The first version ran the
            # unparseable branch before both the grep and the voided set, and blocked
            # on it.  A trailer naming a declaration the extractor cannot read then
            # blocked every armed stop with no way out, because the message's own
            # advice, a `Lean: void` trailer, was checked AFTER the branch that refused
            # it (r1038).  A gate whose escape is unreachable is worse than no gate.
            if not named:
                # An UNREADABLE trailer may still be closed, by any token it carries.
                # That looseness is confined to this branch on purpose.
                if any(t in voided for t in cands):
                    continue
                unparseable.append((sha[:8], reason.strip()[:70]))
                continue
            name = named[0]
            # AND A READABLE ONE IS CLOSED ONLY BY ITS OWN NAME.  Matching any shared
            # token meant a void of `alpha_one` closed a debt named `beta_two` whenever
            # the two reasons shared a word (r1039, probe B): the mirror of the defect
            # this branch was widened to fix.
            if name in voided:
                continue
            try:
                # A DECLARATION, NOT A MENTION.  `-w` was not enough: the name
                # appeared in lean/ only inside a docstring saying it would never be
                # written, and that marked the debt paid (r1039, probe E).  Requiring a
                # declaration keyword before it is what distinguishes the two.
                #
                # THE TRAILING BOUNDARY IS A CHARACTER CLASS, NEVER `\b`.  `git grep -E`
                # uses POSIX ERE, where `\b` is not a word boundary but a LITERAL `b`:
                # `theorem foo\b` matched `theorem foob` and nothing else, so the test
                # asked whether the layer declares <name>b.  NO debt could be paid by
                # writing the thing the hook asks for, and only a `Lean: void` trailer
                # could ever clear one.  A gate that cannot be satisfied is
                # indistinguishable from one nobody has satisfied yet, which is why this
                # went unnoticed while firing.  (A first account of this said the pattern
                # matched NOTHING, which is the wrong description of a real bug: it
                # matched a different thing.)
                hit = subprocess.run(
                    ["git", "grep", "-lE",
                     r"(theorem|lemma|def|abbrev|structure|instance)[[:space:]]+"
                     + re.escape(name) + r"([^A-Za-z0-9_.'!?]|$)",
                     "--", "lean/"],
                    cwd=ROOT, capture_output=True, text=True)
            except Exception:
                continue
            if hit.returncode == 0 and hit.stdout.strip():
                continue                      # the declaration exists: debt paid
            if pos >= AGE:
                owed.append((sha[:8], name, pos))

    if unparseable:
        lines = "\n".join(f"  {sha}  {txt}" for sha, txt in unparseable)
        print(
            "NOTE, not a block: a `Lean: blocked` trailer names no declaration this gate "
            f"can read.\n{lines}\n"
            "The convention is that the reason NAMES a missing declaration, which is what "
            "makes the debt checkable. This is reported so the trailer can be rewritten, "
            "and it does not stop the turn: a gate whose complaint has no reachable escape "
            "is worse than no gate.",
            file=sys.stderr,
        )

    if not owed:
        return 0

    lines = "\n".join(f"  {sha}  {name}  ({pos} commits ago)" for sha, name, pos in owed)
    print(
        "A `Lean: blocked` TRAILER NAMES A DECLARATION THAT IS STILL ABSENT FROM THE LAYER.\n"
        f"{lines}\n\n"
        "The hatch is for an object the base layer genuinely cannot express, and the skill's own "
        "rule is that a blocker the cycle COULD build is built in the same cycle rather than "
        "recorded. A debt nothing reads back ages out of memory while the record builds on top of "
        "it, which is why this reads it back. Either type the named declaration now, even as a "
        "statement with a named `sorry`, or, if the name was wrong or the obligation has been met "
        "under another name, close it with a `Lean: void -- <name> <why>` trailer. To stop instead, write the "
        "reason to .claude/stop-declared.",
        file=sys.stderr,
    )
    return 2


if __name__ == "__main__":
    sys.exit(main())
