# REVIEW r1834: the rotated-product witness for the small-mass node of (MG), I121

Brief: [BRIEF_I121_witness.md](BRIEF_I121_witness.md). Log: [agent_logs/r1834-i121-witness.log](../agent_logs/r1834-i121-witness.log). Scripts (screens, seconds each): [witness_diag_ratio.py](../scripts/reviewers/r1834/witness_diag_ratio.py), [witness_single_plane.py](../scripts/reviewers/r1834/witness_single_plane.py).

**Verdict: the witness and its hand proof stand. Two corrections: the stated alpha and beta are the unit tensor only up to scale, and "at other angles the pair part is nonzero" fails at the angles 0 and pi/2. "What it settles" needs its reach stated: it bites only at n >= 12, only against strict bounds, and only at t^2 = 1/n.**

| # | claim | verdict |
|---|---|---|
| 1 | the rotated operator's form and the values of alpha, beta | CONFIRMED with a scale correction |
| 2 | the diagonal entries and t^2 = 1/n | CONFIRMED |
| 3 | the pair entries vanish | CONFIRMED, with a correction to the companion sentence on other angles |
| 4 | what it settles | PLAUSIBLE, reach corrected |
| 5 | the inverse matching rotation restores t = 1 | CONFIRMED (immediate) |

## 1. The operator form

- The curvature operator of the unit S^m x S^m is the identity on the two within-factor blocks and zero on the mixed block. Removing the Ricci part with Ric = m-1 on each factor, s = 2m(m-1), n-2 = 2(m-1), gives within-factor entries 2m(m-1)/N and mixed entries -2(m-1)^2/N. The ratio alpha : beta = m : -(m-1) is the brief's, and the Ricci contraction (m-1)alpha + m beta = 0 checks Weylness.
- **Correction.** With alpha = m(m-1)/N and beta = -(m-1)^2/N the squared norm is m(m-1)alpha^2 + m^2 beta^2 = m^2(m-1)/(4(2m-1)), which is 12/7, 25/9, 45/11 at n = 8, 10, 12 (confirmed in the screen). So e is the stated operator divided by this norm. Every quantity the brief draws (t^2, the vanishing of the pair part) is scale-free, so nothing downstream moves, but the sentence should say "proportional to" or carry the normaliser.
- The rewriting as beta I + (alpha - beta)(Pi_{Lambda^2 P'} + Pi_{Lambda^2 Q''}) is only the identity I = Pi_{Lambda^2 P'} + Pi_{Lambda^2 Q''} + Pi_{P' tensor Q''}. The identity term alone is not Weyl, the sum is, and Weylness of g.e follows from O(n)-invariance of W_n. The identity term matters for nothing except the bookkeeping that off-diagonal entries of I vanish.

## 2. The diagonal and t^2

- Pi_{Lambda^2 P'} = Lambda^2 pi_{P'}, so its matrix entry at (a,c; b,d) is the 2 x 2 Gram determinant of pi_{P'} on the frame. With the matching as given, <pi_{P'} e_a, e_b> = K_ab / 2 and <pi_{Q''} e_a, e_b> = sigma_a sigma_b K_ab / 2, K_ab = delta_{k(a)k(b)}. The combined entry is (1/4)(1 + sigma_a sigma_b sigma_c sigma_d)(K_ab K_cd - K_ad K_cb).
- At (a,c; a,c) this is (1 - K_ac)/2, so the entry of g.e is beta on the m matching pairs and beta + (alpha - beta)/2 = (alpha + beta)/2 = (m-1)/(2N) elsewhere. Confirmed.
- Arithmetic, in units of (m-1)^2/N^2: numerator m(m-1)^2 + (m(2m-1) - m)/4 = m(m-1)(m - 1/2), denominator m^3(m-1) + m^2(m-1)^2 = m^2(m-1)(2m-1). The ratio is (m - 1/2)/(m(2m-1)) = 1/(2m) = 1/n. Confirmed by hand and by the screen at n = 8, 10, 12.

## 3. The pair part

- At (a,c; b,c) with a, b, c distinct the identity contributes zero and the formula gives (alpha - beta)(1/4)(1 + sigma_a sigma_b)(K_ab - K_ac K_cb), the brief's expression. If K_ab = 1 then {a,b} = {p_k, q_k} and sigma_a sigma_b = -1. If K_ab = 0 then K_ac K_cb = 1 would force k(a) = k(c) = k(b). So it vanishes in every case. Confirmed.
- **Correction to "at other angles the pair part is nonzero".** At a common angle theta the entry at (p_k, c; q_k, c) with c = p_l, l != k, is cos(theta) sin(theta)(cos^2 theta - sin^2 theta), which also vanishes at theta = 0 and pi/2, where the object is the product itself with t = 1. The same computation with independent angles theta_k shows more: for m >= 2 the matching rotation is pair-free exactly when every theta_k lies in {0, pi/2} mod pi (a product frame) or every theta_k is an odd multiple of pi/4 (the witness up to signs). A mixed choice, one plane rotated and the rest not, is never pair-free.

## 4. What it settles

- **Reach in n.** The witness has rho = P = theta_0(n), and theta_0(n) > sqrt(3/2) exactly when n >= 12 among balanced products (by the closed form, 2/(m-1) - 1/(2m-1) < 1/3 iff m >= 6, and theta_0(10) = 1.2 < 1.2247). At n = 8, 10 it is covered by the sqrt(3/2) branch of (MG) in any frame and threatens no threshold-form bound. The conclusion should be stated for n >= 12.
- **Reach in the bound's form.** The witness attains theta_0, so it refutes bounds of the form "critical, pair-free, t^2 <= 1/n implies value < theta_0" or "implies theta <= sqrt(3/2)" at n >= 12. It is consistent with any bound "value <= theta_0" at small t, which is Conjecture A itself, so it rules out a strict separation, not a non-strict one.
- **Reach in t.** It sits at t^2 = 1/n exactly. It says nothing about t^2 < 1/n. The brief's "small diagonal mass" should read "diagonal mass down to 1/n", and the four-set target of the plan (t^2 much less than 1/n) is untouched by this object.
- **The (MG) inequality in the witness frame.** The diagonal part A is itself Weyl (Ricci only reads diagonal entries, which sum to zero at each vertex, confirmed to 1e-16), and the screen gives P(A)/|A|^3 = -0.540, -0.474, -0.428 at n = 8, 10, 12. So at n = 12 the witness frame violates (MG)'s inequality: rho = 1.236033 > max{1.224745, -0.428}. (MG) therefore survives only through its frame hypothesis, which is the brief's "what excludes it is the maximal frame". Confirmed at n = 12, vacuous at n = 8, 10.
- **"Must see multi-plane rotations".** Screened at n = 8: from the witness frame no single coordinate-plane rotation (361 angles per plane, all 28 planes) raises t^2 above 1/8, the gradient of t^2 over so(8) is zero, and its Hessian is negative semidefinite with 16 null directions, 12 of them the stabiliser so(4) + so(4) of the rotated tensor. So the witness frame is a second-order stationary point of t, invisible to first- and second-order frame conditions and to every one-plane finite rotation. This supports the claim. Strict local maximality is undecided (4 non-orbit null directions) and was not pursued.
- "The screen's near-rotated product at t = 0.3 was this object's neighbour" is consistent with 12^{-1/2} = 0.2887, but I did not reopen the n = 12 screen. PLAUSIBLE.

## 5. The inverse matching rotation

- Applying g^{-1} returns the product frame, where e is diagonal, so t = 1 and P(A)/|A|^3 = theta_0, and (MG) holds with equality. Immediate. The phrase "the finite-angle inequality" names no inequality that the record states for multi-plane rotations. What is shown is only that the witness frame is not t-maximal, since t = 1 is available.
