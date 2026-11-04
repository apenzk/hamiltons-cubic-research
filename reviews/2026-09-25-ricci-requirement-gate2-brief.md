# Gate 2 brief: what the band needs from the Ricci correction, and the product reduction (r1164, r1165)

**Two reviewers, independently: the round checks an argument.** Analysis-only: argue from the definitions; seconds of computation on objects you construct only as a screen. Model: opus.

## The claims, verbatim from [the working file](2026-09-25-I73c-per-vector-rows.md) at 35c6a7eb

> **What the band needs from the Ricci correction, quantitatively.** For a unit coefficient vector $x$ of the pair family, $h_x=\sum x_{uv}h_{uv}$ and $x^{\mathsf T}B_{\mathrm{Ric}}x=-\tfrac1{2(n-2)}\langle h_x,\mathring eh_x\rangle$, so with [r1160](REVIEW_r1160.md)'s $\lvert\langle h,\mathring eh\rangle\rvert\le\tfrac n\kappa\lvert h\rvert^2$ and $G\preceq\tfrac12I$ (which gives $\lvert h_x\rvert^2/(n-2)\le\tfrac12$), $\lvert x^{\mathsf T}B_{\mathrm{Ric}}x\rvert\le\tfrac n{4\kappa}\approx\tfrac14$ in the band. **The margin to beat, in the same units, is $(\kappa-n+5)/(32\kappa)\lesssim3/(32n)$ near $\theta_0$: the a priori Ricci size is about $n$ times too large.** *So the band closes only through one of two facts about the certificate's space $V_+$: the Ricci parts $h_x$ of its vectors are $O(1)$ rather than the a priori $O(n)$, i.e. $V_+$ is nearly orthogonal to the Ricci directions of the pair family; or their commutator masses nearly balance, $C_0(h_x)\approx C_2(h_x)$.* Both are statements about how the bracket structure $P_0C$ that defines $V_+$ interacts with anticommutators, and neither follows from the rows on file. Scale arithmetic on reviewed bounds; no computation.

> **The Ricci part of a pair combination is what its product leaves after the bracket.** For a coefficient vector $x$ of the pair family put $X_x=\sum_{u,v}x_{uv}\,uv$ ($u\in E_0$, $v\in E_2$, as matrices). Since $(uv)^{\mathsf T}=vu$, its skew part is $\tfrac12\sum x_{uv}[u,v]=\tfrac12C x$ and its symmetric part is $\tfrac12\sum x_{uv}\{u,v\}=-h_x$, and the two are orthogonal (`skew_sym_split` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean)), so
> $$\lvert h_x\rvert_F^2=\lVert X_x\rVert_F^2-\tfrac14\lVert Cx\rVert_F^2 .$$
> **On the certificate's space $V_+$ the bracket $Cx$ is large** ($x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$ there, $M_0$ carrying $P_0Cx$), so the requirement of the band (that $h_x$ be $O(1)$ rather than $O(n)$ on $V_+$) **is equivalent to $\lVert X_x\rVert_F^2\le\tfrac14\lVert Cx\rVert_F^2+O(1)$ there: the product $\sum x_{uv}uv$ must be almost entirely skew on $V_+$.** *This converts the Ricci requirement into a statement about products of the two extreme eigenspaces, which the rows constrain through $P_0[E_0,E_2]=E_0$ ($\mathop{\mathrm{rank}}P_0C=p$) but do not yet bound.* Identity typed; the reduction is algebra on it; no computation.
> 

## Givens (audited)

- [r1160](REVIEW_r1160.md): $\lvert\langle h,\mathring eh\rangle\rvert\le\tfrac n\kappa\lvert h\rvert^2$ on traceless symmetric $h$; $\langle h,\mathring eh\rangle=\tfrac a{2\theta}(C_0-C_2)(h)$.
- [r1146](REVIEW_r1146.md): the polarised Gram $G=\tfrac12I-H/(n-2)-\Omega\preceq\tfrac12I$ with $H,\Omega\succeq0$; $B_{\mathrm{lead}}=M_0-M_2$, $M_c=\tfrac a{4\theta}(P_cC)^{\mathsf T}(P_cC)$, $V_+$ its positive eigenspace.
- The margin of L247: $(\kappa-n+5)/(16\kappa)$ on $\lambda_{\max}(L_e)$, at most about $3/(16n)$ near $\theta_0$.
- $h_{uv}=-\tfrac12\{u,v\}$ is the Ricci part of the pair $u\odot v$; $C:x\mapsto\sum x_{uv}[u,v]$.

## Lean

| claim | declaration |
|---|---|
| skew and symmetric parts are orthogonal | `skew_sym_split` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean) |
| the Ricci size bound and the margin comparison | none: the pair matrix is not a layer object |

## Items

1. The quantitative paragraph: does $\lvert x^{\mathsf T}B_{\mathrm{Ric}}x\rvert\le\tfrac n{4\kappa}$ follow for unit $x$ (check $H\preceq\tfrac{n-2}2I$ from $G\succeq0$ and the units of $x$), and is the margin in the same units $(\kappa-n+5)/(32\kappa)$ (check the factor between $\lambda_{\max}(L_e)$ and $\lambda_{\max}(B)$)?
2. The product paragraph: is the skew part of $X_x$ exactly $\tfrac12Cx$ and the symmetric part exactly $-h_x$, with the norms in consistent conventions ($\lvert h\rvert_F$ against the record's $\lvert h\rvert$)?
3. Is "the requirement is equivalent to $\lVert X_x\rVert^2\le\tfrac14\lVert Cx\rVert^2+O(1)$ on $V_+$" right, and does "$Cx$ is large on $V_+$" follow from $x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$?
4. Is any conclusion stated beyond what these support?

## Protocol

Reviewer N (1164 or 1165) logs to `agent_logs/rN.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_rN.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any other file; do not read the other reviewer's report or log. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
