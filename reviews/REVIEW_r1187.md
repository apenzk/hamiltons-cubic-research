# REVIEW r1187: quantitative per-vector ceiling, kappa <= n - 5 - mu_m(x)/2

Log: agent_logs/r1187.log. Brief: Gate 2, analysis-only footing, one seconds-scale screen on constructed objects.

| Item | Verdict | Reason |
|---|---|---|
| 1 | CONFIRMED | Sum over ordered pairs (gamma, delta) in h x h of <[x,psi_gamma],psi_delta>^2 = <x,[psi_gamma,psi_delta]>^2 by invariance. E_0 x E_0 gives 2 b00, E_0 x E_1 and E_1 x E_0 give 2 b01 each, E_1 x E_1 gives 2 b11. Frobenius norm is taken in the orthonormal basis of <X,Y> = (1/2)tr(X^T Y). Screen matched to 1e-9. |
| 2 | CONFIRMED | A = (P_0+P_1)A + P_2 A, and P_2 A has range in E_2 of dimension p, so Eckart-Young gives sum_{i>p} sigma_i(A)^2 <= ||A - P_2 A||_F^2. |
| 3 | CONFIRMED | A = ad_x composed with the isometric inclusion of h; A^T A is the compression of ad_x^T ad_x to h, codimension p, so Cauchy interlacing gives sigma_{p+j}(A) >= sigma_{2p+j}(ad_x). Since 2p+m = N these are the m smallest; ad_x is skew for the invariant form, so ad_x^T ad_x = -ad_x^2. |
| 4 | CONFIRMED | b00, b01 >= 0 as sums of squares; L244 (ii)'s row (A) identity K = (n-4) - 4b00 - 4b01 - b11 holds at every unit x in E_0 with K = kappa + 1. mu_m is continuous on the compact unit sphere of E_0, so the max is attained. |
| 5 | CONFIRMED (novelty, strengthening); REFUTED (star remark as stated) | mu_m, Eckart-Young and bottom-singular-value interlacing appear nowhere in findings/; L244's per-vector caps use the TOP sums kappa_r. The bound strictly improves L244's x-free kappa <= n-5 wherever some x in E_0 has dim c(x) < m. The remark "stars, whose elements are decomposable with mu_m = 0" holds only for p >= n-2. A unit decomposable x has -ad_x^2 spectrum {0 (mult 1+(n-2)(n-3)/2), 1 (mult 2(n-2))}, so mu_m(x) = max(0, 2(n-2-p)); a star e_1 ^ U with p = dim U < n-2 gets the margin kappa <= p - 3. Screen at n=12: mu_m = 4, 2, 0, 0 at p = 8, 9, 10, 11. The (8,50,8) star cited in second-order.md's star-isotropy lemma (line 343) is such a case. |

**Repair.** Replace the star sentence with: "It gives no margin at stars with p >= n-2, whose decomposable elements have mu_m = 0 (those are L246's); a star with p < n-2 has mu_m = 2(n-2-p) at every element and the ceiling reads kappa <= p-3 there."

**Screen (seconds).** 2(b00+2b01+b11) - mu_m >= 1.18 on 150 random orthonormal splits at (n,p) = (5,3), (6,5), (6,4), (7,6), (8,4). A screen of the linear-algebra step only, not evidence for critical points.

**Lean.** Agree with the brief: none of 1-4 is typable without singular values of ad_x in the layer.
