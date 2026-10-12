"""Build findings/INDEX-literature.md from every notes.md in references/.

WHY THIS EXISTS.  The record held hundreds of transcribed numbered statements across 86
source folders, and the table indexing them had three rows.  So reaching a statement meant
knowing which folder to open, which is exactly what a literature sweep does not know:
two of one sweep's three routes were things the record already held, and one route was
proposed, ranked and worked while the theorem it needed sat transcribed in a notes.md
with its consequence drawn beside it, missed by the cycle and by three independent
reviewers.

WHAT IT READS.  A transcribed statement is a bolded kind and number, with or without a
blockquote marker, both shapes being present in the notes:

    > **Theorem 1.2.** (1). The only algebraic curvature operator ...
    **Theorem A.** *Let $(M,g)$ be a closed Kaehler-Einstein manifold ...*

GENERATED, NEVER EDITED.  A hand-edited index drifts from the notes and the drift is
invisible, which is the failure the whole file exists to prevent.  Rerun it whenever a
reference folder gains a notes.md or a statement.

A source whose notes.md carries no numbered statement contributes NO ROW.  That is a
LEAD rather than a conclusion: it may have been stored and never transcribed, which is
the state `## references layout` warns about, or it may state its content as prose.
Reading the count as the first of those is how this script's own first run reported 48
sources as unread when they were transcribed in full.
"""
import collections
import glob
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
assert os.path.isdir(os.path.join(ROOT, 'references')), (
    f"ROOT resolved to {ROOT}, which has no references/: this file has moved and the "
    "level count above is stale")

# `Conjecture` WAS ABSENT AND THE PROGRAMME'S OWN TARGET IS ONE, so Conjecture A had no
# row at any state of this file (r906).  A kind list is the second thing here that was
# guessed rather than read off the notes.
KINDS = "Theorem|Lemma|Proposition|Corollary|Conjecture|Remark|Definition"
# THE LEADING `>` IS OPTIONAL, AND KEYING ON IT READ HALF THE SHELF AS UNREAD.
# `## references layout` asks for statements transcribed verbatim and does not fix a
# marker, so the notes carry both shapes: a blockquote, and a bolded head followed by
# the statement in italics.  A first version matched only the blockquote and reported 48
# of 86 sources as carrying no numbered statement, which was recorded as "stored and
# never transcribed" when they were transcribed in full.
# A NUMBER OR LETTER IS REQUIRED after the kind: a bare `**Definition**` is a section
# label, not a numbered statement, and five of them collided in one source (r906).
# THE NAME STOPS AT THE NUMBER and whatever follows is body, in the head as well as in
# a heading.  Allowing prose into the name put 17 of 368 row names past the kind and
# number, one of them a whole sentence of this record's own commentary (r907).
STATEMENT = re.compile(r'^>? ?\*\*((?:' + KINDS + r')\s+[A-Z0-9][\w.]*)([^*]*)\*\*\s*(.{0,200})', re.M)
# A HEADING NAMING A NUMBERED STATEMENT IS A ROW TOO, and it is the THIRD shape a guessed
# pattern missed: 49 labels across 29 sources live only in a markdown heading (r906, whose
# count of 41 across 23 was reproduced and found low).  Such a heading is exactly what a
# screen wants, since it names the statement AND says where it sits: `## Lemma 5.7, page
# 14, which is the source for Q(W_n) in W_n`.  Three patches to one pattern is the
# argument for having fixed the shape in the spec before building the index, which is now
# done in `## references layout`.
HEADING = re.compile(r'^#+\s+(.*?\b(?:' + KINDS + r')\s+[A-Z0-9][\w.]*.*)$', re.M)
BODY_CHARS = 185


def _clip(s):
    """A body cut to the bound, at a word boundary.

    THE CUT IS APPLIED WHEREVER A BODY IS BUILT, because applying it before the heading
    merge appended a gloss left the longest body at 215 and the bound stated in this file
    was not one (r906, measured again by r907).

    IT BOUNDS THE STATEMENT TEXT AND NOT THE RENDERED CELL.  A pipe leaves here as
    `&#124;`, six characters standing for one, so a body carrying ten of them exceeds the
    bound in the file while obeying it in substance.  Measuring the file and expecting 185
    is therefore the wrong check: the longest cell is 235."""
    if len(s) <= BODY_CHARS:
        return s
    return re.sub(r'\s*\S*$', '', s[:BODY_CHARS])


EQUATION = re.compile(r'\(\d+\.\d+\)|\\tag\{', re.M)
QUOTED = re.compile(r'^> ', re.M)
KINDWORD = re.compile(r'\b(' + KINDS + r')\b')


def classify_empty(txt):
    """What a source contributing no statement row DOES carry.

    EVERY SOURCE IS ACCOUNTED FOR, because a bare count of sources outside the index
    was read twice as a count of unread sources and was wrong both times: first as "48
    never transcribed", then as "all transcribed, merely unindexed".  Neither held.  A
    lecture-notes section has numbered EQUATIONS and no theorems, so it is transcribed
    in full and has nothing this index's shape can hold."""
    # THIS ORDER IS THE ORIGINAL AND THE REORDER THAT REPLACED IT WAS NET HARMFUL.  The
    # six sources r906 found mislabelled were fixed by WIDENING THE PATTERN, which gave
    # them rows so this function never sees them; the reorder fixed none of them and moved
    # 11 of the 17 remaining labels, four quoting sources becoming "prose summary only"
    # including the one source r906 singled out for documenting its own partial
    # transcription (r907).  A conjunction of QUOTED and KINDWORD also held for only 1 of
    # 7 members, the rest having a blockquote in one place and a kind word in another,
    # twice in this record's own commentary.
    if QUOTED.search(txt):
        return "verbatim quotation without a numbered head"
    if EQUATION.search(txt):
        return "numbered equations rather than theorems"
    if KINDWORD.search(txt):
        return "statements named in prose"
    return "prose summary only, worth a second read"


def harvest():
    """Every transcribed statement, as (slug, name, opening clause)."""
    rows = []
    for path in sorted(glob.glob(os.path.join(ROOT, 'references', '*', 'notes.md'))):
        slug = os.path.basename(os.path.dirname(path))
        try:
            txt = open(path, encoding='utf-8').read()
        except OSError:
            continue
        seen = set()
        for m in STATEMENT.finditer(txt):
            name = m.group(1).strip().rstrip('.')
            # prose inside the bolded head belongs to the body, not the name
            tail = re.sub(r'\s+', ' ', m.group(2)).strip(' .,')
            body = re.sub(r'\s+', ' ', m.group(3)).strip()
            if tail:
                body = f"{tail}. {body}" if body else tail
            # A SECOND HEAD WITH THE SAME LABEL IS COMMENTARY, NOT A SECOND STATEMENT, and
            # it merges.  The record glosses a source's theorem in its own words under the
            # same label, as in `**Theorem C's trichotomy is exactly the record's competitor
            # list**` beside a blockquote of Theorem C itself.  Appending it made a
            # duplicate pair in five sources, and the gloss is exactly what a screen wants,
            # so it joins the statement's row rather than competing with it (r907).
            prior = next((k for k, r in enumerate(rows)
                          if r[0] == slug and r[1] == name), None)
            if prior is not None:
                if body and body not in rows[prior][2]:
                    rows[prior] = (slug, name, _clip(f"{rows[prior][2]} **{body}**"))
                continue
            rows.append((slug, name, _clip(body)))
            seen.add(name)
        lines = txt.split('\n')
        for m in HEADING.finditer(txt):
            head = re.sub(r'\s+', ' ', m.group(1)).strip().rstrip('.')
            # THE LABEL IS THE KIND AND ITS NUMBER, taken by match rather than by
            # splitting on a comma: a heading without one left its whole prose in the
            # label column, 23 rows of it (r906).
            lm = re.match(r'.*?\b((?:' + KINDS + r')\s+[A-Z0-9][\w.]*)', head)
            if not lm:
                continue
            label = lm.group(1)
            # THE GLOSS IS WHAT FOLLOWS THE LABEL, taken by position.  `replace` cut the
            # label out of the MIDDLE of a heading and left the body starting on a comma
            # or a conjunction, in 13 rows (r907).  The whole heading is kept as the body
            # when the label sits inside it rather than at the front, because a heading
            # reading `Theorem C's trichotomy is exactly the record's competitor list` IS
            # the useful text and mutilating it loses more than the repetition costs.
            # THE HEADING'S OWN TAIL, which is all a MERGE may contribute: the row it
            # merges into already carries the statement, so appending the text beneath the
            # heading duplicated it (visible as a body reading its own first clause twice).
            tail = head[lm.end(1):].strip(' ,') if lm.end(1) < len(head) else ''
            if lm.start(1) > 0:
                # the label sits inside the heading, so the whole heading IS the useful
                # text: `Theorem C's trichotomy is exactly the record's competitor list`
                tail = head
            # AND THE TEXT BENEATH, which is what a NEW row's body should be.  A row
            # reading only `*named in a section heading*` tells a reader a statement exists
            # and sends them to the folder, which is the trip this index exists to save
            # (r906's item 4, which it called the one with consequences for the file's
            # stated purpose).
            start = txt[:m.start()].count('\n') + 1
            beneath = []
            for line in lines[start:]:
                if line.startswith('#'):
                    break
                if line.strip():
                    beneath.append(line.strip().lstrip('> ').strip())
                elif beneath:
                    break
            body = re.sub(r'\s+', ' ', ' '.join(beneath)).strip()
            # a heading is often followed by its own bolded restatement, so strip a leading
            # head naming the same statement rather than printing the label twice
            body = re.sub(r'^\*\*' + re.escape(label) + r'\.?\*\*\s*', '', body)
            hit = next((k for k, r in enumerate(rows)
                        if r[0] == slug and label and label in r[1]), None)
            if hit is not None:
                if tail and tail not in rows[hit][2]:
                    rows[hit] = (slug, rows[hit][1], _clip(f"{rows[hit][2]} **{tail}**"))
                continue
            rows.append((slug, label, _clip(body or tail) or "*named in a section heading*"))
    return rows


def _pipe(s):
    """A table cell's pipes, as an entity rather than a backslash."""
    return s.replace('|', '&#124;')


def render(rows, empties):
    by = collections.defaultdict(list)
    for slug, name, body in rows:
        by[slug].append((name, body))
    out = [
        "# The transcribed literature, one row per numbered statement",
        "",
        "**GENERATED by [lit_index.py](../scripts/misc/lit_index.py) from every `notes.md` "
        "in [references/](../references/). Nothing here is edited by hand.**",
        "",
        "**THIS IS THE FIRST PLACE A CANDIDATE ROUTE IS SCREENED**, before the fence posts, "
        "[findings/](.), [ATTEMPTS.md](../ATTEMPTS.md), [reviews/](../reviews/), "
        "[references/](../references/) and [verification/](../verification/). *A candidate "
        "whose mechanism is a cited theorem is settled here in one read and nowhere else "
        "cheaply.*",
        "",
        "**Why it exists.** The record held these statements in 86 source folders with a "
        "three-row table over them, so reaching one meant knowing which folder to open, "
        "which is exactly what a sweep does not know. *Two of one sweep's three routes were "
        "things the record already held, and a route was proposed, ranked and worked while "
        "the theorem it needed sat transcribed with its consequence drawn beside it, missed "
        "by the cycle and by three independent reviewers.*",
        "",
        f"**{len(rows)} statements across {len(by)} sources.** *A source contributing no row "
        "either was never transcribed or states its content as prose, and the count alone does "
        "not say which: it is a lead to check rather than a list of unread sources.*",
        "",
    ]
    if empties:
        out.append("## Sources carrying no theorem-shaped statement, and what each carries instead")
        out.append("")
        out.append("**Every stored source is accounted for here, and THESE LABELS ARE MACHINE-INFERRED "
                   "RATHER THAN CHECKED.** *They come from a three-regex cascade over the notes, not "
                   "from a reading of them, and a cycle presented an earlier version as though it had "
                   "read all 35* ([r906](../reviews/REVIEW_r906.md), which read eleven and found six "
                   "mislabelled). **Two are known wrong and no classifier can fix them**: "
                   "`li-2024-sphere-theorems-second-kind`, whose only quotation is this record\'s own "
                   "verdict rather than the source\'s statement, and `self-dual-weyl-degenerate`, which "
                   "is a search log with no stored source at all. *A count of sources outside the index "
                   "was twice read as a count of UNREAD sources and was wrong both times, first as never "
                   "transcribed and then as all transcribed.*")
        out.append("")
        out.append("| source | what it carries |")
        out.append("|---|---|")
        for slug, why in sorted(empties):
            out.append(f"| [{slug}](../references/{slug}/notes.md) | {why} |")
        out.append("")
    for slug in sorted(by):
        out.append(f"## [{slug}](../references/{slug}/notes.md)")
        out.append("")
        out.append("| statement | what it says |")
        out.append("|---|---|")
        for name, body in by[slug]:
            # A PIPE IS ESCAPED AS AN ENTITY, NEVER AS A BACKSLASH.  Every pipe in this
            # file sits inside inline mathematics, where `\|` is the LaTeX NORM delimiter,
            # so a backslash escape silently turned `s|T|^2` into `s\|T\|^2` and changed
            # absolute value into a norm in 12 rows (r906 latent, r907 live and counted).
            # The entity renders as a pipe and carries no meaning in mathematics.
            out.append(f"| **{_pipe(name)}** | {_pipe(body)} |")
        out.append("")
    return '\n'.join(out) + '\n'


if __name__ == '__main__':
    rows = harvest()
    covered = {r[0] for r in rows}
    empties = []
    for path in sorted(glob.glob(os.path.join(ROOT, 'references', '*', 'notes.md'))):
        slug = os.path.basename(os.path.dirname(path))
        if slug in covered:
            continue
        try:
            empties.append((slug, classify_empty(open(path, encoding='utf-8').read())))
        except OSError:
            pass
    dest = os.path.join(ROOT, 'findings', 'INDEX-literature.md')
    open(dest, 'w', encoding='utf-8').write(render(rows, empties))
    by = {r[0] for r in rows}
    print(f"findings/INDEX-literature.md: {len(rows)} statements across {len(by)} sources")
    folders = len(glob.glob(os.path.join(ROOT, 'references', '*', 'notes.md')))
    print(f"  {len(by)} of {folders} sources carry theorem-shaped statements; the other "
          f"{folders - len(by)} are listed in the file with what each carries instead")
    tally = collections.Counter(w for _, w in empties)
    for why, k in tally.most_common():
        print(f"    {k:3d}  {why}")
