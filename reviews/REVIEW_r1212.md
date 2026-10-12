# Review r1212: Batch 17 of the I73 class-ceiling note (subalgebra cap, complement identity, general cap)

Object: section "## Batch 17" of [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md), read verbatim off disk. Log: [agent_logs/r1212.log](../agent_logs/r1212.log). Footing: analysis only, with three seconds-to-a-minute screens on objects constructed for this review, reported as screens.

| claim | verdict |
|---|---|
| C1 Casimir formula | CONFIRMED |
| C2 index table | PLAUSIBLE (values and conclusion right, one justifying clause false, correction below) |
| C3 conclusion | CONFIRMED |
| C4 complement identity | CONFIRMED |
| C5 general-cap facts | PLAUSIBLE (two wording repairs, one downstream defect in L255) |
| C6 Lean | CONFIRMED |

## C1 Casimir formula: CONFIRMED

- Derivation: the ambient form restricted to a simple ideal is (ell/2)(,) with (,) positive on the compact form in the long-root-sqrt2 normalisation. For ambient-unit x, (x,x) = 2/ell. ad_x is skew for the ambient form on h, so sum over an ambient ONB y of h of ||[x,y]||^2 = -tr_h(ad_x^2) = 2h^vee (x,x) = 4h^vee/ell.
- Direct counts: so(k) on R^k, x = e1^e2 brackets to 2(k-2) unit elements, so C = 2(k-2) = 4(k-2)/2. so(3) on R^3: C = 2 with ell = 4. su(2) on R^4: so(4)'s per-element total 4 falls entirely in Lambda^2_+ since [Lambda^2_+, Lambda^2_-] = 0, so C = 4 and M = 12. su(m) on R^{2m}: 4m/2 = 2m.
- Screen: su(3) realified in so(6), C = 6.000 to machine precision.
- M(h) = sum_u sum_v ||pi_h [u,v]||^2 = -sum_u tr_h(ad_u^2), basis independent. Distinct ideals commute and the centre is central, so M = sum_i d_i C_i with the centre contributing 0. The ordered-triple convention matches L255 (so(4) gives 24, so(n) gives 2N(n-2)).

## C2 index table: PLAUSIBLE

- Every listed ratio checks: A_r 2(r+1)/sqrt(r(r+2)) decreasing, max 4/sqrt3 = 2.3094 at r = 1. C_r 2(r+1)/sqrt(r(2r+1)) decreasing, same max. G_2 8/sqrt14 = 2.138. F4 0.832, E6 0.453, E7 0.260, E8 0.127. B_r, D_r: 2(k-2)/sqrt(k(k-1)/2) is increasing because d/dk of (k-2)^2/(k^2-k) has numerator (k-2)(3k-2) > 0.
- The false link. "Every simple type in its smallest faithful real representation has ell >= 2 ... larger representations of any type have larger ell and smaller C" fails at A_1: its smallest faithful real representation is R^3 (ell = 4, C = 2), and the LARGER R^4 has ell = 2 and C = 4, which is exactly the 2.309 entry the table uses. Equal-ell larger representations also exist (B_3 on R^8 and R^7, both ell = 2; su(4) on R^8 and so(6) on R^6, both ell = 2).
- Correction: every nontrivial real irreducible representation of a compact simple Lie algebra has Dynkin index at least 2 in this normalisation. The complex irreducibles of index 1 are the fundamentals of A_r and C_r, which are of complex and quaternionic type, so their real forms are realifications with ell = 2. Real-type irreducibles have ell >= 2, and index adds over summands. Hence C <= 2h^vee for every embedding, which is the inequality the table needs.
- Counterexample hunt, none found. Spin(7) on R^8: C = 10, ratio 2.182. so(8) through either half-spin: 2.268. so(9) spin R^16: ell = 4, C = 7. so(10) half-spin: ell = 8. Low-rank coincidences A1 = B1 = C1 (2.309), B2 = C2 (1.897 on R^5 and R^8), A3 = D3 (2.066 on R^6 and R^8). su(3) on R^6: 2.121. The largest non-orthogonal value is 2.3094 against so(9)'s 14/6 = 2.3333.

## C3 conclusion: CONFIRMED

- Superadditivity: sum d_i C_i <= max_i(C_i/sqrt d_i) sum d_i^{3/2} <= max_i(C_i/sqrt d_i)(sum d_i)^{3/2}. A centre adds dimension and no mass, so mixtures never beat their best ideal.
- A simple ideal of a subalgebra of so(n) is so(k) with k <= n (bounded by so(n) by monotonicity) or a type bounded by 2.3094, which so(n) exceeds exactly from n = 9 (n = 8 gives 2.268).
- With L255: theta <= N 2(n-2)/(2N^{3/2}) = sqrt2(n-2)/sqrt(n(n-1)), and its square over theta0(n)^2 is n(n-2)/(n-1)^2 < 1. At n = 8 the route fails (2/sqrt3 = 1.1547 > theta0(8) = 1.1456), consistent with the stated range.

## C4 complement identity: CONFIRMED

- With W = Z_V, W' = Z_{V-perp}: tr(W+W')^3 = N(n-2)/4 (Step 4's value at the whole algebra). The mixed terms are 3 tr(W^2 W') + 3 tr(W W'^2), and by invariance their sum is (3/8) sum_{x in V, y in V-perp} ||[x,y]||^2 in record units, which is (3/4) of the same sum in Frobenius units (a Frobenius-unit bracket is half a record-unit bracket and Frobenius norm squared is twice record).
- Screen: random V of dimensions 5 and 10 in so(7), both sides agree to 1e-13.

## C5 general-cap facts: PLAUSIBLE

- (1) True as structure: [e^e-perp, e^e-perp] lies in Lambda^2 e-perp, so a star has M = 0 and every nonzero term of the restricted three-form has a Lambda^2 e-perp factor. Wording repair: with alpha(e) = <A_0 e, e> as defined in batch 1 of the note, the Lambda^2 e-perp mass of V = E_0 + E_2 is d - <A_V e, e> = d - 2 alpha(e) on the symmetric family, not d - alpha(e).
- (2) Correct to about 1%. L243 with k = d = 14, r = 11, tr P^2 = 4 G_00, and T < 2 theta0(12) 14^{3/2} = 129.49 gives G_00 < 19.905, that is ||Ric(W^2)||^2 < 0.406 against batch 9's 0.402 and the isotropic 1/3 (ratio 1.219). "The same 0.40" is right to the precision stated. The L243 threshold is marginally looser, so "adds nothing" holds as "adds about 1%".
- (3) Screen reproduced: projected ascent at n = 12, d = 6, 8 restarts, 7 of 8 end at M = 24.0717 with ||pi_{V-perp}[V,V]||^2 = 4.74, so the maximiser is not a subalgebra. The 6-dimensional subalgebra maximum is 24 (every simple ideal has C <= 4 there). Wording repair: "sit on the subalgebra envelope" should read "sit 0.3% above the d = 6 subalgebra value, far below the envelope's so(n) level". This is a literal failure of a dimension-by-dimension subalgebra cap, harmless for the M/d^{3/2} cap the programme needs (1.638 against 2.462).
- Downstream defect outside the object: L255's "What it gives" in findings/second-order.md and batch 16's screen paragraph say the ascent "ends on subalgebras" at d = 6. By this screen, and by batch 17's own sentence, it does not. Both need the d = 6 exception.

## C6 Lean: CONFIRMED

- lean/HamiltonsCubic/Results/I73SubalgebraCap.lean compiles clean (lake env lean, 12 s), no sorry, native_decide or axiom, imported in lean/HamiltonsCubic.lean.
- sum_three_halves_le and ratio_le_of_parts state exactly the superadditivity step. sok_ratio_mono is the squared form of so(k) <= so(n). whole_below_theta0 is the squared form of sqrt2(n-2)/sqrt(n(n-1)) < theta0(n) for n >= 3.
- Untyped and correctly declared as quoted: C = 4h^vee/ell and the index table. Also untyped and undeclared: the n >= 9 crossing 2(n-2)/sqrt N > 4/sqrt3. It is arithmetic, one nlinarith away, and the docstring files 2.309 under "classical input". A one-line addition would close it.
