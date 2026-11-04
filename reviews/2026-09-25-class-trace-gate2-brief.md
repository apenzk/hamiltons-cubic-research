# Gate 2 brief: the class-trace form of the leading pair test (r1149, r1150)

**Two reviewers, independently: the round checks an argument.** Analysis-only: argue from the definitions; seconds of computation on objects you construct are allowed only as a screen. Model: opus.

## The claim, verbatim from [the working file](2026-09-25-I73c-per-vector-rows.md) at 76fbc0ed

> **The leading-order test, in the class traces: it binds iff $\mathop{\mathrm{tr}}(P_2B_{00})>\mathop{\mathrm{tr}}(P_2B_{22})+p$, and the linear class rows leave that open.** Write $t_{abc}=\mathop{\mathrm{tr}}(P_aB_{bc})$, totally symmetric by ad-invariance. Row (B) at $x\in E_0$ reads $b_{22}-b_{00}-1=b_{01}-b_{12}$, so the test $\mathop{\mathrm{tr}}(P_0B_{22})<\mathop{\mathrm{tr}}(P_0B_{00})+p$ is $t_{001}<t_{012}$. The nine class rows ((A), (B), (C) traced over $E_0,E_1,E_2$) have rank $7$, and solving them in terms of $t_{022},t_{122},t_{222}$ gives, with $D:=\tfrac12\big(t_{222}-t_{002}+p\big)$,
> $$t_{001}=4D+t_{122},\qquad t_{012}=2D+t_{122},\qquad t_{011}-t_{112}=-4D,$$
> **so the bracket part of the pair operator exceeds $\tfrac12$ exactly when $D<0$, i.e. $\mathop{\mathrm{tr}}(P_2B_{00})>\mathop{\mathrm{tr}}(P_2B_{22})+p$**, the mirror on $E_2$ of the $E_0$ condition. Nonnegativity of $t_{001}$ gives only $D\ge-t_{122}/4$, so the linear rows allow both signs. *Whether the per-vector caps ($\sum_bb_{ab}(x)\le\tfrac12\kappa_{m_a}(x)$) exclude $D\ge0$ is a linear programme at each $(n,p)$: a sweep over the bulk, which waits for approval under the analysis-only rule, and the analytic question is whether $t_{222}+p\le t_{002}$ follows from the caps by hand.* Hand reduction; the rank and the solved form screened in seconds with sympy on the nine rows.

## Givens (quoted; treat as established)

> $Q(\mathcal W_n)\subseteq\mathcal W_n$ ([L234](../findings/second-order.md), step (1)), so at a critical point $W^\#=\theta W-W^2$ holds as an **operator** identity on $\Lambda^2\mathbb R^n$. With $W=\sum_a\lambda_aP_a$ and $B_{ab}=P_a\#P_b\succeq0$ (a sum of $\tfrac12[\psi_\gamma,\psi_\delta]\otimes[\psi_\gamma,\psi_\delta]$ over $\gamma\in E_a$, $\delta\in E_b$):
> $$\sum_{a,b}B_{ab}=(n-2)\,\mathrm{Id},\qquad\sum_{a,b}\lambda_bB_{ab}=-W,\qquad\sum_{a,b}\lambda_a\lambda_bB_{ab}=\sum_a\lambda_a(\theta-\lambda_a)P_a .$$
> **Every right side is scalar on each eigenspace $E_c$.** The class system uses the traces of these identities against $P_c$, the per-index rows averaged over a basis; the identities themselves say that for EVERY unit $x\in E_c$ the numbers $b_{ab}(x)=\langle B_{ab}x,x\rangle\ge0$ satisfy the three rows with $E_c$'s right sides, and $\sum_bb_{ab}(x)\le\tfrac12\kappa_{m_a}(x)$ with $\kappa_r(x)$ the sum of the top $r$ eigenvalues of $-\mathrm{ad}_x^2$, **which depends on $x$**.
> 


- Symmetric family: $\lambda=(-a,0,a)$ on $E_0,E_1,E_2$, $\dim E_0=\dim E_2=p$, $\dim E_1=m$, $a=1/\sqrt{2p}$. $b_{ab}(x)=\langle B_{ab}x,x\rangle$. The rows (A), (B), (C) are the three displayed identities evaluated at unit $x\in E_c$, with right sides $n-2$, $-\lambda_c$, $\lambda_c(\theta-\lambda_c)$.
- Inner product $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on $\Lambda^2=\mathfrak{so}(n)$.

## Lean

| claim | declaration |
|---|---|
| total symmetry of $t_{abc}$ | none: the layer has no declaration for $B_{ab}=P_a\#P_b$ on eigenspace projections |
| the nine traced rows have rank 7 and the solved form | none, same reason; a linear system in ten unknowns that a reviewer can re-solve by hand |
| the test is $D<0$ | none, same reason |

## Items

1. Is $t_{abc}$ totally symmetric (check the normalisation of $B_{ab}$ as a sum over $\gamma\in E_a,\delta\in E_b$)?
2. Are the nine traced rows written correctly, is the rank 7, and is the solved form ($t_{001}=4D+t_{122}$, $t_{012}=2D+t_{122}$, $t_{011}-t_{112}=-4D$, $D=\tfrac12(t_{222}-t_{002}+p)$) right? Re-derive by hand, not by rerunning anyone's script.
3. Does "the bracket part of the pair operator exceeds $\tfrac12$ exactly when $D<0$" follow from the certificate given (note the certificate is sufficient: say what "exactly" can and cannot mean here)?
4. Is "the linear rows allow both signs" right, and is any sign of $D$ forced by facts in the givens that the claim did not use (for example nonnegativity of every $t_{abc}$, or $\sum_bb_{ab}(x)\le\tfrac12\kappa_{m_a}(x)$)?

## Protocol

Reviewer N (1149 or 1150, as your dispatch names) logs to `agent_logs/rN.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with the word DONE or FAILED. Commit a skeleton `reviews/REVIEW_rN.md` first and update it, committing only that file by path (`git commit -- reviews/REVIEW_rN.md`). Do NOT edit `reviews/INDEX.md` or any other file, and do not read the other reviewer's report or log. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
