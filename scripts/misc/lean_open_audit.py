#!/usr/bin/env python3
"""Who breaks if a name is removed from a Lean namespace.

Run `--ns <Namespace>` BEFORE deleting a definition: it lists the files that reach
that namespace's names through `open`, which is exactly the set that stops compiling.
A transitive import keeps the DEFINITION reachable while the NAME stops resolving, so
the breakage is pure name resolution and is invisible to every per-file check: the
edited file elaborates, its `sorry` count is unchanged, the axiom audit is clean, and
an auditor briefed on that file confirms the change preserves its propositions.

Query the NAMESPACE being emptied, not the moved names. The names return the same files
and read as "who mentions this" rather than "who will stop compiling", which is the
mistake this was written after.

THE DEAD-OPEN CHECK THIS ONCE CARRIED IS GONE, AND THE CATEGORY IT LOOKED FOR IS EMPTY.
Lean raises `unknown namespace` on an `open` of a namespace that does not exist, so a
tree that builds cannot contain one and the check could only ever report FALSE
POSITIVES. It reported exactly one, a nested namespace its regex could not see, and
that claim was cited three times and proposed for a gate before the category itself was
tested. A checker whose findings are all false trains its reader to ignore it.

Usage:
  python3 scripts/misc/lean_open_audit.py --ns <Namespace>
"""
import argparse
import collections
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2] / "lean" / "HamiltonsCubic"


def scan():
    """Collect opens and declared namespaces.

    NAMESPACES NEST, AND A FIRST VERSION OF THIS SCAN MISSED THAT.  It matched only
    `namespace HamiltonsCubic...` written out in full at line start, so a nested
    `namespace OperatorNorm` inside `HamiltonsCubic.RealLayer` was invisible and the
    audit reported a DEAD OPEN three times for a namespace that exists.  A checker
    with false positives is worse than none, because it trains its reader to ignore
    it.  So the scan now tracks the open namespace stack, and `section ... end` is
    NOT a namespace even though it shares the `end` keyword.
    """
    # PASS 1 collects every declared namespace, because an unqualified `open` can only
    # be resolved once the full set is known.
    declared_all = set()
    for f in sorted(ROOT.rglob("*.lean")):
        stack = []
        for line in f.read_text(encoding="utf-8").split("\n"):
            m = re.match(r"namespace\s+([A-Za-z_][A-Za-z0-9_.']*)", line)
            if m:
                stack.append(m.group(1))
                full = ".".join(s for s in stack if s is not None)
                parts = full.split(".")
                for k in range(1, len(parts) + 1):
                    declared_all.add(".".join(parts[:k]))
                continue
            if re.match(r"section\b", line):
                stack.append(None); continue
            if re.match(r"end\b", line) and stack:
                stack.pop()

    opens = collections.defaultdict(list)
    declared = declared_all
    for f in sorted(ROOT.rglob("*.lean")):
        stack = []
        for line in f.read_text(encoding="utf-8").split("\n"):
            if line.startswith("open "):
                # QUALIFIED opens name the namespace in full.
                for ns in re.findall(r"HamiltonsCubic\.[A-Za-z0-9_.]+", line):
                    opens[ns].append(f.name)
                # UNQUALIFIED opens resolve against the enclosing namespace stack, and a
                # first version missed them entirely: it demanded a literal
                # `HamiltonsCubic.` prefix, so `open scoped OperatorNorm` written inside
                # `namespace HamiltonsCubic.RealLayer` was invisible and the query
                # returned two of the four files that open it. That is a FALSE NEGATIVE
                # on exactly the case the query exists for.
                prefix = ".".join(s for s in stack if s is not None)
                body = re.sub(r"^open (scoped )?", "", line).split("--")[0]
                for tok in re.findall(r"[A-Za-z_][A-Za-z0-9_.']*", body):
                    if tok.startswith("HamiltonsCubic") or tok in ("in", "scoped"):
                        continue
                    if prefix:
                        parts = prefix.split(".")
                        for k in range(len(parts), 0, -1):
                            cand = ".".join(parts[:k] + [tok])
                            if cand in declared_all:
                                opens[cand].append(f.name)
                                break
            m = re.match(r"namespace\s+([A-Za-z_][A-Za-z0-9_.']*)", line)
            if m:
                stack.append(m.group(1))
                continue
            if re.match(r"section\b", line):
                stack.append(None)          # a section is not a namespace
                continue
            if re.match(r"end\b", line) and stack:
                stack.pop()
    return opens, declared


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--ns", help="list the files that open this namespace")
    args = ap.parse_args()
    opens, declared = scan()

    if args.ns:
        users = sorted(set(opens.get(args.ns, [])))
        if not users:
            print(f"nothing opens {args.ns}")
            return 0
        print(f"{len(users)} file(s) open {args.ns} and would lose any name removed from it:")
        for u in users:
            print(f"  {u}")
        return 0

    print(f"{len(opens)} distinct HamiltonsCubic namespaces opened, {len(declared)} declared")
    print("pass --ns <Namespace> to list the files that would break if a name left it")
    return 0


if __name__ == "__main__":
    sys.exit(main())
