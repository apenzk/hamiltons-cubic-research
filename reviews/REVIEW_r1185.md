# REVIEW r1185: L244's x-free ceiling is strict at n = 12

Log: agent_logs/r1185.log. Footing: analysis only, no computation run.

| Item | Verdict | Note |
|---|---|---|
| 1 | CONFIRMED | From (A), (B): 2 b02 = n-4-3b00-4b01-b11+b22, so K = n-4-4b00-4b01-b11. The b's are sums of squares, so K = n-4 iff all three vanish. `ceiling_equality` states exactly this (row (A) in the summed form b00+b11+b22+2(b01+b02+b12) = n-2) and closes by linarith. |
| 2 | CONFIRMED | b00, b01, b11 vanishing on all of E_0 give [E_0,E_0], [E_0,E_1], [E_1,E_1] orthogonal to E_0. Invariance gives <[E_0,E_1],E_1> = ±<E_0,[E_1,E_1]> = 0 and <[E_0,E_0],E_1> = ±<E_0,[E_0,E_1]> = 0, so both brackets lie in E_2. The sign of invariance is irrelevant to orthogonality. |
| 3 | CONFIRMED | ad_x maps the (p+m)-space E_0+E_1 into the p-space E_2, so the kernel has dimension at least m and sits in c(x). |
| 4 | CONFIRMED | 49/(2p) >= 220/144 iff p <= 16, so m >= 34. c(x) = sum u(k_i) + so(z) with sum k_i = r, z = 12-2r, and sum k_i^2 <= r^2. The best case per rank is r=1: 46, r=2: 32, r=3: 24, r=4: 22, r=5: 26, r=6: 36. Only rank 2 (46) and six equal angles (36) reach 34, and every other type is at most 32 (the maximum is two equal angles, 4+28). |
| 5 | CONFIRMED | Suppose V holds a decomposable d and a J with J^2 = -I. For small t != 0, J+td is invertible, so it is not rank 2, so (J+td)^2 = -c(t) I. Then (Jd+dJ) + t d^2 is a multiple of I for two distinct small t, and subtracting shows d^2 is a multiple of I. But d^2 has rank 2 in dimension 12, a contradiction. The two single-type cases are classical: a linear space of decomposable bivectors is a star or lies in Lambda^2 R^3, and a space of skew x with x^2 = -q(x) I (q a form by polarisation) is a Clifford module of dimension at most rho(12)-1 = 3. |
| 6 | CONFIRMED, reason repaired | The cap p <= 3 is correct. L246's corollary excludes stars on the symmetric family. As written, though, the incompatibility at p <= 3 rests on "far above every critical value on record", which is empirical. L244's own per-vector caps prove it. For unit x, -ad_x^2 has eigenvalues (lambda_k ± lambda_l)^2 or lambda_k^2, each at most 2 because sum lambda_i^2 = 1, so kappa_r(x) <= 2r. The edge needs K = n-4 = 8 <= kappa_{p-1}(x) <= 2(p-1), which forces p >= 5 and so excludes p <= 3 outright. The E_2 cap gives the same result: 10 <= kappa_p <= 2p. |
| 7 | PLAUSIBLE, scope repair | The edge does force the structure at EVERY unit x in E_0, because K = theta/a+1 does not depend on x. The chain, however, proves strictness only for 5 <= p <= 16, the range where the edge is at or above theta_0(12). For 17 <= p <= 33 it proves nothing: m <= 32, and equal-angle rank-4 x already has dim c = 32. The unqualified headline "never attained at n = 12" should read "never attained at n = 12 with p <= 16, the only range where the x-free edge reaches theta_0(12)". For p >= 17 the edge already lies below theta_0(12) (`p17_excluded`), so the programme's use is unaffected. |

## Repairs proposed

- Item 6: replace "far above every critical value on record" with the kappa-cap argument, kappa_r(x) <= 2r, so the edge needs p >= (n-2)/2 = 5. This removes the empirical appeal, and the Hurwitz-Radon step then only needs p <= 3 < 5.
- Item 7: restrict the headline to p <= 16, or state that p >= 17 is excluded above theta_0 by `p17_excluded` and that strictness there is not claimed.
