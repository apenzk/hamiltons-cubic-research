# REVIEW r1191: p = 16 excluded at n = 12 on the symmetric family

Log: agent_logs/r1191.log. Brief: the Gate 2 brief on the claim in reviews/2026-09-25-I73c-per-vector-rows.md (line 223). Analysis-only footing, one seconds-scale screen reported as a screen.

| Item | Verdict |
|---|---|
| 1 Connectivity | CONFIRMED |
| 2 Step B | CONFIRMED |
| 3 Label count | CONFIRMED |
| 4 Sphere average | CONFIRMED |
| 5 L246 numbers | CONFIRMED |
| 6 Conclusion | CONFIRMED |
| 7 Screen | CONFIRMED (a screen) |

## 1. Connectivity

- The sorted angles s_1 >= ... >= s_6 of a skew x are its singular values (each doubled), and sorted singular values are 1-Lipschitz in the operator norm (Weyl), so both sets are closed in the unit 15-sphere of E_0.
- Disjoint: both conditions give s_2..s_6 <= 2 eps and s_1 <= s_6 + 2 eps <= 4 eps, so sum s^2 <= 16 eps^2 + 5 * 4 eps^2 = 36/60 = 0.6 < 1.
- Cover: r1189's characterisation gives the strict form under mu_34 < 1/60 at every x. A connected space covered by two disjoint closed sets lies in one of them.
- Cosmetic: 2 eps = 0.2582, and the claim writes 0.258 (rounded down). Every downstream number survives with 0.2582: s_1^2 >= 1 - 5(0.2582)^2 = 0.6667, (s_1 - s_2)^2 >= 0.3117.

## 2. Step B

- Near a complex structure: s_1 >= 1/sqrt 6 = 0.408, so s_6 >= 0.408 - 0.258 > 0.15, and x is invertible.
- A subspace V of so(12) with dim V > 12: for a fixed v != 0, x -> xv maps V to R^12 with a kernel, so some x != 0 is singular. dim E_0 = 16 > 12. (Adams's bound gives the sharper dim <= rho(12) - 1 = 3, not needed.)

## 3. Label count

- mu_34 = 6 zeros + the 28 smallest of 30 labels doubled = 2 * (sum of the 14 smallest labels), so each chosen label is < delta/2.
- None involves s_1: every label with index 1 is >= (s_1 - s_2)^2 >= 0.31. Every label on {2..6} is <= (2 * 0.2582)^2 = 0.267 < 0.31. So the 14 chosen lie among the 20 on {2..6} even without using delta/2.
- Full pairs: 14 labels in 10 pairs fill at least 4 pairs. Four edges span at least 4 vertices (3 vertices hold only 3 edges). A full pair sums to 2(s_i^2 + s_j^2), and the four covered indices carry at least T minus the largest, s_2^2. So sum14 >= 2(T - s_2^2).
- Index 2: labels avoiding 2 on {3..6} number 12, so at least 2 chosen labels contain index 2. Each is >= (s_2 - s_3)^2 > s_2^2/4 when s_3 < s_2/2. Otherwise T - s_2^2 >= s_3^2 >= s_2^2/4.
- Case split: max(2(T - u), u/2) >= 2T/5 (minimum at u = 4T/5), and T - u >= u/4 gives 2(T - u) >= 2T/5. So mu_34 >= (4/5) T, T <= (5/4) mu_34 < 1/48. `label_count` types exactly this split with the two bounds used separately (no double counting).

## 4. Sphere average

- For c uniform on S^{p-1}, E c_a c_b c_c c_d = (d_ab d_cd + d_ac d_bd + d_ad d_bc)/(p(p+2)). The three pairings give tr S^2, sum tr(psi_a psi_b psi_a psi_b), tr S^2 with S = sum psi_a^2 = -A_0 (psi skew, so psi^T psi = -psi^2).
- For skew X, Y, [X,Y] is skew, so ||[X,Y]||_F^2 = -tr([X,Y]^2) = 2 tr(X^2 Y^2) - 2 tr(XYXY). Hence sum_{a,b} tr(psi_a psi_b psi_a psi_b) <= tr S^2 = tr A_0^2, and E tr x^4 <= 3 tr A_0^2 / 288.
- Normalisation: unit in (1/2) tr gives sum s^2 = 1 and tr x^4 = 2 sum s^4 (checked numerically below).

## 5. Numbers and L246

- tr A_0 = sum tr(psi^T psi) = 2p = 32.
- At (-a, 0, a), Ric(W) = 0 gives A_2 = A_0 (r = 1), and L246's lambda_1 = 0 form gives alpha_j <= 11 * (1/2) = 5.5. Independently, sum_c A_c = 11 I gives A_1 = 11 I - 2 A_0 >= 0, the same cap (L245's h_0 = (n-1)/2), so this step does not even need L246.
- tr A_0^2 <= 5.5 * 32 = 176. From tr x^4 > 2(47/48)^2 at every unit x: tr A_0^2 >= 96 * 2 * (47/48)^2 = 184.08. Contradiction. `p16_near_dec_contradiction` types this.

## 6. Conclusion

- Dichotomy: some unit x in E_0 has mu_34 >= 1/60, so L249 gives kappa <= 7 - 1/120 and `p16_below_theta0` gives theta < theta_0(12) (703921/460800 = 1.52761 < 220/144 = 1.52778, a thin but strict margin). Otherwise the chain above is contradictory. No gap.
- The closing clause on p >= 17 uses L244's x-free theta <= 7/sqrt(2p), 49/34 < 220/144 (line 316 of the note). Correct.

## 7. Screen (a screen, evidence only against the label count)

- scratchpad screen1191.py, 200000 random and adversarial angle vectors with s_2 <= 2/sqrt 60, then local refinement: min mu_34/T = 3.2554, against the needed 0.8. The 5/4 constant is loose by a factor of about 4.
- The spectrum of -ad_x^2 on so(12), built from the full 66 x 66 matrix at three random conjugated x, matches {0^6, labels doubled} to 3e-15.
- For a random 16-dimensional subspace, Monte Carlo E tr x^4 = 0.6862 against the formula's 0.6859 and the bound 0.9383, with tr A_0 = 32.
