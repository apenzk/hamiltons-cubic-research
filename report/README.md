# Report

A paper-style progress report on the Conjecture A programme: the goal, the four strategies, the lemmas proven so far, the negatives that constrain future attempts, and what remains open.

| File | Holds |
| --- | --- |
| [report.tex](report.tex) | Preamble, macros and the list of inputs |
| [sections/](sections/) | One file per section, plus [diagram.tex](sections/diagram.tex) and [diagram-closed.tex](sections/diagram-closed.tex) for the two TikZ figures |
| [report.pdf](report.pdf) | The built document |
| [Makefile](Makefile) | `make` builds, `make clean` removes artefacts |

## Sources

The report is assembled from the programme's working files and states nothing they do not: [findings/INDEX.md](../findings/INDEX.md) for what is true now, [results.md](../results.md) for the numbering and labels only, the mathematics comes from the findings, [plan.md](../plan.md) for the open tasks and priorities, [reviews/INDEX.md](../reviews/INDEX.md) for the audit verdicts, and [references/](../references/) for the literature.

## Labels

Labels are literal and match [results.md](../results.md): **Lemma** is proven, **Observation** is verified numerically at the dimensions stated, **Conjecture** is a candidate that is not proven. **[findings/INDEX.md](../findings/INDEX.md) owns the numbering and the report adopts it**, never the other way round. A result the record has not numbered does not belong in the report yet. **Numbers may skip here**: the report presents what is worth presenting, so gaps in its sequence are expected and are not a defect to repair. Every result carrying a qualification (a measured rather than proven ingredient, a conditionality, a pending audit), states it at the point of use, and the ledger in the last section collects them.

## Building

Needs a TeX distribution with `latexmk` and `pdflatex`. Run `make`.

To edit one part, open its file in [sections/](sections/), the root only carries the preamble and the input list, so a section can be rewritten without touching anything else.
