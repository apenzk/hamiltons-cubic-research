"""Remove em dashes from markdown, one batch of files at a time, and keep every anchor live.

The em dash is forbidden in this record's prose. Nearly all of the occurrences sit in
HEADINGS, separating a name from its gloss, so removing one moves the heading's anchor and
every link pointing at it has to move with it. That is the whole difficulty: GitHub turns
each space around a dropped em dash into a hyphen and a comma into nothing, so
`Lemma L57 — the diagonal case` slugs to `lemma-l57--the-diagonal-case` while
`Lemma L57, the diagonal case` slugs to `lemma-l57-the-diagonal-case`. Rewriting the heading
without remapping the link leaves a dangling anchor that nothing reports.

So this does three things for the batch it is given, and refuses to leave the second undone:

  1. in the batch's files, ` — ` in a heading becomes `, `, and an em dash in PROSE is left
     alone and listed, prose needing a judgement this cannot make;
  2. every link anywhere in the repository that points at a heading the batch moved is
     remapped, by computing the old and new slug rather than by matching `--`, since a
     double hyphen can be legitimate;
  3. every link into or within the batch's files is then resolved against the headings that
     now exist, and any that does not resolve is printed.

`--check` reports and changes nothing. Without it the batch is rewritten in place.

Usage:  dedash.py [--check] <file.md> [<file.md> ...]
"""
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def slug(heading: str) -> str:
    """GitHub's heading slug: slug the RENDERED text, not the markdown source.

    Two rules carry this, and getting either wrong makes the remap silently miss anchors.

    **A link contributes its text and not its URL.** `[L30](#lemma-l30-...)` renders as
    `L30`, so a heading carrying a link slugs from `L30` alone; feeding the URL in instead
    computes an old anchor no link ever used, and that heading's real anchor is then left
    unremapped and dangling. Emphasis markers and backticks go the same way.

    **EACH space becomes a hyphen.** Collapsing runs of whitespace instead reports `a — b`
    and `a, b` as the same anchor, so the remap does nothing at all.
    """
    s = heading.strip().lstrip("#").strip()
    s = re.sub(r"!\[[^\]]*\]\([^)]*\)", "", s)          # images contribute nothing
    s = re.sub(r"\[([^\]]*)\]\([^)]*\)", r"\1", s)      # links contribute their text
    s = s.replace("`", "").replace("*", "")             # the UNDERSCORE stays: these headings use it for math subscripts
    s = s.lower()
    s = re.sub(r"[^a-z0-9 _\-]", "", s)                 # the underscore SURVIVES, as GitHub keeps it
    return s.replace(" ", "-")


def headings(text: str) -> set:
    """Every anchor a renderer offers for this file.

    A heading's slug, **and any explicit `<a id="...">` it carries**, which renders as a real
    anchor and is what a hand-written short link points at. Reading slugs alone reports such a
    link as dangling, which is a false positive that sends the reader chasing a sound link.
    """
    out = {slug(l) for l in text.split("\n") if l.lstrip().startswith("#")}
    out |= set(re.findall(r"<a\s+id=[\"']([^\"']+)[\"']", text))
    return out


_CODE = re.compile(r"(?s)```.*?```|``.*?``|`[^`\n]*`|<!--.*?-->")


def outside_code(text: str, fn):
    """Apply `fn` to the parts of `text` that a renderer treats as prose, leaving code alone.

    **A link inside a fenced block, an inline span or an HTML comment is not a link**, it is an
    example of one, and the record contains tables of exactly such examples. Rewriting or
    reporting them treats documentation of a link as a link, which is a false positive in the
    checker and a corrupted example in the rewriter.
    """
    out, last = [], 0
    for m in _CODE.finditer(text):
        out.append(fn(text[last:m.start()]))
        out.append(m.group(0))
        last = m.end()
    out.append(fn(text[last:]))
    return "".join(out)


def prose_only(text: str) -> str:
    """`text` with every code region blanked to spaces, for scanning."""
    return _CODE.sub(lambda m: " " * len(m.group(0)), text)


def tracked_markdown() -> list:
    out = subprocess.run(["git", "ls-files", "*.md"], cwd=ROOT,
                         capture_output=True, text=True).stdout.split()
    return [ROOT / f for f in out]


def rewrite_headings(paths, check):
    """Return (mapping {file -> {old_slug: new_slug}}, prose_hits).

    **The mapping is keyed by FILE and not by slug alone.** Two files can carry the same
    heading, and a rename in one then rewrites the other's links to an anchor it does not
    have. That is not hypothetical: it happened here, to every heading `results.md` shared
    with a findings file.
    """
    mapping, prose = {}, []
    for p in paths:
        rel = p.relative_to(ROOT).as_posix()
        mapping[rel] = {}
        lines = p.read_text().split("\n")
        out = []
        for i, line in enumerate(lines, 1):
            if line.lstrip().startswith("#") and " — " in line:
                new = line.replace(" — ", ", ")
                a, b = slug(line), slug(new)
                if a != b:
                    mapping[rel][a] = b
                out.append(new)
            else:
                if "—" in line:
                    prose.append((rel, i, line.strip()[:110]))
                out.append(line)
        if not check:
            p.write_text("\n".join(out))
    return mapping, prose


def remap_links(mapping, check):
    """Rewrite only links that RESOLVE to a file whose headings moved."""
    if not any(mapping.values()):
        return 0
    touched = 0
    for p in tracked_markdown():
        t = p.read_text()
        rel_self = p.relative_to(ROOT).as_posix()

        def cross(m):
            tgt = (p.parent / m.group(1)).resolve()
            try:
                rel = tgt.relative_to(ROOT).as_posix()
            except ValueError:
                return m.group(0)
            new = mapping.get(rel, {}).get(m.group(2))
            return f"({m.group(1)}#{new})" if new else m.group(0)

        def infile(m):
            new = mapping.get(rel_self, {}).get(m.group(1))
            return f"(#{new})" if new else m.group(0)

        o = t
        t = outside_code(t, lambda seg: re.sub(
            r"\(([A-Za-z0-9_./\-]+\.md)#([a-z0-9_\-]+)\)", cross, seg))
        t = outside_code(t, lambda seg: re.sub(r"\(#([a-z0-9_\-]+)\)", infile, seg))
        if t != o:
            touched += 1
            if not check:
                p.write_text(t)
    return touched


def repair_collapsed(paths, check):
    """Repoint links whose anchor is an em-dash casualty, and only those.

    A heading that lost ` — ` lost a hyphen from its slug with it, so a link still carrying
    `a--b` where the file now has `a-b` is unambiguously that heading. **The test is that the
    link's own anchor is NOT a heading while the collapsed form IS**, which leaves alone both
    a legitimate `--` and a link stale for some other reason, a rename or a dropped clause,
    where guessing would point the reader at the wrong block.
    """
    have = {p.relative_to(ROOT).as_posix(): headings(p.read_text()) for p in paths}
    fixed = 0
    for p in tracked_markdown():
        t = p.read_text()
        o = t
        rel_self = p.relative_to(ROOT).as_posix()

        def pick(rel, anchor):
            hs = have.get(rel)
            if not hs or anchor in hs or "--" not in anchor:
                return None
            c = anchor.replace("--", "-")
            return c if c in hs else None

        def cross(m):
            tgt = (p.parent / m.group(1)).resolve()
            try:
                rel = tgt.relative_to(ROOT).as_posix()
            except ValueError:
                return m.group(0)
            new = pick(rel, m.group(2))
            return f"({m.group(1)}#{new})" if new else m.group(0)

        def infile(m):
            new = pick(rel_self, m.group(1))
            return f"(#{new})" if new else m.group(0)

        t = outside_code(t, lambda seg: re.sub(
            r"\(([A-Za-z0-9_./\-]+\.md)#([a-z0-9_\-]+)\)", cross, seg))
        t = outside_code(t, lambda seg: re.sub(r"\(#([a-z0-9_\-]+)\)", infile, seg))
        if t != o:
            fixed += 1
            if not check:
                p.write_text(t)
    return fixed


def dangling(paths):
    """Links into or within the batch's files that no heading there carries."""
    have = {p.relative_to(ROOT).as_posix(): headings(p.read_text()) for p in paths}
    bad = []
    for p in tracked_markdown():
        t = prose_only(p.read_text())
        for m in re.finditer(r"\(([A-Za-z0-9_./\-]+\.md)#([a-z0-9_\-]+)\)", t):
            tgt = (p.parent / m.group(1)).resolve()
            try:
                rel = tgt.relative_to(ROOT).as_posix()
            except ValueError:
                continue
            if rel in have and m.group(2) not in have[rel]:
                bad.append(f"{p.relative_to(ROOT)} -> {rel}#{m.group(2)}")
        rel_self = p.relative_to(ROOT).as_posix()
        if rel_self in have:
            for m in re.finditer(r"\(#([a-z0-9\-]+)\)", t):
                if m.group(1) not in have[rel_self]:
                    bad.append(f"{rel_self}#{m.group(1)} (in-file)")
    return bad


def main():
    args = sys.argv[1:]
    check = "--check" in args
    files = [a for a in args if a != "--check"]
    if not files:
        print(__doc__)
        return 1
    paths = [(ROOT / f) if not os.path.isabs(f) else Path(f) for f in files]
    missing = [p for p in paths if not p.exists()]
    if missing:
        print("no such file: " + ", ".join(str(m) for m in missing))
        return 1

    before = sum(p.read_text().count("—") for p in paths)
    mapping, prose = rewrite_headings(paths, check)
    touched = remap_links(mapping, check)

    verb = "would remove" if check else "removed"
    print(f"{verb} {before - len(prose)} heading em dashes from {len(paths)} file(s)")
    moved = sum(len(v) for v in mapping.values())
    print(f"anchors moved: {moved}, link files {'to update' if check else 'updated'}: {touched}")
    if prose:
        print(f"\nPROSE em dashes left for a human, {len(prose)}:")
        for f, i, s in prose:
            print(f"  {f}:{i}: {s}")
    if not check:
        salvaged = repair_collapsed(paths, check)
        if salvaged:
            print(f"em-dash casualties repointed in {salvaged} file(s)")
        bad = dangling(paths)
        if bad:
            print(f"\nDANGLING ANCHORS, {len(bad)}, STALE FOR SOME OTHER REASON, FIX BY HAND:")
            for b in bad:
                print("  " + b)
            return 2
        print("\nno dangling anchors into or within the batch")
    return 0


if __name__ == "__main__":
    sys.exit(main())
