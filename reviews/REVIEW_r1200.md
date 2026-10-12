# REVIEW r1200: p = 14 at n = 12, the coupled average and its dichotomy

Claim: the paragraph "p=14 at n=12: a coupled average, and the dichotomy it needs" in [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md) through its Owed sentence, and [CoupledMoment.lean](../lean/HamiltonsCubic/Results/CoupledMoment.lean).

Log: [agent_logs/r1200.log](../agent_logs/r1200.log)

Footing: analysis only. The figures below marked "screen" come from a pure-Python random local search in the scratchpad (seconds each) and are reported as screens, never as evidence for a positive claim.

| item | claim | verdict |
|---|---|---|
| 1 | averaging steps | CONFIRMED |
| 2 | R_0 relation, coupled identity, 2R_1 >= mu_m | CONFIRMED |
| 3 | p = 14 reduction | CONFIRMED |
| 4 | decomposable regime 12.008 | CONFIRMED |
| 5 | one doubled pair | CONFIRMED |
| 6 | small top angle | CONFIRMED |
| 7 | one or two top gaps, and vertex 1 in no doubled pair at u >= 0.23 | CONFIRMED |
| 8 | Owed statement and coverage | PLAUSIBLE (coverage and u < 0.585 confirmed, the screen figure unreproduced and its "twice tau" loose) |
| Lean | statement match | CONFIRMED |

## Item 1

E over the unit sphere of E_0 of x (x) x is (1/p) sum_a psi_a (x) psi_a, so E(-x^2) = A_0/p and, x wedge x being quadratic in x, E(x wedge x) = Omega_0/p. Averaging the per-vector identity: E tr(-x^2 A_0) = tr A_0^2 / p and E<x wedge x, Omega_0> = ||Omega_0||^2/p, so tr A_0^2 = 2p + 2p E R_0 - ||Omega_0||^2. Normalisation check at p = 1 (E_0 = span psi): the per-vector identity reads tr x^4 = 2 - ||x wedge x||^2 with ||x wedge x||^2 = (12 (tr x^2)^2 - 24 tr x^4)/24 = 2 - tr x^4, and L251's formula reads 3 tr x^4 = 2 tr x^4 + 2 - (2 - tr x^4). Both hold, so the two formulas use the same norm on Omega_0.

## Item 2

The Casimir sum is tr(-ad_x^2) on so(12) = 2(n-2) at unit x, so R_0 + R_1 + R_2 = n - 2. With R_2 = R_0 + 1, 2R_0 + 1 + R_1 = n - 2, R_0 = (n - 3 - R_1)/2. Only averages of the two relations enter, so row (B) needs only to hold on average. Substituting: p(p+2) E tr x^4 = 2(2p + p(n - 3 - E R_1) - Omega) + 2p - Omega = 2pn - 2p E R_1 - 3 Omega, and division by p gives the coupled identity. 2R_1(x) = sum over orthonormal e in E_1 of <-ad_x^2 e, e> = tr(P_{E_1}(-ad_x^2)), ad_x being skew for the invariant form, and Ky Fan gives the trace of a compression to the m-dimensional E_1 at least mu_m(x). With Omega >= 0, E[(p+2) tr x^4 + mu_m] <= 2n. The p = 15 remark (17 E tr x^4 <= 24 - E mu_36, no cap on A_0) follows.

## Item 3

theta >= sqrt(220)/12 gives kappa = theta sqrt(28) >= sqrt(6160)/12 = 4 sqrt(385)/12 = sqrt(385)/3 ~ 6.54047. L249 at m = 38: (1/2) mu_38 <= 7 - kappa <= tau ~ 0.45953. The spectrum of -ad_x^2 is six zeros and the 30 values twice each, so the 38 smallest are the zeros and the 16 smallest values twice: mu_38 = 2 T_16. At p = 14, (p+2) tr x^4 + mu_38 = 32 sum s^4 + 2 T_16, so the average bound is E[16 sum s^4 + T_16] <= 12. A continuous function exceeding 12 at every point of the compact sphere has average above 12, so the pointwise statement on {T_16 <= tau} suffices. Screen: min of 16 sum s^4 + T_16 on T_16 <= tau is 12.173 at s ~ (0.921, 0.342, 0.099, 0.096, 0.092, 0.091), matching the record's 12.17.

## Item 4

With no vertex-1 value among the 16, they are 16 of the 20 values on vertices 2..6, whose total is sum over pairs of 2(s_i^2 + s_j^2) = 8T, T = 1 - u. The omitted four sum to at most 5T (Gram, q = 4), so T_16 >= 3T and T <= tau/3 ~ 0.153177. Power mean gives sum s^4 >= (1-T)^2 + T^2/5, and 16((1-T)^2 + T^2/5) + 3T = 16 - 29T + 19.2T^2, decreasing up to T = 0.755, is 12.0084 at T = tau/3. Correct, thin margin as stated.

## Item 5

With D doubled groups, F free and S single among the 15 groups: 2D + S = 16 and D + S + F = 15 give D = F + 1. At D = 1, F = 0 every other group contributes one value, which in a 16-smallest selection is the smaller (s_i - s_j)^2 up to ties, so T_16 = sum_{i<j}(s_i - s_j)^2 + (s_a + s_b)^2 = 6 - (sum s)^2 + (s_a + s_b)^2. On span(1, v): M1 = 2v and Mv = -2*1 + 8v, the matrix [[0,-2],[2,8]], characteristic polynomial lambda^2 - 8 lambda + 4, eigenvalues 4 +- 2 sqrt 3. On the orthogonal complement M = 6. So lambda_min = 4 - 2 sqrt 3 ~ 0.536 > tau. Screen: at D = 1, g = 5 the least T_16 found is 0.569, consistent.

## Item 6

Two distinct doubled groups contribute 2(s_i^2 + s_j^2) + 2(s_k^2 + s_l^2) over at least three distinct indices, at least twice the sum of three distinct squares, which is at least s_4^2 + s_5^2 + s_6^2 >= 1 - 3u > 0.31 at u < 0.23. T_16 > 0.62 > tau. Correct for every D >= 2 and every g.

## Item 7

A doubled group (1, j) costs 2(u + s_j^2) >= 0.46 > tau at u >= 0.23 (margin 0.0005). So vertex 1 contributes only single values, each at least its gap d_1j. One gap: the other 15 are 15 of the 20 on vertices 2..6, omitted five at most 6T, so at least 2T. At u >= 1/2, s_j <= sqrt(1-u) <= sqrt(u) gives d_1j >= (sqrt u - sqrt(1-u))^2, and the sum expands to 3 - 2u - 2 sqrt(u(1-u)), the quadratic form [[1,-1],[-1,3]] on a^2 + b^2 = 1, least eigenvalue 2 - sqrt 2 ~ 0.586. At u < 1/2, 2T > 1 > tau. Two gaps: the other 14 give at least 8T - 7T = T. The two gaps sum to 2a^2 + r - 2(s_j + s_k) >= 2a^2 + r - 2 sqrt(2r) with r = s_j^2 + s_k^2 <= 1 - u, decreasing in r on r < 2, so at least 2(sqrt u - sqrt((1-u)/2))^2. This bound holds at every u, no range restriction needed. The sum is 2 - 2 sqrt(2u(1-u)) >= 2 - sqrt 2. Both bounds correct as stated.

## Item 8

Coverage. D = F + 1 >= 1 always. D = 1 is item 5 at every u and g. D >= 2 with u < 0.23 is item 6. At u >= 0.23 vertex 1 carries g single gap values: g = 0 is item 4, g = 1, 2 is item 7 at every D. What remains is u >= 0.23, g >= 3, D >= 2, which is the Owed case. The partition is exhaustive. Two sharpenings the statement could carry: it lives at u >= 0.23, and the count F >= 5 - g gives D >= 6 - g, so g = 3 forces D >= 3.

u < 0.585. Three gaps with r = s_j^2 + s_k^2 + s_l^2 <= 1 - u sum to at least 3a^2 + r - 2 sqrt(3r) >= 3(sqrt u - sqrt((1-u)/3))^2 (decreasing in r on r < 3). Below tau needs sqrt u - sqrt((1-u)/3) < sqrt(tau/3) = 0.39138, which fails from u ~ 0.5836 up (at u = 0.585 the three gaps sum to 0.4632 > tau). So u < 0.5836 < 0.585. CONFIRMED.

Screen figure 0.916. My screen (random starts filtered to the Owed structures with the 16-smallest selection, u >= 0.23, 10146 feasible starts, 60 refined) finds 0.947 at s ~ (0.578, 0.454, 0.454, 0.347, 0.347, 0.115), structure g = 4, D = 2, and per structure (g, D) = (3,3) 1.18, (3,4) 1.26, (3,5) 1.17, (4,2) 0.970, (4,3) 1.008 from plain sampling. The record's 0.916 is lower than any value I found, which is consistent with a stronger optimiser, but I could not reproduce it, and no script for the 12.17, 0.916 or 22.2 screens is in [scripts/misc/](../scripts/misc/). Either way the case sits about 0.46 above tau. "twice tau" is loose: 2 tau = 0.919 > 0.916, so "about twice tau".

p = 13 remark. At p = 13, m = 40, tau_13 = 7 - sqrt(5720)/12 ~ 0.6974 and mu_40 = 2 T_17. Screen: min of 30 sum s^4 + 2 T_17 on T_17 <= tau_13 is 22.16 at s ~ (0.909, 0.245, 0.239, 0.239, 0.008, 0.002). Matches 22.2 < 24.

## Lean

`lake env lean HamiltonsCubic/Results/CoupledMoment.lean` exits 0 with no output. The file has no sorry and is imported at [HamiltonsCubic.lean:626](../lean/HamiltonsCubic.lean#L626).

- coupled_moment: hypotheses are the averaged identity (with R0 standing for E R_0), the averaged Casimir and row (B), and L251's formula. The conclusion is the prose identity. The inequality with mu_m and Omega >= 0 is by hand, as the prose says.
- p14_decomposable: only the final scalar step on 0 <= T <= tau/3. The Gram step and the power-mean step are by hand. Matches its prose use.
- one_pair_floor: the pair placed at (e, f), which is general by the permutation symmetry of 6I - J. Holds for all real s, as used.
- gap_floor_one, gap_floor_two: a = sqrt u, b = sqrt(1-u), c = sqrt((1-u)/2) satisfy the constraints, and the conclusions are the prose bounds.

## Most serious finding

No defect in the proved chain. The weakest points are provenance and wording in the Owed sentence: the screened minimum 0.916 is unreproduced here (I find 0.947 as an upper estimate) and has no script on disk, and "twice tau" should read "about twice tau" (2 tau = 0.919). The decomposable margin (12.008) and the no-doubled-pair margin at vertex 1 (0.46 against 0.4595) are both thin but correct.
