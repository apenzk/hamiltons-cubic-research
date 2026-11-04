# Review r1150: the class-trace form of the leading pair test

Brief: [2026-09-25-class-trace-gate2-brief.md](2026-09-25-class-trace-gate2-brief.md). Claim at 76fbc0ed in [the working file](2026-09-25-I73c-per-vector-rows.md). Method: argued from the definitions and re-derived by hand. A sympy screen of my own (seconds, on the nine rows written below) agrees with every hand step. Analysis-only rule observed: no sweep.

## Verdicts

| item | verdict |
|---|---|
| 1. total symmetry of $t_{abc}$ | CONFIRMED |
| 2. nine rows, rank 7, solved form | CONFIRMED |
| 3. "exceeds $\tfrac12$ exactly when $D<0$" | PLAUSIBLE, wording corrected: the equivalence is between the certificate's test and $D<0$, and "mirror" is wrong |
| 4. "the linear rows allow both signs" | CONFIRMED, with a sharper necessary condition for $D\ge0$ that the claim did not state |

## Item 1

With $B_{bc}=\tfrac12\sum_{\gamma\in E_b,\delta\in E_c}[\psi_\gamma,\psi_\delta]\otimes[\psi_\gamma,\psi_\delta]$, $t_{abc}=\mathop{\mathrm{tr}}(P_aB_{bc})=\tfrac12\sum_{\varepsilon\in E_a,\gamma\in E_b,\delta\in E_c}\langle[\psi_\gamma,\psi_\delta],\psi_\varepsilon\rangle^2$. Ad-invariance makes $\langle[X,Y],Z\rangle$ totally antisymmetric, so its square is totally symmetric, and the triple sum over orthonormal bases of $E_a,E_b,E_c$ is symmetric in $(a,b,c)$. The factor $\tfrac12$ is common to every $B_{bc}$, including $b=c$, so the normalisation plays no role. Consistency check on the normalisation: $\sum_{a,b}B_{ab}=\mathrm{Id}\#\mathrm{Id}$ gives $\langle(\mathrm{Id}\#\mathrm{Id})x,x\rangle=\tfrac12\mathop{\mathrm{tr}}(-\mathrm{ad}_x^2)=n-2$ at unit $x$ under $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, matching row (A).

## Item 2

Write $s=\theta\sqrt{2p}$ and $\lambda=a(-1,0,1)$. Since $B_{ab}=B_{ba}$, row (B) at unit $x\in E_c$ is $a(b_{22}+b_{12}-b_{00}-b_{01})=-\lambda_c$ and row (C) is $a^2(b_{00}+b_{22}-2b_{02})=\lambda_c(\theta-\lambda_c)$. At $E_0$ these are $b_{22}-b_{00}-1=b_{01}-b_{12}$ (as the claim writes) and $2b_{02}=b_{00}+b_{22}+s+1$. Traced over a basis of $E_c$ ($\dim p,m,p$):

- (B0) $t_{022}+t_{012}-t_{000}-t_{001}=p$, (B1) $t_{122}+t_{112}-t_{001}-t_{011}=0$, (B2) $t_{222}+t_{122}-t_{002}-t_{012}=-p$.
- (C0) $t_{000}+t_{022}-2t_{002}=-p(s+1)$, (C1) $t_{001}+t_{122}-2t_{012}=0$, (C2) $t_{002}+t_{222}-2t_{022}=p(s-1)$.
- (A0) $t_{000}+t_{011}+t_{022}+2(t_{001}+t_{002}+t_{012})=(n-2)p$, (A1) $t_{001}+t_{111}+t_{122}+2(t_{011}+t_{012}+t_{112})=(n-2)m$, (A2) $t_{002}+t_{112}+t_{222}+2(t_{012}+t_{022}+t_{122})=(n-2)p$.

**Solved form.** (B2) is $t_{012}=2D+t_{122}$ with $2D=t_{222}-t_{002}+p$. (C1) then gives $t_{001}=2t_{012}-t_{122}=4D+t_{122}$. (B1) gives $t_{112}-t_{011}=t_{001}-t_{122}=4D$. All three match the claim, and they use only (B1), (B2), (C1). Further, (B0) gives $t_{000}=t_{022}-2D-p$ and (C2) gives $t_{002}=2t_{022}-t_{222}+p(s-1)$, so $D=t_{222}-t_{022}-\tfrac p2(s-2)$ in the free variables.

**Rank 7.** (C1), (B2), (B1), (B0), (C2) take new pivots $t_{001},t_{012},t_{011},t_{000},t_{002}$, (A1) is the only row containing $t_{111}$, and (A0) is the only remaining row fixing $t_{011}$ once $t_{112}-t_{011}$ is set. That is seven independent rows. The two dependencies are structural, from total symmetry: $\sum_c\lambda_c(\mathrm A_c)=\sum_c(\mathrm B_c)$ and $\sum_c\lambda_c(\mathrm B_c)=\sum_c(\mathrm C_c)$ hold as linear forms, and their right sides agree because $\mathop{\mathrm{tr}}W=0$. By hand, (C0) reduces to $0=0$ after substituting (B0), (B2), (C2). Ten unknowns less seven leaves three free, $t_{022},t_{122},t_{222}$, as claimed.

## Item 3

Traced (B0) is $t_{022}-t_{000}-p=t_{001}-t_{012}$, and the solved form gives $t_{001}-t_{012}=2D$. The certificate's test $\mathop{\mathrm{tr}}(P_0B_{22})<\mathop{\mathrm{tr}}(P_0B_{00})+p$, i.e. $t_{022}<t_{000}+p$, is therefore exactly $D<0$, i.e. $t_{002}>t_{222}+p$, i.e. $\mathop{\mathrm{tr}}(P_2B_{00})>\mathop{\mathrm{tr}}(P_2B_{22})+p$. I re-checked the input $4T=p+s^{-1}\sum_u(b_{00}-b_{22}+1)$ from row (C) and $as/\theta=1$, so $4T>p\iff D<0$ with strict inequalities matching.

**What "exactly" can mean.** The certificate is $\lambda_{\max}(B_{\mathrm{lead}})\ge T/p$, a sufficient bound. So the equivalence holds between "the certificate proves the bracket part exceeds $\tfrac12$" (that is, $4T>p$) and $D<0$. At $D\ge0$ the bracket part may still exceed $\tfrac12$ when the positive eigenvalues of $B_{\mathrm{lead}}$ are unequal. The bolded sentence "the bracket part of the pair operator exceeds $\tfrac12$ exactly when $D<0$", and the heading's "binds iff", overclaim. **Correction**: "the certificate shows the bracket part exceeds $\tfrac12$ exactly when $D<0$" (equivalently, the bracket part exceeds $\tfrac12$ whenever $D<0$).

**"The mirror on $E_2$ of the $E_0$ condition" is wrong.** Swapping the labels $0\leftrightarrow2$ in the $E_0$ condition $t_{022}<t_{000}+p$ gives $t_{002}<t_{222}+p$, which is $D>0$. The condition found is $t_{002}>t_{222}+p$, the negation of the mirror. **Correction**: "an equivalent condition read on $E_2$", or drop the phrase.

## Item 4

**Nonnegativity of all ten traces forces no sign.** Beyond $t_{001}\ge0$ (giving $D\ge-t_{122}/4$) and $t_{012}\ge0$ (weaker, $D\ge-t_{122}/2$), the claim omits $t_{000}\ge0$, which gives the upper bound $2D\le t_{022}-p$. Explicit nonnegative solutions of all nine rows at $p=12$, $s=6$, $n=14$, $m=67$:

| | $t_{000}$ | $t_{001}$ | $t_{002}$ | $t_{011}$ | $t_{012}$ | $t_{022}$ | $t_{111}$ | $t_{112}$ | $t_{122}$ | $t_{222}$ | $D$ |
|---|---|---|---|---|---|---|---|---|---|---|---|
| $D<0$ | 2 | 4 | 49 | 12 | 6 | 12 | 740 | 8 | 8 | 35 | $-1$ |
| $D>0$ | 0 | 4 | 49 | 20 | 2 | 14 | 708 | 24 | 0 | 39 | $1$ |

(Found by hand from the solved form, then checked against the nine rows by the screen.) Both also meet the trace-level relaxation of the caps, $\sum_{x\in E_c}R_a(x)\le\tfrac12\sum_x\kappa_{m_a}(x)\le m_c\min(m_a,n-2)$, using $\kappa_r(x)\le2r$ for unit $x$ (the top eigenvalue of $-\mathrm{ad}_x^2$ is $(\mu_1+\mu_2)^2\le2$). For example the largest $E_2$ sum at the $D>0$ point is $t_{002}+t_{012}+t_{022}=65\le144$. So "the linear rows allow both signs" is right, and it stays right after adding every nonnegativity and the traced caps. Whether the per-vector caps, with $\kappa$ depending on $x$, exclude $D\ge0$ is not settled by anything in the givens: I agree it is the open question. The argument in the claim ("$t_{001}\ge0$ gives only $D\ge-t_{122}/4$") shows no sign is forced by that row alone, and the table above completes it.

**A necessary condition for $D\ge0$ that the claim did not state.** From $t_{000}\ge0$ and $D=t_{222}-t_{022}-\tfrac p2(s-2)$: $D\ge0$ requires $t_{022}\ge p$ and $t_{222}\ge t_{022}+\tfrac p2(s-2)\ge\tfrac{ps}2$, i.e. **the average $E_2$ self-mass $b_{22}(y)$ over $y\in E_2$ is at least $\theta\sqrt{p/2}$** (about $3$ at $p=12$, $\theta_0$). Also at $m=0$ every $t_{1bc}$ vanishes and $D=0$ is forced. This turns the owed analytic question into a single upper bound: any cap giving $\mathop{\mathrm{tr}}(P_2B_{22})<p\,\theta\sqrt{p/2}$ forces $D<0$, so the test binds. The crude cap $b_{22}(y)\le\tfrac12\kappa_{p-1}(y)\le p-1$ does not reach it (at $p=12$ it allows $11$ against about $3$).
