#!/usr/bin/env python3
"""Pre-commit gate for the defects a reviewer should never be spent on.

Six agent-rounds of this programme were spent finding a dangling anchor, two
proposals sharing an id, ten table rows contradicting the table's own ladder, a
blank line that ended a markdown table and dropped 43 rows out of it, a numbered
result with a heading and no row, and a hook keyed on a flag name nothing writes.
Every one is a grep and an arithmetic pass apart, and every one cost a reviewer's
context window and a fold.

So they move here. What is left for a reader is the thing only a reader can do:
asking whether a statement is the result. The checks run against STAGED files
alone, so a session is never blocked for a defect another session is mid-way
through writing.
"""
import json
import os
import re
import subprocess
import sys


def staged(cwd):
    try:
        out = subprocess.run(["git", "diff", "--cached", "--name-only"], cwd=cwd,
                             capture_output=True, text=True, timeout=30).stdout
    except Exception:
        return []
    return [p for p in out.splitlines() if p.strip()]


def added_lines(cwd, path):
    """The lines this commit ADDS, so a session is never blocked for a defect it
    inherited. The record is written by several sessions and carries old damage in
    places nobody staged; a gate that reports it teaches the committer to bypass
    the gate, which is worse than no gate."""
    try:
        out = subprocess.run(["git", "diff", "--cached", "-U0", "--", path], cwd=cwd,
                             capture_output=True, text=True, timeout=30).stdout
    except Exception:
        return set()
    return {l[1:] for l in out.splitlines()
            if l.startswith("+") and not l.startswith("+++")}


def slug(heading):
    """The renderer's slug: link markup contributes its TEXT and not its target.

    Reading `[Foo](bar.md)` whole turns a heading's slug into one no link can name,
    so a correct anchor is reported as dangling and the repair for it is refused."""
    heading = re.sub(r"\[([^\]]*)\]\([^)]*\)", r"\1", heading)
    return re.sub(r"[^\w\s\-]", "", heading.strip().lower()).replace(" ", "-")


def _strip_code(text):
    """Code spans and fences quote text; they do not link to it."""
    text = re.sub(r"```.*?```", "", text, flags=re.S)
    return re.sub(r"`[^`\n]*`", "", text)


def check_anchors(path, text, added):
    heads = {slug(m.group(1)) for m in re.finditer(r"^#{1,6} (.+)$", text, re.M)}
    # AN EXPLICIT ANCHOR IS A TARGET TOO.  A heading whose slug is long or carries
    # math is commonly given a short `<a id="...">` beside it, and a checker reading
    # headings alone calls every link to that id dangling.
    heads |= set(re.findall(r'<a\s+id="([^"]+)"', text))
    joined = _strip_code("\n".join(added))
    bad = sorted({m.group(1) for m in re.finditer(r"\]\(#([a-z0-9\-]+)\)", joined)
                  if m.group(1) not in heads})
    return [path + ": link to #" + b + ", which no heading in the file carries" for b in bad]


def check_table_breaks(path, text, added):
    out, lines = [], text.split("\n")
    for i in range(1, len(lines) - 1):
        # Fire when the blank itself is new, or either neighbour is: an inserted blank
        # line adds no table row, so guarding on the row below missed the whole incident.
        if (not lines[i].strip() and lines[i - 1].startswith("| ")
                and lines[i + 1].startswith("| ")
                and (lines[i + 1] in added or lines[i - 1] in added or "" in added)):
            out.append(path + ":" + str(i + 1) + ": a blank line inside a table ends it, "
                       "and every row below drops out of the rendered table")
    return out


def check_duplicate_ids(path, text, added):
    out, seen = [], {}
    for m in re.finditer(r"^\| \*?\*?(\d+)\*?\*? \|", text, re.M):
        seen.setdefault(m.group(1), 0)
        seen[m.group(1)] += 1
    touched = {m.group(1) for l in added
               for m in [re.match(r"^\| \*?\*?(\d+)\*?\*? \|", l)] if m}
    for pid, n in sorted(seen.items(), key=lambda kv: int(kv[0])):
        if n > 1 and pid in touched:
            out.append(path + ": id " + pid + " is carried by " + str(n) + " rows, and an id is "
                       "a permanent address")
    return out


def check_proposal_scores(path, text, added):
    def ladder(occ, crit):
        if crit:
            return (7,) if occ == 1 else (9, 10)
        return (10,) if occ >= 5 else (8,) if occ >= 3 else (6,) if occ == 2 else (3,)

    out = []
    for m in re.finditer(r"^\| (\d+) \| \*\*(\d+)\*\* \| (\d+) \| (\d+) \| (\d+)(!?) \|",
                         "\n".join(added), re.M):
        pid, tot, imp, imprt, occ, crit = (m.group(1), int(m.group(2)), int(m.group(3)),
                                          int(m.group(4)), int(m.group(5)), m.group(6) == "!")
        if tot != imp * imprt:
            out.append(path + ": row " + pid + " totals " + str(tot) + " where impact times "
                       "importance is " + str(imp * imprt))
        allowed = ladder(occ, crit)
        if imp not in allowed:
            out.append(path + ": row " + pid + " has impact " + str(imp) + " at "
                       + str(occ) + ("!" if crit else "") + " occurrences, where the table's own "
                       "ladder gives " + " or ".join(str(a) for a in allowed))
    return out


def check_flag_names(cwd, path, text, added):
    """A hook naming a flag nobody writes is a hook that silently never fires."""
    try:
        owner = open(os.path.join(cwd, ".claude/hooks/loop_flag.py")).read()
    except OSError:
        return []
    known = set(re.findall(r'^[A-Z_]*FLAG\s*=\s*"([^"]+)"', owner, re.M))
    if not known:
        return []
    used = set(re.findall(r'\.claude/([a-z0-9-]*(?:active|loop-active))', "\n".join(added)))
    return [path + ": names the flag '" + u + "', which loop_flag.py does not define; "
            "it defines " + ", ".join(sorted(known)) for u in sorted(used - known)]


# Words this index uses of a file's STATUS or in plain prose, which a shape rule cannot
# separate from a declaration name: `levi6` is a real declaration with no underscore and
# no internal capital, so a rule about shape drops it while a stop-list does not.
NOT_A_DECL = frozenset({
    "out", "proved", "partial", "typed", "iff", "det", "rfl", "decide",
    "native_decide", "sorry", "ring", "omega", "simp", "norm_num", "linarith",
    "nlinarith", "field_simp", "trivial", "rest", "none", "statement",
})


_LAYER_CACHE = {}


def _layer_text(cwd):
    """Every Lean source in the layer, concatenated once.

    Read lazily and cached, since the named-declaration check asks after it per
    token and a row can name a dozen."""
    if cwd not in _LAYER_CACHE:
        parts = []
        for root, _dirs, names in os.walk(os.path.join(cwd, "lean", "HamiltonsCubic")):
            for n in names:
                if n.endswith(".lean"):
                    try:
                        with open(os.path.join(root, n), encoding="utf-8") as fh:
                            parts.append(fh.read())
                    except OSError:
                        pass
        _LAYER_CACHE[cwd] = "\n".join(parts)
    return _LAYER_CACHE[cwd]


def check_named_decls(cwd, path, text, added):
    """A row naming a declaration its own file no longer carries.

    An index row is edited in fragments: the tail is corrected and the head keeps
    describing the file as it was, so the row names a theorem that has been deleted
    or renamed. The row still reads as a description of the file, and nothing
    compares the two, so it survives every later edit that does not touch that
    clause."""
    out = []
    for line in added:
        m = re.match(r"^\| [^|]+ \| \[[^\]]*\]\(([^)]*\.lean)\)", line)
        if not m:
            continue
        target = os.path.join(cwd, os.path.dirname(path), m.group(1))
        if not os.path.exists(target):
            out.append(path + ": row points at " + m.group(1) + ", which does not exist")
            continue
        try:
            src = open(target, encoding="utf-8").read()
        except OSError:
            continue
        for m2 in re.finditer(r"`([A-Za-z_][A-Za-z0-9_'.]{2,})`", line):
            name = m2.group(1)
            if "." in name or name[0].isupper():
                continue
            # A ROW SAYING A FILE DOES NOT CARRY SOMETHING IS NOT NAMING ITS CONTENTS.
            # The index's job includes stating what a file leaves out, so "Kernel-checked,
            # no `native_decide`" is a correct negative and the commonest clause in the
            # file.  Reading every backticked token as a declaration the file must contain
            # inverts that, and the negation is always the word immediately before.
            if name in NOT_A_DECL:
                continue
            # THE WINDOW STARTS AFTER THE ROW'S OWN LINK, WHOSE END IS ALREADY KNOWN.
            # A fixed lookback reaches back INTO that link, so the row's own target sits
            # in the window and every cross-file test matches it: over this index a bare
            # ".lean in the window" test silenced 114 of 528 tokens, the clause saying
            # what the file proves among them.  Comparing the match against the target
            # does not rescue it either, since the window truncates the path mid-string
            # and the fragment is equal to nothing.  Anchoring the window removes the
            # guesswork: anything in it is prose, and a .lean in prose is another file's.
            start = max(m.end(), m2.start() - 70)
            before = line[start:m2.start()].lower()
            if re.search(r"\b(no|not|without|never|free of|zero|none|nothing|"
                         r"rather than|instead of|in place of)\b[^.]*$", before):
                continue
            # AND A TOKEN ATTRIBUTED TO ANOTHER FILE IS THAT FILE'S, NOT THIS ONE'S.
            # A row comparing itself against a sibling quotes the sibling's declaration.
            if ".lean" in before or re.search(r"(?:'s|s')\s*$", before):
                continue
            if re.search(r"\b(?:theorem|lemma|def|noncomputable def|abbrev)\s+" + re.escape(name) + r"\b", src):
                continue
            if re.search(r"\b" + re.escape(name) + r"\b", src):
                continue
            # THE DEFECT IS A NAME THAT NO LONGER EXISTS, so the layer is what decides.
            # A row legitimately names a lemma its file USES rather than declares, so
            # requiring the name in THIS file reports correct rows as stale. A name absent
            # from the whole layer is the one that has been deleted.
            # ON A WORD BOUNDARY, because a bare substring test passes a fragment that is
            # a name in nothing: `_record` rides on `pair_le_theta_record`, `index_at_theta`
            # on `no_index_at_theta`.  A renamed declaration keeps a similar name, so a
            # rename is what this still misses, and that is worth stating rather than
            # implying: the check catches a DELETION.
            if re.search(r"(?:^|[^A-Za-z0-9_'])" + re.escape(name)
                         + r"(?:[^A-Za-z0-9_']|$)", _layer_text(cwd)):
                continue
            out.append(path + ": row names `" + name + "`, which " + m.group(1)
                       + " does not carry")
    return out



def check_literature_index(cwd, path, text, added):
    """Defects a REVIEWER SHOULD NEVER HAVE BEEN SPENT ON, in the generated literature index.

    THREE ROUNDS WERE SPENT FINDING THESE BY HAND.  r906 and r907 between them counted
    duplicate rows, row names carrying prose past the kind and number, placeholder bodies,
    and a pipe escaped with a backslash, which inside inline mathematics is the LaTeX NORM
    delimiter and silently turned an absolute value into a norm in twelve rows.  Every one
    of those is a pass over the file, which is what this gate is for, and a round consumed
    by them is a round not spent on the mathematics.
    """
    out = []
    rows, seen = 0, {}
    for line in text.split("\n"):
        if line.startswith("## ["):
            section = line[4:].split("]")[0]
        m = re.match(r"\| \*\*(.+?)\*\* \| (.*?) \|$", line.rstrip())
        if not m:
            continue
        rows += 1
        name, body = m.group(1), m.group(2)
        key = (section, name)
        seen[key] = seen.get(key, 0) + 1
        if re.search(r"(?:Theorem|Lemma|Proposition|Corollary|Conjecture|Remark|Definition)"
                     r"\s+[A-Z0-9][\w.]*\s+\S", name):
            out.append(path + ": row name '" + name[:60] + "' carries prose past the kind and "
                       "number, which belongs in the body")
        if "named in a section heading" in body:
            out.append(path + ": row '" + name[:40] + "' has a placeholder body, so it says a "
                       "statement exists without saying what it is")
    for (section, name), n in seen.items():
        if n > 1:
            out.append(path + ": " + section + " carries " + str(n) + " rows named '" + name
                       + "'; a second head with one label is commentary and merges")
    if "\\|" in text:
        out.append(path + ": a pipe is escaped with a BACKSLASH, which is the LaTeX norm "
                   "delimiter inside mathematics and changes meaning. Use &#124;")
    if rows and "GENERATED" not in text[:600]:
        out.append(path + ": carries rows without saying it is generated, so a reader may "
                   "edit it by hand and the edit is lost on the next run")
    return out


def check_lean_double_docstring(path, text, added):
    """Two declaration docstrings in a row, which is a parse error.

    It arrives from SCRIPTED EDITING: a substitution matches a declaration and
    prepends its own docstring without reading the lines above the anchor, so
    the edit is correct in isolation and wrong in place.  The message names a
    token, so it reads as a problem with the statement rather than the layout.
    Three occurrences in one session, each costing a build cycle.
    """
    out = []
    lines = text.split("\n")
    for i, line in enumerate(lines):
        if not line.strip().startswith("/--"):
            continue
        j = i - 1
        while j >= 0 and not lines[j].strip():
            j -= 1
        if j >= 0 and lines[j].strip().endswith("-/") and not lines[j].strip().startswith("/-!"):
            # confirm the block above is a DECLARATION docstring, not a section comment
            k = j
            while k >= 0 and not (lines[k].strip().startswith("/--")
                                  or lines[k].strip().startswith("/-!")):
                k -= 1
            if k >= 0 and lines[k].strip().startswith("/--"):
                out.append(f"{path}:{i+1}: a declaration docstring directly follows another; "
                           "merge them or delete one")
    return out


def check_lean_modifier_placement(path, text, added):
    """A `set_option`/`open ... in` between a docstring and its declaration.

    It is a parse error, and the message names a token rather than the layout,
    so it reads as a problem with the STATEMENT.  Six occurrences in one
    session, each costing a build cycle, is what put it in a gate rather than
    in a rule: the shape is decidable from the file and needs no judgement.
    """
    out = []
    lines = text.split("\n")
    for i, line in enumerate(lines):
        if not re.match(r"^\s*(set_option|open|open scoped)\b.*\bin\s*$", line):
            continue
        # A modifier is misplaced when the line ABOVE closes a docstring.
        j = i - 1
        while j >= 0 and not lines[j].strip():
            j -= 1
        # Only a DECLARATION docstring `/-- ... -/` binds to what follows; a
        # section comment `/-! ... -/` does not, so a modifier after one is legal.
        opener = None
        for k in range(j, -1, -1):
            t = lines[k].lstrip()
            if t.startswith("/--"):
                opener = "doc"; break
            if t.startswith("/-!"):
                opener = "section"; break
        if j >= 0 and lines[j].rstrip().endswith("-/") and opener == "doc":
            out.append(path + ": line " + str(i + 1) + " puts a modifier BETWEEN a "
                       "docstring and its declaration, which is a parse error; it goes "
                       "above the docstring")
    return out


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0
    tool_input = payload.get("tool_input") or {}
    cmd0 = tool_input.get("command", "")

    # ANY Lean invocation in the foreground blocks the session for minutes:
    # `lake build` rebuilds, `lake env lean` on a scratch file elaborates, and
    # both routinely outlast the patience of whoever is waiting.  The rule
    # naming only `lake build` left `lake env lean` uncovered, and that is the
    # form scratch iteration uses, so the gate matches the toolchain instead.
    # Match the command being RUN, not the word inside a commit message: the
    # first version matched anywhere and refused a commit whose own message
    # described the gate, then refused the edit that would have fixed it.
    runs_lake = bool(re.match(r"^\s*(cd\s+\S+\s*(&&|;)\s*)*lake\s+(build|env|exe)\b", cmd0))

    # A SECOND build of the same tree is worse than no build.  Lake takes no
    # cross-process lock on its build directory, so two invocations compile the
    # same module to the same `.olean` at once, each halving the other's cores.
    # Four accumulated here once, all on one file, and the session read the
    # resulting wall clock as a slow proof rather than as self-inflicted
    # contention.  The toolchain is fast; duplicate toolchains are not.
    if runs_lake:
        try:
            running = subprocess.run(
                ["pgrep", "-f",
                 r"\.elan/toolchains/[^ ]*/bin/(lake (build|env|exe)|lean /)"],
                capture_output=True, text=True).stdout.split()
        except Exception:
            running = []
        if running:
            print("A Lean build is ALREADY RUNNING (" + str(len(running)) +
                  " process(es)). Lake takes no lock, so a second one compiles "
                  "the same modules to the same files and both run at half "
                  "speed.\n\n  Wait for it, or kill it first, then re-issue.\n\n"
                  "  pgrep -fl 'lake (build|env)'   lists them\n"
                  "  pkill -9 -f 'lake build'       clears them\n\n"
                  "An empty log means unfinished, not failed.", file=sys.stderr)
            return 2

    if runs_lake and not tool_input.get("run_in_background"):
        print("This runs the Lean toolchain in the foreground, which blocks the "
              "session for as long as it takes and leaves the user unable to "
              "reach you.\n\n  Re-issue it with run_in_background: true.\n\n"
              "An empty log means unfinished, not failed; check pgrep -fc 'lean --' "
              "for liveness and TaskStop any stale entry.", file=sys.stderr)
        return 2

    if "git commit" not in cmd0:
        return 0
    cwd = os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or os.getcwd()

    # A commit staging lean/ takes seconds: the pre-commit hook compiles nothing and
    # launches the tree build in the background, so a foreground commit is fine.
    problems = []
    for path in staged(cwd):
        full = os.path.join(cwd, path)
        if not os.path.exists(full):
            continue
        try:
            text = open(full, encoding="utf-8").read()
        except (OSError, UnicodeDecodeError):
            continue
        added = added_lines(cwd, path)
        if not added:
            continue
        if path.endswith(".md"):
            problems += check_anchors(path, text, added)
            problems += check_table_breaks(path, text, added)
            if path.endswith("skill-proposals.md"):
                problems += check_duplicate_ids(path, text, added)
                problems += check_proposal_scores(path, text, added)
            if path.endswith("reviews/INDEX.md"):
                problems += check_duplicate_ids(path, text, added)
            if path.endswith("INDEX-literature.md"):
                problems += check_literature_index(cwd, path, text, added)
        if path.endswith("INDEX.md"):
            problems += check_named_decls(cwd, path, text, added)
        if path.startswith(".claude/hooks/") and path.endswith(".py"):
            problems += check_flag_names(cwd, path, text, added)
        if path.endswith(".lean"):
            problems += check_lean_modifier_placement(path, text, added)
            problems += check_lean_double_docstring(path, text, added)

    if not problems:
        return 0
    print("Mechanical defects in the files this commit stages. Each is one edit, and "
          "each is the kind a review round can be wholly consumed by.\n\n  "
          + "\n  ".join(problems), file=sys.stderr)
    return 2


if __name__ == "__main__":
    sys.exit(main())
