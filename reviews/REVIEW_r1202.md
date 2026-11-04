# REVIEW r1202: p = 14 excluded at n = 12

Log: [agent_logs/r1202.log](../agent_logs/r1202.log)

Target: the paragraphs "**$p=14$ at $n=12$: a coupled average, and the dichotomy it needs.**" and "**$p=14$ is excluded at $n=12$.**" in [the per-vector note](2026-09-25-I73c-per-vector-rows.md), with [CoupledMoment.lean](../lean/HamiltonsCubic/Results/CoupledMoment.lean). Givens (coupled average, L249, Gram row sum, decomposable bound) taken as passed.

| Item | Claim | Verdict |
|---|---|---|
| 1 | Structure reduction, count, matrix identity | CONFIRMED (wording repair) |
| 2 | Missing vertex gives 3T | CONFIRMED |
| 3 | Enumeration floor | CONFIRMED (independent rebuild, every entry matches) |
| 4 | T_16 >= min(4 - 2 sqrt 3, 3T) at every unit angle vector | CONFIRMED |
| 5 | Closing argument | CONFIRMED |
| 6 | p <= 13 and the p = 13 remark | CONFIRMED |
| 7 | Lean match | CONFIRMED (docstring nit) |

## Item 1

- For non-negative angles $(s_i-s_j)^2\le(s_i+s_j)^2$. If a minimising 16-set holds a sum without its gap, swapping in the gap gives a 16-set of no larger sum, hence also minimising. So a minimising 16-set can be chosen with every lone value a gap. Each of the 15 pairs is then doubled, single or free.
- Count: $2|H_2|+|H_1|=16$ and $|H_2|+|H_1|+|F|=15$ give $|F|=|H_2|-1$. Correct.
- Cost: a gap on $ij$ is $s^{\mathsf T}(e_i-e_j)(e_i-e_j)^{\mathsf T}s$, a doubled pair adds $2(s_i^2+s_j^2)$, so $M=L(H_1)+2D(H_2)$. Since $2D(H_2)=L(H_2)+\lvert L\rvert(H_2)$ and $H_1\cup H_2=K_6\setminus F$, the second form follows. Screened on 2000 random structures against the root sum $\sum\alpha\alpha^{\mathsf T}$: zero failures.
- **Wording repair.** "so the 16 smallest values are a structure" reads as if the minimising set is always one. With ties (for instance $s_j=0$, where gap and sum coincide) a minimising set may hold a lone sum. The correct phrasing is "the 16 smallest can be chosen to form a structure", which is all the argument uses, since only the value $T_{16}$ enters.

## Item 2

- If $v$ is untouched, all five pairs at $v$ are free, so the 16 values are 16 of the 20 on the other five vertices, whose total is $8(1-s_v^2)$. The four left out sum to at most $5(1-s_v^2)$ by the Gram row sum at $q=4$, leaving at least $3(1-s_v^2)\ge3(1-s_1^2)=3T$. Correct.

## Item 3

Independent enumeration (my own script, [r1202_enum.py] in scratchpad, not the author's). It differs from the author's in building $M$ directly as the sum of root outer products ($e_i-e_j$ for every chosen gap, $e_i+e_j$ additionally for doubled pairs) instead of the Laplacian formula, and it tests "touching" as incidence to a chosen edge. It loops over $|H_2|=k$, all $H_2$, all $F$ of size $k-1$ in the remaining pairs, and takes floating-point `eigvalsh`.

| $\lvert H_2\rvert$ | touching structures | least $\lambda_{\min}$ |
|---|---|---|
| 1 | 15 | 0.535898 ($=4-2\sqrt3$) |
| 2 | 1365 | 0.916128 |
| 3 | 30030 | 1.000000 |
| 4 | 225225 | 1.155452 |
| 5 | 630630 | 0.714350 |
| 6 | 629370 | 0.652198 |
| 7 | 178020 | 0.683375 |
| 8 | 6165 | 2.000000 |

- Every entry matches the note. Total structures 1,704,510 (the note's "about two million" is loose but harmless).
- Non-touching structures reach $\lambda_{\min}=0$ as expected, so the touching restriction is load-bearing and correctly placed.
- Hand check that no touching structure is singular: a component $C$ of $H_1\cup H_2$ free of $H_2$ edges needs $c(6-c)\le|F|=|H_2|-1\le\binom{6-c}2-1$, impossible for $1<c\le6$.
- **Wording.** "exact enumeration of ... integer matrices" is exact as an enumeration, but the eigenvalues are floating point (in mine too). The margin $0.652-0.4595$ is ten orders above double-precision error on integer $6\times6$ matrices, so the conclusion stands. The note should say the eigenvalues are floating point, or certify $M-\tau I\succ0$ exactly.

## Item 4

- At any unit $s$ (sorted, non-negative), pick a minimising 16-set that is a structure (item 1). If it misses a vertex, item 2 gives $T_{16}\ge3T$. Otherwise $T_{16}=s^{\mathsf T}Ms\ge\lambda_{\min}(M)\ge4-2\sqrt3$ by item 3. So the bound is about $T_{16}$ itself, through the one structure realising it, and needs nothing about non-minimising structures. Correct.
- Screen: $\min\big(T_{16}-\min(4-2\sqrt3,3T)\big)$ over 20000 random and 300 Nelder-Mead starts is $-1.6\times10^{-15}$, so the bound holds and is attained.

## Item 5

- L249 with $\kappa=\theta\sqrt{28}\ge\sqrt{385}/3$ gives $T_{16}\le\tau\approx0.45953$ at every unit $x\in E_0$. Since $\tau<4-2\sqrt3\approx0.53590$, the first branch is impossible, so $3T\le T_{16}\le\tau$.
- $\sum s^4\ge(1-T)^2+T^2/5$ by Cauchy-Schwarz on $s_2..s_6$. With $T_{16}\ge3T$ the sum is at least $16-29T+19.2T^2$, decreasing on $[0,\tau/3]$, with value $12.0084$ at $T=\tau/3$. So $16\sum s^4+T_{16}>12$ strictly at every unit $x$, and the continuous integrand gives $\mathbb E>12$ against $\mathbb E\le12$. Every unit $x\in E_0$ is covered because both L249 and item 4 are pointwise.
- Screen: min of $16\sum s^4+T_{16}$ on $T_{16}\le\tau$ is $12.170$, matching the note.

## Item 6

- L251 gave $p\le14$, now $p=14$ is excluded, so $p\le13$ for symmetric three-value critical points above $\theta_0(12)$. Scope matches the coupled average's hypothesis.
- $p=13$ remark, screened: $m=66-2p=40$, $\mu_{40}=2T_{17}$, $\tau_{13}=7-\sqrt{(220/144)\cdot26}\approx0.6974$. Min of $15\mathop{\mathrm{tr}}x^4+\mu_{40}=30\sum s^4+2T_{17}$ on $T_{17}\le\tau_{13}$ is $22.15<24$, matching "22.2 < 24". The remark is a screen and is labelled as one.

## Item 7

- Built in background: `lake build HamiltonsCubic.Results.CoupledMoment` succeeds. `#print axioms` on `p14_branch`, `p14_threshold`, `p14_decomposable`, `one_pair_floor` gives only `propext`, `Classical.choice`, `Quot.sound`. No `sorry`, no `native_decide`.
- `p14_branch` takes the structure bound and $T_{16}\le\tau$ as hypotheses and returns $3T\le T_{16}$, exactly its prose use. `p14_threshold` proves $7-\kappa\le\tau$ from $\theta\ge\sqrt{220/144}$, exactly its prose use. `one_pair_floor` places the pair on the last two coordinates, which is the general case by symmetry.
- The enumeration, the Gram row sum and the Cauchy-Schwarz step enter only in prose, which the note says.
- Nit: the module docstring lists the $p=14$ steps without `p14_branch` and `p14_threshold`, and line 15 trips the long-line linter.

## Most serious finding

No break. The weakest link is item 3, which rests on a machine enumeration with floating-point eigenvalues. It reproduces independently with every per-$|H_2|$ minimum matching to six digits, and the margin is $0.19$. Two wording repairs: "can be chosen to form a structure" in item 1, and "floating-point eigenvalues" (or an exact PSD certificate) in item 3.
