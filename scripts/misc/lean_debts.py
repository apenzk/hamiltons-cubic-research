#!/usr/bin/env python3
"""Generate plan-lean.md: what the Lean layer still owes, read off the layer.

WHY IT IS GENERATED.  A debt list maintained by hand outlives the debt.  Someone
discharges a `sorry`, the row stays, and a later reader cannot tell an open item
from a stale one without opening the file it names.  Here the list is rebuilt
from the sources and from the axiom audit, so a row leaves when the thing it
records leaves, and nobody deletes anything.

TWO KINDS OF DEBT, AND THEY ARE DIFFERENT.

  A `sorry` is a claim the layer states and has not proved.  The statement is
  worth having on its own, so this is honest debt: the type pins the claim and
  the proof is owed.

  A `native_decide` is a claim the layer proved by trusting the Lean compiler
  rather than the kernel.  It reads as proved and is weaker than proved, which
  is the more dangerous of the two, and it propagates: every theorem importing
  such a declaration inherits the trust.

WHAT FEEDS IT.  `sorry` sites come from the sources directly, which needs no
build.  The compiler-dependent declarations come from the JSON that
axiom_audit.py writes, which does need one:

    python3 scripts/misc/axiom_audit.py --json lean/axioms.json
    python3 scripts/misc/lean_debts.py

Without the JSON the file is still generated, carrying the `sorry` half and
saying plainly that the other half is stale.
"""
import argparse
import collections
import datetime
import json
import os
import re
import subprocess
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PKG = os.path.join(REPO, "lean", "HamiltonsCubic")
OUT = os.path.join(REPO, "plan-lean.md")
AXIOMS = os.path.join(REPO, "lean", "axioms.json")

TACTIC_USE = re.compile(r"(?:^|[\s;|])native_decide(?:[\s,)]|$)")

COMPILER_SHAPE = re.compile(r"\._native\.native_decide\.|^Lean\.(ofReduceBool|trustCompiler)$")
DECL = re.compile(
    r"^(?:private\s+|protected\s+|noncomputable\s+|nonrec\s+)*"
    r"(?:theorem|lemma)\s+([A-Za-z_][A-Za-z0-9_'!?₀-₉]*)")
SORRY = re.compile(r"(?<![A-Za-z_])sorry(?![A-Za-z_])")

# A PARAMETERLESS `def X : Prop` is a claim; a parameterised one is a predicate.
# The distinction is the whole detector: `CarriesEdge g v` describes an object
# and is definitional, while a `Prop` taking no arguments asserts something, and
# an assertion nobody proves is a debt however ordinary its definition looks.
CLAIM = re.compile(r"^def\s+([A-Za-z_][A-Za-z0-9_']*)\s*:\s*Prop\b")


def relpath(path):
    return os.path.relpath(path, REPO)


def sources():
    out = []
    for root, _, files in os.walk(PKG):
        for f in sorted(files):
            if f.endswith(".lean"):
                out.append(os.path.join(root, f))
    return sorted(out)


def sorry_sites(path):
    """Every `sorry` in one file, with the theorem it sits under and its docstring.

    Comment depth is tracked rather than guessed.  This layer discusses its own
    debts in module docstrings -- "L15 states it and carries its `sorry` there"
    -- and a scanner that only skips lines starting with a comment marker reads
    every one of those as an open obligation.  A `sorry` inside backticks is
    prose about a `sorry`, not one.

    The theorem is the last declaration seen above the site, and the docstring is
    the `/-- ... -/` block above that theorem, which is where this layer records
    what a proof is waiting on.  Both are read rather than required.
    """
    text = open(path, encoding="utf-8").read()
    sites, decl, doc, depth = [], None, "", 0
    for i, line in enumerate(text.splitlines(), 1):
        stripped = line.strip()

        # A `/-- ... -/` docstring on its own is captured; every other block
        # comment is skipped entirely.
        if depth == 0 and stripped.startswith("/--") and stripped.endswith("-/"):
            doc = stripped[3:-2].strip()
            continue
        opens = line.count("/-")
        closes = line.count("-/")
        if depth == 0 and opens > closes and stripped.startswith("/--"):
            doc, depth = stripped[3:], depth + opens - closes
            continue
        if depth > 0:
            if doc:
                doc += " " + (stripped[:-2] if stripped.endswith("-/") else stripped)
            depth += opens - closes
            continue
        if opens > closes:
            depth += opens - closes
            continue
        if stripped.startswith("--"):
            continue

        m = DECL.match(stripped)
        if m:
            decl = m.group(1)
            continue
        # `sorry` inside backticks is prose about one.
        bare = re.sub(r"`[^`]*`", "", line)
        if SORRY.search(bare):
            sites.append((i, decl or "?", " ".join(doc.split())[:240]))
            doc = ""
    return sites


def strip_comments(text):
    """Lean source with `--` lines and `/- -/` blocks removed.

    PROSE IS WHERE THE MISCOUNT CAME FROM.  A docstring saying "this is a
    hypothesis in the same way `X` is" names `X` and binds nothing, and the
    first version of this file counted every such file as a consumer.
    """
    text = re.sub(r"/-.*?-/", " ", text, flags=re.S)
    return re.sub(r"--[^\n]*", " ", text)


def binder_re(name):
    """`(h : X)`, `{h : X}`, `[inst : X]` or `⦃h : X⦄`: a real dependency on `X`."""
    n = re.escape(name)
    return re.compile(
        r"[(\{\[⦃]\s*[A-Za-z_][A-Za-z0-9_'!?₀-₉]*"
        r"(?:\s+[A-Za-z_][A-Za-z0-9_'!?₀-₉]*)*\s*:\s*" + n + r"(?![A-Za-z0-9_'])")


def producer_re(name):
    """A declaration whose CONCLUSION is `X`, with whatever arguments it carries.

    `theorem foo : X (ι := ι) := by`, a continuation line `    X := by`, and
    `    X (a := b) c d e := by` all count, as does a qualified `Ns.X`.  This is
    the opposite of a consumer and the first version of this file counted it as
    one.  THE ARGUMENT RUN IS WHY THE SECOND VERSION STILL MISSED THEM: it
    allowed parenthesised arguments only, and an instantiation applies most of
    its arguments bare, so a file that discharged a claim outright still read as
    concluding nothing.
    """
    n = re.escape(name)
    arg = r"(?:[ \t]*(?:\([^()]*\)|\{[^{}]*\}|[A-Za-z_][A-Za-z0-9_'.]*))*"
    qual = r"(?:[A-Za-z_][A-Za-z0-9_']*\.)*"
    return re.compile(r"(?:^[ \t]*|:[ \t]*)" + qual + n + arg + r"[ \t]*:=", re.M)


def hypothesis_debts():
    """Closed claims the layer states, never proves, and passes round as binders.

    THE THIRD KIND OF DEBT, AND THE ONE THAT HIDES BEST.  A `sorry` announces
    itself and `native_decide` shows in the axioms.  A `Prop` that is defined,
    taken as a hypothesis by several results, and proved nowhere reads as
    ordinary machinery: every file mentioning it type-checks, the build is
    green, and the axiom audit is clean, because a conditional theorem really is
    proved.  What is unproved is its antecedent, and nothing counts those.

    A CONSUMER IS A FILE WITH A BINDER, NOT A FILE WITH THE NAME IN IT.  This
    function read `if name in text` until 2026-09-18, and an audit against the
    tree found SIX of the seven rows it produced wrong, in both directions:
    prose mentions counted as consumers, theorems CONCLUDING the claim counted
    as consumers, binders in the defining file dropped by an explicit exclusion,
    and two different `Prop`s of the same name collapsed into one row.  Every
    one of those follows from that one line.

    A claim is discharged when some declaration concludes it with no explicit
    binders of its own.  One that concludes it WITH binders is a conditional
    producer and moves the debt rather than closing it, so it is reported and
    the row stays.
    """
    defined = collections.defaultdict(list)
    for path in sources():
        rel = relpath(path)
        for i, line in enumerate(open(path, encoding="utf-8").read().splitlines(), 1):
            m = CLAIM.match(line.strip())
            if m:
                defined[m.group(1)].append((rel, i))

    consumers = collections.defaultdict(set)
    producers = collections.defaultdict(set)
    discharged = set()
    for path in sources():
        rel = relpath(path)
        text = strip_comments(open(path, encoding="utf-8").read())
        for name in defined:
            if not re.search(rf"(?<![A-Za-z0-9_']){re.escape(name)}(?![A-Za-z0-9_'])", text):
                continue
            if binder_re(name).search(text):
                consumers[name].add(rel)
            for m in producer_re(name).finditer(text):
                producers[name].add(rel)
                head = text.rfind("theorem ", 0, m.start())
                head = max(head, text.rfind("lemma ", 0, m.start()))
                sig = text[head:m.start()] if head >= 0 else ""
                # An explicit binder in the producer's own signature makes it
                # conditional: it moves the debt rather than closing it.
                if not re.search(r"[(\{⦃]", sig):
                    discharged.add(name)

    # A GOAL AND AN ABANDONED HYPOTHESIS HAVE THE SAME SHAPE HERE: defined once, taken by
    # nothing, concluded by nothing.  The table listed them together, and the definition's own
    # docstring warned that a reader working the table as a debt list would delete the statement
    # of the problem.  A generated file cannot carry that distinction unless the SOURCE marks it,
    # so the source does, with `Debt class: goal.` in the docstring, and this reads it back.
    goals = set()
    for name, places in defined.items():
        for rel, ln in places:
            try:
                src = open(os.path.join(REPO, rel), encoding="utf-8").read().splitlines()
            except OSError:
                continue
            head = "\n".join(src[max(0, ln - 40):ln])
            if "Debt class: goal." in head.rsplit("/--", 1)[-1]:
                goals.add(name)

    return ({
        n: (defined[n], sorted(consumers[n]), sorted(producers[n]))
        for n in defined if n not in discharged and n not in goals
    }, {
        n: defined[n] for n in sorted(goals) if n not in discharged
    })


def compiler_rows():
    """Declarations resting on the compiler, grouped by file, from the audit."""
    if not os.path.exists(AXIOMS):
        return None
    ax = json.load(open(AXIOMS, encoding="utf-8"))
    by_module = collections.defaultdict(list)
    for name, axioms in ax.items():
        if not any(COMPILER_SHAPE.search(a) for a in axioms):
            continue
        # A declaration at the root namespace has no dot to split on.
        ns, _, short = name.rpartition(".")
        by_module[ns or "(root)"].append(short or name)
    return by_module


def module_file(namespace):
    """Best-effort path for a namespace, by matching the last dotted segment."""
    tail = namespace.rsplit(".", 1)[-1]
    for path in sources():
        if os.path.basename(path)[: -len(".lean")] == tail:
            return relpath(path)
    return None


def native_decide_files():
    """Files whose SOURCE uses `native_decide`, with a count of the uses.

    This is what the work is actually organised by: a debt is retired file by
    file, and the audit's per-declaration list does not say where the tactic was
    written.  A declaration inheriting the trust through an import is covered
    when the file it came from is fixed.
    """
    counts = {}
    for path in sources():
        text = open(path, encoding="utf-8").read()
        counts_here = 0
        depth = 0
        for line in text.splitlines():
            # Track `/- ... -/` nesting so DOCSTRING PROSE is never counted.
            # A line-start test cannot do this: a docstring's CONTINUATION lines
            # begin with ordinary words, so a paragraph naming the tactic read
            # as a use of it, and the Base count came out 25 against 17 real.
            stripped = line.strip()
            opens = line.count("/-")
            closes = line.count("-/")
            was_in = depth > 0
            depth += opens - closes
            if depth < 0:
                depth = 0
            if was_in or opens > closes or stripped.startswith("--"):
                continue
            # And require the TACTIC shape, not the mere name: a line may cite
            # the tactic in a `set_option` or a string and not invoke it.
            if TACTIC_USE.search(line):
                counts_here += 1
        if counts_here:
            counts[relpath(path)] = counts_here
    return counts



def coverage_rows():
    """Every numbered result not proved in Lean, main route first.

    A `sorry` reaches the statement debt only once someone has typed the claim, so a
    result whose unfinished half was never typed, or that has no Lean row at all, is
    invisible there. This table is read from the record's numbering and lean/INDEX.md
    instead, so what it lists is the gap between the record and the layer.

    Order: results the main-route dependency figure draws, then results the closed-route
    figure draws, then by how many results rest directly on each, then by id.
    """
    def ids_in(path):
        try:
            return set(re.findall(r"\(n(\d+)\)", open(os.path.join(REPO, path), encoding="utf-8").read()))
        except OSError:
            return set()
    main_route = ids_in("report/sections/diagram-dag.tex")
    closed_route = ids_in("report/sections/diagram-closed-dag.tex")
    rests_on = {}
    try:
        for a, b in json.load(open(os.path.join(REPO, "report", "result-graph.json")))["dep"]:
            rests_on[b] = rests_on.get(b, 0) + 1
    except (OSError, ValueError, KeyError):
        pass

    record = {}
    for line in open(os.path.join(REPO, "findings", "INDEX-results.md"), encoding="utf-8"):
        m = re.match(r"^\|\s*\*\*(\d+)\*\*\s*\|\s*([^|]*?)\s*\|[^|]*\|\s*(.*?)\s*\|\s*$", line)
        if not m:
            continue
        kind = m.group(2).strip()
        if kind.upper().startswith("WITHDRAWN") or kind.lower().startswith("conjecture"):
            continue
        link = re.search(r"\[[^\]]*\]\(([^)]*)\)", m.group(3))
        record[m.group(1)] = (kind, os.path.normpath(os.path.join("findings", link.group(1))) if link else "")

    state = {}
    for line in open(os.path.join(REPO, "lean", "INDEX.md"), encoding="utf-8"):
        if not line.startswith("| "):
            continue
        cells = [c.strip() for c in line.split("|")]
        if len(cells) < 6 or cells[1].startswith("I") or cells[1] == "id":
            continue
        m = re.search(r"\bL(\d+)\b", cells[1])
        if not m:
            continue
        st = re.sub(r"[*`]", "", cells[3]).strip().lower()
        word = st.split(",")[0].split("(")[0].strip().split(" ")[0] if st else ""
        owed = re.sub(r"\s+", " ", cells[4])
        kind = "statement" if "(statement)" in cells[1] else "result"
        state.setdefault(m.group(1), []).append((kind, word, owed))

    rows = []
    for n, (knd, where) in record.items():
        entries = state.get(n, [])
        if any(k == "result" and w == "proved" for k, w, _ in entries):
            continue
        part = [o for k, w, o in entries if k == "result" and w == "partial"]
        if part:
            now, owed = "partial", part[0]
        elif entries:
            now, owed = "statement only", entries[0][2]
        else:
            now, owed = "no Lean row", ""
        route = "main" if n in main_route else ("closed" if n in closed_route else "")
        rank = (0 if route == "main" else 1 if route == "closed" else 2, -rests_on.get(n, 0), int(n))
        rows.append((rank, n, knd, now, route, rests_on.get(n, 0), owed, where))
    rows.sort()
    return rows

def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--out", default=OUT)
    args = ap.parse_args()

    files = sources()
    sorries = [(relpath(p), s) for p in files for s in [sorry_sites(p)] if s]
    n_sorry = sum(len(s) for _, s in sorries)
    nd = native_decide_files()
    comp = compiler_rows()

    today = datetime.date.today().isoformat()
    L = []
    L.append("# The Lean layer's open debts")
    L.append("")
    L.append(f"**GENERATED by [lean_debts.py](scripts/misc/lean_debts.py) from the layer itself, on {today}. Nothing here is edited by hand.** A row leaves this file when its `sorry` is discharged or its `native_decide` retired, so an entry standing here is an entry still owed. *Editing it by hand is the one way it can lie: a row deleted while the debt stands reappears on the next run, and a row added by hand never leaves.*")
    L.append("")
    L.append(f"**Regenerate with `python3 scripts/misc/lean_debts.py`**, after `python3 scripts/misc/axiom_audit.py --json lean/axioms.json` when the second table is to move. *The first table is read from the sources, so it is as current as the last run of this script. The second is read from the audit and is as old as the audit.*")
    L.append("")
    cov = coverage_rows()
    L.append(f"**{len(cov)} numbered results carry no Lean proof** (the coverage debt, last section, which the lean loop works from).")
    L.append("")
    L.append(f"Read from **{len(files)} files**: **{n_sorry} open `sorry`** across {len(sorries)} of them, and **`native_decide` in {len(nd)} files**"
             + (f", tainting **{sum(len(v) for v in comp.values())} declarations**." if comp else ", with no axiom audit on disk to say what they taint."))
    L.append("")

    L.append("## The compiler debt: proved by trusting the Lean compiler rather than the kernel")
    L.append("")
    L.append("**These read as proved and are weaker than proved.** `native_decide` evaluates the claim with the compiled evaluator and the kernel takes the answer on trust, so the guarantee covers the compiler and its backend as well as the kernel. **The trust propagates**: every theorem importing one of these inherits it, which is why the base layer dominates the table.")
    L.append("")
    L.append("*Retiring one is a derivation rather than a tactic swap.* Kernel arithmetic on `ℚ` reduces through `Rat.normalize`, which is exactly what the kernel will not unfold cheaply, so `decide` walls on these sums. **`norm_num` DOES NOT WALL, because it emits a certificate the kernel checks rather than asking the kernel to evaluate**, and [Sharp.lean](lean/HamiltonsCubic/Base/Sharp.lean) was retired entirely this way on 2026-09-20, four declarations including the layer's normalisation anchor. *A first version of this paragraph said `norm_num` walls too, which was a route recorded closed from one attempt.* **The unfold set is the work**: `Fin.sum_univ_six` rather than `Fin.sum_univ_succ`, so an index match meets literal indices instead of `Fin.succ` terms and reduces at all; `Matrix.cons_val_two`, `_three` and `_four` with `Matrix.vecHead` and `Matrix.vecTail`, so a `![...]` literal evaluates at a numeral; `Fin.ext_iff` so residual `Fin` equalities decide; and a raised `maxHeartbeats` with `simp`\'s own `maxSteps` where the term is large, the config going BEFORE `only`. **The other route, proving the general-`n` statement and taking the fixed dimension as a corollary, removes the axiom AND strengthens the claim**, so it is the better one where the general statement is true and reachable.")
    L.append("")
    L.append("**AND `native_decide` BUYS SPEED AS WELL AS CONVENIENCE, WHICH IS WHAT MAKES A RETIREMENT COST SOMETHING.** *The compiled evaluator settles a closed rational computation in milliseconds where the kernel grinds through every step of it*, so a retirement can turn a module that built in seconds into one that takes minutes, **and every later build pays that, not just the cycle that made the change.** *A retirement reported only as `#print axioms` clean has reported half of it.* **SO TIME THE MODULE BEFORE AND AFTER, AND PUT BOTH NUMBERS IN THE COMMIT.** Where the cost is large the answer is usually a better proof rather than a reverted one: **the general-`n` route is fast** because it replaces a fixed-dimension expansion with a structural argument, and a brute `simp` over every entry at a raised heartbeat limit is the shape that gets expensive.")
    L.append("")
    if comp:
        top = sorted(comp.items(), key=lambda kv: -len(kv[1]))
        where = ", ".join(f"`{ns}` carries {len(d)}" for ns, d in top[:4])
        L.append(f"**Where the taint lands, by namespace**: {where}. *The namespace a declaration ends up in is not the file the tactic was written in, so the table below is the work list and this line is its consequence.*")
        L.append("")
    L.append("| file | uses of `native_decide` |")
    L.append("| --- | --- |")
    for path, uses in sorted(nd.items(), key=lambda kv: (-kv[1], kv[0])):
        L.append(f"| [{path}]({path}) | {uses} |")
    L.append("")

    debts, goals = hypothesis_debts()
    if goals:
        L.append("## The goal, which is NOT a debt")
        L.append("")
        L.append("**A goal and an abandoned hypothesis have the same shape in the table below**: defined once, "
                 "taken as a hypothesis by nothing, concluded by nothing. *They were listed together until "
                 "2026-09-23, and the definition's own docstring warned that a reader working that table as a "
                 "debt list would delete the statement of the problem.*")
        L.append("")
        L.append("**A generated file cannot carry the distinction unless the SOURCE marks it**, so the source "
                 "does: the marker is `Debt class: goal.` in the definition's docstring, and this section is "
                 "what reads it back. *A goal that lost its marker would silently rejoin the debt list, which "
                 "is why the marker sits beside the definition rather than in a list kept here.*")
        L.append("")
        L.append("| claim | defined |")
        L.append("| --- | --- |")
        for n, places in goals.items():
            where = ", ".join(f"[{r.split('/')[-1]}:{ln}]({r})" for r, ln in places)
            L.append(f"| `{n}` | {where} |")
        L.append("")
    L.append("## The hypothesis debt: closed claims stated, passed round, and proved nowhere")
    L.append("")
    L.append("**This is the kind that hides best.** A `sorry` announces itself and a `native_decide` shows in the axiom set. *A `Prop` defined once, taken as a hypothesis by several results and proved nowhere reads as ordinary machinery*: every file naming it type-checks, the build is green, and the axiom audit comes back clean, because **a conditional theorem really is proved**. What is unproved is its antecedent, and nothing else in this repository counts those.")
    L.append("")
    L.append("**A ROW WITH NO CONSUMERS IS NOT THEREBY DEAD WEIGHT, AND THIS TABLE CANNOT TELL A GOAL FROM AN ABANDONED HYPOTHESIS.** *A statement of the problem has exactly this shape: defined once, taken by nothing, concluded by nothing.* **So read the definition before working a consumerless row**, since the cheapest-looking entry here is the one whose deletion costs most.")
    L.append("")
    L.append("**Keeping such a claim as a hypothesis rather than an `axiom` is the right call and is not what is owed.** *A binder is visible to every reader and every caller, where an `axiom` is visible only to `#print axioms`.* **What is owed is that each of these is either proved or retired**, since every result taking one is conditional until then.")
    L.append("")
    L.append("**A CONSUMER HERE IS A FILE WITH A BINDER.** *This column read `if the name appears in the file` until 2026-09-18, and an audit against the tree found SIX of the seven rows it produced wrong, in both directions: prose mentions counted as consumers, theorems CONCLUDING the claim counted as consumers, binders in the defining file dropped by an explicit exclusion, and two different `Prop`s of the same name collapsed into one row.* **A prose mention is a reader\'s signpost and a binder is a debt**, and only the second is counted below.")
    L.append("")
    L.append("**A claim with a CONDITIONAL producer keeps its row.** *A theorem concluding the claim from hypotheses of its own moves the debt rather than closing it, and the producer column says where it moved to.*")
    L.append("")
    L.append("| claim | defined | taken as a hypothesis by | concluded by |")
    L.append("| --- | --- | --- | --- |")
    for name, (sites, consumers, producers) in sorted(debts.items()):
        where = ", ".join(f"[{os.path.basename(pa)}:{ln}]({pa})" for pa, ln in sites)
        if len(sites) > 1:
            where = f"**DEFINED {len(sites)} TIMES**, {where}"
        who = ", ".join(f"[{os.path.basename(c)}]({c})" for c in consumers) or "nothing"
        made = ", ".join(f"[{os.path.basename(c)}]({c})" for c in producers) or "nothing"
        L.append(f"| `{name}` | {where} | {who} | {made} |")
    L.append("")

    L.append("## The statement debt: claims typed and not yet proved")
    L.append("")
    L.append("**A `sorry` is honest debt.** The type pins the claim, every hypothesis is a binder, and what is owed is the proof. *A statement worth having arrives before its proof does, and this table is what the layer has stated and not closed.*")
    L.append("")
    L.append("**The trap to check when discharging one is a binder that excludes nothing.** A hypothesis written to import a classical theorem, satisfied by every object in range, clears the `sorry` and leaves the debt exactly where it was, in a form this table reads as discharged. *Before closing a `sorry`, exhibit an object its hypotheses rule out.*")
    L.append("")
    L.append("| file | line | theorem | what is owed |")
    L.append("| --- | --- | --- | --- |")
    for path, sites in sorted(sorries):
        for line, decl, doc in sites:
            L.append(f"| [{path}]({path}) | {line} | `{decl}` | {doc or 'no docstring at the site'} |")
    L.append("")

    L.append("## The coverage debt: numbered results the layer does not prove")
    L.append("")
    L.append(f"**{len(cov)} of the record's numbered results carry no Lean proof**, read from [findings/INDEX-results.md](findings/INDEX-results.md) and [lean/INDEX.md](lean/INDEX.md), withdrawn results and conjectures excluded. *A result reaches the statement debt above only once its claim is typed, so this is the table that measures the layer against the record.* **The lean loop takes its next id from the top of this table.**")
    L.append("")
    L.append("**Order: the main route first** (the results the report's main-route dependency figure draws), **then the closed routes, then by how many results rest directly on each.** *`partial` means one half is proved, and the last column is lean/INDEX.md's account of that half; `statement only` means the claim type-checks and nothing is proved; `no Lean row` means the layer has not touched it.*")
    L.append("")
    L.append("| # | result | kind | Lean state | route | rested on by | what the Lean row checks |")
    L.append("| --- | --- | --- | --- | --- | --- | --- |")
    for i, (_, n, knd, now, route, deps, owed, where) in enumerate(cov, 1):
        link = f"[L{n}]({where})" if where else f"L{n}"
        owed = owed if len(owed) <= 220 else owed[:217] + "..."
        L.append(f"| {i} | {link} | {knd} | {now} | {route} | {deps} | {owed} |")
    L.append("")

    with open(args.out, "w", encoding="utf-8") as fh:
        fh.write("\n".join(L) + "\n")
    print(f"{args.out}: {n_sorry} sorry sites, native_decide in {len(nd)} files, "
          f"{len(debts)} unproved claims")
    return 0


if __name__ == "__main__":
    sys.exit(main())
