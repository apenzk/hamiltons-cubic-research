# REVIEW r1201: p = 14 at n = 12, the coupled average and its dichotomy

Claim: the paragraph "p=14 at n=12: a coupled average, and the dichotomy it needs" in [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md) through its Owed sentence, and [CoupledMoment.lean](../lean/HamiltonsCubic/Results/CoupledMoment.lean).

Log: [agent_logs/r1201.log](../agent_logs/r1201.log)

| # | item | verdict |
|---|---|---|
| 1 | averaging steps | CONFIRMED |
| 2 | R_0 formula, coupled identity, 2R_1 >= mu_m | CONFIRMED |
| 3 | p = 14 reduction | CONFIRMED |
| 4 | decomposable regime 12.008 | CONFIRMED |
| 5 | one doubled pair | CONFIRMED |
| 6 | small top angle | CONFIRMED |
| 7 | one or two top gaps | CONFIRMED |
| 8 | Owed statement and coverage | CONFIRMED, one wording repair (0.916 is slightly below twice tau) |
| L | Lean statements | CONFIRMED |

Most serious finding: none breaks the chain. The only inaccuracy is "0.916, twice tau": 2 tau = 0.91906, so 0.916 is just under twice tau. Suggested wording: "about twice tau".

## 1. Averaging

On the unit sphere of the p-dimensional E_0, E(x tensor x) = (1/p) sum_a psi_a tensor psi_a. Both x -> -x^2 and x -> x wedge x are quadratic, so E(-x^2) = A_0/p and E(x wedge x) = Omega_0/p. Averaging the per-vector identity, which is linear in the quadratic x tensor x on its left and in the pairing term, gives tr(A_0^2)/p = 2 + 2 E R_0 - |Omega_0|^2/p. Multiplying by p gives the stated tr A_0^2 = 2p + 2p E R_0 - |Omega_0|^2. Each step follows.

## 2. Coupled identity

- R_0 + R_1 + R_2 = n - 2: for unit x the thirty values sum over pairs to sum_{i<j} 2(s_i^2 + s_j^2) = 10, and each appears twice in the spectrum of -ad_x^2, so the trace is 20 = 2(n - 2). With R_2 = R_0 + 1, 2R_0 + 1 + R_1 = n - 2, so R_0 = (n - 3 - R_1)/2.
- Substitution: p(p+2) E tr x^4 = 2 tr A_0^2 + 2p - |Omega_0|^2 = 6p + 4p E R_0 - 3|Omega_0|^2 = 2pn - 2p E R_1 - 3|Omega_0|^2. Dividing by p gives (p+2) E tr x^4 + 2 E R_1 = 2n - 3|Omega_0|^2/p.
- 2R_1(x) = sum over an orthonormal basis e of E_1 of <-ad_x^2 e, e> = tr(P_{E_1}(-ad_x^2)), and dim E_1 = m, so Ky Fan gives >= mu_m. Dropping |Omega_0|^2 >= 0 gives E[(p+2) tr x^4 + mu_m] <= 2n.
- The p = 15 aside: 17 E tr x^4 <= 24 - E mu_36 <= 24 is at least L251 step 1's bound 24/17, and uses no cap on A_0. Confirmed.

## 3. The p = 14 reduction

- kappa = theta sqrt(28) >= sqrt(28 * 220)/12 = 4 sqrt(385)/12 = sqrt(385)/3.
- m = 66 - 28 = 38. mu_38 is six zeros plus the 16 smallest of the 30 values, each twice, so mu_38 = 2 T_16. L249 gives T_16 <= 7 - kappa <= tau = 7 - sqrt(385)/3 = 0.459530.
- tr x^4 = 2 sum s^4, so the coupled bound at p = 14 is E[2(16 sum s^4 + T_16)] <= 24, that is E[16 sum s^4 + T_16] <= 12. A pointwise strict bound > 12 on every unit x with T_16 <= tau, where every unit x of E_0 has T_16 <= tau, gives E > 12 (continuous function on a compact sphere, so its minimum exceeds 12), a contradiction. The reduction is sound.

## 4. Decomposable regime

With no vertex-1 value among the 16, they are 16 of the 20 values on vertices 2..6, which total 8T (T = 1 - u). The four omitted sum to at most 5T (Gram, q = 4, attained, for example at s_2^2 = 0.8T, others 0.05T), so T_16 >= 3T and T <= tau/3 = 0.153177. Power mean on five angles gives sum s^4 >= (1 - T)^2 + T^2/5. So 16 sum s^4 + T_16 >= 16 - 29T + 19.2T^2, decreasing on [0, 0.755], value 12.0084 at T = tau/3. Confirmed.

## 5. One doubled pair

- 30 values in 15 groups. With D doubled, S single and F free groups, 2D + S = 16 and D + S + F = 15, so D = F + 1. In particular D >= 1 always, and D = 1 forces F = 0, so the case "one doubled pair and none free" is the whole of D = 1.
- A single group contributes its smaller value (s_i - s_j)^2 (if the larger is taken instead, the two are tied). So T_16 = sum_{i<j} (s_i - s_j)^2 + (s_a + s_b)^2 = 6|s|^2 - (sum s)^2 + (s_a + s_b)^2 = s^T(6I - J + vv^T)s.
- On the plane <1, v>: M1 = 2v and Mv = 8v - 2 * 1, so the matrix in basis (1, v) is [[0, -2], [2, 8]], characteristic polynomial lambda^2 - 8 lambda + 4, eigenvalues 4 +- 2 sqrt 3. On the complement M acts as 6. So T_16 >= 4 - 2 sqrt 3 = 0.5359 > tau. Confirmed.

## 6. Small top angle

With D >= 2 (item 5), two distinct doubled pairs cover at least three distinct indices and contribute 2(s_i^2 + s_j^2) each, at least twice the squares of three distinct angles, which is at least s_4^2 + s_5^2 + s_6^2 >= 1 - 3u > 0.31 for u < 0.23. So T_16 >= 0.62 > tau. Confirmed.

## 7. One or two top gaps

- A doubled pair at vertex 1 contributes 2(u + s_j^2) >= 2u >= 0.46 > tau when u >= 0.23 (thin: 2 * 0.23 = 0.46 against 0.45953, but strict). So vertex 1 enters only through single values, and the one taken is the smaller (s_1 - s_j)^2 up to ties.
- One gap: the other 15 are among the 20 on vertices 2..6, sum at least 8T - 6T = 2T. The gap (sqrt u - s_j)^2 is decreasing in s_j <= sqrt u, and s_j <= sqrt(1 - u), so for u > 1/2 it is at least (sqrt u - sqrt(1 - u))^2. Total 3 - 2u - 2 sqrt(u(1-u)), minimised at u = 1/2 + sqrt 2/4 with value 2 - sqrt 2 = 0.5858 > tau. For u <= 1/2 the bound 2(1 - u) >= 1 > tau alone.
- Two gaps: the other 14 sum at least 8T - 7T = T. By convexity of (sqrt u - t)^2 the two gaps are at least 2(sqrt u - mean)^2 with mean <= sqrt((1 - u)/2) <= sqrt u when u >= 1/3. Total 2 - 2 sqrt(2u(1-u)) >= 2 - sqrt 2. For u <= 1/2, T = 1 - u >= 1/2 > tau alone. The prose's condition 1 - u < u is stronger than the two-gap bound needs, so it is valid on its stated range.
- Confirmed.

## 8. Owed statement and coverage

- Coverage: D >= 1 always. D = 1 is item 5 at every u. D >= 2 and u < 0.23 is item 6. D >= 2 and u >= 0.23: vertex 1 is in no doubled pair and carries g single values. g = 0 is item 4, g = 1, 2 are item 7 (valid for any D), and g >= 3 is the Owed case. The split is exhaustive. The Owed case as stated (g >= 3, D >= 2) is a superset of what remains, which is g >= 3, D >= 2, u in [0.23, 0.585).
- u < 0.585: three gaps (sqrt u - s_j)^2 with s_j <= sqrt u and s_j^2 summing to at most 1 - u. By convexity their sum is at least 3(sqrt u - sqrt((1-u)/3))^2 when u >= 1/4, and this is below tau only for u < 0.5843. Confirmed, with 0.585 a valid rounding up.
- Screen figure: a crude random-restart polish over s (150 restarts, structure g >= 3, D >= 2 enforced by penalty) found 0.947 at u = 0.335, (D, g) = (2, 4). This is consistent with the recorded minimum 0.916 (a better optimiser finding a lower value) and far above tau. "twice tau" is slightly off: 2 tau = 0.919 > 0.916. Suggest "about twice tau".

## Screens (screens, not evidence)

Script: scratchpad r1201_screen.py, 22 s under sage python.

- min of 16 sum s^4 + T_16 over T_16 <= tau: 12.169 at s = (0.920, 0.342, 0.096, 0.094, 0.094, 0.093), matching the recorded 12.17.
- Owed structures: min T_16 found 0.947 (recorded 0.916).
- p = 13 (m = 40, T_17 <= 7 - sqrt(5720)/12 = 0.6974): min of 30 sum s^4 + 2 T_17 found 22.15, matching the recorded 22.2 < 24.

## Lean

The file compiles clean (lake env lean, exit 0, no warnings, no sorry). Statement against prose:

- coupled_moment: hypotheses are the averaged per-vector identity (hid, with R0 read as E R_0), the averaged Casimir and row (B), and the moment formula. Conclusion (p+2)E + 2R1 = 2n - 3 Om/p matches the display. The step 2R_1 >= mu_m and the inequality form are prose only, as the table says.
- p14_decomposable: 0 <= T and 3T <= tau give 12 < 16((1-T)^2 + T^2/5) + 3T, exactly the scalar step. The Gram and power-mean inputs are prose.
- one_pair_floor: stated for the pair at the last two coordinates, the general pair following by permutation of coordinates. Matches the eigenvalue claim.
- gap_floor_one: a^2 + b^2 = 1 gives (a - b)^2 + 2b^2 >= 2 - sqrt 2, which is the one-gap bound at a = sqrt u, b = sqrt(1-u).
- gap_floor_two: a^2 + 2c^2 = 1 gives 2(a - c)^2 + 2c^2 >= 2 - sqrt 2, which is the two-gap bound at c = sqrt((1-u)/2), since 2c^2 = 1 - u.
- Both gap theorems hold for all real a, b (c), so they carry no hidden range, and the range conditions of item 7 sit in the prose, where they are correct.
