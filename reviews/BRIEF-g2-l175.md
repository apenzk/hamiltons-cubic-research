# Gate 2 brief, the (A),(B) fence, and a conventions bullet called unscoped

**You are one of two reviewers working from identical briefs, cold and independently.** Two separate claims are under review; treat them separately and give each its own verdict.

**On the second, note what is at stake.** A cycle has declared a tabled convention **wrong as written** and rewritten it. *That cycle has misread the record five times today, a string census taken for a hypothesis census, a consequence sentence read without its neighbour's scope clause, a threshold reversed, a tabled sense said not to exist, and a circular sentence cited as an argument.* **Read the file, not this brief's account of it.**

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

## Claim 1, [Lemma L175](../findings/bounds-relaxations.md), the fence

In [L104](../findings/bounds-relaxations.md)'s value-type reduction, with $\mu_j=m_j-\delta_{ij}$:

$$\text{(A}_i)\ \textstyle\sum_{j<k}2\mu_j\mu_kt_{ijk}+\sum_j\mu_j(\mu_j-1)t_{ijj}=2(n-2),\qquad \text{(B}_i)\ \textstyle\sum_{j<k}\mu_j\mu_k(\nu_j+\nu_k)t_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_jt_{ijj}=-2\nu_i,$$
$$\text{(C}_i)\ \textstyle\sum_{j<k}2\mu_j\mu_k\nu_j\nu_kt_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_j^2t_{ijj}=2\nu_i(\theta-\nu_i).$$

> **$\theta$ occurs in (C) and nowhere else.** So the feasible set cut out by (A) and (B) does not move with $\theta$, and any bound derived from membership in it alone holds at every $\theta$ at once, which is to say it bounds nothing. **Hence no Schur-convexity argument from the SDIEP toolbox reaches $\theta$**, every object that toolbox produces being built from (A) and (B). *The majorisation half of [I17](../plan.md) (that the subset-sum family is exactly $-\lambda/(n-2)\prec\lambda$), is a recognition and stands.*

Machine-checked at `lean/HamiltonsCubic/Results/L175.lean`.

### Attack

1. **Is $\theta$ really absent from (A) and (B)?** Check the reduction at source, not from this brief, the right-hand sides could carry $\theta$ through $\nu$ or through the normalisation.
2. **The inference.** "A $\theta$-free constraint set bounds $\theta$ only vacuously", **is that right?** A constraint on $T$ plus a *separate* relation determining $\theta$ from $T$ could still bound $\theta$. **Does (C) do that, and if so is the fence too strong?** This is the item to press hardest.
3. **"Every object the toolbox produces is built from (A) and (B)"** is a claim about a body of technique and is argued in prose. Is it true, and is it the kind of claim that can be?
4. **The Lean file**: read its statements against the claim. `theta_free_bounds_nothing` is an `Iff.rfl`, say whether it states anything.
5. **The majorisation half.** Is it a recognition, and does the closure leave it intact?

## Claim 2, a conventions bullet, called unscoped and rewritten

[conventions.md](../findings/conventions.md) carries, eleven bullets apart:

> $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ for the symmetric hollow sectional matrix $K_{ab}=W_{abab}$ … **$t\le2$ with $t=2$ iff $W$ is coordinate-diagonal in some frame**

and, before the edit:

> **The letter $M$ carries two objects, and their norms differ by $\sqrt2$.** $M$ (or $K$) is the $n\times n$ **sectional** matrix …, **where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor**; $W$ is the operator on $\Lambda^2$, where $\operatorname{tr}(W^2)=1$.

> **The claim**: the second is the diagonal-locus value stated without its scope; $K$ captures only the entries $W_{abab}$, so $\lVert K\rVert_F^2\le2$ with equality exactly where those determine $W$. The bullet is rewritten to carry the scope.

### Attack

6. **Are the two bullets actually inconsistent**, or is there a reading on which both stand, a different normalisation of $K$, or a scope the first bullet carries implicitly from its own context?
7. **Is the repair's reason right?** *"$K$ captures only the entries $W_{abab}$, so equality is exactly where those determine $W$"*, derive it or refute it. **A plausible-sounding reason for a true conclusion is still a defect.**
8. **Was the original bullet load-bearing anywhere?** If a consumer read it unqualified, the edit changes what that consumer may claim. Say what you find.
9. **The consequence stated**: that at the sectional matrix off the diagonal locus, [L94](../findings/bispectral.md)'s bound would read $\kappa^2\le4$. Check it.
10. **Name what would show the edit wrong.**
