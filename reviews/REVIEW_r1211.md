# Review r1211: Batch 16 of the I73 class-ceiling log (symmetric three-value family, internal-mass cap)

Log: [agent_logs/r1211.log](../agent_logs/r1211.log). Object: [the class-ceiling note](2026-09-26-I73-class-ceiling.md), section "Batch 16", Steps 1 to 5. Givens: [L244](../findings/second-order.md) and the record normalisation.

| claim | verdict |
|---|---|
| C1 operator identity | CONFIRMED |
| C2 per-vector rows | CONFIRMED |
| C3 mass floor and theta cap | CONFIRMED, one wording repair |
| C4 M = 8 tr Z^3, theta <= 4 | CONFIRMED |
| C5 sharp target, subalgebra values, record search | CONFIRMED with a scope repair and a missing citation |
| C6 Lean | CONFIRMED |

## C1

W = a(P2 - P0), so W^2 = a^2 Pi and W# = a^2(P0#P0 + P2#P2 - 2 P0#P2). Criticality over a^2 gives 2 P0#P2 = Pi + P0#P0 + P2#P2 - (theta/a)(P2 - P0). Substituting into Pi#Pi = P0#P0 + P2#P2 + 2 P0#P2 gives 2(P0#P0 + P2#P2) + (1 + theta/a) P0 + (1 - theta/a) P2, which is the stated identity with K = 1 + theta/a. At x in E0 it returns L244's row (C), 2b02 - b00 - b22 = K. At x in E2 it gives b00 + b22 - 2b02 = K - 2, which is row (C) at E2 (lambda_c = a: a^2(b00 + b22 - 2b02) = a(theta - a)).

## C2

By L244's formula and ad-invariance, 2<(Pi#Pi)x,x> = sum over gamma, delta in V of <[x,psi_delta],psi_gamma>^2 = ||P_V ad_x P_V||_HS^2. The four blocks give A_x + D_x + ||P0 ad_x P2||^2 + ||P2 ad_x P0||^2, and the two off-diagonal blocks are equal because ad_x is skew, so the total is A_x + D_x + 2B_x. At E0: A + D + 2B = 2(A + D) + 2K >= 2K. At E2: 2B = A + D + 4 - 2K, and B >= 0 gives A + D >= 2(K - 2), hence A + D + 2B >= 2K - 4. The step uses B_x >= 0 at E2, which the text leaves implicit behind "so".

## C3

M(V) is the sum over an orthonormal basis adapted to E0 + E2 of ||P_V ad_x P_V||^2, so M >= p(2K) + p(2K - 4) = 4p(K - 1) = 4p theta sqrt(2p) = 2 d^{3/2} theta. No inequality is reversed. In class totals the chain is exact: rows (C) summed read 2S - X - U = 2pK and 2U - S - Y = 2p(2 - K), their sum is S + U - X - Y = 4p (the stated consistency identity), and eliminating S and Y gives M = X + Y + 3S + 3U = 4p(K - 1) + 2X + 6U, so the floor is attained exactly when X = U = 0.

Wording repair: the trivial cap M <= 2d(n - 2) (from tr(-ad_x^2) = 2(n - 2)) gives theta <= (n - 2)/sqrt(2p). The text calls that "L244's theta <= (n-2)/sqrt(2p)", while L244's bound is (n - 5)/sqrt(2p). It should read "L244's theta <= (n-5)/sqrt(2p) up to an additive constant in the numerator".

## C4

Record-orthonormal psi_i = sqrt2 U_i with U_i Frobenius-orthonormal. For skew matrices tr(vuw) = -tr(uvw), so <[u,v],w>_rec = (1/2) tr([u,v]^T w) = -tr(uvw). Then tr(psi_i psi_j psi_k)^2 = 8 tr(U_i U_j U_k)^2, and tr((sum U_i x U_i)^3) = sum tr(U_i U_j U_k)^2. So M = 8 tr Z^3 and the factor 8 is right. tr Z = sum (tr U_i)^2 = 0 and tr Z^2 = sum tr(U_i U_j)^2 = d. Z is real symmetric (U_i^T x U_i^T = Z), so sum lambda^3 <= (sum lambda^2)^{3/2} applies and M <= 8 d^{3/2}, theta <= 4.

At V = so(n), Z = (1/2) sum over a != b of (E_ab x E_ab - E_ab x E_ba) = (G - SWAP)/2. Its eigenvalues are (n-1)/2 on Omega, -1/2 on the rest of the symmetric tensors and +1/2 on the antisymmetric ones. That gives tr Z = 0, tr Z^2 = N and 8 tr Z^3 = (n-1)^3 - (n-1) = n(n-1)(n-2) = 2N(n-2), which matches M(so(n)) = N * 2(n-2).

Screen (seconds, pure Python, [r1211_screen.py] in the reviewer scratchpad): M and 8 tr Z^3 agree to 10 digits on random subspaces of so(5) (d = 4, 7) and so(6) (d = 5), with tr Z = 0 and tr Z^2 = d. At so(4), so(5), so(6) both equal 24, 60, 120.

Remark: tr Z = 0 sharpens the power-mean step to a constant (D-2)/sqrt(D(D-1)) below 1, D = n^2. That changes nothing material.

## C5

The whole-algebra value is 2N(n-2)/(2N^{3/2}) = sqrt2 (n-2)/sqrt(n(n-1)). The ratio of squares to theta0(n)^2 is n(n-2)/(n-1)^2 < 1 at every n. Values at n = 12: so(12) 1.23091 against theta0(12) = 1.23603, so(10) 1.1926, Lambda^2_+ 1.1547 (M = 12, screened).

Scope repair: su(m) in so(2m) has M = 2m(m^2 - 1) (Killing form of su(m) is m times the vector-rep trace form of so(2m)), so the value is m/sqrt(m^2 - 1): 1.1547 at m = 2, 1.0607 at m = 3, 1.0328 at m = 4 (screened). "At most 1.0607" holds for m >= 3. The m = 2 case is su(2) = Lambda^2_+, listed separately, so the text should say m >= 3.

Record search (object, not vocabulary). The internal bracket mass tau000 + 3 tau002 + 3 tau022 + tau222 of V0 + V2 is already on the record in [L242's realisability paragraph](../findings/bounds-relaxations.md), which uses the Dynkin cap 240 for a 24-dimensional subalgebra (su(5), matching 2m(m^2 - 1) at m = 5). That paragraph names the missing ingredient as "a cap on the bracket mass a k-dimensional subspace holds", and batch 16 supplies the reduction to it. The reduction theta <= M(V)/(2 d^{3/2}) and the cubic-trace form are not found in findings/. The total subspace mass mu = sum ||[e_a,e_b]||^2 of [isotropy-cap.md](../findings/isotropy-cap.md) is a different object (whole bracket, not its projection to V). Batch 16 should cite L242's paragraph as the first appearance of the object.

## C6

[I73InternalMass.lean](../lean/HamiltonsCubic/Results/I73InternalMass.lean) compiles. The three declarations depend on propext, Classical.choice and Quot.sound only. mass_ge_of_rows takes exactly the two summed rows (checked against L244's rows traced over E0 and E2, with S = T002, U = T022) and X, U >= 0, which are the hypotheses the derivation uses. The non-vacuity example checks out (2*7/2 - 0 - 1 = 6, 2 - 7/2 - 1/2 = -2). sum_cube_le is correct for signed reals. theta_le_four's floor 4p(theta r) is 4p(K - 1) with r = sqrt(2p), and its cap 8(2p)r is 8 d^{3/2}. The header states what is untyped (the operator identity, the rows, the class-total reading, M = 8 tr Z^3). Nothing is hidden.
