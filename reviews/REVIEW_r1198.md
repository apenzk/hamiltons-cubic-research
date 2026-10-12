# REVIEW r1198: p = 15 excluded at n = 12 (L251 candidate)

Claim: the paragraph "p=15 is excluded at n=12: a sharper fourth moment and a two-slice dichotomy" in [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md), with [L251P15.lean](../lean/HamiltonsCubic/Results/L251P15.lean). Log: [agent_logs/r1198.log](../agent_logs/r1198.log).

**Verdict: the exclusion of p = 15 holds.** Every item is CONFIRMED. Two sentences in step 4 are worded wrongly and need repair, but the bounds they state are right.

| item | claim | verdict |
|---|---|---|
| 1 | threshold mu_36 < 0.46 | CONFIRMED |
| 2 | fourth moment E tr x^4 <= 24/(p+2) | CONFIRMED |
| 3 | mu_36 = 2 T_15, Gram row sums, 8T and 6T | CONFIRMED |
| 4 | slice 0.83 <= u < 0.885 empty | CONFIRMED |
| 5 | singular dichotomy u >= 0.885 | CONFIRMED, two wording repairs (W1, W2) |
| 6 | connectivity and closing contradiction | CONFIRMED |
| 7 | conclusion p <= 14, Reach remark | CONFIRMED |
| Lean | L251P15.lean declarations | CONFIRMED (compiles, exit 0, no sorry) |

## Item 1

L249 at n = 12 gives kappa <= 7 - mu_36/2, so mu_36 <= 2(7 - kappa). theta_0(12) sqrt(30) = sqrt(220 * 30 / 144) = sqrt(45.833) = 6.77003 > 6.77, so mu_36 < 0.46 strictly. m = 66 - 30 = 36.

## Item 2

- Moment: tr x^4 = sum c_a c_b c_c c_d tr(psi_a psi_b psi_c psi_d). The three pairings give sum_ab tr(psi_a^2 psi_b^2) = tr A_0^2 twice (the second by cyclicity) and S once. So E tr x^4 = (2 tr A_0^2 + S)/(p(p+2)).
- Constant 2p: under the inner product -1/2 tr, orthonormality means tr(psi_a psi_b) = -2 delta_ab. Then 1/2 sum tr(psi_a psi_b)^2 = 1/2 * 4p = 2p. wedge_gram summed over a, b gives the squared entrywise norm of sum_a psi_a wedge psi_a as 12 sum tr(..)^2 - 24 S = 24(2p - S). The prose norm is this divided by 24, which the Lean docstring states. So S <= 2p.
- tr A_0^2 <= 11p: A_0 is PSD (a sum of -psi^2), A_0 <= 11/2 I, tr A_0 = 2p. So tr A_0^2 <= 11/2 tr A_0 = 11p. The Casimir constant 11 = n - 1 checks against the basis e_ij - e_ji.
- So E tr x^4 <= 24p/(p(p+2)) = 24/17 = 1.4118.

## Item 3

- -ad_x^2 has 6 zeros and each of the 30 values twice (6 + 60 = 66). The 36 smallest are the zeros plus 30 values, which are the 15 smallest labels counted twice. So mu_36 = 2 T_15.
- Gram: the sum of (v.s)^2 over q distinct v equals s^T (sum v v^T) s. This is at most lambda_max(G) T, where G is the q x q Gram matrix with diagonal 2 and off-diagonal entries of size at most 1. Gershgorin gives lambda_max(G) <= q + 1.
- Totals: (s_a - s_b)^2 + (s_a + s_b)^2 = 2(w_a + w_b), and each vertex lies in 4 pairs (five vertices) or 3 pairs (four vertices). That gives 8T and 6T.
- When s_6 = 0 the vectors e_j - e_6 and e_j + e_6 are distinct, so the two copies of w_j are admissible Gram vectors.

## Item 4

- s_1 >= sqrt(0.83) = 0.9110 and s_j <= sqrt(0.17) = 0.4123. So every d_1j >= 0.2487 > 0.23, and p_1j is larger still. None of the 15 touches vertex 1.
- The 15 lie among the 20 values on vertices 2..6. Their sum is at least 8T - 6T = 2T > 0.23, since T = 1 - u > 0.115.
- Nothing here assumes s_6 = 0, so the step covers general x.

## Item 5

**u <= 0.23.** Every w_i >= 1 - 4(0.23) = 0.08, so p_ij >= 4(0.08) = 0.32 for i, j <= 5 and none of these is chosen. The 15 lie among 10 gaps and 10 copies of w. So at least 5 copies of w are chosen, and T_15 >= 0.4.

**0.46 < u < 0.885.**
- w_1 and p_1j are both >= u > 0.23, so they are out. The case m = 0 gives 2T > 0.23.
- A chosen d_1j excludes both copies of w_j and the three p_jk, since p_jk >= w_j and d_1j + w_j >= u/2 > 0.23 (vertex_split with c = 1). That is 5m - C(m,2) exclusions against 5 + m allowed, which forces m = 1.
- With m = 1, the 20 values on 2..6 lose the 5 forced exclusions plus exactly one more. **W1**: the prose says "the three d_jk and eleven or twelve of the twelve on K". The correct split is either all three d_jk with 11 of the 12 on K, or two d_jk with all 12 on K (3 + 12 = 15, not 14). The two bounds that follow are exactly these two branches, so only the sentence needs repair.
- First branch: sum of 11 of 12 on K >= 6T_K - 2T_K = 4T_K. Then d_jk + 4w_k >= (4/5)w_j, which gives d_1j + (12/5)w_j >= (12/17)u = 0.706u.
- Second branch: d_jk + 6w_k >= (6/7)w_j, which gives d_1j + (12/7)w_j >= (12/19)u = 0.632u.
- Both exceed 0.29 at u > 0.46.

**Band 0.23 < u <= 0.46.**
- band_constants checked: w_2 >= 0.54/4 = 0.135 and Q >= 1 - 2u >= 0.08.
- The touching values, other than d_12 and the six gaps d_ij, are w_1, w_2 and the p_ij. Each is >= w_2 >= 0.135, and p_12 >= u > 0.23.
- The counting holds: 18 values touch {1,2} and 12 lie on {3,4,5,6}, with f + [d_12] + 12 - k' = 15.
- **W2** (the definition of V_r): the proof needs V_r to range over the touching values OTHER than d_12 (f >= k' + 2 is what licenses V_{k'+2}).
  - Read literally ("the r smallest touching values"), d_12 is included. Then at k' = 3 the five values could be d_12, d_13, d_23, d_14 and d_24, and "keeps a gap at every j in {3,4,5}" fails.
  - The bound survives: four_way gives (2w_3 + d_13 + d_23) + (2w_4 + d_14 + d_24) >= w_1 + w_2 >= 0.365. Alternatively the sixth chosen touching value restores coverage.
  - The same reading is what makes "the six are the gaps" exact at k' = 4.
  - Repair: define V_r over the touching values other than d_12.
- Cases, with V_r read that way:
  - k' <= 2 gives >= 3Q >= 0.24.
  - k' = 3 gives 2Q + V_5 >= 0.295, or else 5 of the 6 gaps cover each j, and 2w_j + d_ij >= (2/3)w_2 (vertex_split with c = 2) gives 2w_2 >= 0.27.
  - k' = 4 gives Q + V_6 >= min(w_1 + w_2 by three_way, 0.135 + 1.5 w_2 = 0.3375, Q + 0.27).
  - k' = 5: any 7 of the 12 pool values sum to at least 2(w_4 + w_5). They hold at most 3 gaps, and the 4 smallest others are >= w_5, w_5, w_4, w_4, since p_45 >= w_4 + w_5 and w_3 >= w_4. V_7 then has one non-gap value, and four_way gives >= 0.135 + w_1 + w_2 >= 0.5.
  - k' >= 6: at least two values >= 0.135, with the pool >= 0 used in place of the negative Gram expression.
- four_way is used at k' = 5 but never named in the prose.

**Screens** (seconds, own random search over angle vectors, screens only). Min T_15 is 0.895 on u in [0.2, 0.23], 0.793 in the band, and 0.272 on u in (0.46, 0.885). General (nonsingular) s on the slice [0.83, 0.885) gives 0.274. All are above 0.23 and consistent with the record's figures.

## Item 6

- x -> x e_1 maps the 15-dimensional E_0 into the 11-dimensional e_1-perp, so it has a kernel of dimension >= 4. A kernel vector is a singular skew matrix, and since n is even, s_6 = 0.
- u = ||x||_op^2 is continuous, and the unit sphere S^14 is connected. So u takes values on an interval that contains u(x_0) >= 0.885 and misses [0.83, 0.885), and hence u >= 0.885 everywhere.
- tr x^4 >= 2u^2 >= 1.5665 > 24/17.

## Item 7

- With L250 (p = 16) and L244 (p >= 17), the conclusion p <= 14 follows.
- Reach: at p = 14, kappa = sqrt(220 * 28 / 144) = 6.5405, so mu_38 <= 0.919, and the average is 24/16 = 1.5.
- Screen: min 2 sum s^4 subject to T_16 <= 0.46 is 1.463 at s ≈ (0.92, 0.34, 0.1, ...). This is below 1.5, which matches "floor near 1.465".

## Lean

[L251P15.lean](../lean/HamiltonsCubic/Results/L251P15.lean) compiles clean in the background (exit 0, no output) and holds no sorry. It is imported in [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean), but the file itself is untracked in git.

- quartic_sum_le: states S <= 1/2 sum tr(psi_a psi_b)^2 for any skew family. Faithful. The evaluation of the right side as 2p under orthonormality is prose only.
- moment_ceiling: the moment formula (hE), S <= 2p and tr A_0^2 <= 11p enter as hypotheses. The inputs are the available ones and none is vacuous.
- p15_threshold: states 2(7 - kappa) < 0.46 with kappa = theta sqrt(30). This matches the prose.
- slice_gap: hypotheses s_j^2 <= T and u in [0.83, 0.885). Faithful.
- vertex_split, three_way and four_way are generic and correct: the minima sit at t = a/(1+c), (a+b)/3 and (a+b)/4.
- band_constants: its hypotheses (Q <= 3 w_2, w_2 <= w_1) are the true ordering facts.
- p15_contradiction: the arithmetic 2(0.885)^2 > 24/17.
- The order statistic, the Gram row sum, the exclusion counting and the case split are prose, as the claim declares.

## Most serious finding

The step 4 band case defines V_r as the smallest touching values without excluding d_12, and read that way the k' = 3 sentence "keeps a gap at every j" is false. The bound itself survives through four_way, so this is a wording repair. The m = 1 sentence in the 0.46 < u < 0.885 case miscounts its split (W1), but the formulas are right. Nothing is refuted.
