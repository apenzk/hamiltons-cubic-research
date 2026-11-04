# Hamilton's cubic on Weyl curvature operators

A research record on a conjecture of Böhm and Wilking: the lemmas proved so far, the routes tried and abandoned, the adversarial reviews every claim went through, and a Lean formalisation of the results that admit one.

---

# Problem

Let $W_n$ be the space of algebraic Weyl curvature operators in $\mathbb{R}^n$, and let $`Q(W) = W^2 + W^\#`$ be Hamilton's quadratic map, sending $W_n$ to itself, which is [Fox](references/fox-2019-nonassociative-curvature-algebra/notes.md)'s Lemma 5.7.

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

Until 2026-11-03 the work ran in a separate private repository, and this one received a copy of it at intervals, the commits titled "sync". Since then the work happens here directly, as described under *Working on this repository*. The papers the record consulted are linked at their sources from [references/](references/), where each folder keeps the citation and the reading notes. A link marked *unpublished, held in the private record* names working material this snapshot carries only as a citation.

---

# Continuing the research from this repository

This repository carries everything the loops need to run on their own: the record, the skills and hooks in [.claude/](.claude/), the Lean project and the scripts. Clone it and start from [plan.md](plan.md) and [STATUS.md](STATUS.md).

- **Papers.** `python3 scripts/fetch-references.py` downloads the papers listed in [references/FETCH.tsv](references/FETCH.tsv) from their arXiv pages or direct links and extracts the text the notes quote by line number. Git ignores the downloads. A few sources need a manual download, and the script lists them.
- **Lean.** `lake build` in [lean/](lean/) builds the formalisation, with Mathlib fetched on the first run.
- **Report.** `make` in [report/](report/) rebuilds the PDF.
- **Retrieval.** The research loop searches the record with a local retrieval tool before deriving anything. Build its index with `python3 scripts/rag/registries.py . .rag/head`, `python3 scripts/rag/fetch_sources.py .rag/head/manifest.tsv .rag/papers` and `.venv/bin/python scripts/rag/rag.py index`, and rerun the last after the record changes. Usage and the evaluation are in [scripts/rag/](scripts/rag/README.md).
- **Git hooks.** `git config core.hooksPath .githooks` switches on the commit-time checks, the privacy check described below among them.
- **The $n=12$ certificate.** [Lemma L254](results.md) cites an outside sum-of-squares certificate that this repository does not hold, so its replay is unavailable here.

---

# Working on this repository

Work happens on a local branch and reaches main as one squashed commit, checked for private material on the way.

- **Work branch.** Research cycles commit on a local branch, `loop` on the maintainer's machine, which is never pushed. A pushed branch, and any pull request opened from it, keeps every intermediate commit readable on GitHub even after a squash merge and branch deletion, so intermediate work stays on the machine.
- **Publishing.** `git checkout main && git merge --squash loop && git commit`, then `git push origin main`. Only the squashed result reaches GitHub.
- **Privacy check.** On main, the pre-commit hook runs [check-private.py](.githooks/check-private.py) over every tracked file and refuses the commit on a forbidden string, a secret pattern such as an API key, or an email address outside the allowed ones. Work branches commit unchecked, and the squash is what gets checked.
- **The forbidden-string list** names the private material it guards, so it lives outside every repository, in `~/.config/hamiltons-cubic/forbidden.txt`, one string per line, with `allow <file> <string>` lines waiving one string in one file. Its source of truth is the export gate in the private repository. While the file is missing, every commit on main is refused.
- **Setup on a new computer:**
  1. `git config core.hooksPath .githooks`, which also switches on the Lean build hook.
  2. Copy `scripts/export-public/forbidden.txt` from the private repository to `~/.config/hamiltons-cubic/forbidden.txt`.
  3. Run `python3 .githooks/check-private.py` once, and expect `check-private: clean`.

---

# License

Copyright (c) 2026 apenzk. Two licenses apply, split by what the file is.

- **Mathematical writing**, [results.md](results.md), [findings/INDEX.md](findings/INDEX.md), [plan.md](plan.md), [ATTEMPTS.md](ATTEMPTS.md), [reviews/INDEX.md](reviews/INDEX.md), and everything under [findings/](findings/), [reviews/](reviews/) and [report/](report/), is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Reuse it, adapt it, build on the lemmas, credit the source and say what you changed. Full text in [LICENSE-docs](LICENSE-docs).
- **Code** (everything under [scripts/](scripts/)) is licensed under the [MIT License](https://opensource.org/license/mit). Full text in [LICENSE](LICENSE).
- **Papers cited** under [references/](references/) stay under their own authors' terms. The folder holds citations and notes, with each paper linked at its source.
