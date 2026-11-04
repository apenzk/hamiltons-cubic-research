# REVIEW r1900: g2 torus family has trace at least 2

Log: [agent_logs/r1900-g2-trace.log](../agent_logs/r1900-g2-trace.log). Section under review: "H asks nothing more of g2's torus family" in [2026-09-28l-I117-g2-torus.md](2026-09-28l-I117-g2-torus.md). Analysis only, one scratch Lean compile.

| # | claim | verdict |
|---|---|---|
| 1 | the short rows | CONFIRMED |
| 2 | the trace formula | CONFIRMED |
| 3 | the proof chain | CONFIRMED |
| 4 | the conclusion 4/5 and what it settles | CONFIRMED, one wording correction |
| 5 | the sp(k) bullet | CONFIRMED, with the explicit G supplied below |
| 6 | the Lean | CONFIRMED, two scope notes |

## 1. The short rows (CONFIRMED)

Concrete roots, $s^2=\tfrac23$: short $S_0=s(1,0)$, $S_1=s(\tfrac12,\tfrac{\sqrt3}2)$, $S_2=s(-\tfrac12,\tfrac{\sqrt3}2)$, long $L_0=s(0,\sqrt3)$, $L_1=s(-\tfrac32,\tfrac{\sqrt3}2)$, $L_2=s(\tfrac32,\tfrac{\sqrt3}2)$, so $\lvert L\rvert^2=3s^2=2$ and $L_i\perp S_i$.

- Pairs onto $S_0$: $S_0=L_2-S_1$, $S_0=S_2-L_1$, $S_0=S_1-S_2$. Long plus long lands on a long root, $L_0\pm S_0$ is no root. Coefficients $\tfrac12,\tfrac12,\tfrac23$, doubled: $x_2y_1+x_1y_2+\tfrac43y_1y_2$.
- Onto $S_1$: $L_2-S_0$, $L_0-S_2$, giving $x_2y_0+x_0y_2$. Onto $S_2$: $L_0-S_1$, $L_1+S_0$, giving $x_0y_1+x_1y_0$. Each is $x_ky_j+x_jy_k$ with $\{j,k\}$ the other two indices, the long partner of $S_j$ being $L_k$.
- $(\alpha\cdot S_0)^2$: $L_1,L_2$ give $(s^2\cdot\tfrac32)^2=1$, $L_0$ gives $0$, $S_0$ gives $s^4=\tfrac49$, $S_1,S_2$ give $(s^2/2)^2=\tfrac19$. So $\sigma_i$ is as written.
- Screen: $I/4$ satisfies the row ($\sigma=\tfrac16$, both sides $\tfrac5{24}$).

## 2. The trace formula (CONFIRMED)

$\mathop{\mathrm{tr}}P_\alpha=2$ and $\mathop{\mathrm{tr}}(\alpha\alpha^{\mathsf T})=\lvert\alpha\rvert^2$, so $\mathop{\mathrm{tr}}C=\sum_\alpha(2w_\alpha+\lvert\alpha\rvert^2w_\alpha^2)$: $2x+2x^2$ per long weight, $2y+\tfrac23y^2$ per short.

## 3. The proof chain (CONFIRMED)

- Largest-weight step: $x_ky_j\le x_ky_i$, $x_jy_k\le x_jy_i$ (needs $x\ge0$), and $2y_jy_k\le y_i(y_j+y_k)$ from $y_jy_k\le y_iy_k$ and $y_jy_k\le y_jy_i$. So the right side is at most $y_i\big(x_j+x_k+\tfrac23(y_j+y_k)\big)$.
- Division by $y_i>0$ gives $1-\sigma_i\le x_j+x_k+\tfrac23(y_j+y_k)$, which is $G_i\ge1$.
- Comparisons: $2x+2x^2=2(x+x^2)$ exactly; $2y+\tfrac23y^2-2(\tfrac23y+\tfrac19y^2)=\tfrac23y+\tfrac49y^2\ge0$; $2y_i+\tfrac23y_i^2-\tfrac89y_i^2=2y_i(1-\tfrac19y_i)\ge0$ iff $y_i\le9$.
- $y_i\le9$: the right side is positive (all short weights positive), so $1-\sigma_i>0$ and $\tfrac49y_i^2<1$, $y_i<\tfrac32$. Correct and far from tight.
- The unused weight $x_i$ contributes $2x_i+2x_i^2\ge0$. Every weight appears in $G_i$ at most once. So $\mathop{\mathrm{tr}}C\ge2G_i\ge2$.
- Hypotheses actually used: $x\ge0$ and $y>0$, weaker than positive definiteness, as the first bullet says.

## 4. The conclusion and what it settles (CONFIRMED, wording correction)

- $\tfrac35\cdot2-\tfrac4{10}=\tfrac45>\tfrac{36}{49}$ is correct arithmetic, but the parabola $\tfrac35\tau-\tfrac1{10}\tau^2$ decreases past $\tau=3$ and falls below $\tfrac45$ for $\tau>4$. "$\mathop{\mathrm{tr}}C\ge2$, hence $\lVert C\rVert^2\ge\tfrac45$" needs both bounds of the section above: the parabola on $[2,4]$ and $\tau^2/14\ge\tfrac45$ for $\tau\ge\sqrt{11.2}\approx3.35$. The maximum of the two over $\tau\ge2$ is least at $\tau=2$, so $\tfrac45$ stands. Suggested wording: "hence $\lVert C\rVert^2\ge\tfrac45$ by the two bounds of the section above (the parabola up to $\tau=4$, $\tau^2/14$ beyond)".
- Coverage: the argument runs on every positive solution, any stabiliser, so the trivial-stabiliser type needs no enumeration for H. No stability input is used or needed.
- Scope: this covers the torus-invariant family only. H at $n\ge9$ for $\mathfrak g_2$ in general still needs the non-torus-invariant idempotents; the heading says "torus family" and is accurate.
- The $\mathfrak{su}(2)$ point: $2\cdot\tfrac12+2\cdot\tfrac14=\tfrac32$, and it fails $y>0$. Correct.

## 5. The sp(k) bullet (CONFIRMED)

- Let $M=p_{ij}$ be the largest of all short weights $p,q$. In the $p$-row, $(u_i+u_j)q_{ij}\le(u_i+u_j)M$, $p_{il}p_{jl}\le\tfrac M2(p_{il}+p_{jl})$, $q_{il}q_{jl}\le\tfrac M2(q_{il}+q_{jl})$, the sum over $l\ne i,j$ (diagonal weights absent). Dividing by $M$: $G=(u_i+u_j)+\tfrac14\sum_{l\ne i,j}(p_{il}+p_{jl}+q_{il}+q_{jl})+X^-_{ij}\ge1$. If the maximum is $q_{ij}$, the $q$-row gives the same with $X^+_{ij}$, using $p_{il}q_{jl}\le\tfrac M2(p_{il}+q_{jl})$. Matches the bullet's split.
- $X^-_{ij}$ explicitly: the $l=j$ term of $a_i$ and the $l=i$ term of $a_j$ give $\tfrac12(p_{ij}^2+q_{ij}^2)$ inside $\tfrac12(a_i+a_j)$, and $-\tfrac12(q_{ij}^2-p_{ij}^2)$ cancels $q_{ij}^2$: $$X^-_{ij}=u_i^2+u_j^2+\tfrac14\sum_{l\ne i,j}(p_{il}^2+p_{jl}^2+q_{il}^2+q_{jl}^2)+p_{ij}^2,$$ and $X^+_{ij}$ the same with $q_{ij}^2$. A sum of squares, nonnegative coefficients. The note should state this form, since the factor-two check depends on it.
- Trace in $\mathfrak{so}(4k)$'s metric: $\sum_i(2u_i+2u_i^2)+\sum_{i<j}(2p_{ij}+p_{ij}^2+2q_{ij}+q_{ij}^2)$, consistent with $\sum_ia_i$.
- Factor two: $u_i,u_j$: $2u+2u^2=2(u+u^2)$, equality. $p_{il},p_{jl},q_{il},q_{jl}$ ($l\ne i,j$, all distinct weights): $2p+p^2\ge\tfrac12p+\tfrac12p^2$. The maximum $p_{ij}$: $2p+p^2\ge2p^2$ iff $p\le2$, and $p_{ij}^2\le X^-_{ij}<1$ from the row (right side positive). $q_{ij}$ has no part in $G$ and adds $2q+q^2\ge0$. All other weights add. So $\mathop{\mathrm{tr}}C\ge2G\ge2$.
- Screen: at $k=2$, $I/3$ ($u=p=q=\tfrac13$) gives $G=\tfrac23+\tfrac13=1$ exactly, so $G\ge1$ is tight there, while the trace $\tfrac{10}3$ is not.
- $2>1.79,\,1.91$, so with the premises (parabola on $[\tau_-,\tau_+]$, Cauchy–Schwarz above) H holds on the torus families of $\mathfrak{sp}(2)$, $\mathfrak{sp}(3)$; $2<2.08$ at $k=4$. Correct as stated, prose only, and the same torus-family scope as item 4.

## 6. The Lean (CONFIRMED)

A scratch copy of [G2TorusTrace.lean](../lean/HamiltonsCubic/Results/G2TorusTrace.lean) compiles with `lake env lean` (exit 0, no errors). `#print axioms` on `g2_torus_trace`, `g2_torus_H`, `row_bound`, `trace_of_row` and `weight_lt`: `[propext, Classical.choice, Quot.sound]` each, no `sorryAx`.

- `row_bound`: row with $a=x_j$, $b=x_k$, right side `b * ya + a * yb`, i.e. $x_ky_j+x_jy_k$, and $\sigma$ as in item 1. Hypotheses $a,b\ge0$, $y_0>0$, $y_a,y_b\ge0$, $y_a,y_b\le y_0$. Matches the prose step.
- `weight_lt`: needs $y_a,y_b>0$ for a positive right side, then $y_0<9$. Matches.
- `trace_of_row`: the conclusion is item 2's trace expression ($2\sum x^2+\tfrac23\sum y^2+2\sum x+2\sum y$), with the third long weight $c\ge0$. Matches.
- `g2_torus_trace`: rows `r0`, `r1`, `r2` are exactly the three rows derived in item 1 on my concrete root labelling ($S_0$: $x_2y_1+x_1y_2$; $S_1$: $x_2y_0+x_0y_2$; $S_2$: $x_1y_0+x_0y_1$), $\sigma_i$ omitting $x_i$. Case split on the largest $y$ covers all cases. Hypotheses $x\ge0$, $y>0$.
- `g2_torus_H`: states $\tau\ge2$ with the scalar core and Cauchy–Schwarz as hypotheses, concluding $\tfrac{36}{49}\le q$ through `g2_threshold` (needs only $\tau\ge\tfrac{12}7$). It takes $\tau$ abstractly, so the link from `g2_torus_trace`'s expression to $\tau$ is by hand, and the $\tfrac45$ of the statement is not typed (only $\tfrac{36}{49}$, which is what H needs). Both are consistent with the declaration table.

## Summary

Every claim holds. Corrections to fold: (a) item 4, cite both bounds for $\tfrac45$, since the parabola alone falls below $\tfrac45$ past $\tau=4$; (b) item 5, write out $X^-_{ij}=u_i^2+u_j^2+\tfrac14\sum_{l\ne i,j}(p_{il}^2+p_{jl}^2+q_{il}^2+q_{jl}^2)+p_{ij}^2$ (the $q_{ij}^2$ cancels), the fact the factor-two check for $p_{ij}$ and $q_{ij}$ rests on, together with $p_{ij}<1$ from the row.
