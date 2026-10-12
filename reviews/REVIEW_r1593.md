# Review r1593: L273 (H on the torus slice of so(2m), m >= 5, from the matrix inequality J1)

Log: agent_logs/r1593.log

Overall: CONFIRMED WITH MINOR GAPS. The lemma's three numbered parts hold as stated. The gaps sit in wording (1) and in the "What it gives" paragraph, where one sentence reads the m >= 5 threshold of the method as a threshold of H on the family.

| claim | verdict | reason in one line |
|---|---|---|
| T1 L273 (1) F <= 3||A|| g + T and g >= 1/sqrt m | CONFIRMED | L271 (1) is F = 3<A, A_mu> + T; tr A_mu = ||U||^2 + ||V||^2 = b^2; equality needs A a NONNEGATIVE multiple of A_mu (wording) |
| T2 L273 (2) lambda_m (1 - g^2) <= Psi_kappa(g) for m >= 5, failing at m = 4 | CONFIRMED | quartic, t0, both relations, all four Taylor coefficients and their signs, the threshold and the m = 4 failure rederived by hand |
| T3 L273 (3) J1 implies H on the torus slice | CONFIRMED | chain valid link by link, b = 0 case correct, no sign assumption on A, P, Q is used |
| T4 What it gives | PLAUSIBLE | both equality cases and the Lagrange form (theta = 2 sqrt(lambda nu)/3, one theta) verified; "nothing else" is unproven; the sentence tying H's threshold to (2) is overstated (screen: H holds locally at the uniform point on the m = 4 slice) |
| LEAN fidelity | CONFIRMED | all six declarations say what the table says; jh_zero's docstring labels itself "L273 (1)" where it is (2) |

## Method

Every step of the written chain was read and rederived by hand from L268, L271 and the givens. Two bounded screens (sage -python, under a minute in total, script in the reviewer's scratchpad) were run and are reported as screens only: (a) the Hessians of T and g^2 on the unit root sphere at the uniform point for m = 4, 5, 6, 8, by central differences; (b) 40 BFGS starts maximising T + lambda_5 g^2 on the root sphere at m = 5. The Lean file was read in full at lines 555-697 and searched for sorry and native_decide (none).

## T1, part (1)

- L271 (2) identifies the idempotent Cartan block as A_mu with (A_mu)_ii = d_i and (A_mu)_ij = -P_ij Q_ij. With the Frobenius pairing on the Cartan block in the orthonormal h_i basis, <A, A_mu> = sum_i A_ii d_i - sum_{i != j} A_ij P_ij Q_ij, so L271 (1) reads F = 3<A, A_mu> + T for every torus-invariant X (L271 (1) places no sign condition on mu). Cauchy-Schwarz gives F <= 3||A|| g + T.
- Equality: Cauchy-Schwarz is an equality exactly when A = s A_mu with s >= 0. "A parallel to A_mu" also admits s < 0, where the inequality is strict. Minor wording repair: "equality for A a nonnegative multiple of A_mu".
- Trace: U^2 + V^2 = (P^2 + Q^2)/2 entrywise, so d_i = (1/2) sum_l (P_il^2 + Q_il^2) and sum_i d_i = (1/2)(||P||^2 + ||Q||^2) = b^2. Cross-check from L268: tr A_mu = 2 sum_alpha mu_alpha^2 ||u_alpha||^2 = 2 sum_{i<j}(U_ij^2 + V_ij^2) = ||U||^2 + ||V||^2. At b = 1, g = ||A_mu|| >= tr A_mu / sqrt m = 1/sqrt m. Also g <= tr A_mu = 1, since A_mu is a sum of PSD rank ones.
- ||X||^2 = ||A||^2 + b^2 (L271 (1)), which (3) uses as 1 + a^2.

## T2, part (2)

- phi(a) = kappa (1 + a^2)^{3/2} - 3 a g has phi'(a) = 3 (kappa a sqrt(1 + a^2) - g). The map a -> a sqrt(1 + a^2) is strictly increasing from 0 to infinity, so phi' is increasing (phi is convex) and has a unique zero, which is the minimiser. For g > 0 it is interior.
- With t = sqrt(1 + a^2): g = kappa t sqrt(t^2 - 1), so g^2 = kappa^2 t^2 (t^2 - 1), and Psi = kappa t^3 - 3 kappa t (t^2 - 1) = kappa t (3 - 2 t^2). Then Psi - lambda (1 - g^2) = lambda kappa^2 t^4 - 2 kappa t^3 - lambda kappa^2 t^2 + 3 kappa t - lambda = h(t). Matches.
- g -> t is a continuous increasing bijection from [0, inf) onto [1, inf), so g >= 1/sqrt m is exactly t >= t0. Proving h >= 0 on all of [t0, inf) covers g in [1/sqrt m, 1] and more, so the range is sufficient.
- t0: t0^2 - 1 = 1/(2(m-1)), and kappa^2 t0^2 (t0^2 - 1) = [4(m-1)^2/(m(2m-1))] [(2m-1)/(2(m-1))] [1/(2(m-1))] = 1/m. kappa t0 = sqrt(2(m-1)/m) and 3 - 2 t0^2 = (m-2)/(m-1), so kappa t0 (3 - 2 t0^2) = sqrt2 (m-2)/sqrt(m(m-1)) = lambda_m (1 - 1/m). So h(t0) = 0.
- Taylor coefficients (checked by differentiating): h' = kappa (2t^2 - 1)(2 lambda kappa t - 3); h''/2 = kappa (6 lambda kappa t^2 - 6t - lambda kappa); h'''/6 = 2 kappa (2 lambda kappa t - 1); h''''/24 = lambda kappa^2. All four match the record.
- Signs: the first and third are immediate. For the second, with x = lambda kappa t0, t0 times the bracket is 6 t0^2 (x - 1) - x >= 3(x - 1) - x = 2x - 3 >= 0 using t0^2 >= 1/2 and x >= 3/2. So all four are nonnegative and h(t0 + u) >= 0 for u >= 0.
- Threshold: lambda kappa t0 = [sqrt(2m)(m-2)/(m-1)^{3/2}] sqrt(2(m-1)/m) = 2(m-2)/(m-1). The condition 2 lambda kappa t0 >= 3 is 4(m-2) >= 3(m-1), i.e. m >= 5.
- m = 4: 2 lambda kappa t0 = 8/3 < 3 and 2 t0^2 - 1 = 4/3 > 0, so h'(t0) < 0 and h < 0 just to the right of t0, i.e. for g just above 1/2. The claimed failure holds.
- Observation (used in T4): to first order in e = g^2 - 1/m, Psi(g) = lambda_m (1 - 1/m) - (3/(2 kappa t0)) e + O(e^2). The factors (2t0^2 - 1) cancel, so the slope is exactly 3/(2 kappa t0), which equals lambda_m at m = 5 and exceeds it at m = 4.

## T3, part (3)

- F and ||X||^3 are both homogeneous of degree 3, so b > 0 reduces to b = 1.
- b = 0 means P = Q = 0, so d = 0, A_mu = 0 and T = 0, giving F = 0. The stated reason also holds: A # A = 0 for A in Sym^2(t), since t is abelian and each rank-one product carries a bracket.
- Chain at b = 1: F <= 3 a g + T by (1); T <= lambda_m (1 - g^2) by J1; lambda_m (1 - g^2) <= Psi_kappa(g) by (2), which applies because (1) gives g >= 1/sqrt m; Psi_kappa(g) <= kappa (1 + a^2)^{3/2} - 3 a g by the definition of the minimum at a = ||A|| >= 0. Summing gives F <= kappa (1 + a^2)^{3/2} = kappa ||X||^3.
- The chain uses no sign of A, P or Q. J1 is required for every (P, Q) on the root sphere, sign-indefinite ones included, and that is how J1 is stated.
- Consistency check: at the uniform point with A a nonnegative multiple of A_mu, every inequality in the chain is tight (h(t0) = 0), so the chain attains kappa. This confirms that L271 (1)'s normalisation agrees with I attaining kappa.

## T4, What it gives

- Uniform point: U = V = mu (J - I) with 2 mu^2 m(m-1) = 1, so P = 2 mu (J - I) and Q = 0. Then d_i = 1/m, A_mu = I/m and g^2 = 1/m. T = 4 mu^3 tr (J - I)^3 = 4 mu^3 m(m-1)(m-2) = sqrt2 (m-2)/sqrt(m(m-1)) = lambda_m (1 - 1/m). This is an equality case.
- Lambda^2_+ edge: P_12 = p and Q_12 = +-p with 2p^2 = 1, all other entries zero. tr P^3 = tr Q^3 = 0, d_1 = d_2 = 1/2 and A_12 = -+1/2, so A_mu = u_alpha u_alpha^T and g = 1. T + lambda g^2 = lambda, so this is an equality case too. Within the two-index family (P_12, Q_12) = (p, q) with p^2 + q^2 = 1, g^2 = 1/2 + 2 p^2 q^2, so equality there holds only at p = +-q.
- Sub-block uniform points (uniform on k < m indices) are strict: J1 there reads f(k) <= f(m) with f(k) = sqrt2 (k-2) sqrt k/(k-1)^{3/2}, and f increases (0, 0.612, 1.089, ... towards sqrt2).
- "nothing else" (the equality set being exactly these two, up to the listed symmetries) is an unproven assertion that rests on the screens. It should either be marked as screened, or be read as describing the edge (the other entries zero) rather than as a classification of the equality set. The images under P <-> Q, Q -> SQS and index permutations should also be named.
- Lagrange equations (derived). Take the variables P_ij, Q_ij for i < j, with b^2 = sum_{i<j}(P_ij^2 + Q_ij^2), g^2 = sum_k d_k^2 + sum_{k != l} P_kl^2 Q_kl^2, and d as above. Then dT/dP_ij = 3 (P^2)_ij, dg^2/dP_ij = 2 P_ij (d_i + d_j + 2 Q_ij^2) and db^2/dP_ij = 2 P_ij. Stationarity gives 3 (P^2)_ij = 2 P_ij (nu - lambda (d_i + d_j + 2 Q_ij^2)), and the Q equation is the same with P and Q exchanged. Rescale (P, Q) = s (P', Q') with lambda s^2 = nu. The result is (P'^2)_ij = theta P'_ij (1 - d'_i - d'_j - 2 Q'^2_ij) with theta = 2 nu/(3s) = (2/3) sqrt(lambda nu), one theta for both equations. theta = 1 is L271 (2)'s system. The record's form is confirmed.
- Caveat to state: the rescaling needs nu > 0. Euler's identity gives 2 nu = 3T + 4 lambda g^2 = 3(T + lambda g^2) + lambda g^2, which is positive at any stationary point with T + lambda g^2 >= 0, in particular at the maximum (value >= lambda). Stationary points with nu <= 0 are not of the stated form, but they are irrelevant to J1.
- Q = 0 reading: J1 at Q = 0 is T_u - T >= lambda_m (g^2 - 1/m), with T_u = lambda_m (1 - 1/m) the maximum of (1/2) tr P^3 over traceless symmetric P of the given norm, attained at J - I. Confirmed.
- Overstatement: "(2) is where the threshold m >= 5 of statement H comes from on this family". (2) is where the METHOD's threshold arises, because the decoupled bound J1 then (2) loses at m = 4. The lemma gives no evidence that H fails on the torus slice at m = 4. Screen (a) supports the opposite reading locally. At the uniform point, on the tangent space of the root sphere, D - r Hg is positive definite (D = -Hess T) for both r = lambda_m and r = 3/(2 kappa t0). The minimum eigenvalues are 1.724 and 1.633 at m = 4, 1.186 and 1.186 at m = 5, 0.888 and 0.930 at m = 6, and 0.579 and 0.648 at m = 8. By the slope observation in T2, r = 3/(2 kappa t0) is exactly the second-order test for H on the slice. So at m = 4 the uniform point is a strict local maximum of F/||X||^3 on the slice (screen, local only). Suggested repair: "(2) is where this route's threshold m >= 5 enters: 4(m-2) >= 3(m-1)", dropping "of statement H".
- Screen (b): at m = 5 the maximum of T + lambda_5 g^2 over 40 BFGS starts was 1.18585412240735 against lambda_5 = 1.18585412256314. It reached lambda and never exceeded it, consistent with the record's screen. This is a screen, not evidence for J1.

## LEAN

- jh is h(t) verbatim.
- jh_mono: hypotheses 0 < kappa, 0 < l, 1/2 <= t0^2, 3 <= 2 l kappa t0, 0 < t0, 0 <= u. It concludes jh t0 <= jh (t0 + u) via the exact Taylor expansion (ring) with the four record coefficients. None of the hypotheses assumes the conclusion, and all are satisfiable at the actual constants (jh_constants).
- jh_threshold: 3 <= 2 (2(m-2)/(m-1)) iff 5 <= m for real m > 1. Faithful.
- jh_zero: the two relations imply jh t0 = 0 for arbitrary reals, with no hidden hypothesis. Its docstring says "L273 (1), the equality point", but the declaration belongs to (2). This is a label slip, cosmetic.
- jh_constants: for real m > 2 the actual kappa, t0 and lambda_m satisfy both relations, lambda kappa t0 = 2(m-2)/(m-1), and t0^2 >= 1/2. Faithful. The statements are about closed-form reals, so no instance is vacuous.
- jh_nonneg: for real m >= 5 and t >= t0 it gives 0 <= jh at the actual constants, assembled from the above. Faithful to "(2) in the variable t". The docstring's "that is lambda_m (1 - g^2) <= Psi_kappa(g)" is the prose substitution, and the record's table and header correctly list that as prose.
- No sorry or native_decide in the file. The m = 4 failure has no declaration. It is a one-line sign fact (8/3 < 3) and could be added as jh_threshold's converse instance if wanted.
