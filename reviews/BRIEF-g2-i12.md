# Gate 2 brief, whether I12's target is subsumed by a recorded lemma

**You are one of two reviewers working from identical briefs, cold and independently.** Form your verdict from the record itself. **This is a brief about a closure, not a proof**: an item graded 4 and listed live has been closed as subsumed, and if that is wrong a live item was retired.

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Reading the machine-checked layer.** `lake`, `lean` and `elan` are **not on `PATH`**, they live in `~/.elan/bin`. To build, `cd lean && PATH="$HOME/.elan/bin:$PATH" lake build`. *A bare `which lake` returning nothing is not evidence the toolchain is absent*, and a statement-level audit of a Lean file is weaker than one that has run it.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -- reviews/REVIEW_r<N>.md reviews/INDEX.md -m "..."`, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## The item, as it stood

> **I12, the four-index certificate off the diagonal locus.** *Theorem: at a maximiser, in every orthonormal frame, $\Sigma:=A^2+B^2+C^2-AB-BC-CA\le\theta^2(2-t_F/2)^2$ in the opposite-pair sums of the frame-diagonal part, $t_F$ the frame's own vertex-matrix budget.* Grade **4**.

Here $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$ are the opposite-pair sums over a four-subset $\{i,j,k,l\}$.

## The closure argument

> **Two recorded facts settle it.**
>
> **(1)** [second-order.md](../findings/second-order.md) carries: *"Consequently [Lemma L24] gives, at every maximiser and every $4$-subset, $A^2+B^2+C^2-AB-BC-CA\le\theta^2$."* The surrounding block fixes a **pair-diagonal** $M$ and says the block and its spectrum *"need diagonality alone, with no criticality and no row sum entering, which is what makes them applicable to $\operatorname{diag}(M)$ in a frame where $W$ is not diagonal"*, the same object I12 quantifies over.
>
> **(2)** [conventions.md](../findings/conventions.md) records, from [L94](../findings/bispectral.md): *"$t=t_F=\lVert K(F)\rVert_F^2$ per frame, and $\kappa^2=\max_Ft_F$. Lemma L94 gives $\kappa^2\le2\lVert M\rVert_F^2$ with equality exactly at coordinate-diagonal $W$, so $t_F\le2$ in every frame."*
>
> **Hence $(2-t_F/2)^2\ge1$ always**, so $\Sigma\le\theta^2$ implies $\Sigma\le\theta^2(2-t_F/2)^2$ everywhere, and is strictly stronger wherever $t_F<2$, that is, off the diagonal locus, which is exactly where the item claimed to be useful. At $t_F=1$ the target permits $2.25\,\theta^2$ against the recorded $\theta^2$.
>
> **So the item's theorem is a weakening of a lemma the record proved before it was filed.**

## What to attack

1. **Is the recorded $\Sigma\le\theta^2$ really available at every orthonormal frame**, or only at frames where $M$ is pair-diagonal? Read the block at source. **The quoted sentence is the whole hinge**: if it licenses only the diagonal locus, the subsumption fails off it and the closure is wrong.
2. **Are the two $\Sigma$'s the same quantity?** I12 says "the opposite-pair sums of the frame-diagonal part"; the recorded lemma says $A=M_{ij}+M_{kl}$ for a pair-diagonal $M$. Check that $M$ means the same object in both, and that no normalisation differs between them, this record has a live factor-of-two hazard between $\lVert\cdot\rVert$ and $\lVert\cdot\rVert_F$.
3. **Is $t_F\le2$ right, and is it the same $t_F$?** [conventions.md](../findings/conventions.md) warns that the per-frame and extremal readings of $t$ *"are distinct and have been swapped"*. **Check which one I12's statement uses.** If I12 means $\kappa^2=\max_Ft_F$ rather than the per-frame $t_F$, the arithmetic changes.
4. **Check the direction of the inequality in $\theta$.** $\theta$ could be negative or the statement could be at $\lvert\theta\rvert$; verify $(2-t_F/2)^2\ge1$ does what the argument says under the record's own sign conventions.
5. **Does the recorded lemma carry hypotheses I12's target does not**, so that the two are incomparable rather than nested? The record says the block needs diagonality alone but *"the necessary condition below is the part that needs a maximiser"*. Both claim a maximiser, check that nothing else differs.
6. **[r353](REVIEW_r353.md) returned `REFUTED as proved` on the L24 application inside I12's own derivation.** Read it. **If L24 cannot be applied the way I12 applied it, can it be applied the way the recorded lemma applies it?** A subsumption that leans on a step already refuted in a neighbouring context is the failure mode to look for here.
7. **What, if anything, does I12 have that the recorded lemma lacks?** A frame-dependent right-hand side is weaker as a bound but might be sharper as a *statement* in some regime, or might be the form a downstream consumer needs. Say whether anything is lost by the closure.
8. **The grade.** The closure asserts that a grade of 4 was an over-estimate. Is that fair, or was the grade about something the closure does not address?
9. **Name what would break the closure**, the reading of the record under which I12's target is not implied.
