# REVIEW r1925: I124 batches 3 to 5, the circle direction's coupling

Log: [agent_logs/r1925-i124-coupling.log](../agent_logs/r1925-i124-coupling.log). Note under review: [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md). Screen script (seconds, n = 4, a screen and never evidence): scratchpad `r1925/screen.py`.

**Verdict: every identity of batches 3 to 5 is CONFIRMED link by link, and none of it is new: batch 4's two rows are [L284](../findings/second-order.md)'s steps (3) and (4) at z = -w_c, and batch 5's decoupled case is L284's C = 0, already on record as the outside author's closed algebra in the [I121 note](2026-09-28-I121-MG-audit.md) (line 63). Two corrections: the q = 0 range in batch 5, and the frame dependence of "the decoupled case is where I124 must consume theta >= theta_0".**

| # | claim | verdict |
|---|---|---|
| 1 | Batch 3: u in D-perp, u perp W and w_c, T(W,w_c,u) = -&#124;u&#124;^2, the 2x2 form, h_c, the criterion | CONFIRMED (û needs u != 0) |
| 2 | Batch 4: rows -(a/b)<R,x> and -<u,y>, decomposition, sufficiency, bound on h_c | CONFIRMED, and it is L284 in circle coordinates |
| 3 | Batch 5: R = u = 0 iff A critical and nu an eigenvector, closure, pi_D and pi_perp of nu o nu | CONFIRMED, and it is L284's C = 0, on record |
| 4 | Padded W_CP2 screen claim | CONFIRMED by hand and by an independent screen |
| 5 | Circle with q = 0, L24 | CONFIRMED formulas, with the range stated too narrowly. The "must consume theta_0" sentence PLAUSIBLE only in a maximal frame |
| 6 | Record search | ON RECORD: L284, the I121 note, r1801's endpoint criterion, the 28h sweep |

## 1. Batch 3: CONFIRMED

- u in D-perp: for x in D, <A o nu, x> = <A o x, nu> = 0 since A o x in D (D o D in D) and nu perp D. u = A o nu - r nu is perp nu by the choice of r, perp A since in D-perp, hence perp W = aA + b nu and w_c = a nu - b A.
- D-perp component of W o W = theta W: a^2 A o A lies in D, 2ab A o nu lies in D-perp, so 2ab A o nu + b^2 pi_perp(nu o nu) = theta b nu. Correct. Pairing with u and using <A o nu, u> = |u|^2, <nu, u> = 0: b <nu o nu, u> = -2a |u|^2. Correct.
- <W o nu, u> = a|u|^2 - 2a|u|^2 = -a|u|^2, and <W o A, u> = a<Q(A), u> + b|u|^2 = b|u|^2 (Q(A) in D). Then T(W, w_c, u) = a(-a|u|^2) - b(b|u|^2) = -|u|^2. Every link holds. It agrees with the given row T(W,w_c,y) = -<A o nu, y> at y = u.
- Normalisation of h_c: the circle phi -> cos phi A + sin phi nu has unit tangent (-b, a) at W, which is w_c, so its second derivative there is 6(T(W,w_c,w_c) - theta/2) = 3E, and T(W,w_c,w_c) - theta/2 = E/2 = (2ap - theta(1+a^2))/(2b^2). The note's h_c is the right entry of the form v -> T(W,v,v) - (theta/2)|v|^2, the same form whose off-diagonal entry is T(W,w_c,û) = -|u|. h_c < 0 above Theta_n follows from batch 1 (b^2 E <= -theta(1-a)^2 < 0 at a < 1, p <= Theta_n <= theta by L57).
- Criterion: for [[h_c, -m], [-m, h_u]] with h_c < 0, a positive eigenvalue exists iff h_u > 0 or det < 0, and both are h_u > -m^2/|h_c|. An exact iff, strict at equality. Condition: u != 0 for û to exist, which the statement should carry.
- Screen (n = 4, W_CP2 in a random frame, a = 0.439): T(W,w_c,u) = -|u|^2 and T(W,w_c,w_c) - theta/2 = h_c agree to 1e-16.
- Minor: u lies in nu's characters only (L_A commutes with the sign group), so the mixing in the 2x2 test comes from w_c's trivial-character component. The "What it gives" sentence reads that way already.

## 2. Batch 4: CONFIRMED, and it is L284 restated

- R = Q(A) - pA lies in D (Q(A) in D) and is perp A since <Q(A), A> = p.
- Direct row: W o w_c = (a^2 - b^2) A o nu + ab(nu o nu - A o A), the r1918 form. On x in D minus A: the D component a^2 Q(A) + b^2 pi_D(nu o nu) = theta a A gives <nu o nu, x> = -(a^2/b^2)<R, x>, so T(W,w_c,x) = ab(-(a^2/b^2) - 1)<R, x> = -(a/b)<R, x>. On y in D-perp minus nu: <nu o nu, y> = -(2a/b)<A o nu, y>, so T = (a^2 - b^2 - 2a^2)<A o nu, y> = -<u, y>. Both rows correct, and equal to r1916's (b/a)<Q(nu), x>.
- Decomposition: R̂ in D minus A, û in D-perp minus nu, mutually orthogonal and orthogonal to w_c, with V their complement in W-perp. The row vanishes on V. Correct when R, u != 0 (otherwise drop the zero one). A positive eigenvalue on any subspace gives v with positive second variation, so the sufficiency holds. It is a sufficient test only, since R̂ and û also couple to V.
- h_c bound: -theta(1-a)^2/(2b^2) = -theta(1-a)/(2(1+a)) using b^2 = (1-a)(1+a). Correct, and it tends to 0 as a -> 1.
- **On record, [L284](../findings/second-order.md) (Gate 2 r1793, r1794, Lean `identity_86`).** With t = a: L284's z = (A/t - tW)/b = bÂ - a nu = -w_c. Its operator U = (1/2)I + (1/2)W (x) W - rho^{-1} L_W is -rho^{-1} times the second-variation operator on W-perp, so rho C is w_c's second-variation row with its w_c-component removed, and eta = -h_c/theta. Steps (3)-(4) give rho pi_D C = -q_perp/(tb) and rho pi_U C = -(Y_U + (lambda_U - lambda-bar)B_U)/(tb). With q_perp = a^2 R and sum_U (Y_U + (lambda_U - lambda-bar) B_U) = ab u, these are exactly batch 4's -(a/b)R and -u, and L284's identity is |row|^2 = (a/b)^2|R|^2 + |u|^2. So "couples to exactly two directions" is L284's three orthogonal defects with Y_U and lambda_U - lambda-bar merged into u. **The note should cite L284. What it adds is the reading of C as w_c's second-variation row and the resulting 2x2 and 3x3 ascent tests.** Also L284's "eta >= 0 is L214's inequality" is batch 1's h_c <= 0.

## 3. Batch 5 equivalence and closure: CONFIRMED, on record

- R = 0 is Q(A) = pA, which is criticality of A on the sphere (Q(A) = lambda A forces lambda = p). u = 0 is A o nu = r nu, and the eigenvalue of an eigenvector nu is necessarily <A o nu, nu> = r. Both directions are immediate.
- pi_D(nu o nu) = (theta a - a^2 p) A / b^2 = r A by theta a = a^2 p + b^2 r, and pi_perp(nu o nu) = (theta - 2ar) nu / b = q nu by theta b = 2abr + b^2 q. So span{A, nu} is closed, P on it is the circle cubic, and W is its critical point.
- **On record**: the [I121 note](2026-09-28-I121-MG-audit.md), line 63, "What C = 0 is, from L284": e diagonal critical, f one eigenvector of L_e with eigenvalue tau, f o f = tau e + q f, the outside author's closed algebra of Conjecture 27.1. Batch 5 is that paragraph in the note's letters (e = A, f = nu, d = p, tau = r).

## 4. Padded W_CP2: CONFIRMED by hand and by screen

- By hand, through W = W+ + W- at n = 4, where P is additive over the two halves: W_CP2 = (x, 0) with x the top of the cubic on W+ (value f). The coordinate-diagonal part of 2 w1 w1^T - w2 w2^T - w3 w3^T is (1 on 12 and 34, -1/2 on the other four), so pi_D W has half the norm squared: a = b = 1/sqrt2, A = (x, y)/sqrt2 with y the matching top of W-, nu = (x, -y)/sqrt2, which is off-diagonal (w1 w1^T minus its anti-self-dual partner is e12 e34^T + e34 e12^T). Then p = f/sqrt2, q = (f - f)/(2 sqrt2) = 0, A o nu = (1/2)(f x, -f y) = p nu, so r = p and u = 0. A is critical since both halves are critical with equal weight, so R = 0, and theta = f = sqrt2 p. S^2 x S^2's Weyl tensor is diag(1,0,0,0,0,1) - 1/3, proportional to (2,-1,-1,-1,-1,2) in lexicographic pair order, as the note says. Theta_4 = sqrt(2*3*2)/4 = sqrt3/2 (problem.md line 582).
- Screen, independent code from definitions (I#I = 2I checked, Weyl space of dimension 10): theta = 1.224745, a = b = 0.707107, p = r = 0.866025, q = 0, |R| = 7e-16, |u| = 1e-15.
- **Addition, the coordinate frame is special.** In a random frame the same W_CP2 has a = 0.439, p = 0.865, r = 0.459, q = 0.914, |R| = 0.041, |u| = 0.38, and the 3x3 form on span{w_c, R̂, û} has eigenvalues (-1.62, -0.57, -0.29). Hand reason: with Kähler direction eta in Lambda+, |pi_D W|^2 is proportional to sum (eta_i^2 - 1/3)^2, maximal (a^2 = 1/2) exactly when eta is a coordinate form, and A is non-critical for generic eta. The decoupled frames of W_CP2 at n = 4 are its maximal frames.

## 5. Circle with q = 0, and L24: formulas CONFIRMED, one range and one sentence corrected

- With q = 0 the derivative of p c^3 + 3r c s^2 is 3s(c^2(2r - p) - r s^2), so interior critical points have a^2 (3r - p) = r, a^2 = r/(3r - p), and theta b = 2abr gives theta = 2ar, consistent with theta a = a^2 p + b^2 r. At r = p: a^2 = 1/2, theta = sqrt2 p = sqrt(3/2) at p = sqrt3/2. All correct.
- a^2 > 1 iff p > 2r when 3r > p, so p/3 < r < p/2 has no interior point. Correct but **too narrow**: for 0 < r <= p/3 there is none either (a^2 < 0 or no solution), r = 0 gives a = 0 and r = p/2 gives a = 1, both excluded. For r < 0 an interior point exists with a^2 = |r|/(3|r| + p) in (0, 1/3) and theta = 2ar < 0, which batch 2's r >= a theta/(1+a) > 0 excludes. The statement should read: with q = 0 and r > 0, an interior critical point exists iff r > p/2. That is the q = 0 case of the binary endpoint criterion on record ([r1801](REVIEW_r1801.md), I121 note line 110: the closed branch's maximum is d iff d q^2 <= (d + tau)^2 (d - 2 tau)).
- L24: at a local maximum of P on the whole sphere of W_n, the second variation 6(<A o v, v> - p/2) <= 0 gives L_A <= p/2 off A. Correct, with "diagonal local maximum" meaning a local maximum on the full sphere that happens to be diagonal. Then r <= p/2 and, with q = 0, no decoupled W sits over it. The decoupled A of W_CP2 has r = p, so S^2 x S^2 is a saddle, consistent.
- **"So the decoupled case is where I124 must consume theta >= theta_0": PLAUSIBLE only for a maximal frame.** Padded W_CP2 is a local maximum below theta_0 at n >= 12 (theta_0(12) = 1.236 > 1.2247, on record in [R54](../routes.md) and the [28h sweep](2026-09-28h-LIT-step8-sweep.md)), so it has no ascent direction in any frame. Batches 3 and 4 are stated "in any frame", and in a generic frame W_CP2 is coupled (item 4), so a frame-by-frame argument must also consume theta >= theta_0 in the coupled case. The sentence holds once the frame is fixed as one maximising the diagonal norm, where W_CP2 is decoupled at n = 4 (for padded W_CP2 at n >= 12 the maximal frame was not checked here). The note should either fix the maximal frame or drop "is where".

## 6. Record search: batches 3 to 5 are on record

- Batches 3 and 4: [L284](../findings/second-order.md) (line 1419), steps (3)-(4), as mapped in section 2. The note cites L214 and r1916/r1918 and omits L284.
- Batch 5's equivalence and closure: the [I121 note](2026-09-28-I121-MG-audit.md) line 63 (L284's C = 0 is the author's closed algebra, Conjecture 27.1), with the closed-branch scalar analysis at lines 86 to 123.
- Batch 5's circle analysis at q = 0: the binary endpoint criterion of [r1801](REVIEW_r1801.md), recorded in [R54](../routes.md) as "(MG) is p >= 2r and p q^2 <= (p + r)^2 (p - 2r)".
- W_CP2's frame split: the [28h sweep](2026-09-28h-LIT-step8-sweep.md) line 7 records its diagonal part as padded S^2 x S^2's with t^2 = 1/2, and R54 records it as a local maximum below theta_0. Its decoupling (R = u = 0) is written nowhere I found, and is immediate from the W+/W- split.
- New in the note: the second-variation reading (h_c = -theta eta, the row of w_c equal to rho C) and the 2x2 and 3x3 ascent criteria built on it.
