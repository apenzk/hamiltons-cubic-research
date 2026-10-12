# REVIEW r1210: Batch 16 of the I73 class ceiling (internal-mass cap)

Log: agent_logs/r1210.log. Object: Steps 1 to 5 of "## Batch 16" in reviews/2026-09-26-I73-class-ceiling.md, and lean/HamiltonsCubic/Results/I73InternalMass.lean.

| claim | verdict |
|---|---|
| C1 Step 1 operator identity | CONFIRMED |
| C2 Step 2 per-vector rows | CONFIRMED |
| C3 Step 3 M(V) >= 4p(K-1) | CONFIRMED, provenance note |
| C4 Step 4 M = 8 tr Z^3, theta <= 4 | CONFIRMED |
| C5 Step 5 values and record search | CONFIRMED with two repairs (one sub-sentence REFUTED as worded) |
| C6 Lean | CONFIRMED |

## C1

W = a(P2 - P0) gives W^2 = a^2 Pi and, by bilinearity and symmetry of #, W^# = a^2(P0#P0 + P2#P2 - 2 P0#P2) = a^2(2(P0#P0 + P2#P2) - Pi#Pi). Criticality divided by a^2 reads Pi + 2(P0#P0 + P2#P2) - Pi#Pi = (theta/a)(P2 - P0), which rearranges to Pi#Pi = 2(P0#P0 + P2#P2) + (1 + theta/a) P0 + (1 - theta/a) P2, and 1 - theta/a = 2 - K. Paired with x in E0 it returns the given row (C), 2b02 - b00 - b22 = K. Sign convention (E0 negative) agrees with L244 (ii).

## C2

By L244's formula and ad-invariance, <[x,psi_g],psi_d> = <[psi_g,psi_d],x>, so ||P_V ad_x P_V||^2 = sum over g,d in V of <[psi_g,psi_d],x>^2 = 2<(Pi#Pi)x,x>. A_x = 2b00, D_x = 2b22, B_x = 2b02, and P2 ad_x P0 has the norm of P0 ad_x P2 since ad_x is skew, so the total is A + D + 2B. At E0: A + D + 2B = 2(A + D) + 2K >= 2K. At E2: 2B = A + D + 4 - 2K, B >= 0 gives A + D >= 2(K - 2), and the total is >= 2K - 4. All directions correct.

## C3

Summing p vectors of E0 and p of E2: M >= 2pK + p(2K - 4) = 4p(K - 1) = 4p theta sqrt(2p), and 4p sqrt(2p) = 2 d^{3/2}. No reversed inequality. The trivial cap M <= d * 2(n-2) (Casimir 2(n-2) in record units, L244 row (A)) returns (n-2)/sqrt(2p) exactly.

Provenance. Traced over E0 and E2, the Step 1 identity is exact: 2S - X - U = 2pK and 2U - S - Y = 2p(2 - K) (ordered class totals X = T000, Y = T222, S = T002, U = T022), hence 4p(K - 1) = 3S - 3U + Y - X, which is the formula theta = (3 tau002 - 3 tau022 + tau222 - tau000)/(4p sqrt(2p)) already on the record at reviews/2026-09-25-LIT-step9-sweep-round2.md line 27 (R38's line). With M = X + Y + 3S + 3U (on the record at findings/bounds-relaxations.md line 605, L242's section), M - 4p(K - 1) = 2X + 6U >= 0. So Step 3 is that formula with 2 tau000 + 6 tau022 dropped, a class-level consequence (the summed row (C) is a row of post F76's system). Batch 14 of the same note states the S <= M(F) form. The batch should cite the R38 formula as the source of Step 3. The new content of batch 16 is Step 4.

## C4

Record units: <[u,v],w> = (1/2) tr([u,v]^T w) = -(1/2) tr([u,v] w), and tr(vuw) = -tr(uvw) for skew matrices, so <[u,v],w> = -tr(uvw). A record-unit psi has Frobenius norm sqrt2, so psi = sqrt2 U and <[psi_i,psi_j],psi_k>^2 = 8 tr(U_i U_j U_k)^2. tr((sum U_i (x) U_i)^3) = sum_ijk tr(U_i U_j U_k)^2, so M = 8 tr Z^3: the factor 8 is right. tr Z = sum (tr U_i)^2 = 0, tr Z^2 = sum tr(U_i U_j)^2 = sum delta_ij = d. Z is symmetric (U^T (x) U^T = U (x) U), so tr Z^3 <= (tr Z^2)^{3/2} = d^{3/2} and theta <= 8 d^{3/2}/(2 d^{3/2}) = 4. At V = so(n): Z = (1/2)(G - SWAP), eigenvalues (n-1)/2 once, +1/2 on the antisymmetric square, -1/2 on the rest of the symmetric square, tr Z^3 = (n-1)((n-1)^2 - 1)/8, so 8 tr Z^3 = n(n-1)(n-2) = 2N(n-2). Screen (seconds, scratchpad script): M_record = 8 tr Z^3, tr Z = 0, tr Z^2 = d reproduced on random subspaces of so(5), so(6), so(7) to 1e-15, and the so(n) spectrum at n = 4, 5, 6.

## C5

Whole algebra: 2N(n-2)/(2N^{3/2}) = (n-2)/sqrt(N) = sqrt2 (n-2)/sqrt(n(n-1)). Squared ratio to theta0(n)^2 = 2(n-1)(n-2)/n^2 is n(n-2)/(n-1)^2 < 1. At n = 12: 1.2309 against 1.23603. so(10): 720/(2*45^{1.5}) = 1.1926. Lambda^2_+: structure constants sqrt2 in record units, M = 12, 1.1547 (hand computation). The "open statement" tr Z^3 < (theta0/4) d^{3/2} is equivalent to M/(2d^{3/2}) < theta0.

Repair 1 (REFUTED as worded). "su(m) in so(2m) at most 1.0607" is false at m = 2, where su(2) is Lambda^2_+ (or Lambda^2_-) and gives 1.1547. Screen: su(m) has M = 2dm, d = m^2 - 1, ratio m/sqrt(m^2 - 1): 1.1547, 1.0607, 1.0328, 1.0206, 1.0142 at m = 2..6. Correct wording: "su(m) in so(2m), m >= 3, at most 1.0607 (at m = 3)".

Repair 2. The reduction of Step 3 is on the record under the class-trace name (see C3). Record search for the object (tau000 + 3tau002 + 3tau022 + tau222, internal bracket mass, realignment, cubic trace of sum U_i (x) U_i) in findings/: the mass expression appears only at bounds-relaxations.md:605 (L242's non-realisability), and the cubic-trace identity and the theta <= 4 corollary appear nowhere in findings/. L243's Gaussian cap bounds the total bracket out of V (c free), a different object.

## C6

Compiled with lake env lean in 7 s, no errors, warnings or sorry. mass_ge_of_rows: hypotheses are the exact traced rows (checked above), conclusion 4p(K-1) <= M, needs only X, U >= 0, matches 2X + 6U >= 0. sum_cube_le: sum x^3 <= (sum x^2) sqrt(sum x^2), proved termwise via |x_i| <= sqrt(sum x^2), correct. theta_le_four: r = sqrt(2p), d^{3/2} = 2p r, floor 4p theta r <= M and cap M <= 16 p r give theta <= 4. The non-vacuity example checks (2*3.5 - 0 - 1 = 6, 2 - 3.5 - 0.5 = -2). The header's NOT-stated list (operator identity, per-vector rows, class reading, M = 8 tr Z^3) is accurate, and the stated rows are the ordered-sum totals it names. Nothing hidden.
