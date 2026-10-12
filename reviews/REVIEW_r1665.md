# REVIEW r1665: L275, J1 on the face P = Q

Log: [agent_logs/r1665.log](../agent_logs/r1665.log). Brief: Gate 2, cold, analysis only. Every step was checked by hand from the definitions. A seconds-long screen and a Lean compile were run as screens only.

**Overall: CONFIRMED WITH MINOR GAPS.** No step is refuted. The gaps are unstated routine justifications, listed below.

| claim | verdict |
|---|---|
| Statement | CONFIRMED |
| Step (1) | CONFIRMED |
| Step (2) | CONFIRMED |
| Step (3) | CONFIRMED WITH GAPS (G2) |
| Step (4) | CONFIRMED WITH GAPS (G1, G3) |
| Step (5) | CONFIRMED WITH GAPS (G4) |
| Step (6) | CONFIRMED |
| Range m >= 4 | CONFIRMED WITH GAPS (G5) |
| Translation to J1 / What it gives | CONFIRMED |
| Lean statement L275_bound | CONFIRMED |

## Link by link

- **(1)** $(U^2)_{ij}=\sum_{k\ne i,j}U_{ik}U_{kj}$ (zero diagonal), and Cauchy–Schwarz over $k$ gives $\lvert(U^2)_{ij}\rvert\le\sqrt{e_{ij}e_{ji}}$ since $\sum_{k\ne i,j}x_{kj}=D_j-x_{ij}=e_{ji}$. Then $\operatorname{tr}U^3=\sum_{i\ne j}U_{ij}(U^2)_{ij}\le\sum_{i\ne j}\sqrt{x_{ij}e_{ij}e_{ji}}$.
- **(2)** $R_{ij}-e_{ij}e_{ji}=x_{ij}\big((D_i-x_{ij})+(D_j-x_{ij})\big)\ge0$, and $R_{ij}\ge0$ since $D_i,D_j\ge x_{ij}$. At $R_{ij}=0$, $0\le e_{ij}e_{ji}\le R_{ij}=0$ kills the term, and adding the remaining $R_{ij}\ge0$ to $\sum R$ only enlarges it. Correct.
- **(3)** $R_{ij}>0$ forces $D_i,D_j>0$, and then $ee'=D_iD_j(1-p)(1-q)$, $R=D_iD_j(1-pq)$ with $q=x_{ij}/D_j=p_{ji}$. The identity $2ab/(a+b)=2(1-p)(1-q)/\big((1-p)(1+q)+(1-q)(1+p)\big)=2(1-p)(1-q)/(2-2pq)=f$ holds ($a+b>0$ because $R>0$ excludes $p=q=1$). HM $\le$ AM and $(1-p)/(1+p)\le1-p$ give $f\le1-\tfrac12(p+q)$. The Lean `L275_pair` proves the denominator-free form, difference $p(1-q)^2+q(1-p)^2$ (checked by expansion). Symmetrisation: $\sum_{i\ne j}x_{ij}\big(1-\tfrac12p_{ij}-\tfrac12p_{ji}\big)=S-\sum_{i,j}x_{ij}p_{ij}=S-\sum_iD_i\rho_i=S\sum_i\pi_i(1-\rho_i)$.
- **(4)** $\sum_{i\ne j}R_{ij}=S^2-\sum_iD_i^2-\sum_{i,j}x_{ij}^2$ and $\sum_{i,j}x_{ij}^2=\sum_iD_i^2\rho_i$, so $\sum R/S=S(1-s-\sum\pi_i^2\rho_i)$ and the claimed inequality rearranges exactly to $\sum_i\pi_i(1-\kappa\pi_i)\rho_i\ge1-\kappa+\kappa s$. At $S=1$, $\pi_i\rho_i=\sum_jx_{ij}^2/D_i$ and $\pi_i^2\rho_i=\sum_jx_{ij}^2$, giving the column form. $\pi_i\le\tfrac12$ from $S\ge2D_i$, and $\kappa<2$, so $1/\pi_i-\kappa\ge2-\kappa>0$. Cauchy–Schwarz for fixed $j$ over $i$ with $x_{ij}>0$: $\sum_ix_{ij}^2w_i\ge D_j^2/\sum_i w_i^{-1}$ with $w_i^{-1}=\beta_i$, and the restricted sum of $\beta_i\ge0$ is at most $B-\beta_j$. Correct.
- **(5)** Trivial case: $1-\kappa+\kappa s\le0\iff s\le1-1/\kappa$. Chord of $1/(1-\kappa t)$ on $[0,\tfrac12]$: endpoints $1$ and $2/(2-\kappa)$, slope $2\kappa/(2-\kappa)=\gamma$, so $\beta_i\le\pi_i(1+\gamma\pi_i)$ and $B-\beta_j\le c_j:=1-\pi_j+\gamma(s-\pi_j^2)$. Titu with numerators $\pi_j^4$: $\sum\pi_j^2/c_j\ge s^2/\sum_j\pi_j^2c_j$, and $\sum_j\pi_j^2c_j=s-\sum\pi^3+\gamma(s^2-\sum\pi^4)\le s(1-s)(1+\gamma s)$ using $\sum\pi^3\ge s^2$, $\sum\pi^4\ge s^3$ (Jensen under the law $\pi$: $\mathbb E_\pi[\pi^2]\ge s^2$, $\mathbb E_\pi[\pi^3]\ge s^3$), both entering with a minus sign, $\gamma>0$: right direction. With $1+\gamma s=(2-\kappa+2\kappa s)/(2-\kappa)$ the target is $s(2-\kappa)\ge(\kappa s+1-\kappa)(1-s)(2-\kappa+2\kappa s)$, whose difference is $(1-2s)\big[(\kappa-1)-(\kappa(1-s)-1)^2\big]$ (proved by `ring` in `L275_close`). Signs: $s\le\max\pi_i\le\tfrac12$, $\kappa(1-s)\le1$ from the non-trivial case, $\kappa(1-s)\ge\kappa/2$ from $s\le\tfrac12$, so $(\kappa(1-s)-1)^2\le(1-\kappa/2)^2$ and the bracket is $\ge-\tfrac14(\kappa^2-8\kappa+8)>0$ for $\kappa\in(4-2\sqrt2,2)$. Correct.
- **(6)** $\sum x\,ee'/R\le S\sum\pi(1-\rho)\le\kappa\sum R/S$, then (2) gives $\operatorname{tr}U^3\le\sqrt\kappa\,\sum R/\sqrt S=\lambda_m\sum R/\sqrt S$. Correct for $S>0$, and at $U=0$ both sides vanish.
- **Range.** $\kappa=\lambda_m^2=2m(m-2)^2/(m-1)^3=2K_m^2$. $\kappa<2$ for every $m$ since $(m-1)^3-m(m-2)^2=m^2-m-1>0$. $\kappa$ increases in $m$ (log-derivative $(m+2)/\big(m(m-1)(m-2)\big)>0$), and $\kappa_4=32/27\approx1.18519>4-2\sqrt2\approx1.17157$. At $m=3$, $\kappa=3/4$ and step (5) fails, so $m\ge4$ is where the bound (5) needs it.
- **Translation.** With $V=0$: $P=Q=U$, $d_i=\sum_l U_{il}^2=D_i$, $b^2=\lVert U\rVert^2=S$, $T=\operatorname{tr}U^3$, $(A_\mu)_{ii}=d_i$, $(A_\mu)_{ij}=-P_{ij}Q_{ij}=-x_{ij}$, so $g^2=\sum D_i^2+\sum_{i\ne j}x_{ij}^2$ and $\lambda_m(1-g^2)=\lambda_m\sum_{i\ne j}R_{ij}$ at $S=1$: L275 at $S=1$ is J1. The face is scale-invariant, so L273 (3) applies to every torus-invariant $X$ with $V=0$ for $m\ge5$. The $\Lambda^2_+$ edge with $P_{12}=Q_{12}$ has $V=0$. At a single edge both sides are $0$ ($\operatorname{tr}U^3=0$, $R_{12}=R_{21}=0$), i.e. $T=0$, $g^2=1$ at $S=1$: equality, as stated. (The statement does not claim that equality occurs only there, and the screen found none elsewhere.)
- **Lean.** `L275_bound` states $\operatorname{tr}(UUU)\sqrt{\sum U_{ij}^2}\le\frac{\sqrt{2m}(m-2)}{(m-1)\sqrt{m-1}}\big(S^2-\sum_iD_i^2-\sum_{i,j}U_{ij}^4\big)$ under $U^{\mathsf T}=U$, zero diagonal, $4\le m$. Since $\sum_{i\ne j}D_iD_j=S^2-\sum D_i^2$ and zero diagonal makes $\sum_{i\ne j}x_{ij}^2=\sum_{i,j}U_{ij}^4$, this is the block's statement with the block's constant. `lake env lean HamiltonsCubic/Results/L275.lean` exits 0 with the single warning "declaration uses sorry" at line 47 (`L275_bound`), and `L275_pair` and `L275_close` compile.

## Gaps (all minor, none affects truth)

- **G1.** Step (4) passes to $S=1$ without saying why: $\pi$, $\rho$, $s$ are invariant under $x\mapsto cx$, so the inequality in $\pi,\rho$ is scale-free. One clause.
- **G2.** Step (3) sums the bound over pairs with $R_{ij}>0$ and then writes the sum over all pairs, which needs $x_{ij}(1-\tfrac12p_{ij}-\tfrac12p_{ji})\ge0$ on the dropped pairs (true, $p\le1$). Also $a+b>0$ (from $R>0$) for the harmonic-mean form.
- **G3.** Step (4)'s Cauchy–Schwarz needs $B-\beta_j>0$ when $\pi_j>0$ (some $i\ne j$ has $x_{ij}>0$, so $\beta_i>0$) and drops the terms with $\pi_j=0$, both unstated.
- **G4.** Step (5)'s "Titu's form" leaves the numerators implicit: it is Titu with numerators $\pi_j^4$ over denominators $\pi_j^2c_j$, and $\sum\pi^3\ge s^2$, $\sum\pi^4\ge s^3$ are Jensen under the law $\pi$, and neither is justified in the text.
- **G5.** The proof asserts $\kappa<2$ and $\kappa>4-2\sqrt2$ for all $m\ge4$ without the one-line checks: $(m-1)^3-m(m-2)^2=m^2-m-1>0$, and $\kappa$ increasing with $\kappa_4=32/27$. The margin at $m=4$ is thin ($1.1852$ against $1.1716$), which is worth a sentence since $m=4$ is the case the range is chosen for.

## Screens (not evidence)

- 20000 random zero-diagonal symmetric $U$, $m=4$ to $8$, dense, sparse, and with one dominant edge: each of steps (1), (3), (4), (5) and the final inequality holds, maximum defect $0$ (single-edge cases), step (1) to $5\cdot10^{-13}$ relative rounding.
