# Review r1177: Lean statements of L247's band and slice against the record

Log: agent_logs/r1177.log. Footing: analysis only; one seconds-scale Lean check of a constructed witness (a screen).

| # | Lean | Verdict |
|---|---|---|
| 1 | `Rows` | CONFIRMED |
| 2 | `rows_trace_ceiling`, `band_empty` | CONFIRMED |
| 3 | none (F78 prose) | CONFIRMED |
| 4 | `slice_ceiling`, `slice_needs_rho_gt_one`, `fires_l1_zero` | CONFIRMED |

## 1. Rows

Tracing L244 (i) over an orthonormal basis of E_c turns b_ab(x) into t_abc and the right sides into (n-2)p_c, -l_c p_c, l_c(theta - l_c)p_c. At l = (-a,0,a): (A_c) is the sum over (a,b) of t_abc, matching lines 1-3 after total symmetry. (B_c)/a is sum_a (t_a2c - t_a0c) = -(l_c/a) p_c, giving t012+t022-t000-t001 = p, t112+t122-t001-t011 = 0, t122+t222-t002-t012 = -p (lines 4-6). (C_c)/a^2 is t00c - 2t02c + t22c = l_c(theta-l_c)/a^2 p_c, i.e. -(kappa+1)p, 0, (kappa-1)p (lines 7-9). All nine match.

## 2. Ceiling and nonnegativity

(A_0) - 2(B_0) + (C_0) gives 4t000 + 4t001 + t011 = (n-5-kappa)p. The record defines b_ab(x) = 1/2 sum <[psi_g,psi_d],x>^2 >= 0 for every pair (a,b), so B_ab >= 0 and t_abc = tr(P_c B_ab) >= 0 for all indices, including t000, t001, t011. L244 (ii)'s proof has K = kappa+1 = (n-4) - 4b00 - 4b01 - b11 per unit x in E_0; summed over a basis of E_0 this is exactly rows_trace_ceiling. So band_empty is L244's x-free ceiling traced.

## 3. F78

D_neg_of_kappa needs n-5 < kappa. band_empty's hypotheses (Rows, p > 0, t000, t001, t011 >= 0) hold at every symmetric three-value critical point, and it gives kappa <= n-5. L247's setting is critical points on this family only, so its hypothesis is met nowhere there. The inference is sound. The claim concerns the sufficient condition only: D < 0 at some critical point with kappa <= n-5 is not excluded by the rows, and F78 says no more than that.

## 4. Slice

slice_ceiling's h0, h1, h2 equal general_identity's h0, h1, h2 with l1 = 0 after the vanishing l1 terms are dropped. Directly re-derived, they are the traced rows (A_0), (B_0), (C_0). In fires_l1_zero, `key` (kernel-checked, = -1 times general_identity at l1 = 0) shows that at l1 = 0 the constant is theta l0 l2 (n-1) p0 Q = -theta a b (n-1) p0 Q. That is a negative multiple of Q when l0 < 0 < l2, theta > 0, n > 1, p0 > 0, so const < 0 iff Q > 0. slice_needs_rho_gt_one uses the same Q polynomial word for word.

Non-vacuity witness, all hypotheses of slice_needs_rho_gt_one: l0 = -2, l2 = 1, theta = 2, n = 15, p0 = 1, t000 = 0, t001 = 0, t002 = 2, t011 = 1, t012 = 4, t022 = 0. Then Q = 8 > 0, the ceiling reads 1 = 1, l0^2 = 4 > 1, and all six traces are nonnegative. fires_l1_zero's conclusion also holds numerically at this point (2 < 8). Checked by elaborating `slice_needs_rho_gt_one 0 0 2 1 4 0 (-2) 1 2 15 1` with norm_num discharges against the built library (a screen, exit clean). The witness is E_0 rows only, so it is not claimed to be a critical point.
