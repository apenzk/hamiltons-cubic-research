---
name: update-report
description: Bring report/ to the state of the record, read the findings index, fold what changed into the LaTeX sections, rebuild the PDF, and send it. Use when the user says "update the report", "refresh the report", "the report is stale", or invokes /update-report.
---

# Update the report

`report/` is a paper-style progress report on the problem in [README.md](../../../README.md), assembled from the programme's working files. **It is not part of the research loop.** Do not run a cycle, and do not edit [plan.md](../../../plan.md), [findings/](../../../findings/), [results.md](../../../results.md), [reviews/](../../../reviews/) or [scripts/](../../../scripts/) while updating it, the report follows the record, never the other way round.

## What to read

| Source | For |
|---|---|
| `git log --oneline -- .` since the last `report/` commit | What changed, and which commits are mathematics rather than housekeeping |
| [findings/INDEX.md](../../../findings/INDEX.md) | The index. Read it in full; it names the file each subject lives in |
| [findings/](../../../findings/) | Open only the files the index points at for what changed |
| [plan.md](../../../plan.md) | Priorities and open tasks, the report's "what would close it" section tracks this |

`git show <sha>` on a `feat(` or `fix(` commit is usually faster than diffing the findings files: the commit body states what changed and why, in prose.

## The framing, which is deliberate and must survive

Each of these was argued for and settled. Changing one is the user's call, not the update's.

- **§1.1 states Problem P exactly as posed** and adds nothing: *for $n\ge12$, $P$ on the unit sphere of $\mathrm{Weyl}_n$ is maximized on the Weyl tensor of products of spheres*, granting the diagonal case. The balanced product, $\theta_0(n)$, evenness and uniqueness are **derived**, and listed separately as interpretations.
- **Conjecture A is a step, taken in §6.1, not the frame.** The report is about Problem P throughout.
- **Labels are literal**: `Lemma` proven, `Observation` verified numerically at the dimensions named, `Conjecture` a candidate. A machine computation goes in a `Verification` block that names its arithmetic, alongside the proof and never inside it.
- **Off-path work lives in Appendices A–C**, each stating why it was pursued and what keeps it out of the endgame.
- **Refutations and withdrawn claims stay in**, recorded where they bit, see the language rule below for how to phrase them.

## The language rule: status, not history

**The report states the position. It does not narrate how the position was reached.** This is the rule most often broken, and it is broken by writing what feels like useful context.

Never write: *this cycle*, *for one revision*, *until recently*, *the record used to*, *has since changed*, *Gate 2 landed*, *a cycle of this record read…*, or *now* where it only means "unlike before". A reader cannot use any of it, and it dates the document the moment it is opened.

**The list is not the rule, and what escapes it is the sentence that needs the reader to know a previous version.** *An earlier version read…*, *no longer*, *had been written*, *that phrasing*, *not previously catalogued*, none of these is a banned word, and each presupposes a draft nobody outside can see. **The test is whether the sentence survives being read by someone holding only this document.** If it does not, state the position it compares against instead of the comparison: not *"an earlier version read the equality case as exactly the compact symmetric pairs"* but *"the equality case is not exactly the compact symmetric pairs, and two corrections separate it from that"*.

A refuted claim is still recorded, as **what is false and why**, not as an event:

| Instead of | Write |
|---|---|
| "This report carried, for one revision, the target … Both are false" | "The natural reading (*two horns and a low middle*) is false, and $S^5\times S^7$ settles it alone" |
| "One step has stopped being a computation" | "The dual step of that chain is an argument" |
| "REFUTED as stated. The post read: …" | "Only the *uniform single-plane* third moment fails to determine $\theta$. The wider reading is false, because …" |
| "Gate 2 landed twice" | "Two independent audits cover it" |

Audits are **evidence**, so attribute them as evidence ("two reviewers, independently, on identical briefs") never as events in a schedule. **And the apparatus behind them is not the reader's business: no rounds, no run that was stopped, no filed or unfiled reports, no logs, no cycles, and no appeal to "the record", which the reader cannot open.** What a debt row owes a reader is **evidential standing**, one derivation behind a result, or two independent ones. *"One reviewer was stopped mid-run, so that round has a single filed report"* is a schedule; *"one independent rebuild rather than two"* is the same fact, and usable.

The one place a temporal word is correct is a genuine present obligation: *audit pending*, *unreviewed*, *owed*. That is the current state of a debt, not a story.

## Numbering

`Lemma`, `Observation` and `Conjecture` share **one** sequence, and **[findings/INDEX.md](../../../findings/INDEX.md) owns it**, a number is assigned when a result gets a block in [findings/](../../../findings/), and every other file adopts it. The report never assigns a number: it adopts whatever the record already gave a result, and a result the record has not numbered is not ready for the report. **Gaps in the report's numbering are expected and correct**, the report covers what is worth presenting, not the whole sequence, so numbers may skip. To see what the record has assigned:

```
grep -o "^| \*\*[0-9]*\*\*" findings/INDEX.md | grep -o "[0-9]*" | sort -n | tail -3
```

And what the report currently carries:

```
grep -ho "begin{\(Lem\|Obs\|Conj\)}{[0-9]*}" report/sections/*.tex | grep -o "[0-9]*" | sort -n | tail -3
```

## The route diagrams, drawn by hand

[sections/diagram.tex](../../../report/sections/diagram.tex) is **Figure 1**, `fig:routes`, every live route, one branch each. **Figure 1 draws every route [routes.md](../../../routes.md) marks live; [STATUS.md](../../../STATUS.md)'s chain is only the one being worked.** **A branch is one strategy: a route that serves a single step of another (its instrument, one of its cases) folds into that step's box and takes no column of its own. Routes marked reserve, fallback or stalled, and routes registered but not started, share one grey box that names them by id. A closed route goes to Figure 3.** *Every live route stays visible, and the column limit below is spent only on the strategies being worked.* [sections/diagram-closed.tex](../../../report/sections/diagram-closed.tex) is **Figure 3**, `fig:closed`, the same map with the failed routes added, so its centre is a copy of Figure 1 exactly. **Both are about routes and nothing else**: neither carries lemma boxes. A lemma belongs at its step's section pointer and in the ledger, which is where a reader can act on it; in the figure it doubled the width and paid for that in legibility.

| PDF | label | file | drawn |
|---|---|---|---|
| Figure 1 | `fig:routes` | `sections/diagram.tex` | by hand |
| Figure 2 | `fig:routes-dag` | `sections/diagram-dag.tex` | generated from Figure 1 |
| Figure 3 | `fig:closed` | `sections/diagram-closed.tex` | by hand |
| Figure 4 | `fig:closed-dag` | `sections/diagram-closed-dag.tex` | generated from Figure 3 |
| Figure 5 | `fig:full-dag` | `sections/diagram-full-dag.tex` | generated from the record |

**A figure's number is its position among the floats and moves when a float is added; its label does not.** Name a figure by its label, and check any number against the built PDF (`pdftotext report.pdf - | grep '^Figure'`) before relying on it.

**Figures 1 and 2 print together, and Figures 3, 4 and 5 on consecutive pages**, held by `\clearpage` around their inputs in 09-status.tex: Figure 4 is placed `[H]` and Figures 3 and 5 are rotated floats, which otherwise land after the closed-routes table.

**The two figures share about twenty nodes as literal copies, and nothing keeps them in step.** A shared node may be *abridged* in Figure 3, which is the busier figure, dropping a section pointer or a clause is fine. It may never *disagree*. Figure 3 once showed the diagonal half as granted for several commits after Figure 1 had it proved, and its own caption claims its centre is Figure 1 unchanged, so a contradiction there is a false statement rather than an untidy one.

**Figure 1 is a DAG with ONE root and ONE leaf**, its caption saying so: the line reads downward as a reduction from Problem P to the success box, so every node lies on a path between them. A node with no incoming edge is a second root, one with no outgoing edge a second leaf, and either means the figure is drawn wrong or carries a box that does not belong. *Three roots and two leaves once survived unnoticed through several revisions, including one where the figure was read page by page: attack (a) had no incoming edge while its siblings did, and the projection estimate's arrow ran backwards, making the settled half of a dichotomy into something nothing reached.* **Run [check_figure_dag.py](../../../scripts/runs/check_figure_dag.py) after any change to either figure**, it takes no judgement and catches what reading the picture does not. It checks ten things: Figure 1's one root and one leaf, Figure 3's one root, that no two boxes overlap, that Figure 1 carries no closed-route box, that every red-drawn style sets red text, that every caption cites its partner figure, that every generated figure draws its legend inside the picture, that every figure page's ink falls inside the text block, that every generated figure covers the results its route diagram names, and **that the full graph covers the record**.

**Every convention this file states earns a line in that script, or it drifts.** *Three were stated here and broken anyway: boxes placed by hand landed on each other with two at identical coordinates, a CLOSED attack drew a red box on the live line with an arrow into the success box, and twenty-six red boxes carried black text against two carrying red.* **None reached the log and none was caught by reading the picture**, the closed box even passed the root-and-leaf check, since a node with an incoming and an outgoing edge is neither. **A convention asserted in prose and never measured is a convention that has already drifted.**

**An annotation box goes on the side its own edge leaves from.** One hanging off `.west` belongs to the left, and pushing every annotation the same way leaves a kill edge crossing the whole figure. *Widen the figure to make room and move the annotation, never the step: a step's `x` is its column and a row's alignment is what makes the picture read downward.*

**Whenever a shared node's claim changes, change it in both.** This is a review prompt rather than a gate, since abridgement is legitimate and a strict comparison flags it:

```
python3 - <<'PY'
import re
def nodes(p):
    t=open(p).read(); d={}
    for m in re.finditer(r'\\node\[[^\]]*\]\s*(?:at\s*\([^;]*?\)\s*)?\((\w+)\)\s*(?:at\s*\([^;]*?\)\s*)?(\{.*?\});', t, re.S):
        d[m.group(1)]=re.sub(r'\s+',' ',m.group(2))
    return d
a=nodes('sections/diagram.tex'); b=nodes('sections/diagram-closed.tex')
for k in sorted(set(a)&set(b)):
    if a[k]!=b[k]:
        print('['+k+']\n  1:',a[k][:120],'\n  2:',b[k][:120])
PY
```

Read each pair it prints and ask whether Figure 3 is saying something *less* or something *else*. Less is fine; else is the bug.

**The colour convention is load-bearing and is asserted in four places**, both legends and both captions. Change it in the `\definecolor` block of [report.tex](../../../report/report.tex), never in the node styles, so the two figures cannot disagree on it.

| | |
|---|---|
| blue, solid | a step of the main argument, **settled** |
| grey, **dashed** | a step **not yet proven** |
| red | a **failed path**, and where it stops |

Macro names track meaning rather than colour: `openink` is the grey, `deadink` and `failline` the red. Renaming them when a colour changes is part of the change.

**Boxes carry status; edges carry structure.** Every edge is solid. An arrow says only what follows from what, and whether a thing is proven is the box's colour and dashing, so a dashed edge asserts nothing the picture does not already say, and the legend has no entry to decode one. Dashed edges once ran into settled boxes while solid ones ran into unproven boxes, which is the opposite of what the box convention says.

**Every node sits in the row of its longest-path depth from Problem P**, at `y = -PITCH * depth` with `PITCH` about 43mm, so a child is always in the row directly below its parent, and the picture reads downward as the caption claims. Compute the depth from the edges rather than placing by eye: nodes drifted rows for several revisions, the SOS certificate sitting three rows below its parent and the dichotomy two rows *above* where its own edge put it.

**An edge meets a border at its midpoint, perpendicular.** In TikZ `-|` is horizontal-then-vertical and `|-` the reverse, so the last leg must match the anchor: `-|` into a `.north` or `.south`, `|-` into an `.east` or `.west`. Get it backwards and the arrow slides into a corner. Leave from a named anchor too --- an offset like `($(x.south)+(-14mm,0)$)` starts partway along the border and reads as a miss. And leave on the side the target is on: a box on the left reached by an edge exiting `.east` crosses the whole figure and doubles back.

**Figure 3 is a landscape page**, `sidewaysfigure`, because at 40 nodes it does not read at `\textwidth`. Rotating swaps the axes, so the figure's width is capped against `\textheight` --- the long page dimension once rotated --- and `\resizebox{0.86\textheight}{!}` is what fits it, the `0.86` being margin. **`adjustbox`'s `max totalheight` does not bind inside `sidewaysfigure`**: it left the goal box clipped off the left edge, and capping the height instead pushed the figure past both margins. Rotation only pays when the figure is wider than tall, which Figure 3 is at 565 by 470mm and Figure 1 is not.

**Measure the fit, never assume it.** `\resizebox` and `\adjustbox` overflow silently --- nothing reaches the log --- so check the ink against the page:

```
gs -q -dNOPAUSE -dBATCH -sDEVICE=bbox -dFirstPage=<n> -dLastPage=<n> report.pdf
```

A portrait page is 595 by 842pt with a 453pt text block; a landscape figure may use the full 842pt length. Ink reaching 0 or the page dimension is clipped, not merely large.

**Width is the binding constraint, and the row grid drives it.** Strict rows force siblings into separate columns, so a row's node count sets the figure's width; seven columns is about the ceiling. Figure 1 at 18 nodes spans ~210mm and reads well; Figure 3 at 40 nodes spans ~565mm and is at the edge of legibility at `\textwidth`. **Before adding a node to a crowded row, ask what comes out** --- cutting box text to topic-plus-pointer buys room, adding a column costs it.

**Where a new closure goes depends on what it was.** A whole strategy (an alternative path from the conjecture to a proof) becomes a **red branch** forking from Conjecture A, running *what it does* → *what it produced* → *where it stops*, and reaching no further. A technique that fails at one step becomes a **red side box** beside that step. Getting this wrong is what made the figure unreadable once: it said every closure was a technique, and four of them were whole routes.

## The dependency figures, generated

**Three figures are generated from the record's own citations by [result_dag_figures.py](../../../scripts/misc/result_dag_figures.py) and are never edited by hand.** They sit under the route diagrams: `fig:routes-dag` after Figure 1, `fig:closed-dag` and the full `fig:full-dag` after Figure 3. Regenerate them whenever a result is added, retyped or withdrawn, and commit the `.tex` they write.

**An edge is a dependency, and most citations are not one.** The extractor takes every `L<n>` inside a result's block, and the classification is the whole of the work: a mention that contrasts, supersedes, corrects or records provenance is not an edge. **Read naively the citations carry 188 cycles and every one is a sentence about the record's history read as a sentence about mathematics**, *"THIS RETIRES L84 AS A DEPENDENCY"*, *"THE OBSERVATION THAT BECAME L191"*. Classified, the graph is acyclic, and a cycle that survives classification is a finding rather than an artefact.

**Colour is the audit status the index records, and the macros come from [report.tex](../../../report/report.tex)'s `\definecolor` block.** Never write a colour literal into a node style: the report asserts one convention across every figure, and a second palette invented in a generator makes two figures disagree about what red means. *`deadink` is the red of a failed route, so it is the right red for a withdrawn result and the wrong one for anything else, a Gate 2 finding takes `posedink`, which cannot be mistaken for it at node size.*

| | |
|---|---|
| `lemink` | a Gate 2 verdict with nothing found against it |
| `posedink` | a verdict that refuted something or left a gap |
| `openink`, dashed | no verdict on file |
| `deadink` | withdrawn |

**Kind stays in the suffix rather than taking a colour**, `.O`, `.C`, `.W`, because the record types almost everything `Lemma` and a colour spent there separates nothing.

**A red ring behind a node in Figure 4 marks a result a red box of Figure 3 names**, the result that showed a route failed. The node keeps its audit colour, and the generator reads red from Figure 3's own `deadink` styles.

**Order within a level is chosen by barycentre sweeps, and that is what makes the figure readable.** Placed by id the same graph draws as a hairball at any size, since id order has nothing to do with the edges. Rows are the longest-path depth, so a result sits above everything it rests on.

**A rotated figure is sized with `\resizebox` and the factor is MEASURED, never reasoned about.** `adjustbox` does not bind inside `sidewaysfigure` in either `max height` or `max totalheight`, and `\resizebox` overflows silently, so the only thing that settles it is `gs -q -dNOPAUSE -dBATCH -sDEVICE=bbox -dFirstPage=<n> -dLastPage=<n> report.pdf` against the text block, which on A4 with 2.5cm margins runs 71 to 524pt. *Rotation swaps the axes, so the figure's PRE-rotation height is what lands across the page width, and on a tall graph that is the binding dimension.* **Three plausible values in a row each put ink on the page edge and lost the leftmost column**, which is why the check now measures rather than trusting the source. **And the caption has a fraction of the room a portrait one has**, three lines overran the block and the last was cut, which `bbox` reports as ink at the page edge and the log reports not at all.

**The figures come in pairs and each caption names its partner.** The live map against the closed one, and each route diagram against the reading of what its results rest on. *A caption naming no partner leaves the pair discoverable only by scrolling.*

**The colour convention is drawn as swatches inside the picture, not spelled out in the caption.** A caption is read once and scrolled past, and on a rotated page it is the scarcest room there is: three lines of legend overran the block and the last was cut, which reaches no log.

**A generated figure's seeds are READ FROM ITS ROUTE DIAGRAM, never listed in the generator.** Figure~2 is the reading of Figure~1 and Figure~4 the reading of Figure~3, so each takes the `L` numbers its own diagram names. *A hand-kept list stops being that the first time someone names a new lemma in the `.tex`, and the caption goes on claiming a correspondence that has lapsed.* **Regenerate whenever a route diagram gains or loses a result**, which the check enforces.

**A caption says what the figure is, not what the argument is.** *Figure 1's ran to eleven lines and most of it repeated the paragraph directly above the figure.* Three sentences is the shape: what the picture reads as, the colour convention in a clause, and the partner figures. **Anything a reader would need without the picture belongs in the body text**, where it is found by someone not looking at a figure.

**The full graph is checked against the RECORD, not against the route diagrams.** *The route diagrams sit still for weeks while the record gains results, so a figure can fall dozens behind and pass a check that compares the two.* **A result the graph does not draw is declared in [result-graph-isolates.txt](../../../report/result-graph-isolates.txt)**, which names every result no dependency edge reaches in either direction. *That is a claim somebody made after reading every citation naming it, so it is written down and checked rather than inferred, and a result that quietly stops being drawn fails instead of disappearing.*

**The classified graph is an INPUT and is tracked at [result-graph.json](../../../report/result-graph.json).** The pass that separates dependencies from citations is the expensive part and survives nowhere else: read naively the citations carry cycles in the dozens, every one a duplication, correction or consequence note read as a dependency. *`DAG_GRAPH` overrides the tracked path for experiments and is not where the graph lives.*

## Build and check

```
cd report && latexmk -pdf report.tex && latexmk -c
```

Then verify, every time:

- `grep -n "Reference.*undefined\|^!" report.log`, empty.
- `grep -c Overfull report.log`, compare against before your edit; a new box over ~20pt is visible and worth fixing, usually by moving a long inline formula into a display.
- **Render the pages you changed** and read them: `pdftoppm -png -r 105 -f <n> -l <n> report.pdf out`. Locate a page by searching `pdftotext report.pdf -` for a phrase you wrote.

## Deliver

1. **Send the PDF with `SendUserFile`**, on every rebuild, without being asked. **The PDF is the deliverable.**
2. **Commit** `report/` on its own, `docs(report): …`, separate from any other concern in the working tree.

**There is no web build and no HTML.** The PDF is the only output. A second rendering meant every diagram existed twice, in TikZ and in mermaid, and keeping the copies in step cost more than the HTML was worth. If a shareable link is ever wanted, ask before building one back.

## Editing this file

**An edit here follows [editing-skills](../editing-skills/SKILL.md)**, when it is allowed, where the lesson goes, and the verbatim report it owes.
