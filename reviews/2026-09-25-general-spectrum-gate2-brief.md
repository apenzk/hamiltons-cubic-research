# Gate 2 brief: L247's certificate at general three-value spectra (r1170, r1171)

**Two reviewers, independently: the round checks an argument.** Analysis-only: argue from the definitions; seconds of exact symbolic computation on the stated linear system are allowed as a screen. Model: opus.

## The claim, verbatim from [the working file](2026-09-25-I73c-per-vector-rows.md) at 58225eb7

> **L247 extends to general three-value spectra with $\lambda_1\ge0$.** For eigenvalues $\lambda_0<\lambda_1<\lambda_2$ ($\lambda_0<0<\lambda_2$) of multiplicities $p_0,m,p_2$, the bracket term of the pair matrix is $-\tfrac1{4\theta}\sum_c\lambda_c(P_cC)^{\mathsf T}(P_cC)$, whose positive part comes from the classes with $\lambda_c<0$; **when $\lambda_1\ge0$ that is $E_0$ alone**, so the certificate $\lambda_{\max}\ge T/\mathop{\mathrm{rank}}P_0C$ holds with $T=-\tfrac1{2\theta}\sum_c\lambda_ct_{02c}$, and $\mathop{\mathrm{rank}}P_0C=p_0$ as before when the rows keep $b_{20}>0$ on $E_0$. The nine traced rows with $\mathop{\mathrm{tr}}W=0$ give
> $$\theta(\lambda_0-\lambda_1)(4T-p_0)=\mathrm{const}+c_{000}t_{000}+c_{011}t_{011}+c_{122}t_{122},$$
> typed as `general_identity` in [ClassTraceGeneral.lean](../lean/HamiltonsCubic/Results/ClassTraceGeneral.lean) (denominators cleared; coefficients by exact linear algebra, identity checked by the kernel), with
> $$c_{000}=-\frac{(\lambda_0-\lambda_1)^2(2\lambda_0\lambda_1-\lambda_0\lambda_2-\lambda_1\lambda_2)}{2(\lambda_1-\lambda_2)^2},\quad c_{011}=\frac{(\lambda_0-\lambda_1)^2(\lambda_0(2\lambda_1+\lambda_2)-3\lambda_1\lambda_2)}{2(\lambda_0-\lambda_2)^2},\quad c_{122}=\frac{\lambda_2(\lambda_0-\lambda_1)(\lambda_1-\lambda_2)}{\lambda_0-\lambda_2}.$$
> **Signs**: $c_{122}<0$ always; $c_{011}<0$ whenever $\lambda_1\ge0$; $c_{000}\le0$ iff $\lambda_0(2\lambda_1-\lambda_2)\ge\lambda_1\lambda_2$, which holds at $\lambda_1=0$. Since $\theta(\lambda_0-\lambda_1)<0$, **on $\lambda_1\ge0$, $\lambda_0(2\lambda_1-\lambda_2)\ge\lambda_1\lambda_2$ the certificate fires ($4T>p_0$) wherever $\mathrm{const}<0$**, by nonnegativity of the traces alone. At $\lambda=(-a,0,a)$ the constant is $\tfrac a8p_0(an-5a-\theta)$ and the identity is r1149's. *The region $\mathrm{const}<0$ is an explicit polynomial condition in $(\lambda,\theta,n,p_0,m)$ (in the file); its shape, and the corrections, are owed, as for L247.* Screened by sympy (the rank, the solved form, the multipliers), proved in Lean.
> 

## Givens (audited)

- [L247](../findings/second-order.md) and its Gate 2 ([r1146](REVIEW_r1146.md), [r1147](REVIEW_r1147.md), [r1149](REVIEW_r1149.md), [r1150](REVIEW_r1150.md)): the pair matrix's bracket part $B_{\mathrm{lead}}=-\tfrac14C^{\mathsf T}eC$, $e=W/\theta$; the rank certificate; $G\preceq\tfrac12I$; the traced rows (A), (B), (C) with right sides $(n-2)d_c$, $-\lambda_cd_c$, $\lambda_c(\theta-\lambda_c)d_c$.
- `rank P_0C = p` was shown on the symmetric family from L244's floor $b_{20}>0$; the claim asserts it carries over "when the rows keep $b_{20}>0$ on $E_0$".

## Lean

| claim | declaration |
|---|---|
| the identity with the stated coefficients, from the nine rows and $\mathop{\mathrm{tr}}W=0$ | `general_identity` in [ClassTraceGeneral.lean](../lean/HamiltonsCubic/Results/ClassTraceGeneral.lean) |
| the sign analysis of $c_{000},c_{011},c_{122}$ and the conclusion $4T>p_0$ where $\mathrm{const}<0$ | none: scalar sign facts, not typed |
| the positive part of $B_{\mathrm{lead}}$ from $E_0$ alone when $\lambda_1\ge0$ | none |

## Items

1. Is the bracket term right at a general spectrum, and does its positive part come from $E_0$ alone exactly when $\lambda_1\ge0$? Is $T=-\tfrac1{2\theta}\sum_c\lambda_ct_{02c}$ its trace?
2. Does `general_identity` state the claimed identity (check that its left side is $\mathrm{Den}\cdot\theta(\lambda_0-\lambda_1)(4T-p_0)$ via $\theta\cdot4T=-2\sum_c\lambda_ct_{02c}$, and that its hypotheses are exactly the traced rows and $\mathop{\mathrm{tr}}W=0$)? Do the displayed $c$'s match the Lean coefficients after dividing by Den?
3. The signs: $c_{122}<0$ always, $c_{011}<0$ for $\lambda_1\ge0$, $c_{000}\le0$ iff $\lambda_0(2\lambda_1-\lambda_2)\ge\lambda_1\lambda_2$. Does "the certificate fires wherever const $<0$" follow, including the direction of the inequality (the factor $\theta(\lambda_0-\lambda_1)<0$)?
4. Is the carry-over of $\mathop{\mathrm{rank}}P_0C=p_0$ justified at a general spectrum (does L244's floor $b_{20}>0$ exist off the symmetric family)? Is anything stated beyond support?

## Protocol

Reviewer N (1170 or 1171) logs to `agent_logs/rN.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_rN.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any other file; do not read the other reviewer's report or log. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
