# REVIEW r1184: L244 x-free ceiling strict at n = 12

Log: agent_logs/r1184.log

| Item | Verdict | Note |
|---|---|---|
| 1 | CONFIRMED | Row (A) minus 2x(B)-substitution gives K = n-4-4b00-4b01-b11 by hand; `ceiling_equality` states exactly this with b00, b01, b11 >= 0 and proves it by linarith. |
| 2 | CONFIRMED | b_ab(x) = 0 for all unit x in E_0 gives [E_0,E_0], [E_0,E_1], [E_1,E_1] orthogonal to E_0. Invariance: <[E_0,E_1],E_1> = +-<E_0,[E_1,E_1]> = 0, so [E_0,E_1] lies in E_2; <[E_0,E_0],E_1> = +-<E_0,[E_0,E_1]> = 0, so [E_0,E_0] lies in E_2. Uses E_0+E_1+E_2 = so(n). |
| 3 | CONFIRMED | Rank-nullity: ad_x from dimension p+m into dimension p has kernel of dimension >= m, contained in c(x). |
| 4 | CONFIRMED | 49/(2p) >= 220/144 iff p <= 16.03, so m >= 34. dim c(x) = sum k_i^2 + C(z,2) over angle multiplicities k_i and kernel z. Full enumeration over all 20 types (a seconds screen, also done by hand): top values 46 (rank 2), 36 (six equal angles), 32 (angle multiplicity 2, z = 8), 30, 26, ... Only two types reach 34. The claim's "(one repeated angle)" wording is loose, the numbers are right. |
| 5 | CONFIRMED | Suppose V holds a decomposable d and a complex-type J (J^2 = -I). Every J + t d has rank >= 12 - 2 = 10 > 2, so is complex type: (J+td)^2 = scalar I for every t. Two distinct nonzero t give d^2 = scalar I, false since d^2 has rank 2. So V is one type. All-complex: x^2 = -(|x|^2/6) I polarises to anticommuting complex structures after orthonormalising, a Cl_p module on R^12, p <= rho(12) - 1 = 3. All-decomposable: classical, e ^ U or inside Lambda^2 R^3. The claim's own parenthetical ("small rank-two perturbation") is correct but the rank argument above works for every t and is the cleaner proof. |
| 6 | PLAUSIBLE | p <= 3 cap is right (stars excluded by L246 Corollary on the symmetric family at every p; Lambda^2 R^3 gives p <= 3; Hurwitz-Radon gives 3). The incompatibility step rests on "far above every critical value on record", an appeal to the record rather than an argument. Repair from L244 itself: K <= kappa_{p-1}(x), and every eigenvalue of -ad_x^2 at unit x is at most (t_i + t_j)^2 <= 2, so K <= 2(p-1) <= 4 < 8 = n-4. The edge K = n-4 is unreachable at p <= 3, analytically. |
| 7 | CONFIRMED | K = theta/a + 1 is x-independent, so theta = (n-5)/sqrt(2p) forces K = n-4 at every unit x in E_0, which is the hypothesis of item 2. Conclusion: at n = 12 no symmetric three-value critical point with theta >= theta_0(12) sits at theta = 7/sqrt(2p) exactly. Scope note: "strict" means non-attainment only; it gives no quantitative inward move of the edge. |

## Summary

The chain holds. One repair: replace the item 6 appeal to "every critical value on record" by the cap K <= kappa_{p-1}(x) <= 2(p-1) <= 4 < 8.
