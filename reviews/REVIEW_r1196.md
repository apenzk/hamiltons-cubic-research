# REVIEW r1196: Gate 2 on the p = 15 paragraph at n = 12 (I73c per-vector rows)

Log: [agent_logs/r1196.log](../agent_logs/r1196.log). Claim: the "$p=15$ at $n=12$" paragraph of [the per-vector note](2026-09-25-I73c-per-vector-rows.md). Analysis-only footing; the screens below are seconds each, on objects constructed here, and are reported as screens.

| # | Item | Verdict |
|---|---|---|
| 1 | L249 threshold $2(7-\theta_0(12)\sqrt{30})\approx0.46$ | CONFIRMED |
| 2 | $\mathop{\mathrm{tr}}(\mathrm{ad}_x^4)=4\mathop{\mathrm{tr}}x^4+12$; variance bound needs $\mathop{\mathrm{tr}}x^4\le0.18<\tfrac13$ | CONFIRMED |
| 3 | separation at $\delta=0.46$, complex-structure branch dies, $1.47$ against $1.94$ | CONFIRMED (conditional on the screened ratio, as the claim says) |
| 4 | per-vector identity, $\kappa\le8+\langle x\wedge x,\Omega_0\rangle$, returns row (B) | CONFIRMED, with a framing repair |
| 5 | quantitative rigidity at radius $0.38$ would close $p=15$ | PLAUSIBLE; the sub-claim "star pieces of dimension 5 are infeasible under the cap" REFUTED (the cap forbids dimension $\ge6$) |

## 1. Threshold

$p=15$ gives $m=66-30=36$ and $\kappa=\theta\sqrt{30}$. L249 gives $\kappa\le7-\tfrac12\mu_{36}(x)$, so $\mu_{36}(x)\ge2(7-\theta_0\sqrt{30})$ gives $\theta\le\theta_0$ (strict for strict inequality). $\theta_0\sqrt{30}=\sqrt{220\cdot30/144}=6.7700$, threshold $0.45994$.

## 2. Fourth moment

With angles $s_i$ ($\sum s_i^2=1$), $-\mathrm{ad}_x^2$ has eigenvalues $(s_k\pm s_l)^2$ twice each for $k<l$ and six zeros. Then $\mathop{\mathrm{tr}}(\mathrm{ad}_x^4)=\sum_{k<l}4(s_k^4+6s_k^2s_l^2+s_l^4)=20q+12(1-q)=8q+12$ with $q=\sum s_i^4$, and $\mathop{\mathrm{tr}}x^4=2q$. Checked numerically at a random unit $x$ (agreement to $10^{-14}$). The top-$r$ bound at fixed trace $T=20$ and second moment $S$, $\kappa_r\le rT/N+\sqrt{r(N-r)(S-T^2/N)/N}$ at $N=66$, $r=30$, needs $\kappa_{30}\le19.54$, i.e. $S\le12.73$, i.e. $\mathop{\mathrm{tr}}x^4\le0.183$; $q\ge\tfrac16$ gives $\mathop{\mathrm{tr}}x^4\ge\tfrac13$. Scope: this is the Cauchy-Schwarz form of the second-moment bound, which is what the claim names.

## 3. L250's route at $\delta=0.46$

- $\mu_{34}\le\mu_{36}$ (fewer nonnegative terms), so the $\mu_{34}$ ratio applies with the right direction.
- The ratio screen covered only $\mu_{34}<0.2$; rerun here with the window widened to $\mu_{34}<0.46$ (3000 starts), the supremum is still $0.307$, so the $0.31$ stands as a screen over the range the argument uses.
- The screen measures distance to the CONES (decomposable: $1-s_1^2$; complex structure: $\sum(s_i-\bar s)^2$), and $1.08$ is the gap between the unit sets. The cone version is still disjoint at $d^2\le0.1426$: $s_1^2\ge0.857$ caps $\sum s_i\le1.85$, while $\bar s\ge0.378$ needs $\sum s_i\ge2.27$.
- Complex-structure branch: $6\bar s^2\ge0.857$ and a single deviation at most $\sqrt{0.1426\cdot5/6}=0.345$ give $s_{\min}\ge0.033>0$, so every such $x$ is invertible, and $x\mapsto xe_1$ on the 15-dimensional $E_0$ has a kernel. Dies, with thin margin.
- Decomposable branch: $s_1^2\ge1-0.1426$ gives $\mathop{\mathrm{tr}}x^4\ge2(0.857)^2=1.470$ ($1.477$ with the $T^2/5$ term). Cap: $\mathbb E\mathop{\mathrm{tr}}x^4\le3\mathop{\mathrm{tr}}A_0^2/(p(p+2))\le3\cdot5.5\cdot2p/(p(p+2))=33/17=1.941$. The branch fails to contradict, as claimed.

## 4. The identity

Summing the wedge Gram over an orthonormal basis of $E_0$ at unit $x\in E_0$: $2\sum\langle x,\psi\rangle^2=2$, $-\sum\mathop{\mathrm{tr}}(x^2\psi^2)=\mathop{\mathrm{tr}}(x^2A_0)=-\mathop{\mathrm{tr}}(-x^2A_0)$, $\tfrac12\sum\lVert[x,\psi]\rVert_F^2=2R_0(x)$. So $\langle x\wedge x,\Omega_0\rangle=2+2R_0-\mathop{\mathrm{tr}}(-x^2A_0)$. The 4-form norm is $\tfrac1{24}\sum_{abcd}$ in the `wedgeSelf` convention (from `wedge_gram`'s $12\mathop{\mathrm{tr}}(XY)^2-24\mathop{\mathrm{tr}}(XYXY)$). Screen: explicit 4-forms at three random 15-dimensional $E_0$, both sides agree to $10^{-15}$.

Consequence: $R_0=b_{00}+b_{01}+b_{02}$ and $K=2b_{02}-b_{00}-b_{22}\le2R_0$; $\mathop{\mathrm{tr}}(-x^2A_0)\le5.5\mathop{\mathrm{tr}}(-x^2)=11$. So $\kappa\le8+\langle x\wedge x,\Omega_0\rangle$. CONFIRMED.

Row (B): the same sum over $E_2$ gives $\langle x\wedge x,\Omega_2\rangle=2R_2-\mathop{\mathrm{tr}}(-x^2A_2)$; with $\Omega_0=\Omega_2$ and $A_0=A_2$ this is $R_2-R_0=1$, i.e. $b_{12}+b_{22}-b_{00}-b_{01}=1$. The $\Omega_1$ pairing summed with the others returns row (A) ($\sum_c\Omega_c=0$). CONFIRMED.

**Framing repair.** $\kappa\le8$ at near-decomposable $x$ is weaker than L244's $x$-free $\kappa\le n-5=7$ already on file, so "near-decomposable $x$ make the last term small" gives nothing. The bound beats the record only where $\langle x\wedge x,\Omega_0\rangle<-1$, and closes $p=15$ only at $\langle x\wedge x,\Omega_0\rangle<-1.23$ for some $x$. The "independent upper bound" the claim asks for is a NEGATIVE one, which the text should say.

## 5. Rigidity

- The star-piece cap is off by one. A star piece $e\wedge U$, $\dim U=k$, has $A_V=k\,ee^{\mathsf T}+P_U$, eigenvalue exactly $k$ on $e$. Under $A_0\preceq\tfrac{11}2I$ that forbids $k\ge6$ only. Screen: $e_1\wedge\langle e_2,\dots,e_6\rangle$ plus a random 10-dimensional completion inside $\mathfrak{so}(11)=\Lambda^2e_1^\perp$ gives $\lambda_{\max}(A_0)=5.0\le5.5$. The p15 screen's "star5+10: no feasible start" comes from its random completions in all of $\mathfrak{so}(12)$ adding mass on $e_1$. The claim should read "star pieces of dimension $\ge6$", and "dimension 5 already infeasible" should be withdrawn.
- The logic survives the correction. A 15-dimensional space near an exact linear space of decomposables is excluded by dimension alone: stars have dimension $\le11$, $\Lambda^2\mathbb R^3$ has dimension $3$. The cap enters only if rigidity is stated for pieces.
- The rigidity statement is unproved and radius $0.38$ is large on the unit sphere, so this item is a correct account of what would close it, with no evidence yet that the rigidity holds at that radius beyond the $\mu_{36}$ screen's $3.17$.
