# Gate 2 brief, the two pinned moments of $F_u$, and the check they run on a tabulated spectrum

**You are one of two reviewers working from identical briefs, cold and independently.** Work from what is below and from sources you fetch yourself. Do not read the findings file this came from until you have formed your own verdict on every claim.

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -- reviews/REVIEW_r<N>.md reviews/INDEX.md -m "..."`, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## Definitions

- $\mathcal W_n$: symmetric operators on $\Lambda^2\mathbb R^n$ satisfying first Bianchi and Ricci-flat, with $\langle X,Y\rangle$ the Frobenius pairing on operators. $\dim\mathcal W_n=\tfrac{n(n+1)(n+2)(n-3)}{12}$.
- $Q(W)=W^2+W^\#$ with $\#$ the halved Böhm–Wilking product, $P(W)=\langle W,Q(W)\rangle$, and $F_u(h)=\tfrac12(uh+hu)+u\#h$.
- $T$ is the symmetric trilinear form with $T(W,W,W)=P(W)$; $\lVert T\rVert^2=\sum_{a,b,c}T(u_a,u_b,u_c)^2$ over an orthonormal basis of $\mathcal W_n$.
- On the record already, Gate 2 passed: $\operatorname{tr}(L_W^2)=\tfrac{(n-1)(2n-1)}4$ at unit $W$, every $n\ge6$, both parities, where $L_W=F_W$. This is Fox's Killing-metrisation constant.

## The statement under review

> For every $u\in\mathcal W_n$, $n\ge6$:
> $$\operatorname{tr}(F_u)=0,\qquad \operatorname{tr}(F_u^2)=\frac{(n-1)(2n-1)}4\,\lVert u\rVert^2,\qquad \lVert T\rVert^2=\frac{(n-1)(2n-1)}4\cdot\dim\mathcal W_n .$$
> And a tabulated spectrum satisfies both, identically in $m=n-4$.

## The proof as written

> $\langle F_uh,k\rangle=T(u,h,k)$ holds on the nose: $F_u(h)=B(u,h)$ for the symmetric bilinear $B(X,Y)=\tfrac12(XY+YX)+X\#Y$, and $\langle B(X,Y),Z\rangle$ is totally symmetric, the anticommutator term by cyclicity of the trace, the sharp term by the standard symmetry of $\#$. So $u\mapsto\operatorname{tr}(F_u)$ is an $O(n)$-invariant **linear** functional on $\mathcal W_n$, which is irreducible and nontrivial, hence zero; and $u\mapsto\operatorname{tr}(F_u^2)$ is an $O(n)$-invariant **quadratic** form on the same space, which is absolutely irreducible, hence a multiple of $\lVert u\rVert^2$. The multiple is the Killing constant. Summing $\operatorname{tr}(F_{u_a}^2)=\sum_{b,c}T(u_a,u_b,u_c)^2$ over an orthonormal basis gives $\lVert T\rVert^2$ on the left and $\tfrac{(n-1)(2n-1)}4\dim\mathcal W_n$ on the right. $\square$

## The table being checked

For $u=W_{\mathbb{CP}^2}$ padded, $\theta^*=P(u)=\sqrt{3/2}$ and unit norm, the space decomposes under $SO(m)$, $m=n-4$, as $\bigoplus_\lambda M_\lambda\otimes V_\lambda$ with $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}$. The tabulated $\operatorname{spec}(F_\lambda)/\theta^*$, with $\dim M_\lambda$ in brackets:

| $\lambda$ | $\dim V_\lambda$ | $\dim M_\lambda$ | $\operatorname{spec}(F_\lambda)/\sqrt{3/2}$ |
|---|---|---|---|
| trivial | $1$ | $20$ | $-1^{\times2},\ -\tfrac16^{\times6},\ 0^{\times6},\ \tfrac13^{\times3},\ \tfrac12^{\times2},\ 1^{\times1}$ |
| vector | $m$ | $20$ | $-\tfrac12^{\times4},\ 0^{\times12},\ \tfrac12^{\times4}$ |
| $\Lambda^2$ | $\tfrac{m(m-1)}2$ | $6$ | $-\tfrac16^{\times2},\ 0^{\times3},\ \tfrac13^{\times1}$ |
| $S^2_0$ | $\tfrac{(m+2)(m-1)}2$ | $10$ | $-\tfrac16^{\times6},\ 0^{\times1},\ \tfrac13^{\times3}$ |
| $V_{(2,1)}$ | $\tfrac{m(m-2)(m+2)}3$ | $4$ | $0$ throughout |
| $V_{(2,2)}$ | $\tfrac{m(m+1)(m+2)(m-3)}{12}$ | $1$ | $0$ throughout |

> **The first moment vanishes in each block separately** ($-2-1+1+1+1$, $-2+2$, $-\tfrac13+\tfrac13$, $-1+1$) which is more than the identity demands, since only the $\dim V_\lambda$-weighted total is pinned.
>
> **The second moment, weighted.** The four blocks give $\operatorname{tr}(F_\lambda^2)/\theta^{*2}=4,\,2,\,\tfrac16,\,\tfrac12$, so
> $$\frac{\operatorname{tr}(F_u^2)}{\theta^{*2}}=4+2m+\frac{m(m-1)}{12}+\frac{(m+2)(m-1)}4=\frac{(2m+7)(m+3)}6=\frac{(2n-1)(n-1)}6,$$
> and multiplying by $\theta^{*2}=\tfrac32$ returns $\tfrac{(n-1)(2n-1)}4$ exactly.
>
> Also claimed: $\operatorname{tr}(F_u^3)$ is an invariant cubic, hence a multiple of $P(u)$, and the table returns $\theta^{*3}\tfrac{2n^2-15n+1}{36}$, but nothing fixes that constant independently, so the value defines it rather than testing the table.

## What to attack

1. **$\langle F_uh,k\rangle=T(u,h,k)$ with no constant.** Derive it. Is $\langle X\#Y,Z\rangle$ totally symmetric under the halved Böhm–Wilking $\#$, and does the anticommutator term's symmetry survive on $\mathcal W_n$ rather than on all of $S^2(\Lambda^2)$? **A factor here rescales $\lVert T\rVert^2$ and breaks the check**, so it is the first thing to settle.
2. **The two Schur arguments.** Is $\mathcal W_n$ irreducible as an $O(n)$-representation, and **absolutely** irreducible, at every $n\ge6$? Is $Q$ (hence $F$) $O(n)$-equivariant or only $SO(n)$-equivariant, and does the difference matter for either argument? State the range each argument needs.
3. **The summation step.** $\sum_a\operatorname{tr}(F_{u_a}^2)=\lVert T\rVert^2$: check the index bookkeeping and that the same orthonormal basis is used consistently.
4. **The four block traces.** Recompute $4,2,\tfrac16,\tfrac12$ from the tabled spectra, checking the multiplicities sum to $\dim M_\lambda$ in each row. **A transcription error in the table is the most likely defect and is not visible from the collapse**, so read the multiplicities as well as the values.
5. **The collapse.** Verify $4+2m+\tfrac{m(m-1)}{12}+\tfrac{(m+2)(m-1)}4=\tfrac{(2m+7)(m+3)}6$ and the substitution $m=n-4$, and check the arithmetic at $n=12$ against $\tfrac{253}4$.
6. **What the check licenses.** The block says the $m$-freeness of the four characteristic polynomials remains undischarged, two scalars not pinning $56$ eigenvalues. **Is that the right assessment, or does it understate or overstate what two moment identities constrain?** Construct, if you can, an $m$-dependent perturbation of the tabled spectra preserving both moments, that is the concrete test of the claim.
7. **The blockwise first moment.** Is "more than the identity demands" right, does anything on the record force each block separately traceless?
8. **The third-moment claim.** Is $\operatorname{tr}(F_u^3)$ really a multiple of $P(u)$, i.e. is the space of $O(n)$-invariant cubics on $\mathcal W_n$ one-dimensional at the $n$ in scope? If it is not, the block's reason for there being no third check is wrong even if the conclusion stands. Recompute $\tfrac{2n^2-15n+1}{36}$.
9. **Hypothesis inventory**, and the edges: $n=6$, odd $n$, $u=0$, and the dimensions at which the table's $\dim V_\lambda$ formulas degenerate ($m=2,3$).
10. **Name what would break it.**
