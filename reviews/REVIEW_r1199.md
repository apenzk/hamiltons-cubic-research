# Review r1199: p = 15 excluded at n = 12 (L251 candidate)

Adversarial Gate 2 review of the paragraph "p=15 is excluded at n=12: a sharper fourth moment and a two-slice dichotomy" in [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md) (line 229 onward) and [L251P15.lean](../lean/HamiltonsCubic/Results/L251P15.lean). Log: [agent_logs/r1199.log](../agent_logs/r1199.log).

**Verdict: every item CONFIRMED.** The chain holds link by link. Two write-up defects, neither affecting the conclusion: an unjustified (but true) inequality in the band case k' = 5, and a loose summary constant in the band case k' = 4.

| # | item | verdict |
|---|---|---|
| 1 | threshold | CONFIRMED |
| 2 | fourth moment | CONFIRMED |
| 3 | order statistic, Gram row sums, totals | CONFIRMED |
| 4 | slice 0.83 to 0.885 | CONFIRMED |
| 5 | singular dichotomy | CONFIRMED (two write-up corrections) |
| 6 | connectivity and close | CONFIRMED |
| 7 | conclusion and Reach | CONFIRMED |
| L | Lean statements | CONFIRMED |

## 1. Threshold

- m = 66 - 30 = 36 and κ = θ√30. At θ = θ_0(12), κ = √(220·30/144) = √45.833 = 6.77003, so L249 gives μ_36(x) ≤ 2(7 - κ) ≤ 0.45994 < 0.46.
- [p15_threshold](../lean/HamiltonsCubic/Results/L251P15.lean) proves 2(7 - κ) < 0.46 from θ ≥ √(220/144). The margin is thin (6.77003 against 6.77) but the statement is exact.

## 2. Fourth moment

- Expanding tr x⁴ with the sphere moment gives three terms: Σ_{a,c} tr(ψ_a²ψ_c²) = tr A_0², Σ_{a,b} tr(ψ_aψ_bψ_aψ_b) = S, and Σ_{a,b} tr(ψ_aψ_b²ψ_a) = tr A_0² by cyclicity. So E tr x⁴ = (2 tr A_0² + S)/(p(p+2)). Orthonormality under -½ tr makes c uniform on the unit sphere of E_0.
- wedge_gram summed over a, b gives Σ_{ijkl}(Σ_a ψ_a∧ψ_a)² = 12 Σ tr(ψ_aψ_b)² - 24 S ≥ 0. With the normalisation ‖·‖² = (1/24)·(entry sum of squares), stated in the Lean docstring, this is ½ Σ tr(ψ_aψ_b)² - S. Orthonormality gives tr(ψ_aψ_b) = -2δ_ab, so ½ Σ tr(ψ_aψ_b)² = ½·4p = 2p. The constant 2p is right. The prose paragraph leaves the 1/24 unstated, which is cosmetic since only the sign is used.
- tr A_0 = Σ_a(-tr ψ_a²) = 2p, 0 ⪯ A_0 ⪯ (11/2) I, hence tr A_0² ≤ (11/2)·2p = 11p. Then E ≤ (22p + 2p)/(p(p+2)) = 24/(p+2) = 24/17 ≈ 1.4118.
- Screen (not evidence): a random orthonormal 15-dimensional subspace of so(12) gave S = 14.58 ≤ 30, tr A_0² = 79.3 ≤ 165, formula 0.6788 against Monte Carlo 0.6797 (3000 samples).

## 3. Order statistic and Gram row sums

- -ad_x² has six zeros and each (s_i ± s_j)² twice, 6 + 60 = 66. The 36 smallest are the six zeros and the 30 smallest of the doubled multiset, which is twice the 15 smallest of the 30 values. So μ_36 = 2T_15, and zeros among the 30 values (at s_6 = 0) change nothing.
- Row sums: q values are s^T(Σ vv^T)s with v = e_a ± e_b. Σ vv^T = V V^T shares its nonzero spectrum with the Gram V^T V, whose diagonal is 2 and whose off-diagonal entries lie in {-1, 0, 1} for distinct lines. Gershgorin gives λ_max ≤ q + 1, so the sum is at most (q+1)T.
- Totals: each unordered pair contributes (s_a+s_b)² + (s_a-s_b)² = 2(s_a² + s_b²), and each vertex lies in 4 pairs on five vertices (total 8T) and 3 on four vertices (total 6T).

## 4. Slice 0.83 ≤ u < 0.885

- s_j² ≤ 1 - u and u ≥ ½ give (s_1 - s_j)² ≥ (√u - √(1-u))² ≥ 0.2487 at u = 0.83, increasing in u. Every vertex-1 value, sums and w_1 included, exceeds 0.23, so none is among the 15.
- The 15 lie among the 20 values on {2..6}, and the 5 left out sum to at most 6T, so T_15 ≥ 2T = 2(1-u) > 0.23. Nothing uses s_6 = 0, so this holds for general x.
- Screen: the minimum of T_15 on this slice over general s is 0.2716.

## 5. Singular dichotomy

- The opening sentence "Five nonzero angles give u ≥ 1/5" overstates. s_6 = 0 leaves s_5 free to vanish. The bound u ≥ 1/5 still holds from five angles summing to 1, and no case uses s_5 > 0.
- **u ≤ 0.23.** w_i ≥ 1 - 4u ≥ 0.08, so every (s_i+s_j)² with i, j ≤ 5 is at least 4(0.08) = 0.32 and drops out. The 15 come from 10 gaps and 10 values w_i, so at least five are w_i, and T_15 ≥ 0.4. Correct.
- **0.46 < u < 0.885.** The vertex-1 sums and w_1 exceed 0.23.
  - m = 0 gives 2T > 0.23.
  - A chosen d_1j excludes both copies of w_j and the three (s_j+s_k)², k ∈ {2..5}∖{j}, since each is at least w_j and d_1j + w_j ≥ u/2 > 0.23. With m chosen gaps the exclusions number 5m - C(m,2), and the unchosen values on {2..6} number 20 - (15 - m) = 5 + m. At m = 2, 3, 4 this is 9 > 7, 12 > 8, 14 > 9, so m = 1 is forced. Counting correct.
  - At m = 1, 14 of the 15 remaining values are chosen: either all three d_jk and 11 of the 12 on K (sum at least 6T_K - 2T_K = 4T_K), or two d_jk and all 12 (sum 6T_K, dropping one w_k). vertex_split at c = 4 and c = 6 gives d_jk + 4w_k ≥ (4/5)w_j and d_jk + 6w_k ≥ (6/7)w_j. At c = 12/5 and c = 12/7 it gives (12/17)u = 0.706u and (12/19)u = 0.632u, both above 0.29 at u > 0.46. Correct.
- **Band 0.23 < u ≤ 0.46.**
  - The 18 values touching {1,2} are d_12 and (s_1+s_2)² ≥ 4w_2 ≥ 0.54, the six gaps d_ij, the six sums (s_i+s_j)² ≥ w_2, and the four copies of w_1 and w_2 at vertex 6. With the 12 on {3,4,5,6} they account for all 30 values. The labels are correct: nothing below 0.135 was misfiled.
  - The count 15 = f + [d_12] + 12 - k' gives k' = f + [d_12] - 3 and f ≥ k' + 2. The kept values on {3..6} are at least 6Q - (k'+1)Q by row sums with w_6 = 0.
  - k' ≤ 2 gives ≥ 3Q ≥ 0.24.
  - k' = 3: if the chosen touching values include a non-gap, the bound is ≥ 2Q + 0.135 ≥ 0.295. Otherwise at least five of the six gaps are chosen, one at each j, and vertex_split at c = 2 gives 2w_j + d_ij ≥ (2/3)w_i ≥ (2/3)w_2, so the bound is ≥ 2w_2 ≥ 0.27. Correct. The split reads more cleanly on the chosen set than on V_5, but the two phrasings are equivalent.
  - k' = 4: with the six gaps, three_way gives Σ_j(w_j + d_1j + d_2j) ≥ w_1 + w_2 > 0.365. With one non-gap and five gaps, the bound is 0.135 + (3/2)w_2 ≥ 0.3375. **Correction (cosmetic):** the text says "≥ 0.27 with two, so > 0.33". Two non-gaps give 0.27, which is not above 0.33. The claim "> 0.33" holds only after adding Q ≥ 0.08 (0.35), which the phrase omits. Every branch exceeds 0.23 either way.
  - k' = 5: the Gram bound degenerates to 6Q - 6Q = 0, and the text instead asserts that the seven kept values are "at least 2(w_4+w_5)" **without a reason**. This is a gap in the written argument, and it is load-bearing in the all-six-gaps branch. It is true. The five dropped values sum to at most 6w_3 + 4w_4 + 4w_5, as follows. Write a ≥ b ≥ c for s_3, s_4, s_5. Every value other than the three sums (a+b)², (a+c)², (b+c)² is at most a². A 5-subset holding k of the sums is bounded by k = 3: 4a² + 2b² + 2c² + 2(ab+ac+bc) ≤ 6a² + 4b² + 4c²; k = 2: 5a² + b² + c² + 2ab + 2ac ≤ 6a² + 4b² + 4c² via 2ab ≤ a²/2 + 2b²; k = 1: 5a² + 2ab + b²; k = 0: 5a². Hence the kept seven are ≥ 6Q - (6w_3 + 4w_4 + 4w_5) = 2(w_4 + w_5). Screen: 2·10⁵ random (a, b, c) put the normalised slack at minimum 9·10⁻⁷ ≥ 0 (equality at a = b = c). **Correction: add this one-line bound to the k' = 5 case.** The rest of k' = 5 is correct: f ≥ 7 forces a non-gap, so the bound is either two non-gaps ≥ 0.27 or six gaps plus one value, and four_way over j = 4, 5 gives 0.135 + w_1 + w_2 ≥ 0.5.
  - k' ≥ 6: f ≥ 8 means at least two non-gaps, ≥ 0.27.
  - The three cases in u cover (0, 0.885). No missed configuration was found.
- Screens: the minimum of T_15 over singular s is 0.2707 for u < 0.885, at the top of the range, and 0.7940 in the band. Both agree with the record's 0.27 and 0.79.

## 6. Connectivity and close

- x ↦ x e_1 sends E_0 (dimension 15) into e_1^⊥ (dimension 11) by skewness, so the kernel has dimension ≥ 4 and holds a unit x_0 with a zero eigenvalue, i.e. s_6 = 0.
- u = λ_max(-x²) is continuous, and the unit sphere of E_0 (a 14-sphere) is connected. Its image is an interval containing u(x_0) ≥ 0.885 and missing [0.83, 0.885), so it lies in [0.885, 1].
- tr x⁴ = 2Σ s_i⁴ ≥ 2u² ≥ 2(0.885)² = 1.5665 at every point, so the average is ≥ 1.5665 > 24/17 = 1.4118. Contradiction.

## 7. Conclusion and Reach

- With L250 (p = 16) and L244 (p ≥ 17), p ≤ 14 follows at θ ≥ θ_0(12).
- Reach: at p = 14, m = 38 and κ ≥ √(220·28/144) = 6.5405, so μ_38 ≤ 0.919, and the average ceiling is 24/16 = 1.5. Both figures are correct. The "decomposable floor near 1.465" was not rederived. It is a remark on where the route stops and supports no claim.

## Lean

[L251P15.lean](../lean/HamiltonsCubic/Results/L251P15.lean) compiles with `lake env lean` (exit 0, no output). It has no sorry, and [wedge_gram](../lean/HamiltonsCubic/Results/BianchiTraced.lean) is proved.

| declaration | check |
|---|---|
| quartic_sum_le | general skew family, exactly S ≤ ½ Σ tr(ψ_aψ_b)². Matches the prose. |
| moment_ceiling | takes the moment formula, S ≤ 2p and trA2 ≤ 11p as hypotheses. It is satisfiable and uses exactly what items 2 supplies. |
| p15_threshold | exact statement, needs only θ ≥ √(220/144). |
| slice_gap | hypotheses are available at every x in the slice, and it omits s_j ≤ s_1 because that is unneeded. |
| vertex_split, three_way, four_way | unconditional inequalities, with minimisers at t = a/(1+c), (a+b)/3 and (a+b)/4. |
| band_constants | Q ≤ 3w_2 and w_2 ≤ w_1 are available. It is nonvacuous. |
| p15_contradiction | scalar close, with E read as the average and 2u² ≤ E from the pointwise floor. |

The combinatorial steps (the order statistic, the row sums, the case counting and the k' = 5 bound above) are prose, as declared.
