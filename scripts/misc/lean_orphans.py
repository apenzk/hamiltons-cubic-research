#!/usr/bin/env python3
"""Every .lean module under lean/HamiltonsCubic/ must be reachable from the library root.

An unreachable module is built by nobody: `lake build` skips it, `axiom_audit.py` never sees its
declarations, and it carries no row in lean/INDEX.md or plan-lean.md. Its .olean exists only if
somebody built it by name, so the file looks checked from every angle except the one that counts.

Exit 1 and name the orphans when any exist.
"""
import os
import re
import sys

LEAN = os.path.join(os.path.dirname(__file__), "..", "..", "lean")
ROOT = os.path.join(LEAN, "HamiltonsCubic.lean")
PKG = "HamiltonsCubic"


def imports_of(path):
    with open(path) as fh:
        return set(re.findall(r"^import (%s[\w.]*)" % PKG, fh.read(), re.M))


def main():
    modules = set()
    for dirpath, _, filenames in os.walk(os.path.join(LEAN, PKG)):
        for name in filenames:
            if name.endswith(".lean"):
                rel = os.path.relpath(os.path.join(dirpath, name), LEAN)
                modules.add(rel[:-5].replace(os.sep, "."))

    graph = {m: imports_of(os.path.join(LEAN, m.replace(".", os.sep) + ".lean")) for m in modules}

    seen, stack = set(), list(imports_of(ROOT))
    while stack:
        m = stack.pop()
        if m in seen:
            continue
        seen.add(m)
        stack.extend(graph.get(m, ()))

    orphans = sorted(modules - seen)
    if orphans:
        print(f"ORPHANED: {len(orphans)} of {len(modules)} modules unreachable from {PKG}.lean")
        for o in orphans:
            print(f"  import {o}")
        print("\nAdd each to lean/HamiltonsCubic.lean, or the build and the axiom audit both skip it.")
        return 1
    print(f"all {len(modules)} modules reachable from {PKG}.lean")
    return 0


if __name__ == "__main__":
    sys.exit(main())
