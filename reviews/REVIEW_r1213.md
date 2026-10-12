# REVIEW r1213: Batch 17 of the I73 class ceiling (subalgebra cap)

Object: section "## Batch 17" of [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md), read verbatim. Log: [agent_logs/r1213.log](../agent_logs/r1213.log). Analysis-only footing: every number below was derived by hand; the scripts run were second-scale screens on objects built for this review.

| claim | verdict |
|---|---|
| C1 Casimir formula | CONFIRMED |
| C2 index table | PLAUSIBLE, one false sentence, numbers correct |
| C3 conclusion | CONFIRMED (given C1, C2 as repaired) |
| C4 complement identity | CONFIRMED |
| C5 general-cap facts | (1) CONFIRMED, (2) REFUTED as worded, (3) REFUTED in its second half |
| C6 Lean | CONFIRMED |

## C1, the Casimir formula: CONFIRMED

- For x in a simple ideal h_i, ad-invariance of the ambient form gives sum_y ||[x,y]||^2 = -sum_y <[x,[x,y]],y> = -B_{h_i}(x,x). The other ideals and the centre are killed by ad_x.
- With -B = 2h^vee (,) on the compact form and <,> = (ell/2)(,), a unit x has (x,x) = 2/ell, so C = 4h^vee/ell.
- ell normalisation: su(2) coroot H = diag(1,-1) has (H,H) = 2 and tr H^2 = 2, so the fundamental has index 1. Realification doubles the real trace, so ell doubles.
- Ideals are mutually orthogonal and orthogonal to the centre (invariance plus h_i = [h_i,h_i]), so an adapted ONB exists and M(h) = sum_i d_i C_i with the centre contributing 0.
- Direct counts reproduced by hand: so(k) on R^k, 2(k-2) (y sharing one index with x, each bracket of record norm 1); so(3) on R^3, ell = 4, C = 2; su(2) on R^4, C = 4, M = 12 (half of so(4)'s 24).
- Screen (seconds): su(2) spin-j realified gives C = 4/(2 ell_j) with ell_j = (2/3)j(j+1)(2j+1), exact at j = 1/2, 1, 2 (C = 4, 1, 0.2); su(3) on R^6 gives C = 6, M = 48; so(5) on R^5 gives C = 6.

## C2, the index table: PLAUSIBLE

- **False sentence**: "larger representations of any type have larger ell and smaller C". Counterexample: A1 on R^3 (the smallest real representation) has ell = 4, and A1 on R^4 has ell = 2. A3 = D3 has ell = 2 on both R^6 and R^8. The table's A_r entry at r = 1 uses ell = 2, which is attained on R^4, not on the smallest representation.
- **Correct replacement**: every nontrivial real representation of a simple compact algebra has ell >= 2. The only complex irreducibles of index 1 are the defining representations of su(m) and sp(m), which are of complex or quaternionic type and realify to ell = 2. Every real-type irreducible has index >= 2, and ell is additive over summands.
- With that, C <= 2h^vee for every simple ideal of every subalgebra, which is what the argument uses. The numbers stand: A_r 2(r+1)/sqrt(r(r+2)), C_r 2(r+1)/sqrt(r(2r+1)), both at most 4/sqrt3 = 2.309 (at r = 1); G2 8/sqrt14 = 2.138; F4, E6, E7, E8 with minimal real ell = 6, 12, 24, 60 give 0.83, 0.45, 0.26, 0.13.
- **Counterexample hunt, none found.** B_r and D_r in any representation with ell = 2 have ratio 2h^vee/sqrt d, which equals so(2r+1)'s or so(2r)'s vector ratio. The vector representation is the smallest real representation for k >= 7 (so(7) spin is 8, so(8) spin is 8 by triality), so any embedding into so(n) has k <= n and ratio at most so(n)'s. Low-rank cases: B2 = C2 (R^5 or R^8, both ell = 2, ratio 1.897), D3 = A3 (2.066), so(7) spin on R^8 (10/sqrt21 = 2.182). F4 even at the crude ell = 2 bound (2.496) needs n >= 26, where so(26) gives 2.663.

## C3, the conclusion: CONFIRMED

- so(n)'s ratio squared is 8(n-2)^2/(n(n-1)): 5.14 at n = 8 and 5.44 at n = 9, against (4/sqrt3)^2 = 5.33. So n >= 9 is exactly where so(n) beats A1.
- Superadditivity: M/d^{3/2} = sum d_i C_i / d^{3/2} <= c sum d_i^{3/2} / d^{3/2} <= c, with c the largest C_i/sqrt(d_i) and the centre included with M = 0. Strict with two or more nonzero parts.
- M/(2d^{3/2}) <= (n-2)/sqrt N = sqrt2(n-2)/sqrt(n(n-1)), and the squared comparison with theta0 is (n-2)n < (n-1)^2.

## C4, the complement identity: CONFIRMED

- Z_V + Z_{V-perp} = sum over a Frobenius ONB of so(n) of U (x) U = (1/2)(G - SWAP), the diagonal terms cancelling.
- With G^2 = nG, SWAP^2 = I, G SWAP = G: tr((G - SWAP)^3) = n(n^2 - 3n + 3) - n = n(n-1)(n-2), so tr T^3 = N(n-2)/4.
- The cross terms 3 tr(Z_V^2 Z_W) + 3 tr(Z_V Z_W^2) equal 3 sum tr(abc)^2 over VVW and VWW. Using tr(abc) = -(1/2)<[a,b],c>_F these sum to (3/4) sum_{x in V, y in W} ||[x,y]||_F^2.
- Screen (seconds): random V in so(6) at d = 2, 5, 9, both sides agree to 1e-14.

## C5, where the general cap stands

- **(1) CONFIRMED.** [e wedge e-perp, e wedge e-perp] lies in Lambda^2 e-perp, so the three-form vanishes on three elements of e wedge e-perp. The mass of V on e wedge e-perp is sum_psi |psi e|^2 = alpha(e), so the rest is d - alpha(e), and a star has M = 0.
- **(2) REFUTED as worded.** Solving L243 with P = 2A_0, k = 2p, r = 11 for the threshold at n = 12, theta = theta0 gives ||Ric(W^2)||^2 < 0.402, 0.398, 0.394, 0.390, 0.386, 0.382 at p = 8..13 (isotropic 1/3, so within 15 to 21 percent, which bears out "about 20%"). Batch 9's chain at the same p gives 0.372, 0.347, 0.326, 0.309, 0.294, 0.281, and falls below the isotropic minimum from p = 10 onwards. The two agree only at p = 7 (0.406 against 0.402), which lies outside the window. **Correction**: "through L243's total-mass cap, M <= T closes the n = 12 window when ||Ric(W^2)||^2 is below 0.38 to 0.40 (p = 13 down to 8), within 15 to 21 percent of the isotropic 1/3. This is a near-isotropy condition like batch 9's, but it is weaker than batch 9's chain at every window p and satisfiable at p >= 10, where batch 9's is not. So L243 improves on batch 9 in the window and still needs a spread bound that is unproved."
- **(3) REFUTED in its second half.** The value 24.07 against so(4)'s 24 is on disk (batch 16, the internal-mass screen) and correct as worded. It exceeds every 6-dimensional subalgebra, since su(2) has C <= 4. **"Every other dimension screened ended on a subalgebra" is false.** The d = 20 value M = 180 exceeds every 20-dimensional subalgebra of so(12): every simple algebra of dimension <= 20 with a real representation of dimension <= 12 has C <= 8, so M <= 160. The value is exactly so(7) with one ONB direction removed: 210 - 3 * 10 = 180. The d = 26 value M = 276 exceeds every 26-dimensional subalgebra (C <= 10 for ideals of dimension <= 26, so M <= 260). It is so(8) with a Lambda^2_+ pair x1, x2 removed: 336 - 72 + 6||[x1,x2]||^2 = 276 at ||[x1,x2]||^2 = 2. Screen: both constructions give 180.0 and 276.0 exactly. **Correction**: "the ascent maxima at d = 6, 20, 26 are subspaces lying above every subalgebra of their dimension: at d = 20 and 26 they are so(7) less a line and so(8) less a su(2) plane, codimension 1 and 2 inside a subalgebra." This fits the proposed stability statement (near the envelope means near a subalgebra) better than the text does. The envelope has to be taken over subspaces of subalgebras, not over subalgebras alone.
- **Downstream, same defect**, outside this review's edit scope: batch 16's "the ascent lands on subalgebras" (line 138) and L255's "What it gives", "ends on subalgebras below theta0" for d in {16, 20, 26}. The values themselves stay below theta0(12), so the window statement is unaffected.

## C6, Lean: CONFIRMED

- `lake env lean` on [I73SubalgebraCap.lean](../lean/HamiltonsCubic/Results/I73SubalgebraCap.lean) compiles clean (5 s, no warnings, no sorry, no native_decide). The file is imported from HamiltonsCubic.lean.
- sum_three_halves_le, ratio_le_of_parts, sok_ratio_mono and whole_below_theta0 state exactly what the docstring says. The directions match the prose: f(k) = (k-2)^2/(k(k-1)) has f' proportional to (k-2)(3k-2) >= 0.
- Not typed and disclosed as such: the Casimir formula, the minimal-index table, the 2.309 bound. One more untyped link: the arithmetic step "so(n)'s ratio exceeds 4/sqrt3 exactly from n = 9" (8(n-2)^2 > (16/3) n(n-1)). This is scalar and could be added, but the Lean table's C3 row implies it is typed and it is not.
