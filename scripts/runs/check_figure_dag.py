"""Figure 1 is a DAG with ONE root and ONE leaf.  This checks it.

THE INVARIANT, stated by the user and asserted by the figure's own caption: the
line reads downward as a reduction from Problem P to the success box, so every
node lies on a path between them.  A node with no incoming edge is a second
root; a node with no outgoing edge is a second leaf; either means the figure was
drawn wrong or carries a box that does not belong.

  IT WAS BROKEN, AND HAD BEEN BEFORE THIS SESSION.  Three roots and two leaves:
    * attack (a) had no incoming edge at all, while (b) and (c) both hang off the
      non-diagonal half -- and (a)'s own text says "the residue is the
      non-symmetric ungraded points", which is what that node holds;
    * the projection estimate's arrow ran proj -> dich, making it a root, when it
      is the SETTLED HALF of the dichotomy and the dependency runs the other way;
    * and once reversed it became a leaf, until drawn to the success box, which
      is honest: it is one of the two things that together close Problem P by
      that route.

  None of these was caught by looking at the picture.  The check is mechanical
  and takes no judgement, which is why it is a script rather than a habit.
"""
import os, re, sys

SRC = "report/sections/diagram.tex"
SRC2 = "report/sections/diagram-closed.tex"
LEGEND = {"leg", "k1", "k2", "k3", "k4", "k5", "k6"}

t = open(SRC).read()
nodes = set(re.findall(r'\\node\[[^\]]*\]\s*(?:at\s*\([^;]*?\)\s*)?\((\w+)\)', t)) - LEGEND
edges = []
for m in re.finditer(r'\\draw\[[^\]]*\]([^;]*);', t, re.S):
    # anchors may be multi-word -- "(nondiag.south east)" -- so match the node
    # name and allow anything up to the closing paren.  A first version required
    # the paren immediately after a single-word anchor and silently dropped every
    # such edge, reporting nodes as isolated when they were not.
    refs = [r for r in re.findall(r'\((\w+)(?:\.[\w ]+)?\)', m.group(1)) if r in nodes]
    if len(refs) >= 2:
        edges.append((refs[0], refs[-1]))

src = {a for a, b in edges}
dst = {b for a, b in edges}
roots = sorted(n for n in nodes if n not in dst)
leaves = sorted(n for n in nodes if n not in src)

print(f"  {len(nodes)} nodes, {len(edges)} edges")
print(f"  roots:  {roots}")
print(f"  leaves: {leaves}")

assert roots == ["asked"], (
    f"roots are {roots}, not ['asked'].  Figure 1 reads downward as a reduction "
    "from Problem P, so a node nothing reaches is either drawn wrong or is a box "
    "that does not belong on the live line")
assert leaves == ["win"], (
    f"leaves are {leaves}, not ['win'].  A node that leads nowhere contributes "
    "nothing to the reduction; either its outgoing edge is missing or the box "
    "should not be in this figure")

adj = {}
for a, b in edges:
    adj.setdefault(a, []).append(b)
seen, stack = set(), set()
def cyclic(u):
    if u in stack: return True
    if u in seen: return False
    seen.add(u); stack.add(u)
    r = any(cyclic(v) for v in adj.get(u, []))
    stack.discard(u)
    return r
assert not any(cyclic(n) for n in nodes), (
    "the figure contains a cycle, so it is not a reduction at all -- some step "
    "would depend on its own consequence")

print("\n  one root, one leaf, acyclic.")

# ---- FIGURE 2 CARRIES A DIFFERENT INVARIANT, AND IT IS CHECKED SEPARATELY ----
#
# One root, as in Figure 1 -- but MANY leaves, legitimately: its whole subject is
# the failed routes, and its caption says each "runs to what it produced and then
# to where it stops, and none reaches the success box".  A red terminus is
# supposed to be a leaf.  What must not happen is a red box with no INCOMING
# edge, which would say a closure arrived from nowhere.
#
# Eight of them did.  Every closure arrow ran FROM the red box TO the live step,
# so each was a root -- the same reversal that made Figure 1's projection
# estimate a root.  Reversed, they became termini, which is what the caption
# already claimed they were.
t2 = open(SRC2).read()
n2 = set(re.findall(r'\\node\[[^\]]*\]\s*(?:at\s*\([^;]*?\)\s*)?\((\w+)\)', t2)) - LEGEND
e2 = []
for m in re.finditer(r'\\draw\[[^\]]*\]([^;]*);', t2, re.S):
    refs = [r for r in re.findall(r'\((\w+)(?:\.[\w ]+)?\)', m.group(1)) if r in n2]
    if len(refs) >= 2:
        e2.append((refs[0], refs[-1]))
d2 = {b for a, b in e2}
roots2 = sorted(n for n in n2 if n not in d2)
print(f"\n  Figure 2: {len(n2)} nodes, {len(e2)} edges")
print(f"  roots: {roots2}")
assert roots2 == ["asked"], (
    f"Figure 2 roots are {roots2}, not ['asked'].  Its many leaves are correct -- "
    "red termini are the point -- but a box nothing reaches is a closure that "
    "arrived from nowhere, and the usual cause is a closure arrow drawn from the "
    "red box to the live step rather than from the step to its closure")
print("  one root; multiple leaves are correct here (red termini).")


# ---------------------------------------------------------------------------
# THREE CONVENTIONS THE SKILL STATES AND NOTHING CHECKED.  Each was broken and
# each was found by a reader rather than by a script, which is the failure this
# block ends: a convention asserted in prose and never measured drifts.

RED = ("dead", "shut", "stop", "side", "kill")
ANNOT = {"side", "dead", "shut", "stop", "lem"}


def boxes(text):
    """Placed nodes as (name, x, y, width) in mm, width including inner sep."""
    widths = dict(re.findall(r'(\w+)/\.style\s*=\{[^}]*?text width=(\d+)mm', text, re.S))
    out = []
    for m in re.finditer(r'\\node\[([^\]]*)\]\s*\((\w+)\)\s*at\s*\(([-\d.]+)mm,\s*([-\d.]+)mm\)', text):
        opts, name, x, y = m.group(1), m.group(2), float(m.group(3)), float(m.group(4))
        w = re.search(r'text width=(\d+)mm', opts)
        base = opts.split(',')[0].strip()
        out.append((name, x, y, (float(w.group(1)) if w else float(widths.get(base, 50))) + 7, base))
    return out


def overlaps(text):
    """Pairs whose boxes intersect.  A row's boxes are placed by hand, so a new
    node lands on an old one silently: TeX reports nothing and the ink is simply
    drawn twice.  Two boxes once sat at identical coordinates."""
    bs = boxes(text)
    return [(a[0], b[0]) for i, a in enumerate(bs) for b in bs[i + 1:]
            if abs(a[1] - b[1]) < (a[3] + b[3]) / 2 and abs(a[2] - b[2]) < 18]


for name, text in (("Figure 1", t), ("Figure 2", t2)):
    bad = overlaps(text)
    assert not bad, (
        f"{name}: boxes overlap -- {bad}.  Widen the figure and move the ANNOTATION box, "
        "not the step: an annotation goes on the side its own edge leaves from, so one "
        "hanging off `.west` belongs to the left and pushing it right leaves a kill edge "
        "crossing the whole figure")
    print(f"  {name}: no overlapping boxes.")

# Figure 1 is the live line; a closed route belongs to Figure 2.  A `dead` node
# there drew an arrow into the success box, which asserts the proof runs through
# a step that failed -- and it passed the root/leaf check, because a node with
# both an incoming and an outgoing edge is neither a root nor a leaf.
live_dead = sorted(n for n, _, _, _, base in boxes(t) if base in ("dead", "shut", "stop"))
assert not live_dead, (
    f"Figure 1 carries closed-route boxes {live_dead}.  Figure 1 is the live line and a "
    "failed route belongs to Figure 2, which already holds a copy of every shared node")
print("  Figure 1: no closed-route boxes on the live line.")

# Every red-drawn style sets red text, so a red box reads the same wherever it
# sits.  Twenty-six carried black text and two carried red, the difference being
# a \color span written by hand inside some nodes and not others.
for name, path, text in (("Figure 1", SRC, t), ("Figure 2", SRC2, t2)):
    for style in RED:
        m = re.search(rf'\b{style}/\.style\s*=\{{([^}}]*)\}}', text, re.S)
        if m and "draw=deadink" in m.group(1):
            assert "text=deadink" in m.group(1), (
                f"{path}: style `{style}` draws in deadink and does not set text=deadink, "
                "so its boxes take the ambient colour and the figure carries red boxes with "
                "black text beside red boxes with red text")
    print(f"  {name}: every red style sets red text.")


# ---------------------------------------------------------------------------
# THE FIGURES COME IN PAIRS AND EACH NAMES ITS PARTNER.  A reader meeting one
# needs the other: the live map against the closed one, and each route diagram
# against the reading of what its results rest on.  A caption that names no
# partner leaves the pair discoverable only by scrolling.

GEN = "report/sections/diagram-dag.tex"
GEN2 = "report/sections/diagram-closed-dag.tex"
PAIRS = {
    SRC:  ("fig:routes",      ["fig:closed", "fig:routes-dag"]),
    SRC2: ("fig:closed",      ["fig:closed-dag"]),
    GEN:  ("fig:routes-dag",  ["fig:routes", "fig:closed-dag"]),
    GEN2: ("fig:closed-dag",  ["fig:closed", "fig:routes-dag"]),
}
for path, (own, wants) in PAIRS.items():
    body = open(path).read()
    cap = re.search(r'\\caption\{(.*?)\}\s*\n?\\label\{' + re.escape(own) + r'\}', body, re.S)
    assert cap, f"{path}: no caption found before \\label{{{own}}}"
    for w in wants:
        assert w in cap.group(1), (
            f"{path}: the caption of {own} does not cite {w}.  Each figure names its "
            "partner, so a reader meeting one can find the other")
print("  every figure caption cites its partner.")

# The colour convention belongs in the picture.  Stated only in the caption it
# is read once and then scrolled past, and the caption is the scarcest room on a
# rotated page -- three lines there overran the block and the last was cut.
for path in (GEN, GEN2, "report/sections/diagram-full-dag.tex"):
    body = open(path).read()
    assert "Audit status" in body, (
        f"{path}: no in-figure legend.  The colour convention is drawn as swatches "
        "inside the picture, not spelled out in the caption")
print("  every generated figure carries its legend in the picture.")


# ---------------------------------------------------------------------------
# INK ON THE PAGE, MEASURED.  \resizebox and \adjustbox overflow silently: no
# warning reaches the log and the ink simply runs off the paper.  A rotated
# figure is where this bites -- `adjustbox` does not bind inside
# `sidewaysfigure` in either `max height` or `max totalheight`, so a figure
# sized that way looked fine in the source and lost its leftmost column.
import subprocess

PDF = "report/report.pdf"
TEXT_BLOCK = (71, 524)          # A4 with 2.5cm margins, in points
if os.path.exists(PDF):
    pages = subprocess.run(["pdftotext", PDF, "-"], capture_output=True, text=True).stdout.split("\f")
    figpages = [i + 1 for i, p in enumerate(pages) if len(re.findall(r'^L\d+', p, re.M)) > 50]
    for n in figpages:
        out = subprocess.run(["gs", "-q", "-dNOPAUSE", "-dBATCH", "-sDEVICE=bbox",
                              f"-dFirstPage={n}", f"-dLastPage={n}", PDF],
                             capture_output=True, text=True).stderr
        m = re.search(r'%%BoundingBox: (\d+) (\d+) (\d+) (\d+)', out)
        if not m:
            continue
        x0, _, x1, _ = map(int, m.groups())
        assert x0 >= TEXT_BLOCK[0] - 2 and x1 <= TEXT_BLOCK[1] + 2, (
            f"page {n}: ink runs {x0}--{x1}pt against a {TEXT_BLOCK[0]}--{TEXT_BLOCK[1]}pt text "
            "block, so the figure is clipped.  Measure the scale with "
            "`gs -sDEVICE=bbox` rather than reasoning about which axis binds: after rotation "
            "the figure's PRE-rotation height is what lands across the page width")
        print(f"  page {n}: ink {x0}--{x1}pt, inside the text block.")


# ---------------------------------------------------------------------------
# A GENERATED FIGURE IS THE READING OF ITS ROUTE DIAGRAM, so every result the
# route diagram names appears in it.  The seeds are read from the .tex rather
# than listed in the generator, and this checks the two have not drifted: name a
# new lemma in a route diagram, forget to regenerate, and the caption goes on
# claiming a correspondence that no longer holds.
for route, gen, lab in ((SRC, GEN, "fig:routes-dag"), (SRC2, GEN2, "fig:closed-dag")):
    named = {n for n in re.findall(r'\bL(\d{1,3})\b', open(route).read())}
    drawn = {n for n in re.findall(r'\{L(\d{1,3})', open(gen).read())}
    missing = sorted(named - drawn, key=int)
    assert not missing, (
        f"{gen} omits {['L'+m for m in missing]}, which {route} names.  Regenerate with "
        "scripts/misc/result_dag_figures.py: its seeds are read from the route diagrams, so a "
        "figure that has gained a lemma needs its reading rebuilt")
print("  every generated figure covers the results its route diagram names.")


# ---------------------------------------------------------------------------
# THE FULL GRAPH COVERS THE RECORD, AND WHAT IT LEAVES OUT IS DECLARED.  The
# check above compares a generated figure against its route diagram, which is
# the wrong thing to watch: the route diagrams sit still for weeks while the
# record gains results, so a figure can fall dozens of results behind and pass.
# A result is absent only when no dependency edge reaches it in either
# direction, and that is a claim someone made after reading every citation
# naming it, so it is written down and checked rather than inferred.
ISOLATES = "report/result-graph-isolates.txt"
FULL = "report/sections/diagram-full-dag.tex"
if os.path.exists(ISOLATES) and os.path.exists(FULL):
    record = {m.group(1) for m in
              re.finditer(r'^\|\s*\*\*(\d+)\*\*\s*\|', open("findings/INDEX-results.md").read(), re.M)}
    drawn = set(re.findall(r'\\node\[\w+\] \(n(\d+)\)', open(FULL).read()))
    declared = {l.strip() for l in open(ISOLATES) if l.strip() and not l.startswith("#")}
    missing = sorted(record - drawn - declared, key=int)
    stale = sorted(declared & drawn, key=int)
    assert not missing, (
        f"the full graph omits {['L'+m for m in missing]}, which the record numbers and "
        f"{ISOLATES} does not declare.  Classify their citations with "
        "scripts/misc/result_dag_extract.py and either add the edges or declare them isolated")
    assert not stale, (
        f"{ISOLATES} declares {['L'+s for s in stale]} isolated and the figure draws them. "
        "Remove them from the list: an isolate that gained an edge is no longer one")
    print(f"  the full graph covers the record: {len(drawn)} drawn, {len(declared)} declared isolated.")
