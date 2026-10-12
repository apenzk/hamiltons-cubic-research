#!/usr/bin/env python3
"""The axiom gate: what every theorem in the Lean layer actually rests on.

WHAT `#print axioms` REPORTS.  Lean walks a declaration's whole dependency tree
and returns the declarations in it that carry no proof.  A lemma you proved is
absent, whatever its depth, because it has a proof; what surfaces are the roots.
So one call on a theorem covers every lemma beneath it, and three answers are
possible:

    propext, Classical.choice, Quot.sound   the standard three: kernel-checked
    sorryAx                                 a `sorry` somewhere beneath it
    Lean.ofReduceBool, Lean.trustCompiler   `native_decide` somewhere beneath it

THE FAILURE THIS ADDRESSES.  `lake build` succeeds with `sorry` in the tree, and
succeeds with `native_decide` in the tree.  A row in lean/INDEX.md reading
`proved` records that the file compiled, which is a weaker fact than the word
says, and nothing in the repository has ever measured the difference.

HOW IT RUNS.  Declarations are read out of the source, a Lean module of
`#print axioms` calls is generated and built, and the build output is parsed
back.  The generated module is deleted afterwards, so the audit leaves no file
to drift out of step with the layer.

    python3 scripts/misc/axiom_audit.py                 # audit, print, exit 1 on dirt
    python3 scripts/misc/axiom_audit.py --json out.json # also write the full table
    python3 scripts/misc/axiom_audit.py --only L182     # one module, for a quick check

EXCEPTIONS.  A declaration listed in scripts/misc/axiom_audit_allow.txt is
reported and does not fail the gate.  One name per line, `#` for comments, and a
reason on the same line after the name.  An allow file is where a deliberate
`native_decide` is recorded; a `sorry` is never allowed, since the point of the
gate is that a `sorry` beneath a theorem means the theorem is unproved.
"""
import argparse
import json
import os
import re
import subprocess
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
LEAN = os.path.join(REPO, "lean")
PKG = os.path.join(LEAN, "HamiltonsCubic")
LAKE = os.path.expanduser("~/.elan/bin/lake")
ALLOW = os.path.join(REPO, "scripts", "misc", "axiom_audit_allow.txt")

MODULE = "AxiomAudit"
# WRITTEN BESIDE THE PACKAGE, NOT INSIDE IT.  lean_orphans.py refuses a commit while any
# module under `lean/HamiltonsCubic/` is unreachable from the library root, and this file
# is generated, unimported and deleted at the end of the run.  Inside the package it
# therefore wedges the commit path for as long as an audit runs, and permanently if the
# process is killed or `--keep` is passed (r1036).  NOT every commit: r1037 corrected
# that overstatement, since .githooks/pre-commit exits 0 before reaching the orphan
# check unless a lean/**.lean file is staged.  `lake env lean`
# elaborates it just as well from one directory up.
GENERATED = os.path.join(os.path.dirname(PKG), MODULE + ".lean")

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
SORRY = {"sorryAx"}
# `native_decide` does not surface as `Lean.ofReduceBool` here.  Each use mints
# its own axiom, named after the theorem it closes:
#     HamiltonsCubic.Base.sharpQF_one_basis._native.native_decide.ax_1_1
# One theorem can carry several, one per goal the tactic discharged, so the
# compiler axioms are recognised by shape rather than by a fixed set.
COMPILER_SHAPE = re.compile(r"\._native\.native_decide\.|^Lean\.(ofReduceBool|trustCompiler)$")

# A declaration line, after any attribute lines.  `theorem` and `lemma` only:
# `def` and `instance` carry no proof obligation worth auditing on their own,
# and they reach the report anyway through whatever theorem uses them.
# THE NAME GROUP ADMITS A DOT, and leaving it out hid twenty-seven theorems.  A
# declaration written `theorem IsWeylOf.add` was collected as `IsWeylOf`, the name of
# the STRUCTURE it extends, which resolves, reports clean, and stands in for the
# theorem that was never asked about.  Twenty-seven such collapsed onto seventeen
# `def` prefixes, and the ten resulting repeats were then read as duplicate names and
# deduplicated away, which SILENCED A CORRECT ALARM rather than fixing one (r1036).
#
# `private` IS EXCLUDED, and that is a fix rather than an omission.  A private
# theorem cannot be addressed as `<namespace>.<name>` from the generated module,
# so asking about it returns `unknown constant` and the declaration is counted as
# LOST by the report parser.  It was never auditable from outside its file, and
# its taint still reaches the report through whatever public theorem uses it.
DECL = re.compile(
    r"^(?:@\[[^\]]*\]\s*)*"
    r"(?:protected\s+|noncomputable\s+|nonrec\s+)*"
    # Unicode letters, not ASCII only: a Greek letter (`slotφ_of_not_cross`) truncated the name
    # to its ASCII prefix, and the audit then reported the shortened name as unknown (r1143).
    r"(?:theorem|lemma)\s+([^\W\d][\w.'!?₀-₉]*)"
)
PRIVATE = re.compile(r"^(?:@\[[^\]]*\]\s*)*private\s+(?:theorem|lemma)\s")

# A `/- ... -/` block can carry prose beginning at column zero, and a sentence
# opening "theorem foo ..." then reads as a declaration.  Those names exist
# nowhere, so they are asked about, come back unknown, and inflate the lost count
# until the AUDIT INCOMPLETE banner fires on every run and discriminates nothing.
BLOCK_OPEN = re.compile(r"^\s*/-")
BLOCK_CLOSE = re.compile(r"-/\s*$")
NAMESPACE = re.compile(r"^namespace\s+([A-Za-z_][A-Za-z0-9_.'₀-₉]*)")
END = re.compile(r"^end\s+([A-Za-z_][A-Za-z0-9_.'₀-₉]*)")

# `'X' depends on axioms: [a, b, c]` or `'X' does not depend on any axioms`.
# Lean wraps a long axiom list across lines, so this is matched against the whole
# output with DOTALL rather than line by line.  Matching per line silently found
# nothing at all, which looked exactly like a clean layer.
# `[^']+` CANNOT MATCH A NAME CONTAINING AN APOSTROPHE, and Lean names routinely do:
# `sharpQF'_id`, `WCP2_critical'`, every primed declaration in the layer.  The class
# stopped at the inner quote and the line never matched, so all 27 primed declarations
# were dropped from every audit, silently, and a caller reading `clean/total` saw a
# smaller total rather than an error.  The name is now matched LAZILY up to the literal
# `' depends` or `' does not`, which no declaration name contains.
# AND THE NAME MUST NOT SPAN A NEWLINE.  Under `DOTALL` the lazy `.+?` happily ran
# across lake's warning stream: any apostrophe in a linter message started a match
# that ended at the next real report's quote, so the captured "name" was a whole
# block of build log.  One run produced 5437 entries, 130 of them log fragments,
# and the JSON still looked like a dict of declarations to anything reading it.
# The list in brackets genuinely wraps, so `DOTALL` stays for group 2 while the
# name is anchored to a line start and forbidden newlines.
REPORT = re.compile(
    r"^'([^\n]+?)' (?:depends on axioms: \[(.*?)\]|does not depend on any axioms)",
    re.DOTALL | re.MULTILINE)

# A Lean declaration name carries no whitespace.  Anything that does is build output
# that reached the parser, and it is counted and reported rather than stored.
NAME_OK = re.compile(r"^[^\s]+$")


def declarations(path):
    """Fully-qualified theorem names in one file, in source order.

    The namespace stack is tracked rather than assumed, because a file may open
    more than one and `end` closes sections as well as namespaces.  An `end`
    naming something other than the current namespace is a section end and is
    left alone.
    """
    stack, names = [], []
    in_block = False
    with open(path, encoding="utf-8") as fh:
        for line in fh:
            if in_block:
                if BLOCK_CLOSE.search(line):
                    in_block = False
                continue
            if BLOCK_OPEN.match(line) and not BLOCK_CLOSE.search(line):
                in_block = True
                continue
            m = NAMESPACE.match(line)
            if m:
                stack.append(m.group(1))
                continue
            m = END.match(line)
            if m:
                if stack and stack[-1] == m.group(1):
                    stack.pop()
                continue
            if PRIVATE.match(line):
                continue
            m = DECL.match(line)
            if m:
                prefix = ".".join(stack)
                names.append(f"{prefix}.{m.group(1)}" if prefix else m.group(1))
    return names


def sources(only=None):
    """Every .lean file in the package, excluding the generated module."""
    out = []
    for root, _, files in os.walk(PKG):
        for f in sorted(files):
            if not f.endswith(".lean") or f == MODULE + ".lean":
                continue
            if only and only.lower() not in f.lower():
                continue
            out.append(os.path.join(root, f))
    return sorted(out)


def module_name(path):
    """`lean/HamiltonsCubic/Base/Sharp.lean` -> `HamiltonsCubic.Base.Sharp`."""
    rel = os.path.relpath(path, LEAN)[: -len(".lean")]
    return rel.replace(os.sep, ".")


def generate(files):
    """Write the audit module and return the declarations it asks about."""
    lines = ["-- GENERATED by scripts/misc/axiom_audit.py. Deleted after the run.",
             "set_option linter.all false"]
    decls = []
    for path in files:
        names = declarations(path)
        if not names:
            continue
        lines.append(f"import {module_name(path)}")
        decls.extend(names)
    # Lean requires every import before any command.
    imports = [l for l in lines if l.startswith("import")]
    body = [f"#print axioms {n}" for n in decls]
    with open(GENERATED, "w", encoding="utf-8") as fh:
        fh.write("\n".join(imports + ["", "set_option linter.all false", ""] + body) + "\n")
    return decls


def build():
    """Elaborate the audit module and return its combined output.

    `lake env lean` RATHER THAN `lake build`, and the reason is the REPORT REGEX
    rather than any caching claim.  `REPORT` is anchored to a line start; `lake build`
    prefixes each diagnostic with `info: path:line:col: ` while `lake env lean` does
    not, so the parser and the runner are coupled and changing one breaks the other.

    A REPLAY MECHANISM WAS CLAIMED HERE AND IS REFUTED, by r1033 on four probes: a
    dependency change, this tool's own delete-and-regenerate cycle, a forged mtime,
    and a forged mtime at equal byte count.  All re-elaborated.  Lake hashes content,
    and when it does reuse a result it prints `Replayed <module>` rather than `Built`.
    What prompted the claim was a regenerated `axioms.json` coming back byte-identical
    while `lake env lean` disagreed with it on the same declaration; that observation
    is UNREPRODUCED and is recorded as such rather than explained.  The count that
    moved (32 to 16) is fully accounted for by the file being two commits stale.

    `lake env lean` skips the job graph and elaborates this one file against the
    oleans on disk, so the verdicts are as current as the last build of the tree.
    """
    proc = subprocess.run(
        [LAKE, "env", "lean", GENERATED],
        cwd=LEAN, capture_output=True, text=True,
    )
    return proc.stdout + proc.stderr


def parse(output):
    """Map each reported declaration to the set of axioms it rests on."""
    found = {}
    rejected = 0
    for m in REPORT.finditer(output):
        name = m.group(1)
        if not NAME_OK.match(name):
            rejected += 1
            continue
        axioms = m.group(2)
        found[name] = (
            set(a.strip() for a in axioms.split(",") if a.strip()) if axioms else set())
    if rejected:
        print(f"axiom_audit: REFUSED {rejected} matches whose name carried whitespace, "
              f"which means build output reached the parser", file=sys.stderr)
    return found


def allowed():
    """Declarations permitted to carry a compiler axiom, with their reasons."""
    out = {}
    if not os.path.exists(ALLOW):
        return out
    with open(ALLOW, encoding="utf-8") as fh:
        for line in fh:
            line = line.split("#", 1)[0].strip()
            if not line:
                continue
            name, _, reason = line.partition(" ")
            out[name] = reason.strip()
    return out


def classify(axioms):
    """`clean`, `sorry`, `compiler`, or `other`, worst first."""
    if axioms & SORRY:
        return "sorry"
    if any(COMPILER_SHAPE.search(a) for a in axioms):
        return "compiler"
    if axioms - STANDARD:
        return "other"
    return "clean"


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--only", help="restrict to files whose name contains this")
    ap.add_argument("--json", help="write the full table here")
    ap.add_argument("--keep", action="store_true", help="leave the generated module in place")
    args = ap.parse_args()

    if not os.path.exists(LAKE):
        print(f"lake not found at {LAKE}", file=sys.stderr)
        return 2

    files = sources(args.only)
    decls = generate(files)
    print(f"auditing {len(decls)} declarations across {len(files)} files", file=sys.stderr)
    try:
        output = build()
    finally:
        if not args.keep and os.path.exists(GENERATED):
            os.remove(GENERATED)

    found = parse(output)
    if not found:
        print("no axiom report parsed -- the build failed:", file=sys.stderr)
        print(output[-4000:], file=sys.stderr)
        return 2

    allow = allowed()
    buckets = {"sorry": [], "compiler": [], "other": [], "clean": []}
    for name, axioms in sorted(found.items()):
        buckets[classify(axioms)].append((name, sorted(axioms)))

    total = len(found)
    clean = len(buckets["clean"])
    # A PARSE THAT LOSES DECLARATIONS LOOKS EXACTLY LIKE A SMALLER LAYER.  The count of
    # names asked about is known, so compare it against the count parsed back and say so
    # loudly when they differ; without this the apostrophe bug above was invisible.
    # DISTINCT names, because `found` is keyed by name while `decls` is a list.  A
    # fully-qualified name can be declared in more than one file, and this record has
    # seven such, so comparing the list's LENGTH invented ten lost declarations that
    # were never lost.  A banner that fires on every run discriminates nothing, which
    # is the same failure as not having one.
    asked_names = set(decls)
    lost = sorted(asked_names - set(found))
    if lost:
        print(f"\nAUDIT INCOMPLETE: asked about {len(asked_names)} distinct declarations, "
              f"{len(lost)} came back unparsed and are NOT audited clean:\n")
        for name in lost[:20]:
            print(f"  {name}")
        if len(lost) > 20:
            print(f"  ... and {len(lost) - 20} more")
        print()
    print(f"\n{clean}/{total} clean -- resting on the standard three alone\n")

    failed = False
    for kind, headline in (
        ("sorry", "REST ON A `sorry` AND ARE NOT PROVED"),
        ("compiler", "REST ON THE COMPILER, NOT THE KERNEL"),
        ("other", "CARRY AN AXIOM THE GATE DOES NOT KNOW"),
    ):
        rows = buckets[kind]
        if not rows:
            continue
        print(f"{len(rows)} {headline}")
        for name, axioms in rows:
            note = allow.get(name)
            extra = sorted(set(axioms) - STANDARD)
            if kind == "compiler" and note is not None:
                print(f"  allowed  {name}  [{', '.join(extra)}]  {note}")
            else:
                print(f"  {name}  [{', '.join(extra)}]")
                failed = True
        print()

    if args.json:
        with open(args.json, "w", encoding="utf-8") as fh:
            json.dump({n: sorted(a) for n, a in found.items()}, fh, indent=2, sort_keys=True)
        print(f"table written to {args.json}", file=sys.stderr)

    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
