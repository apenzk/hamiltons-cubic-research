# REVIEW r1152: kappa_r <= r + 2, the uniform proof of the Ky Fan bracket cap

*Gate 2 reviewer r1152, 2026-09-25, brief [2026-09-25-kappa-r-gate2-brief.md](2026-09-25-kappa-r-gate2-brief.md), claim as committed at 9b6a0ad7 in [second-order.md](../findings/second-order.md) line 236. Every step below was checked by hand. The only computation was a screen: the slot spectrum against the matrix of $-\mathrm{ad}_X^2$ at random normal forms, and a Nelder-Mead hunt for a violation, reported as a screen and never as evidence.*

## Summary

| item | verdict |
|---|---|
| 1. slot spectrum | CONFIRMED (one wording clarification, no correction) |
| 2. opposite-sign pairs and leftovers | CONFIRMED |
| 3. degree-weighted inequality, load, final coefficient | CONFIRMED, no double counting |
| 4. $\kappa_r\le r+2$ at every $r$ and $n$, tightness | bound CONFIRMED, no counterexample; tightness claims CONFIRMED but understated (sharpening S below) |

## Item 1: the slot spectrum

- With $\varphi_{pq}$ of norm $1$ under $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}XY$, the unit condition is $\sum_cs_c^2=1$.
- On the four-dimensional span of $E$-slots between blocks $a<b$, $\mathrm{ad}_X$ has eigenvalues $\pm i(s_a+s_b)$ and $\pm i(s_a-s_b)$, so $-\mathrm{ad}_X^2$ has $(s_a+s_b)^2$ twice and $(s_a-s_b)^2$ twice.
- On the two-dimensional span between block $a$ and a free index, $\mathrm{ad}_X$ is a rotation at rate $s_a$, so $-\mathrm{ad}_X^2=s_a^2$ with multiplicity $2$. The Cartan and free-free slots are $0$. The dimension count is $\binom n2$.
- Clarification: the claim's first sentence says "$s_a^2$ per block and free index" where the givens say "twice". The proof treats each such slot individually (coefficient $a_c^2$ per chosen slot, counted once in $r$), so the multiplicity is used correctly and nothing depends on the wording.
- Screen: at $n=5,\dots,9$ and every block count, the slot list agreed with the eigenvalues of the $\binom n2\times\binom n2$ matrix to $4\cdot10^{-16}$.

## Item 2: pairs and leftovers

- On a block pair, let $P\le2$ and $M\le2$ be the chosen slots of value $(s_u+s_v)^2$ and $(s_u-s_v)^2$. Pairing $\min(P,M)$ of each leaves $e=\lvert P-M\rvert\le2$ slots of one type.
- $(s_u+s_v)^2+(s_u-s_v)^2=2s_u^2+2s_v^2=2(a_u^2+a_v^2)$ identically, so the pair sum is exact whatever the signs.
- Each leftover is $(s_u\pm s_v)^2\le(\lvert s_u\rvert+\lvert s_v\rvert)^2=(a_u+a_v)^2$. A block-free slot is $a_c^2$ and a zero slot contributes $0$.

## Item 3: the load

- The inequality: $(a_u+a_v)^2=a_u^2+a_v^2+2a_ua_v$ and $2a_ua_v\le t\,a_u^2+a_v^2/t$ with $t=d_v/d_u>0$, both degrees at least $1$ on an edge. Correct, with equality iff $a_u/d_u=a_v/d_v$.
- Summed over the $d_u$ edges at $u$ (with multiplicity), $a_u^2$ collects $d_u+\sum_{e\ni u}d_v/d_u=d_u+\tfrac1{d_u}\sum_vm_{uv}d_v$. Correct.
- $d_v\le(E-d_u)+m_{uv}$: $G$ has no loops, since leftovers live on pairs $u\ne v$. The $d_v-m_{uv}$ edges at $v$ not joining $u$ are not incident to $u$, so they lie among the $E-d_u$ edges avoiding $u$. Correct.
- $\sum_vm_{uv}^2\le2\sum_vm_{uv}=2d_u$ from $m_{uv}\le2$. Correct.
- Then $\sum_vm_{uv}d_v\le d_u(E-d_u)+2d_u$, and the load is at most $d_u+(E-d_u)+2=E+2$. Correct. A block with $d_u=0$ has load $0$.
- Final coefficient: block $u$ receives $2$ per opposite-sign pair at $u$ (equal to the number of slots in those pairs), $1$ per chosen block-free slot of $u$, and its load. The opposite-sign slots at $u$, the block-free slots at $u$ and the $E$ leftover slots are disjoint subsets of the $r$ chosen slots, so their count is at most $r$ and the coefficient is at most $r+2$. Summing gives $(r+2)\sum_ca_c^2=r+2$. No double counting: each slot is counted once for $u$, and the bound per block is compared with $r$ separately for each $u$, which is what the conclusion needs.
- The step to $\kappa_r$: the slot basis is orthonormal and complete ([L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)), so $\kappa_r(X)$ is the largest sum of $r$ slot values, and the bound holds for every $r$-subset. This is the hypothesis [L237Cap.lean](../lean/HamiltonsCubic/Results/L237Cap.lean) asks for.

## Item 4: truth, counterexample hunt, tightness

- The bound follows from items 1 to 3 at every $r$ and $n$, with nothing $n$-dependent in the argument.
- Screen (not evidence): Nelder-Mead, 25 starts per case, over unit normal forms at $n=4,\dots,14$, every block count, $r=1,\dots,12$. No value exceeded $r+2$.
- Doubled triangle ($r=6$, three equal blocks, both $(s+s)^2$ slots on each pair): $6\cdot\tfrac43=8$, and every load is $4+\tfrac{2\cdot4+2\cdot4}4=8=E+2$. CONFIRMED, needs $n\ge6$.
- Doubled star with centre $u$ and $k$ leaves ($r=E=2k$, $d_u=2k$, $d_v=2$): load at $u$ is $2k+k\cdot\tfrac{2\cdot2}{2k}=2k+2$, at a leaf $2+\tfrac{2\cdot2k}2=2k+2$. CONFIRMED.
- **Sharpening S (the claim understates tightness).** The equality condition $a\propto d$ gives $a_u=k x$, $a_v=x$, $x^2=\tfrac1{k(k+1)}$, and the chosen sum $2k(k+1)^2x^2=2k+2$. So **$\kappa_r=r+2$ at every even $r$ once $n\ge r+2$**, attained by the doubled star with $r/2$ leaves, and not only at $r=2,4,6$. The screen agrees: the maximum equals $r+2$ at each even $r\le12$ exactly when $n\ge r+2$ (and at $r=6$ already from $n=6$ by the triangle), and falls below it otherwise, for example $2+2\cdot\tfrac{1+\sqrt5}2\approx5.236$ at $n=5$, $r=4$.
- Odd $r$: the screen maxima are $2,3+\sqrt3,4+2\sqrt2,5+\sqrt{15}$ at $r=1,3,5,7$ ($n=12$), each below $r+2$, so the bound is not attained at odd $r$ in the screened range. The claim says nothing about odd $r$, so this is a remark, not a correction.
- Consequence for the record's values: $\kappa_2,\kappa_4,\kappa_6=4,6,8$ hold as maxima for $n\ge4,6,6$. The record's $\kappa_r$ is written without $n$, which is right as an upper bound at every $n$. Where it is used as an attained value, it needs $n\ge r+2$ (or $n\ge6$ at $r=6$).

## Proposed wording

Replace "*Tight at $r=2,4,6$ (the values $4,6,8$ above), with equality at the doubled triangle and the doubled star, where every load is exactly $r+2$;*" with "*Tight at every even $r$ once $n\ge r+2$: the doubled star with $r/2$ leaves and $a_c$ proportional to degree attains $r+2$, as does the doubled triangle at $r=6$, and every load there is exactly $r+2$;*". Optional, since the claim as written is true.
