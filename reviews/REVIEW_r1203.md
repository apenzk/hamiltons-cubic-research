# REVIEW r1203: p = 14 excluded at n = 12 (I73c)

Log: agent_logs/r1203.log

Scope: the paragraph "**$p=14$ is excluded at $n=12$.**" in reviews/2026-09-25-I73c-per-vector-rows.md through "Gate 2 pending.", with the preceding coupled-average paragraph for the reduction, and lean/HamiltonsCubic/Results/CoupledMoment.lean. Analysis-only footing: the computations below are bounded screens and one finite exact check on objects I constructed, written from the definitions without reading the author's script.

| Item | Claim | Verdict |
|---|---|---|
| 1 | Structure reduction, count, WLOG, matrix identity | CONFIRMED |
| 2 | Missing vertex gives at least 3T | CONFIRMED |
| 3 | Enumeration: least eigenvalue 4 - 2 sqrt 3, at least 0.652 for two or more doubled pairs | CONFIRMED, and upgraded to an exact integer certificate |
| 4 | T_16 >= min(4 - 2 sqrt 3, 3T) at every unit angle vector | CONFIRMED |
| 5 | Closing argument, strictness, coverage | CONFIRMED |
| 6 | p <= 13, and p = 13 out of reach (22.2 < 24) | CONFIRMED, one wording repair |
| 7 | Lean p14_branch, p14_threshold match prose | CONFIRMED |

Most serious finding: no step breaks. The one place a reader can go wrong is the p = 13 remark, which says "the same screen" while the threshold changes with p (item 6).

## Item 1

- Count. Write $H_2$ for pairs with both values chosen, $H_1$ for pairs with one, $F$ for pairs with none. Then $2|H_2|+|H_1|=16$ and $|H_2|+|H_1|+|F|=15$, and subtracting gives $|H_2|-|F|=1$. Correct.
- WLOG singles are gaps. For $s_i\ge s_j\ge0$, $(s_i-s_j)^2\le(s_i+s_j)^2$. If a 16-subset contains a sum without its gap, swapping the sum for the gap keeps a 16-subset and does not raise the total, so a minimising subset can be taken with every single a gap. The prose says "the 16 smallest values are a structure", which is exact only up to ties ($s_j=0$ makes gap and sum equal). "Can be taken as a structure" is the accurate wording, as the brief itself phrases it. Cosmetic.
- Matrix. A gap is $s^{\mathsf T}(e_i-e_j)(e_i-e_j)^{\mathsf T}s$, an edge of $L$, and a sum is the signless edge $|L|$. A doubled pair gives $L+|L|=2(e_ie_i^{\mathsf T}+e_je_j^{\mathsf T})$, the $2D$ term. So $M=L(H_1)+2D(H_2)=L(H_1)+L(H_2)+|L|(H_2)=L(K_6\setminus F)+|L|(H_2)$. Correct.

## Item 2

A vertex $v$ is untouched when every pair at $v$ lies in $F$. Then all 16 values are among the 20 on the other five vertices, which sum to $8T'$ with $T'=1-s_v^2$. The four left out are a 4-subset whose Gram matrix of roots has row sums at most $4+1$, so they total at most $5T'$, and the 16 total at least $3T'$. Since $s_v^2\le s_1^2$, $3T'\ge3T$. Correct. (An untouched vertex needs $|F|\ge5$, so $|H_2|\ge6$. The case is real, and such $M$ have a zero row, which is why the split is needed.)

## Item 3

Independent rebuild (scratchpad r1203_enum.py). It enumerates disjoint $H_2,F$ among the 15 edges with $|F|=|H_2|-1$, asserts the 16-value count, keeps structures whose $H_1\cup H_2$ covers all six vertices, and builds $M$ as a sum of rank-one gap and sum terms from the definition, a different construction from the $L+2D$ formula under review.

| $\lvert H_2\rvert$ | structures | least $\lambda_{\min}(M)$ |
|---|---|---|
| 1 | 15 | 0.535898 |
| 2 | 1365 | 0.916128 |
| 3 | 30030 | 1.000000 |
| 4 | 225225 | 1.155452 |
| 5 | 630630 | 0.714350 |
| 6 | 629370 | 0.652198 |
| 7 | 178020 | 0.683375 |
| 8 | 6165 | 2.000000 |

- Total 1,700,820 structures ("about two million" in the prose). All eight minima agree with the prose to the digits given, and the $|H_2|=1$ minimum equals $4-2\sqrt3$.
- Exact certificate (scratchpad r1203_exact.py). The prose calls the enumeration exact, but a least eigenvalue from a floating solver is a float. I checked instead that $2M-I$ is positive definite at every one of the 1,700,820 matrices by integer Bareiss elimination (all leading principal minors positive). Entries of $2M-I$ are at most 19 on the diagonal and $-2$ or $0$ off it, so by Hadamard every intermediate stays below $10^{16}$ and int64 is exact. All pass, so $\lambda_{\min}(M)>1/2>\tau\approx0.4595$ for every touching structure, exactly. Sanity: the same routine with exact Python integers rejects $4M-3I$ and $100M-54I$ and accepts $100M-53I$ at the one-pair matrix, as its eigenvalue $0.5359$ requires.
- Consequence for the record: the owed "analytic bound $\lambda_{\min}(M)>\tau$ for $|H_2|\ge2$" is now held by an exact finite certificate at threshold $1/2$, independent of floating point. It remains a computer check, which the prose already says.

## Item 4

$T_{16}$ is the cost of some minimising structure $S^*$ (item 1). If $S^*$ touches all six vertices, $T_{16}=s^{\mathsf T}M_{S^*}s\ge\lambda_{\min}(M_{S^*})\ge4-2\sqrt3$ at $|s|=1$. Otherwise $T_{16}\ge3T$ by item 2. So $T_{16}\ge\min(4-2\sqrt3,3T)$ at every sorted unit angle vector, and every skew $x$ has such a normal form. The argument bounds $T_{16}$ itself, since it needs a bound only at the minimising structure and holds at every structure anyway. Correct.

## Item 5

- $T_{16}\le\tau$: L249 gives $\kappa\le7-\tfrac12\mu_{38}=7-T_{16}$, and $\theta\ge\theta_0(12)$ gives $\kappa=\theta\sqrt{28}\ge\sqrt{6160}/12=\sqrt{385}/3$, so $T_{16}\le\tau=0.459528$ at every unit $x\in E_0$. Here $\mu_{38}=2T_{16}$ because $-\mathrm{ad}_x^2$ on $\mathfrak{so}(12)$ has six zero eigenvalues and each of the thirty values twice, so the 38 smallest are six zeros and sixteen doubled values.
- $\tau<4-2\sqrt3$ ($0.4595<0.5359$), so the min in item 4 is $3T$ and $3T\le T_{16}\le\tau$.
- $\sum s^4\ge s_1^4+(1-s_1^2)^2/5=(1-T)^2+T^2/5$ by Cauchy on the five others. With $T_{16}\ge3T$: $16\sum s^4+T_{16}\ge16-29T+19.2T^2$, decreasing on $[0,\tau/3]$ (derivative $-29+38.4T<0$), value $12.0084$ at $T=\tau/3=0.153176$.
- Strictness: pointwise $\ge12.008$ at every unit $x\in E_0$, so the sphere average is $\ge12.008>12\ge\mathbb E[16\sum s^4+T_{16}]$. Normalisation: $\mathop{\mathrm{tr}}x^4=2\sum s^4$ and $\mu_{38}=2T_{16}$ turn $(p+2)\mathbb E\mathop{\mathrm{tr}}x^4+\mathbb E\mu_{38}\le24$ into the given form. Correct.
- Screen: the minimum of $16\sum s^4+T_{16}$ over unit angle vectors with $T_{16}\le\tau$ is $12.169$ (penalised Nelder–Mead from 1500 near-decomposable starts), matching the prose's $12.17$.

## Item 6

- $p\le13$ follows from this exclusion together with L251 ($p\le14$ for a symmetric three-value critical point at $n=12$ above $\theta_0(12)$). The closing sentence states the conclusion on that same family and threshold, so the combination is sound. The paragraph leaves L251 implicit, and naming it would make the chain self-contained.
- The p = 13 remark. At $p=13$ the relevant quantities change: $m=66-2p=40$, so $\mu_{40}=2T_{17}$, and $\kappa=\theta\sqrt{2p}=\theta\sqrt{26}$, so the threshold is $\tau_{13}=7-\sqrt{220\cdot26/144}\approx0.6974$. My screen with these gives $\min(15\mathop{\mathrm{tr}}x^4+\mu_{40})=2\times11.075=22.15$, matching $22.2<24$. With the $p=14$ threshold $\tau$ kept in place, the same screen gives $24.55>24$, which a reader reusing "the same screen" literally would take as excluding $p=13$. **Repair**: state $\tau_{13}\approx0.697$ (from $\kappa=\theta\sqrt{26}$) and $T_{17}$ in the remark. The claim itself stands.

## Item 7

- p14_branch: from $\min(4-2\sqrt3,3T)\le T_{16}$ and $T_{16}\le7-\sqrt{385}/3$ concludes $3T\le T_{16}$. This is exactly the prose step, with the structure bound (item 4) entering as the hypothesis hmin, which the enumeration supplies outside Lean.
- p14_threshold: $\kappa=\theta\sqrt{28}$, $\theta\ge\sqrt{220/144}$ gives $7-\kappa\le7-\sqrt{385}/3$. Combined with L249 ($T_{16}\le7-\kappa$, external) it yields $T_{16}\le\tau$ as used.
- p14_decomposable carries hT0 : $0\le T$, which holds since $T=1-s_1^2$, and one_pair_floor states the one-pair case with the pair on the last two coordinates, general by relabelling.
- Build: a concurrent Lean build from another session was running, so I did not start one (the repo hook refuses a second). The olean for CoupledMoment is newer than the source (01:22:27 against 01:19:53), and the latest on-disk change was to the module docstring only. No sorry in the file.
