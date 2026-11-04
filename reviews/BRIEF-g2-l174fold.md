# Gate 2 brief, whether L174's Gate 2 findings were applied faithfully

**You are one of two reviewers working from identical briefs, cold and independently.**

**This brief audits an application, not a proof.** Two reviewers audited [Lemma L174](../findings/second-order.md) and returned findings; a cycle then folded those findings into the record. **Your job is to check that what landed is what they found**, no more, no less, and not something adjacent. *This record's own validation pass found that of twenty-six applied verdicts, one was applied wrongly and in the deleting direction, caught only because someone re-read it. That is the failure mode here.*

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Reading the machine-checked layer.** `lake`, `lean` and `elan` are **not on `PATH`**, they live in `~/.elan/bin`. To build, `cd lean && PATH="$HOME/.elan/bin:$PATH" lake build`. *A bare `which lake` returning nothing is not evidence the toolchain is absent*, and a statement-level audit of a Lean file is weaker than one that has run it.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -m "..." -- reviews/REVIEW_r<N>.md reviews/INDEX.md`, **options come before `--`, and the reverse order is invalid git**, leaving the index empty so the structure gate fails closed, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## What to read

- The two reports: [REVIEW_r761.md](REVIEW_r761.md) and [REVIEW_r762.md](REVIEW_r762.md).
- What landed: [second-order.md](../findings/second-order.md)'s **Lemma L174** block, [plan.md](../plan.md)'s **I36** entry, [lean/HamiltonsCubic/Results/L174.lean](../lean/HamiltonsCubic/Results/L174.lean), [findings/INDEX-results.md](../findings/INDEX-results.md)'s row 174, and [lean/INDEX.md](../lean/INDEX.md)'s L174 row.
- The commits that did it: `22864d05`, `36875710`, `acb2c498`.

## The findings that were supposed to land

1. **The norm is unstated.** The numeral $2$ needs $\lVert M\rVert_F=1$; the block said only *"for unit $W$"*. [conventions.md](../findings/conventions.md)'s one tabled sense of $M$ gives $\kappa^2\le4$; under post F33's $\lvert W\rvert_4=1$ it would give $\tfrac12$.
2. **L94 carries an unstated hypothesis**: attainment of $\max_F$, used in one direction only.
3. **The maximiser hypotheses are idle**, the equivalence holds at every unit $W$.
4. **The Lean docstring's *"the quantifier step is the whole risk"* is refuted**; the risky steps sit inside `def L94`, which is **not** the recorded L94 but its unit-norm specialisation, carrying no Gate 2.
5. **The band is inhabited**: $S^5\times S^7$ at $n=12$, $\theta^2=\tfrac{264}{175}$, strictly between $\tfrac32$ and $\tfrac{55}{36}$.
6. **Remark (b) is the reduction's closure condition**, holding at every $n\ge12$ and failing at every $4\le n\le11$; its trailing clause about *"every one at or above the conjecture's own value"* is false there.
7. **What the reformulation buys is narrow**: $\kappa^2$ is continuous but not differentiable; $\kappa^2\le2$ is free so only $\kappa^2\ge2$ is owed; and a constructive proof of that is the original existential again.
8. **The strictness of $\theta>\sqrt{3/2}$ is load-bearing**, padded $W_{\mathbb{CP}^2}$ is a local maximum at $\theta=\sqrt{3/2}$ exactly with $\kappa^2=1$, so at $\theta\ge\sqrt{3/2}$ both sides are false and I36 would be false.
9. **A cheaper citation for the constant**: [conventions.md](../findings/conventions.md)'s $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$.

## What to attack

1. **Each of the nine, one at a time: did it land, and did it land as stated?** Quote what the reviewer wrote and what the record now says, side by side. **A finding weakened in the folding is the defect to look for**, and so is one *strengthened*, which is how a reviewer's hedge becomes the record's assertion.
2. **Did anything land that neither reviewer said?** The cycle writes prose around the findings; check that every claim now in the block traces to a report or to the record, and flag any that traces to neither.
3. **Where the two reviewers disagreed or differed in emphasis, what did the fold do?** Averaging a disagreement is a defect; so is silently taking one side.
4. **Verify the arithmetic that landed**, independently: $\tfrac{220}{144}=\tfrac{55}{36}$, $\theta^2_{5,7}=\tfrac{264}{175}$ at $n=12$, and that it lies strictly in the band.
5. **The `def L94` point.** Read [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) and say whether its docstring now describes what the file proves. **The previous docstring overclaimed; check the replacement does not.**
6. **The I36 entry.** Finding 8 makes the item's threshold load-bearing and adds an obligation. Did the plan entry record the obligation, and is it the right one?
7. **Anything the reviewers found that the fold dropped entirely.** Read both reports for findings absent from this brief's list of nine, **the brief was written by the same cycle that did the folding**, so its list may inherit the same omissions.
8. **Name what would show the fold unfaithful.**
