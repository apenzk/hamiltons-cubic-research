# Hamilton's cubic on Weyl curvature operators

A research record on a conjecture of Böhm and Wilking: the lemmas proved so far, the routes tried and abandoned, the adversarial reviews every claim went through, and a Lean formalisation of the results that admit one.

---

# Problem

Let $W_n$ be the space of algebraic Weyl curvature operators in $\mathbb{R}^n$, and let $Q(W) = W^2 + W^\#$ be Hamilton's quadratic map, sending $W_n$ to itself, which is [Fox](references/fox-2019-nonassociative-curvature-algebra/notes.md)'s Lemma 5.7.

**Goal:** prove that the cubic form $P(W) = \langle W, Q(W) \rangle$, restricted to $W$ of norm 1, is maximized on the Weyl tensor of products of spheres when $n \geq 12$.

**Known:** the result holds when $P$ is restricted to curvature operators that are diagonal with respect to a suitable basis of $\mathbb{R}^n$. That diagonal case is proved in [Jäger's thesis](references/jaeger-2016-diagonal-case/README.md), in high dimensions.

The conjecture is due to Christoph Böhm and Burkhard Wilking. The general (non-diagonal) case is open.

**Process:** work proceeds incrementally. Each solved sub-step is reported as a distinct lemma against the goal above, and effort continues on the next open sub-step rather than stalling on the full result.

---

# Results

The curated, numbered statement of what has been proved lives in [results.md](results.md), the canon that owns the `Lemma`/`Observation`/`Conjecture` sequence, organised by route. The working record, organised by subject, is [findings/INDEX.md](findings/INDEX.md) and [findings/](findings/). The write-up is [report/](report/), and the Lean formalisation with its index is [lean/](lean/).

---

# How the record was made

The research ran as AI-assisted loops in Claude Code, and the loops are part of the record: the skills, hooks and rules that drove them are in [.claude/](.claude/), every claim's adversarial review is in [reviews/](reviews/), and every lemma's independent verification is in [verification/](verification/). [plan.md](plan.md) holds the open tasks and [ATTEMPTS.md](ATTEMPTS.md) the routes tried.

This repository is a public snapshot of a private working record, synced from it at intervals. The papers the record consulted are linked at their sources from [references/](references/), where each folder keeps the citation and the reading notes. A link marked *unpublished, held in the private record* names working material this snapshot carries only as a citation.

---

# Continuing the research from this repository

This repository carries everything the loops need to run on their own: the record, the skills and hooks in [.claude/](.claude/), the Lean project and the scripts. Clone it and start from [plan.md](plan.md) and [STATUS.md](STATUS.md).

- **Papers.** `python3 scripts/fetch-references.py` downloads the papers listed in [references/FETCH.tsv](references/FETCH.tsv) from their arXiv pages or direct links and extracts the text the notes quote by line number. Git ignores the downloads. A few sources need a manual download, and the script lists them.
- **Lean.** `lake build` in [lean/](lean/) builds the formalisation, with Mathlib fetched on the first run.
- **Report.** `make` in [report/](report/) rebuilds the PDF.
- **Git hooks.** `git config core.hooksPath .githooks` switches on the commit-time checks.
- **The $n=12$ certificate.** [Lemma L254](results.md) cites an outside sum-of-squares certificate that this repository does not hold, so its replay is unavailable here.

---

# License

Copyright (c) 2026 apenzk. Two licenses apply, split by what the file is.

- **Mathematical writing**, [results.md](results.md), [findings/INDEX.md](findings/INDEX.md), [plan.md](plan.md), [ATTEMPTS.md](ATTEMPTS.md), [reviews/INDEX.md](reviews/INDEX.md), and everything under [findings/](findings/), [reviews/](reviews/) and [report/](report/), is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Reuse it, adapt it, build on the lemmas, credit the source and say what you changed. Full text in [LICENSE-docs](LICENSE-docs).
- **Code** (everything under [scripts/](scripts/)) is licensed under the [MIT License](https://opensource.org/license/mit). Full text in [LICENSE](LICENSE).
- **Papers cited** under [references/](references/) stay under their own authors' terms. The folder holds citations and notes, with each paper linked at its source.
