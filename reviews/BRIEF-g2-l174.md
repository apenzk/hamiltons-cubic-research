# Gate 2 brief, whether I36's shape claim is the budget claim

**You are one of two reviewers working from identical briefs, cold and independently.** Form your verdict before opening the findings file this came from.

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

## The setting

$t_F=\lVert K(F)\rVert_F^2$ is the vertex-matrix budget of an orthonormal frame $F$, **per frame**, and $\kappa^2=\max_Ft_F$ is its extremal reading. The record warns that *"the per-frame and extremal readings are distinct and have been swapped"*.

**[Lemma L94](../findings/LEDGER.md), on the record with its own Gate 2** ([r101](REVIEW_r101.md), [r102](REVIEW_r102.md), both CONFIRMED with a one-line proof of both halves): $\kappa^2\le2\lVert M\rVert_F^2$, **with equality exactly at coordinate-diagonal $W$**.

**The plan item.** *I36, every local maximiser above $\sqrt{3/2}$ is coordinate-diagonal.* Its own entry records it as filed *"on a shape rather than a mechanism"*.

## The statement under review

> For unit $W$, $\big(\text{every local maximiser with }\theta>\sqrt{3/2}\text{ is coordinate-diagonal in some frame}\big)\iff\big(\text{every such maximiser has }\kappa^2=2\big)$.
>
> **Proof.** L94's equality case, at unit norm, says $\kappa^2=2$ holds precisely when some frame makes $W$ coordinate-diagonal. Applying it under the outer quantifier over $W$ gives each direction. $\square$

Two remarks accompany it:

> **(a)** It gives I36 a mechanism where it had a shape (an existential over frames becomes an extremal condition on a continuous function of $W$), **and leaves the item exactly as open**.
>
> **(b)** The threshold sits **below** $\theta_0(12)$: $\theta_0(12)^2=\tfrac{220}{144}>\tfrac32$, so $\theta>\sqrt{3/2}$ is the *weaker* hypothesis and covers strictly more maximisers.

## The machine-checked statement

`lean/HamiltonsCubic/Results/L174.lean`, state `partial`, built in the kernel. It abstracts `Weyl`, `Frame`, `IsCoordDiagonal`, `kappaSq`, `theta`, `IsUnit`, `IsLocalMax`, takes L94 as a hypothesis, and proves `shape_iff_budget`. **Read its statement against the record's**, the quantifiers, the hypothesis set, and whether the abstraction has weakened the claim into something easier than the record means. Its `threshold_below_theta_zero` records remark (b).

## What to attack

1. **The `κ²` reading.** L94 is stated with $\kappa^2=\max_Ft_F$; I36 speaks of a frame in which $W$ is diagonal. **Is the equivalence using the extremal reading consistently**, or does it slide into the per-frame $t_F$ somewhere? The record says these have been swapped before, so this is the first place to look.
2. **The unit-norm step.** L94 reads $\kappa^2\le2\lVert M\rVert_F^2$; the reformulation sets the right side to $2$. **Check which norm is normalised to $1$**, the record carries $\lVert Z\rVert^2=\tfrac12\mathop{\mathrm{tr}}(Z^{\mathsf T}Z)$ against plain Frobenius, and $\lVert W\rVert=1$ and $\lVert M\rVert_F=1$ are not the same condition.
3. **The quantifier step, which the Lean file isolates.** $W$ is bound outside and the frame inside. Is the equivalence between the two universally quantified statements really immediate from a pointwise iff, and does it survive if the set of qualifying $W$ is empty?
4. **Is L94's "exactly" really a biconditional at unit norm**, or does the equality case carry a hypothesis the reformulation drops? Read L94 at source rather than through this brief.
5. **Remark (b).** Verify $\tfrac{220}{144}>\tfrac32$ and that this makes $\theta>\sqrt{3/2}$ the weaker hypothesis. **Then ask whether "weaker hypothesis, more maximisers" is the right reading**, a weaker hypothesis makes the *theorem* stronger and the item harder, which the remark does not say.
6. **Remark (a)'s claim that the item is "exactly as open".** Is that right, or does the budget form admit an attack the shape form does not, or vice versa? **A reformulation that quietly loses information is the failure to look for.**
7. **What "local maximiser" means here**, and whether L94 needs criticality, maximality or neither. If L94 needs nothing, the equivalence holds for every unit $W$ and the maximiser hypothesis is idle, say so.
8. **Hypothesis inventory**, and the edges: $\kappa^2$ at a $W$ with kernel; whether a maximising frame exists at all, since $\max_F$ presumes attainment over a compact group.
9. **Name what would break it.**
