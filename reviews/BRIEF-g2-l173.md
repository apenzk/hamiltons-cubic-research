# Gate 2 brief, the pinned class's kernel witness

**You are one of two reviewers working from identical briefs, cold and independently.** Work from what is below. Do not read the findings file this came from until you have formed your own verdict on every claim.

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -- reviews/REVIEW_r<N>.md reviews/INDEX.md -m "..."`, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## The setting, quoted from the record

For a unit $W\in\mathcal W_n$ with spectrum given as distinct values $\nu_1,\dots,\nu_d$ and multiplicities $m_1,\dots,m_d$ summing to $N=\binom n2$, with $\sum_im_i\nu_i=0$ by tracelessness, the **pinned class** is

$$\Pi(\lambda)=\{(T,\theta):T\ge0\text{ totally symmetric and hollow, satisfying (A), (B), (C) at every row}\}.$$

A value-type reduction on the record collapses the $3N$ equalities to $3d$. With $a$ in class $i$ and $\mu_j=m_j-\delta_{ij}$:

$$\text{(A}_i)\ \sum_{j<k}2\mu_j\mu_k t_{ijk}+\sum_j\mu_j(\mu_j-1)t_{ijj}=2(n-2),$$
$$\text{(B}_i)\ \sum_{j<k}\mu_j\mu_k(\nu_j+\nu_k)t_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_jt_{ijj}=-2\nu_i,$$
$$\text{(C}_i)\ \sum_{j<k}2\mu_j\mu_k\nu_j\nu_kt_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_j^2t_{ijj}=2\nu_i(\theta-\nu_i).$$

**The variable count is $\binom{d+2}3$ only when every $m_i\ge3$**: a type $\{i,i,j\}$ exists only when $m_i\ge2$ and $\{i,i,i\}$ only when $m_i\ge3$.

**The pair cap** is $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$, at every pair. **The Killing row mass** is $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$, which is relation (A). And $\theta_0(12)=\sqrt{220}/12$.

## The statement under review

> At $n=12$, the spectrum with values $\nu=(-a,\tfrac43a,0)$ and multiplicities $(4,3,59)$, where $a=\sqrt{3/28}$, admits a totally symmetric hollow $T\ge0$ satisfying (A), (B), (C) at every row and the pair cap at every pair, with
> $$\theta=7a=\frac{\sqrt{21}}2=2.2912878\ldots>\theta_0(12).$$
> **Hence no bound proved from (A), (B), (C), positivity and support alone can close Conjecture A over all unit Weyl operators.**

## The witness, in full

$$t_{112}=\tfrac23,\qquad t_{222}=2,\qquad t_{133}=t_{233}=\tfrac4{1711},\qquad t_{333}=\tfrac{178}{32509},$$

with $t_{111}=t_{113}=t_{122}=t_{123}=t_{223}=0$. The record claims all nine relations hold as exact rational identities once $\nu$ is written $a\cdot(-1,\tfrac43,0)$, which makes (B) rational and (C) rational in $\theta/a$; that every pair cap holds, with $(1,1)$, $(1,2)$ and $(2,2)$ tight at $2$ and $(1,3)$, $(2,3)$ reading $\tfrac8{59}$ and $(3,3)$ reading $\tfrac{562}{1711}$; and that the cap is what pins the witness, since without it $t_{112}$ runs to $0.8985$ and $\theta$ to $3.2020$.

## The machine-checked statement

`lean/HamiltonsCubic/Results/L173.lean`, state `partial`, built in the kernel. It carries the forced parameters, the nine relations as rational identities, the six caps, `(7a)² = 21/4`, and `220/144 < 21/4`. **Read it and say whether its statements are the ones the lemma needs**; its docstring is part of what you audit.

## What to attack

1. **Recompute all nine relations from the displayed coefficients**, independently, in exact arithmetic. **A single coefficient wrong makes the witness infeasible and the lemma false**, and the coefficients were transcribed from the record rather than re-derived.
2. **The pair-cap coefficients.** For a pair with $\alpha$ in class $i$ and $\beta$ in class $j$, the record takes $\sum_\gamma T_{\alpha\beta\gamma}=\sum_k\mu^{(ij)}_kt_{ijk}$ with $\mu^{(ij)}_k=m_k-\delta_{ik}-\delta_{jk}$. **Is that right, including when $i=j$**, where two indices are removed from the same class? Check $(1,1)$, $(2,2)$ and $(3,3)$ especially, an error there is what a tight cap would hide.
3. **Admissibility.** Every $m_i\ge3$ is claimed, so all ten types exist. Check it, and check that the witness sets no inadmissible type nonzero.
4. **The forced parameters.** $4+3+59=\binom{12}2$; tracelessness giving $b=\tfrac43a$; unit norm giving $a=\sqrt{3/28}$. Derive each.
5. **The closed form.** $7a=\sqrt{21}/2$, and $\tfrac{21}4>\tfrac{220}{144}$. Verify both, and the ratio $\sqrt{189/55}$.
6. **Is $\theta$ as defined by (C) the same $\theta$ the conjecture bounds?** (C$_i$)'s right side is $2\nu_i(\theta-\nu_i)$, so $\theta$ enters only through that relation. **A witness with a large $\theta$ in the relaxation says nothing unless that $\theta$ is the functional's.** This is the claim on which the whole conclusion rests, attack it hardest.
7. **The conclusion's quantifier.** *"No bound proved from (A), (B), (C), positivity and support alone can close Conjecture A"*, does one feasible point at one spectrum at one dimension establish that? Say precisely what it does and does not rule out, and whether "support" is doing work the argument has not used.
8. **The kernel mechanism.** The record says a zero class of multiplicity $\ge3$ relaxes (A) because $\{i,3,3\}$ carries weight $\mu_3(\mu_3-1)=3422$ against a right-hand side of $20$ while $\nu_3=0$ removes it from (B) and (C). Check that, and check whether the same mechanism needs the multiplicity to be *large* or merely $\ge3$.
9. **Hypothesis inventory**, and the edges: what happens at $m_3=3$ exactly; whether the witness survives at $n\ne12$; and whether $T\ge0$ was checked at every one of the ten types.
10. **Name what would break it**, the coefficient or constraint which, if the record has it wrong, makes the witness infeasible.
