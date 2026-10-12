#!/usr/bin/env python3
"""Regenerate the generated blocks of STATUS.md.

STATUS.md is where the programme's position lives between sessions, so a status
reply reads it rather than recomputing it. This script owns the part that can be
COUNTED: the Lean debt, the live skill proposals with their score distribution,
and the live plan items with their grade distribution by section.

What it does NOT own is the part that is a JUDGEMENT: the chain from the goal to
the current item, and the share of the work already done. Those are written into
STATUS.md by hand and persist there, which is the point, a judgement re-invented
at every status is a judgement nobody can argue with.

The plan's grade is a PRODUCT of four small factors, so its range is 0 to 18 and
most values are unoccupied. Banding it in tens the way a proposal score is banded
would put every item in one row and report nothing, so each grade is its own row.

Generated rather than hand-written, because a hand-maintained count goes stale
silently. Run it before answering `status` and before editing STATUS.md by hand.
"""
import collections
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
MARK_A = "<!-- FIGURES START -->"
MARK_B = "<!-- FIGURES END -->"


def lean_debt():
    files = sorted((ROOT / "lean" / "HamiltonsCubic").rglob("*.lean"))
    sites = 0
    withs = 0
    for f in files:
        n = len(re.findall(r"^\s*sorry\s*$", f.read_text(encoding="utf-8"), re.M))
        if n:
            sites += n
            withs += 1
    # Match native_decide as a TACTIC INVOCATION, not as a word in prose. A first
    # version matched the string anywhere and reported 24 files, because the layer
    # discusses retiring it in docstrings; the generated debt list says 2.
    nd = []
    for f in files:
        for line in f.read_text(encoding="utf-8").split("\n"):
            s = line.strip()
            if s == "native_decide" or s.startswith("by native_decide") or s.endswith("native_decide"):
                if not s.startswith("--") and "`" not in s and "*" not in s:
                    nd.append(f.name); break
    return sites, withs, len(files), nd


def proposals():
    """Every row of the proposals table, as (id, total, the WHOLE row's text).

    The note column is not where a promotion is always recorded: one row carries
    its `PROMOTED` marker in the TITLE cell instead, and a reader of the note
    column alone counted that retired row as live AND as held at the bar, which
    inflated both the live count and the number sitting above the promotion bar.
    So the retired test and the HOLD test both read the entire row.
    """
    p = ROOT / ".claude" / "skill-proposals.md"
    rows = []
    for l in p.read_text(encoding="utf-8").split("\n"):
        m = re.match(r"\| (\d+) \| \*\*(\d+)\*\* \| (\d+) \| (\d+) \| (\S+) \|", l)
        if m:
            rows.append((int(m.group(1)), int(m.group(2)), l))
    return rows


STOP = set("a an the is are was were be been being to of in on at by for its it this that as from "
           "into than then so which what when where who whom not and or but with without no never "
           "every each any all one two their there here have has had does do did can cannot must "
           "should would will".split())


def near_duplicate_proposals():
    """Proposal headings sharing three or more content words with another.

    **This finds a FLOOR and not a count.** The file's own rule is that a duplicate arrives under
    a new name, which is why it looks new, so a match on wording catches only the ones that did
    not bother to rename. It is worth running anyway because it is free at every regeneration,
    and a duplicate SPLITS AN OCCURRENCE COUNT: two rows of one rule sat at 64 and 70 while
    their merged evidence was worth 80, the promotion bar.
    """
    import itertools
    heads = []
    for line in (ROOT / ".claude" / "skill-proposals.md").read_text(encoding="utf-8").split("\n"):
        if line.startswith("## ") and "How these are scored" not in line:
            h = line[3:].strip()
            toks = {w for w in re.findall(r"[a-z']+", h.lower()) if w not in STOP and len(w) > 3}
            heads.append((h, toks))
    out = []
    for (h1, t1), (h2, t2) in itertools.combinations(heads, 2):
        if len(t1) < 3 or len(t2) < 3:
            continue
        ov = len(t1 & t2)
        if ov >= 3 and ov / min(len(t1), len(t2)) >= 0.45:
            out.append((h1, h2))
    return out


def plan_grades():
    """Live items per plan section, with the grade distribution of section 1.

    A grade is written into the item line as `Grade **N**`, so an item carrying
    none is counted as ungraded rather than as zero: the two mean different
    things, zero being a judgement and absence being an omission.
    """
    text = (ROOT / "plan.md").read_text(encoding="utf-8")
    want = {"SECTION 1, ADVANCE THE PROOFS": "advance",
            "SECTION 2, BUILD WHAT THE PROOFS NEED": "build",
            "SECTION 3, DISPROVE": "disprove",
            "BLOCKED": "blocked"}
    here = None
    live = collections.Counter()
    grades = collections.Counter()
    ungraded = collections.Counter()
    for line in text.split("\n"):
        m = re.match(r"^## (.+?)\s*$", line)
        if m:
            here = want.get(m.group(1))
            continue
        if here and line.startswith("- [ ] "):
            live[here] += 1
            g = re.search(r"Grade \*\*(\d+)\*\*", line)
            if g:
                grades[(here, int(g.group(1)))] += 1
            else:
                ungraded[here] += 1
    return live, grades, ungraded


def budgets():
    """Check each judgement section against the budget written into its own heading.

    The generated block has no budget: it is as long as the counts require. What needs a
    ceiling is the half a human writes, because a position file with no ceiling becomes a
    second copy of the record and the copy drifts.
    """
    return _sections(_judgement_half((ROOT / "STATUS.md").read_text(encoding="utf-8")))


def _judgement_half(text):
    return re.split(re.escape(MARK_A), text)[0]


def _sections(text):
    """{name: (budget or None, stamp or None, body)} for EVERY `##` heading.

    Every section is returned, not only the marked ones. A version of the file whose heading
    carries no marker still has to be COMPARABLE, or the stale-stamp check passes silently
    whenever the committed copy predates the markers, which is exactly when it is needed.
    """
    out = {}
    # A DICT KEYED BY HEADING COLLAPSES DUPLICATES, and the earlier section then becomes
    # invisible to EVERY check here, budget and stamp included.  That is not only an evasion:
    # an accidental duplicate silently deletes a section from the gate (r1089).
    seen = []
    for part in re.split(r"^## ", text, flags=re.M)[1:]:
        head, _, body = part.partition("\n")
        m = re.search(r"`\[budget: (\d+) words(?: · updated ([0-9-]+ [0-9:]+))?\]`", head)
        name = head.split("`")[0].strip()
        if name in out:
            out["DUPLICATE HEADING: " + name] = (
                None, None, "two sections carry this heading, so the earlier one is invisible "
                "to every check in this file.")
        seen.append(name)
        out[name] = ((int(m.group(1)), m.group(2), body) if m else (None, None, body))
    return out


def check():
    """Over-budget sections, and sections whose text moved without their stamp moving.

    The stamp is VERIFIED rather than trusted. A hand-written date goes stale exactly the way
    the content does, so it is worth nothing unless something reads it back against the text
    it claims to describe.
    """
    cur = _sections(_judgement_half((ROOT / "STATUS.md").read_text(encoding="utf-8")))
    try:
        old_text = subprocess.run(["git", "show", "HEAD:STATUS.md"], cwd=ROOT,
                                  capture_output=True, text=True, check=True).stdout
        prev = _sections(_judgement_half(old_text))
    except (subprocess.CalledProcessError, OSError):
        prev = {}
    problems = []
    for name in cur:
        if name.startswith("DUPLICATE HEADING: "):
            problems.append(
                "DUPLICATE HEADING: " + name[19:] + " appears twice, so the earlier section is "
                "invisible to every check in this file, budget and stamp included.")
    for name, (cap, stamp, body) in cur.items():
        if cap is None:
            continue
        n = len(body.split())
        if n > cap:
            problems.append(f"OVER BUDGET: '{name}' is {n} words against {cap}. Rewrite it, do not append.")
        if stamp is None:
            problems.append(f"NO STAMP: '{name}' carries no `· updated <date> <time>` in its heading.")
        elif name in prev:
            _, old_stamp, old_body = prev[name]
            # A version predating the stamps cannot be compared against, so a stamp being
            # PRESENT is all that is asked there and `NO STAMP` above covers its absence. The
            # real check needs two stamps, and the hole it had was `_sections` returning nothing
            # for an unmarked heading, which made every comparison vacuous rather than lenient.
            if old_stamp is not None and body.split() != old_body.split() and stamp == old_stamp:
                problems.append(
                    f"STALE STAMP: '{name}' changed but its stamp did not move (reads {stamp}).")

    # THE POSITION'S SHAPE IS CHECKED, NOT JUST ITS LENGTH.  STATUS.md's own header says the
    # chain is one node per line and never run together, and gives the reason: a chain run
    # together lets a missing link pass unread.  That rule was broken twice in one session by
    # PARAPHRASE, which no hook can see -- but the paraphrase is only tempting while the file
    # itself still holds the bullets, and a file that has lost them makes the collapse
    # permanent.  So this guards the source the paste reads from.
    # THREE EVASIONS, EACH RUN TO EXIT 0 BEFORE THEY WERE CLOSED (r1087).  The shape check is
    # only as good as its ability to FIND the section and to reject a chain hiding inside one
    # bullet, and a check that iterates over nothing passes silently, which is the worst way for
    # a gate to fail.
    if not any(k.startswith("The position, from the goal") for k in cur):
        problems.append(
            "POSITION MISSING: no section heading starts 'The position, from the goal'. The "
            "shape check iterates over nothing and would otherwise pass in silence.")
    for name, (cap, stamp, body) in cur.items():
        if not name.startswith("The position, from the goal"):
            continue
        # Evasion 1: the whole chain on ONE bullet, padded with decoys to make the count.
        for l in body.split("\n"):
            s = l.strip()
            if s.startswith("- ←") and s.count("←") > 1:
                problems.append(
                    "POSITION RUN TOGETHER: a node bullet carries " + str(s.count("←")) +
                    " arrows. One node per line means one arrow per line.")
        # Evasion 3: a section with no budget marker skips OVER BUDGET and STALE STAMP entirely.
        if cap is None:
            problems.append(
                "POSITION UNMARKED: the position heading carries no `[budget: N words]`, so its "
                "length and its stamp are both unchecked. The marker is not optional.")
        # A FOURTH EVASION, in two forms, both exiting 0 (r1088): the chain on one bullet
        # written with a DIFFERENT arrow glyph plus single-arrow decoys, and three EMPTY `- ←`
        # bullets with the chain deleted outright.  The old test counted the character `←` and
        # never looked past it, so a bullet with no node in it counted as a node.  Count NODES:
        # a bullet with text after its arrow, and reject any arrow glyph appearing twice inside
        # one of them.
        # A LIST, NOT A STRING: iterating the string put bare `-` and `<` in the set, and the
        # first run flagged every bullet containing an ordinary hyphen.
        ARROWS = ["←", "→", "⟵", "⟶", "⇐", "⇒", "<-", "->"]
        arrows = []
        for l in body.split("\n"):
            s = l.lstrip()
            if not s.startswith("- ←"):
                continue
            rest = s[3:].strip()
            if not rest:
                problems.append(
                    "POSITION EMPTY NODE: a `- ←` bullet carries no node after its arrow. The "
                    "check counts nodes, not arrows, so an empty bullet is not one.")
                continue
            if any(a in rest for a in ARROWS):
                problems.append(
                    "POSITION RUN TOGETHER: a node bullet carries a further arrow after its "
                    "own. One node per line means one arrow per line, whichever glyph is used.")
            arrows.append(l)
        if len(arrows) < 3:
            problems.append(
                "POSITION COLLAPSED: the chain has " + str(len(arrows)) + " node lines. It is "
                "one node per line, never run together, because a chain read as a sentence of "
                "arrows lets a missing link pass unread.")
        for l in body.split("\n"):
            s = l.strip()
            if not s.startswith("- ←") and s.count("←") > 1:
                problems.append(
                    "POSITION RUN TOGETHER: a line outside the bullet list carries " +
                    str(s.count("←")) + " arrows. Split it, one node per line.")
    return problems


def main():
    sites, withs, total, nd = lean_debt()
    rows = proposals()
    live_items, grades, ungraded = plan_grades()
    # The hypothesis debt is the kind that hides best: no `sorry` to grep and a green build,
    # so it earns a row of its own rather than a mention.
    try:
        pl = (ROOT / "plan-lean.md").read_text(encoding="utf-8")
        # READ THE DEBT TABLE ONLY.  This grep ran over the WHOLE file, so it matched the
        # goals table too and reported the same count in every state: the separation
        # lean_debts.py makes was undone one file downstream, and "three to one" was still
        # printed as three here (r1089).
        debt_half = pl.split("## The hypothesis debt", 1)[-1].split("## The statement debt", 1)[0]
        hyp_rows = re.findall(r"^\| `(\w+)` \|", debt_half, re.M)
        # The coverage debt: numbered results the layer does not prove at all. A result
        # reaches the `sorry` count only once its claim is typed, so the `sorry` rows alone
        # read as a near-finished layer while most of the record is unformalised.
        cov_half = pl.split("## The coverage debt", 1)[-1] if "## The coverage debt" in pl else ""
        cov_rows = re.findall(r"^\| \d+ \| (\[?L\d+)[^|]*\|[^|]*\| ([^|]*?) \| (main|closed|) \|", cov_half, re.M)
    except OSError:
        hyp_rows, cov_rows = [], []
    hyp, hypnames = len(hyp_rows), ", ".join(f"`{r}`" for r in hyp_rows)
    # A row RETIRED as already held is a ledger row exactly as a PROMOTED one is.
    promoted = [r for r in rows if "PROMOTED" in r[2] or "RETIRED" in r[2]]
    live = [r for r in rows if r not in promoted]
    buckets = collections.Counter((r[1] // 10) * 10 for r in live)
    at_bar = [r for r in live if r[1] >= 80]
    held = [r for r in at_bar if "HOLD" in r[2].upper()]
    # A bare `HOLD` is a deferral with no recorded reason, which is the same
    # invisible debt this file exists to surface: it reads as a decision taken
    # while nobody can say what it was. The reason lives in the proposal's body,
    # so a row whose body never says `HELD` or `HOLD until` is counted here.
    bare = []
    for r in held:
        cells = [c.strip() for c in r[2].split("|")]
        note = next((c for c in cells if "HOLD" in c.upper()), "")
        if re.sub(r"[*_`,.\s]", "", note).upper() == "HOLD":
            bare.append(r[0])

    out = [MARK_A, "", "## Standing figures", "",
           "*Generated by [status_report.py](scripts/misc/status_report.py). Do not edit by hand.*", "",
           "**Lean debt**", "",
           "| kind | count | where |", "| --- | --- | --- |",
           f"| `sorry` sites | {sites} | across {withs} of {total} files |",
           f"| files carrying a `sorry` | {withs} | of {total} |",
           f"| `native_decide` | {len(nd)} | {', '.join(nd) if nd else 'none'} |",
           f"| unproved hypothesis claims | {hyp} | {hypnames or 'none'} |",
           f"| numbered results with no Lean proof | {len(cov_rows)} | "
           f"{sum(1 for r in cov_rows if r[2] == 'main')} on the main route; "
           f"{sum(1 for r in cov_rows if r[1] == 'partial')} partial, "
           f"{sum(1 for r in cov_rows if r[1] == 'statement only')} statement only, "
           f"{sum(1 for r in cov_rows if r[1] == 'no Lean row')} untouched; "
           f"next in the lean loop's queue: {cov_rows[0][0].lstrip('[') if cov_rows else 'none'} |", "",
           f"**Skill proposals**: {len(live)} live, {len(promoted)} promoted and retired.", "",
           "| score band | live proposals |", "| --- | --- |"]
    for band in sorted(buckets, reverse=True):
        out.append(f"| {band}–{band+9} | {buckets[band]} |")
    out += ["",
            f"**At or above the 80 bar**: {len(at_bar)}, of which {len(held)} carry an explicit HOLD "
            f"and {len(at_bar) - len(held)} are eligible for promotion.", ""]
    if bare:
        out += [f"**{len(bare)} of those HOLDs carry NO REASON in the row**, "
                + ", ".join(str(b) for b in bare)
                + ". *A bare HOLD reads as a decision taken while nobody can say what it was, "
                  "and the reason has to be in the row because the row is what the promotion pass reads.*", ""]

    order = ["advance", "build", "disprove", "blocked"]
    names = {"advance": "1, advance", "build": "2, build",
             "disprove": "3, disprove", "blocked": "blocked"}
    out += [f"**Plan**: {sum(live_items.values())} live items, "
            + ", ".join(f"{live_items[k]} in section {names[k]}" for k in order) + ".", "",
            "*The grade is `closes x attackable x margin x analytic`, so a zero in any "
            "factor sinks the item and the occupied values are few.*", "",
            "| grade | " + " | ".join(names[k] for k in order) + " |",
            "| --- | " + " | ".join("---" for _ in order) + " |"]
    seen = sorted({g for _, g in grades}, reverse=True)
    for g in seen:
        out.append(f"| {g} | " + " | ".join(str(grades[(k, g)]) for k in order) + " |")
    out.append("| ungraded | " + " | ".join(str(ungraded[k]) for k in order) + " |")
    # Section 1's own ceiling is the figure that matters, and it is NOT the
    # maximum over the table: the highest grade on the list has sat in BLOCKED,
    # where a grade describes an item nothing can currently start.
    s1 = [g for (k, g) in grades if k == "advance"]
    if s1:
        top = max(s1)
        out += ["",
                f"**Section 1 tops out at grade {top}**, held by {grades[('advance', top)]} item(s), "
                f"against {max(seen)} as the highest grade anywhere on the list."]
    out += ["", MARK_B]

    d = ROOT / "STATUS.md"
    t = d.read_text(encoding="utf-8")
    block = "\n".join(out)
    if MARK_A in t:
        t = re.sub(re.escape(MARK_A) + r".*?" + re.escape(MARK_B), block, t, flags=re.S)
    else:
        t = t.rstrip("\n") + "\n\n---\n\n" + block + "\n"
    d.write_text(t, encoding="utf-8")
    print(block)
    problems = check()
    for line in problems:
        print(line)
    for h1, h2 in near_duplicate_proposals():
        print(f"NEAR-DUPLICATE PROPOSALS, check whether the repair is the same repair:\n"
              f"    A: {h1}\n    B: {h2}")
    return 1 if problems else 0


def paste():
    """The FIXED parts of a status reply, emitted so they are quoted rather than retyped.

    PARTS 1, 2, 7 AND 8 ARE NOT THE ASSISTANT'S TO WRITE, and saying so in the skill was not
    enough: the generated block was quoted correctly every time while the position, which is
    hand-written prose, was paraphrased from memory twice in one session and both times the
    chain was collapsed onto one line.  STATUS.md forbids exactly that, and gives the reason:
    a chain run together lets a missing link pass unread.

    The rule failed because it is READ at read time and broken at WRITE time, under brevity
    pressure, and because a chat reply is the one artefact in this repository that no hook can
    inspect.  So the fix is not another statement of the rule.  It is to make the fixed parts
    the output of a command: collapsing a chain then means editing what a command printed,
    which is a different and much more visible act than shortening a remembered sentence.

    Parts 3 to 6 are deliberately absent.  They are live judgement, they are the assistant's
    to assemble, and a script that emitted them would be inventing them.
    """
    d = ROOT / "STATUS.md"
    text = d.read_text(encoding="utf-8")
    secs = _sections(_judgement_half(text))
    gen = text.partition(MARK_A)[2].partition(MARK_B)[0].strip()
    out = ["=== PASTE VERBATIM. Parts 1, 2, 7 and 8 of the status reply. ===",
           "=== Reflow NOTHING: the chain is one node per line for a reason. ===", ""]
    for name in ("The position, from the goal to the current item",
                 "Share of the work towards P"):
        for k, v in secs.items():
            if k.startswith(name):
                out += ["## " + k, v[2].strip(), ""]
                break
        else:
            out += [f"!! STATUS.md has no section '{name}' -- the paste is INCOMPLETE", ""]
    out += [gen, "",
            "=== Parts 3 to 6 are yours: the current item with all four grade factors, the",
            "=== stage as a percentage, what is running, and what THIS cycle found."]
    print("\n".join(out))
    return 0


if __name__ == "__main__":
    if "--paste" in sys.argv:
        sys.exit(paste())
    sys.exit(main())
