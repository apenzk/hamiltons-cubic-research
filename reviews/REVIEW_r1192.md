# Review r1192: p = 16 excluded at n = 12 on the symmetric family

Log: agent_logs/r1192.log. Brief: Gate 2 brief 1191/1192, claim from reviews/2026-09-25-I73c-per-vector-rows.md. Analysis-only footing; item 7 is a seconds-scale screen.

| # | Item | Verdict |
|---|---|---|
| 1 | Connectivity | CONFIRMED |
| 2 | Step B | CONFIRMED |
| 3 | Label count T <= (5/4) mu_34 | CONFIRMED |
| 4 | Sphere average | CONFIRMED |
| 5 | L246 at r = 1 and the numbers | CONFIRMED |
| 6 | Conclusion | CONFIRMED |
| 7 | Screen of the label count | CONFIRMED (screen) |

## 1. Connectivity

- The s_i are the singular values of x (each of multiplicity two), and sorted singular values are 1-Lipschitz in the operator norm (Weyl), so s_2 and s_1 - s_6 are continuous on the unit sphere of E_0 and both sets are closed.
- Disjoint: both conditions give s_6 <= s_2 <= 2 eps and s_1 <= 4 eps, so sum s^2 <= 16/60 + 5 * 4/60 = 0.6 < 1 (the claim's 0.516^2 + 5 * 0.258^2 is the same bound).
- Cover: r1189 gives the strict versions, which lie inside the closed ones. S^15 is connected, so one closed set is empty.

## 2. Step B

- Near-complex: s_1 >= 1/sqrt 6 = 0.408, so s_6 >= 0.408 - 0.258 = 0.150 > 0, and x (eigenvalues +- i s_k) is invertible.
- Singular element: for a subspace V of so(12), x -> x e_1 maps V into e_1-perp (dimension 11), so dim V >= 12 already gives a nonzero x with x e_1 = 0. dim E_0 = 16. (Adams' Radon-Hurwitz bound rho(12) = 4 is far stronger; the elementary count suffices.)

## 3. Label count

- mu_34 = six zeros plus the 28 smallest of the 30 labels doubled = 2 * sum14, sum14 the 14 smallest labels. mu_34 < 1/60 puts every chosen label below 1/120.
- s_2 <= 0.258 gives s_1^2 = 1 - T >= 1 - 5/15 = 2/3, (s_1 - s_2)^2 >= (0.8165 - 0.2582)^2 = 0.3117, while every label on {2..6} is at most (2 s_2)^2 <= 0.267: the 14 smallest labels lie among the 20 on {2..6}.
- Full pairs: with k pairs having both labels chosen, 2k + (10 - k) >= 14 gives k >= 4. Three vertices carry only three edges, so four edges cover at least four of the five indices, and the full pairs contribute 2 sum over covered indices of s_i^2 >= 2(T - s_2^2) (the uncovered index has s^2 <= s_2^2).
- Index 2: the labels avoiding index 2 are the 12 on {3..6}, so at least two chosen labels involve 2, each >= (s_2 - s_3)^2 > s_2^2/4 when s_3 < s_2/2, giving sum14 >= s_2^2/2. Otherwise T - s_2^2 >= s_3^2 >= s_2^2/4.
- Case split: max(2(T - u), u/2) >= 2T/5 (equality at u = 4T/5); in the other case u <= 4T/5 gives 2(T - u) >= 2T/5. So mu_34 >= (4/5) T. Matches `label_count`.

## 4. Sphere average

- E c_a c_b c_c c_d = (d_ab d_cd + d_ac d_bd + d_ad d_bc)/(p(p+2)). The first and third pairings give tr((sum psi_a^2)^2) = tr A_0^2 each (A_0 = sum psi^T psi = -sum psi^2; the third by cyclicity), the second gives sum tr(psi_a psi_b psi_a psi_b).
- For skew X, Y: ||[X,Y]||_F^2 = -tr([X,Y]^2) = 2 tr(X^2 Y^2) - 2 tr(XYXY), so the identity holds and sum tr(psi_a psi_b psi_a psi_b) <= tr A_0^2. With p(p+2) = 288 the bound is 3 tr A_0^2 / 288.
- tr x^4 = 2 sum s_i^4 >= 2 s_1^4 = 2(1 - T)^2, with T < (5/4)(1/60) = 1/48.

## 5. L246 and the numbers

- Weyl gives sum_c A_c = 11 I and sum_c lambda_c A_c = 0; at (-a, 0, a) this is A_2 = A_0 (r = 1), so beta = 2 alpha and beta_j <= sum_{i != j} min(1, beta_i) reads alpha_j <= sum_{i != j} min(1/2, alpha_i) <= 11/2.
- A_0 is PSD with tr A_0 = 2p = 32 (basis elements have (1/2)tr norm 1, so tr psi^T psi = 2), so tr A_0^2 <= 5.5 * 32 = 176.
- Demanded: tr A_0^2 > 192 (47/48)^2 = 2209/12 = 184.08. Contradiction. Matches `p16_near_dec_contradiction`.

## 6. Conclusion

- Dichotomy: some unit x with mu_34 >= 1/60 gives kappa <= 7 - 1/120 by L249, and (839/120)^2/32 = 1.52761 < 220/144 = 1.52778 (`p16_below_theta0`; theta < 0 is trivially below). Otherwise items 1 to 5 give a contradiction. No gap.
- The closing clause "confined to p <= 15" additionally rests on L244 for p >= 17, which this brief does not examine.

## 7. Screen (seconds, reported as a screen)

- Label formula for mu_34 agreed with the direct 66 x 66 spectrum of -ad_x^2 at three random unit x to 1e-15.
- 200000 random and near-degenerate angle vectors plus a grid over (support size, s_2, s_3/s_2), all with s_2 <= 0.2582: minimum mu_34 / T = 3.26, against the needed 0.8. The inequality holds with a wide margin.
