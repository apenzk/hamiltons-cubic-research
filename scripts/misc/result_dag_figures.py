#!/usr/bin/env python3
"""Generate the report's three dependency figures from the record's own citations.

WHAT THE GRAPH IS.  An edge runs from a result to one it rests on, extracted from
the `L<n>` mentions inside each `#### Lemma L<n>` block in findings/ and then
classified: a mention that contrasts, supersedes, corrects or records provenance
is not a dependency.  Read naively the citations carry 188 cycles, every one of
them a sentence about the record's history read as a sentence about mathematics.
Classified, the graph is acyclic.

WHAT THE COLOUR CARRIES.  The audit status the index records, because that is
what the record's own governance tracks and what a suffix cannot show:

    audited     a Gate 2 verdict with no finding against it
    finding     a Gate 2 verdict that refuted something or left a gap
    unaudited   no Gate 2 verdict on file
    withdrawn   the index types it WITHDRAWN

Kind stays in the suffix, since 174 of 198 results are Lemmas and a colour
spent on that separates almost nothing.

LAYOUT.  Nodes are placed by longest-path depth so a result sits above everything
it rests on, and the order within a level is chosen by barycentre sweeps.  That
ordering is what makes a chain traceable: placed by id, the same graph draws as a
hairball with no readable structure at all.

    python3 scripts/misc/result_dag_figures.py
"""
import collections
import io
import json
import os
import re
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SEC = os.path.join(REPO, "report", "sections")
# The classified graph is an INPUT, not a scratch file: the by-hand pass that
# separated 290 dependencies from 544 citations survives nowhere else, so it is
# tracked beside the figures it feeds. DAG_GRAPH overrides it for experiments.
GRAPH = os.environ.get("DAG_GRAPH", os.path.join(REPO, "report", "result-graph.json"))

SUFFIX = {"Lemma": "", "Observation": ".O", "Conjecture": ".C"}
STYLE = {"audited": "ok", "finding": "gap", "unaudited": "raw", "withdrawn": "gone"}

# Colours come from report.tex's \definecolor block, never from a literal here:
# the report asserts one convention across every figure, and a second palette
# invented in a node style makes two figures disagree about what red means.
PREAMBLE = [
    "  every node/.style={font=\\tiny},",
    "  res/.style={draw,rounded corners=1.5pt,inner sep=1.5pt,minimum width=9mm,align=center},",
    "  ok/.style={res,draw=lemink,fill=lembg,text=lemink},",
    "  gap/.style={res,draw=posedink,fill=posedbg,text=posedink},",
    "  raw/.style={res,draw=openink,fill=openbg,text=openink,dashed},",
    "  gone/.style={res,draw=deadink,fill=deadbg,text=deadink},",
    # A halo is drawn BEHIND a node, so the node keeps its audit colour and the
    # ring alone says a failed route in Figure 3 names it.
    "  halo/.style={res,draw=deadink,fill=deadbg,text=deadbg,inner xsep=9pt,inner ysep=7pt,minimum width=14mm,line width=.9pt},",
    "  dep/.style={-{Stealth[length=3pt]},openink!55,line width=.2pt},",
    "  bad/.style={-{Stealth[length=3pt]},deadink,line width=.5pt},",
"  lean/.style={fill=inkline,draw=inkline,line width=.2pt,line join=round},",
]

LEGEND_NODE = [
    "% legend: the colour convention belongs in the picture, where a reader meets it",
    "\\begin{scope}[shift={($(current bounding box.south west)+(0,-13mm)$)}]",
    "  \\node[draw=openink!60,rounded corners=1pt,minimum width=96mm,minimum height=LEGEND_HEIGHT,",
    "        anchor=north west,font=\\sffamily\\scriptsize] (leg) at (0,0) {};",
    "  \\node[anchor=north west,font=\\sffamily\\scriptsize\\bfseries] at ($(leg.north west)+(2mm,-1.5mm)$) {Audit status};",
    "  \\node[ok,anchor=west,minimum width=7mm,minimum height=3.4mm,inner sep=0pt] (g1) at ($(leg.north west)+(3mm,-8mm)$) {};",
    "  \\node[anchor=west,font=\\sffamily\\scriptsize] at ($(g1.east)+(1mm,0)$) {Gate~2, nothing found};",
    "  \\node[gap,anchor=west,minimum width=7mm,minimum height=3.4mm,inner sep=0pt] (g2) at ($(leg.north west)+(45mm,-8mm)$) {};",
    "  \\node[anchor=west,font=\\sffamily\\scriptsize] at ($(g2.east)+(1mm,0)$) {a verdict that found something};",
    "  \\node[raw,anchor=west,minimum width=7mm,minimum height=3.4mm,inner sep=0pt] (g3) at ($(leg.north west)+(3mm,-13mm)$) {};",
    "  \\node[anchor=west,font=\\sffamily\\scriptsize] at ($(g3.east)+(1mm,0)$) {no verdict on file};",
    "  \\node[gone,anchor=west,minimum width=7mm,minimum height=3.4mm,inner sep=0pt] (g4) at ($(leg.north west)+(45mm,-13mm)$) {};",
    "  \\node[anchor=west,font=\\sffamily\\scriptsize] at ($(g4.east)+(1mm,0)$) {withdrawn};",
    "  \\node[res,anchor=west,minimum width=7mm,minimum height=3.4mm,inner sep=0pt] (g5) at ($(leg.north west)+(3mm,-18mm)$) {};",
    "  \\fill[lean] (g5.north east) -- ++(-2.2mm,0) -- ++(2.2mm,2.2mm) -- cycle;",
    "  \\node[anchor=west,font=\\sffamily\\scriptsize] at ($(g5.east)+(1mm,0)$) {a full Lean proof};",
    "  \\node[anchor=west,font=\\sffamily\\scriptsize] at ($(leg.north west)+(45mm,-18mm)$) {\\texttt{.O} \\texttt{.C} \\texttt{.W} mark a non-Lemma};",
    "\\end{scope}",
]

HALO_LEGEND = [
    "  \\node[halo,anchor=west,minimum width=7mm,minimum height=3.4mm,inner sep=0pt] (g6) at ($(leg.north west)+(3mm,-23mm)$) {};",
    "  \\node[res,draw=openink,fill=openbg,anchor=center,minimum width=5mm,minimum height=2mm,inner sep=0pt] at (g6) {};",
    "  \\node[anchor=west,font=\\sffamily\\scriptsize] at ($(g6.east)+(1mm,0)$) {red ring: named by a failed route in Figure~\\ref{fig:closed}};",
]


def legend(halo):
    """The legend, with the halo's row only where a figure draws halos."""
    body = LEGEND_NODE[:-1] + (HALO_LEGEND if halo else []) + LEGEND_NODE[-1:]
    return [s.replace("LEGEND_HEIGHT", "27mm" if halo else "22mm") for s in body]


def load():
    g = json.load(open(GRAPH, encoding="utf-8"))
    status = {}
    for line in open(os.path.join(REPO, "findings", "INDEX-results.md"), encoding="utf-8"):
        # The kind field is not always one word: "Lemma, with an Observation" is a
        # real row, and requiring [A-Za-z]+ dropped it silently, which draws the
        # result as unaudited rather than failing.
        m = re.match(r"^\|\s*\*\*(\d+)\*\*\s*\|([^|]*)\|(.*)$", line)
        if not m:
            continue
        n, kind, body = m.group(1), m.group(2).strip(), m.group(3)
        # Two loops audit this record and they use different words. Gate 2 is the
        # research loop's; `Verified: PROVEN` in a verification round is the other,
        # and reading only the first marks a checked result as never checked.
        if kind.upper() == "WITHDRAWN":
            s = "withdrawn"
        elif re.search(r"Gate 2[: ]+(REFUTED|GAP)", body) or re.search(r"\bREFUTED\b", body):
            s = "finding"
        elif re.search(r"Verified: `PROVEN,", body):
            s = "finding"
        elif "Gate 2" in body or re.search(r"Verified: `PROVEN", body):
            s = "audited"
        else:
            s = "unaudited"
        status[n] = (kind, s)
    return g, status


def lean_proved():
    """Results whose Lean file proves the result, not merely states it.

    A row reading `L175 (statement)` proved says the CLAIM type-checks, which is
    a weaker fact and the one most easily mistaken for a proof. Only a row
    without that qualifier counts. Ids arrive in several shapes in that index,
    bare, linked and qualified, so the number is pulled from anywhere in the
    cell and plan items are dropped by their `I` prefix.
    """
    out = set()
    for line in open(os.path.join(REPO, "lean", "INDEX.md"), encoding="utf-8"):
        if not line.startswith("| "):
            continue
        cells = [c.strip() for c in line.split("|")]
        if len(cells) < 5 or cells[1].startswith("I") or cells[1] == "id":
            continue
        m = re.search(r"\bL(\d+)\b", cells[1])
        state = re.sub(r"[*`]", "", cells[3]).strip().lower()
        if m and state.startswith("proved") and "(statement)" not in cells[1]:
            out.add(m.group(1))
    return out


def label(n, status):
    kind, s = status.get(n, ("Lemma", "unaudited"))
    if s == "withdrawn":
        return f"L{n}.W"
    return f"L{n}{SUFFIX.get(kind, '')}"


def depths(nodes, out):
    """Longest path to a sink, so a result sits above all it rests on."""
    memo = {}

    def d(u, seen=frozenset()):
        if u in memo:
            return memo[u]
        if u in seen:
            return 0
        memo[u] = 1 + max((d(v, seen | {u}) for v in out.get(u, ())), default=0)
        return memo[u]

    for n in nodes:
        d(n)
    return memo


def order_levels(levels, out, back, sweeps=24):
    """Barycentre sweeps: place a node near the mean position of its neighbours.

    Without this the figure is unreadable however large the page: edges cross the
    whole width because id order has nothing to do with the graph.
    """
    order = {lv: sorted(v, key=int) for lv, v in levels.items()}
    keys = sorted(order)
    for sweep in range(sweeps):
        for lv in (keys if sweep % 2 == 0 else keys[::-1]):
            pos = {}
            for src in (lv + 1, lv - 1):
                if src in order:
                    pos.update({n: i for i, n in enumerate(order[src])})

            def bary(n):
                xs = [pos[m] for m in (out.get(n, set()) | back.get(n, set())) if m in pos]
                return sum(xs) / len(xs) if xs else 1e9

            order[lv] = sorted(order[lv], key=lambda n: (bary(n), int(n)))
    return order


def draw(nodes, edges, status, per_row, x, y, halo=frozenset()):
    nodes = set(nodes)
    out = collections.defaultdict(set)
    back = collections.defaultdict(set)
    for a, b in edges:
        out[a].add(b)
        back[b].add(a)
    dep = depths(nodes, out)
    levels = collections.defaultdict(list)
    for n in nodes:
        levels[dep[n]].append(n)
    order = order_levels(levels, out, back)

    L = [f"\\begin{{tikzpicture}}[", f"  x={x},y={y},"] + PREAMBLE + ["]"]
    pos, row_y = {}, 0
    for lv in sorted(order, reverse=True):
        row = order[lv]
        for i in range(0, len(row), per_row):
            chunk = row[i:i + per_row]
            x0 = -(len(chunk) - 1) / 2
            for j, n in enumerate(chunk):
                pos[n] = (x0 + j, row_y)
            row_y -= 1
        row_y -= 0.4
    # Halos first, so each result node is drawn on top of its own ring.
    for n in sorted(nodes & set(halo), key=int):
        px, py = pos[n]
        L.append(f"\\node[halo] at ({px:.2f},{py:.2f}) {{{label(n, status)}}};")
    for n in sorted(nodes, key=int):
        px, py = pos[n]
        sty = STYLE[status.get(n, ("Lemma", "unaudited"))[1]]
        L.append(f"\\node[{sty}] (n{n}) at ({px:.2f},{py:.2f}) {{{label(n, status)}}};")
    # The tick goes in before the edges so an arrowhead meeting the same corner
    # lands on top of it rather than under it.
    proved = lean_proved()
    for n in sorted(nodes & proved, key=int):
        L.append(f"\\fill[lean] (n{n}.north east) -- ++(-2.2mm,0) -- ++(2.2mm,2.2mm) -- cycle;")
    for a, b in edges:
        touch_gone = any(status.get(k, ("", ""))[1] == "withdrawn" for k in (a, b))
        L.append(f"\\draw[{'bad' if touch_gone else 'dep'}] (n{a}) -- (n{b});")
    L += legend(bool(nodes & set(halo)))
    L.append("\\end{tikzpicture}")
    return L


def closure(seed, out, depth=2):
    got, frontier = set(seed), set(seed)
    for _ in range(depth):
        nxt = set()
        for u in frontier:
            nxt |= out.get(u, set())
        got |= nxt
        frontier = nxt
    return got


def main():
    if not GRAPH or not os.path.exists(GRAPH):
        print("set DAG_GRAPH to the classified graph json", file=sys.stderr)
        return 2
    g, status = load()
    out = collections.defaultdict(set)
    for a, b in g["dep"]:
        out[a].add(b)
    allnodes = sorted(set(out) | {b for v in out.values() for b in v}, key=int)

    # Seeds are READ FROM THE ROUTE DIAGRAMS, never listed here: a generated
    # figure claims to be the reading of its route diagram, and a hand-kept list
    # stops being that the first time someone names a new lemma in the .tex.
    def named(path):
        body = open(os.path.join(SEC, path), encoding="utf-8").read()
        return sorted({n for n in re.findall(r'\bL(\d{1,3})\b', body) if n in set(allnodes) or n in status},
                      key=int)

    live, closed = named("diagram.tex"), named("diagram-closed.tex")

    # The results a RED box of Figure 3 names: the ones that showed a route
    # failed. Red is read from the diagram's own styles (every style drawn in
    # deadink), so a new red style is picked up without an edit here.
    def failed_named(path):
        src = open(os.path.join(SEC, path), encoding="utf-8").read()
        red = set(re.findall(r"(\w+)/\.style\s*=\s*\{[^}]*draw=deadink", src))
        found = set()
        for m in re.finditer(r"\\node\[([^\]]*)\]\s*\((\w+)\)\s*at\s*\([^)]*\)\s*\{", src):
            if m.group(1).split(",")[0].strip() not in red:
                continue
            i, depth = m.end() - 1, 0
            for j in range(i, len(src)):
                depth += {"{": 1, "}": -1}.get(src[j], 0)
                if depth == 0:
                    found |= set(re.findall(r"\bL(\d{1,3})\b", src[i:j + 1]))
                    break
        return found & set(closed)

    failed = failed_named("diagram-closed.tex")
    figs = [
        (live, "diagram-dag.tex", "fig:routes-dag", 5,
         "\\textbf{What the results of Figure~\\ref{fig:routes} rest on.} Each arrow runs from a "
         "result to one it depends on, read off the record's own citations. "
         "\\textbf{Figure~\\ref{fig:closed-dag} is this reading for the closed routes}, and "
         "Figure~\\ref{fig:full-dag} carries every numbered result.", False),
        (closed, "diagram-closed-dag.tex", "fig:closed-dag", 6,
         "\\textbf{The same reading for Figure~\\ref{fig:closed}}, which names %d results against "
         "Figure~\\ref{fig:routes}'s %d. \\textbf{Figure~\\ref{fig:routes-dag} is the live half of "
         "this}, and Figure~\\ref{fig:full-dag} carries every numbered result."
         % (len(closed), len(live)), False),
        (allnodes, "diagram-full-dag.tex", "fig:full-dag", 15,
         "\\textbf{Every numbered result the record cites, and what each rests on.} $%d$ results, "
         "$%d$ dependencies, \\textbf{acyclic}. A result sits above all it rests on. "
         "Figures~\\ref{fig:routes-dag} and~\\ref{fig:closed-dag} are the two neighbourhoods of "
         "this graph that the route diagrams name." % (len(allnodes), len(g["dep"])), True),
    ]

    for seed, fname, lab, per_row, caption, sideways in figs:
        halo = failed if fname == "diagram-closed-dag.tex" else frozenset()
        nodes = sorted(closure(seed, out) if not sideways else set(seed), key=int)
        edges = [(a, b) for a, b in g["dep"] if a in set(nodes) and b in set(nodes)]
        env = "sidewaysfigure" if sideways else "figure"
        opt = "" if sideways else "[H]"
        # Rotation swaps the axes: the figure's PRE-rotation HEIGHT is what lands
        # across the page width, and here that is the binding dimension -- 643pt of
        # it against a 453pt text block.  `adjustbox` does not bind inside
        # `sidewaysfigure` at all, in either `max height` or `max totalheight`, so
        # the size is set with \resizebox and the factor is MEASURED with
        # `gs -sDEVICE=bbox` against the 71--524pt text block rather than reasoned
        # about: three plausible values in a row put ink on the page edge.
        # A portrait figure caps BOTH dimensions: capped by width alone, a tall
        # graph runs off the page and takes its caption with it.
        box = "{max width=\\textwidth, max totalheight=0.78\\textheight}"
        L = [f"% GENERATED by scripts/misc/result_dag_figures.py -- do not edit",
             f"\\begin{{{env}}}{opt}", "\\centering",
             ("\\resizebox{!}{0.58\\textwidth}{%" if sideways
              else f"\\begin{{adjustbox}}{box}")]
        L += draw(nodes, edges, status, per_row,
                  "13mm" if sideways else "17mm", "8.5mm" if sideways else "11mm", halo)
        L += ["}" if sideways else "\\end{adjustbox}",
              f"\\caption{{{caption}}}", f"\\label{{{lab}}}", f"\\end{{{env}}}"]
        path = os.path.join(SEC, fname)
        io.open(path, "w", encoding="utf-8").write("\n".join(L) + "\n")
        print(f"{fname}: {len(nodes)} nodes, {len(edges)} edges"
              + (f", {len(set(nodes) & set(halo))} ringed" if halo else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
