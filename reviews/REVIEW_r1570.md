# Review r1570: batch 44, a positive-definite idempotent on so(n) other than I/c, its instability and norm

Log: agent_logs/r1570.log

Overall: CONFIRMED with one correction (the "four pairwise non-isomorphic irreducibles" step is false at n = 8) and two small additions (the sign of b, and the norm claim holds for every n >= 7).

| claim | verdict | reason in one line |
|---|---|---|
| E1 the family and its block constants | CONFIRMED (one correction) | every constant and all four equations re-derived by hand and screened at n = 7, 8, 9, 12. at n = 8 so(4) is reducible under SO(4), so the invariant family is five-parameter, though the four-parameter family still closes under # |
| E2 the idempotent and its range of n | CONFIRMED | a_s, b^2, the root sum and product and the discriminant 2(n-6)(5n-24)/(64(n-5)^2) all re-derived. positive definite once b > 0 is chosen (b < 0 gives an indefinite idempotent) |
| E3 norm and instability | CONFIRMED | squared norm (53n^2-524n+1296)/(64(n-5)^2), above N/(n-2)^2 for every n >= 7. excess formula reproduced symbolically, 61389/198656 at n = 9, quartic shift and discriminant -176 correct. full-spectrum screen shows an L_C eigenvalue 0.59-0.64 > 1/2 on C-perp |
| E4 Lean statements | CONFIRMED | the three statements carry the prose's equations and n = 9 coefficients exactly. file compiles clean |
| E5 other | CONFIRMED | refutes only the unproved U. L261, L262, L263, L264, L265 untouched. the closing report matches the record (G2's two, so(n)'s one, all unstable and heavier) |

## Method

Read the batch 44 chain link by link and re-derived each constant by hand from the trace identity and I#I = cI read blockwise. Screens (sage's numpy, seconds each): built so(n) for n = 7, 8, 9, 12 from its bracket in the orthonormal basis e_ij for <X,Y> = -tr(XY)/2 (checked I#I = (n-2)I exactly), formed P_+, P_-, P_s, P_V, computed every product P_X#P_Y with its residual off the family, built C and evaluated C#C - C, its least eigenvalue, its norm, the excess of H, and for n <= 9 the full spectrum of L_C on Sym^2 so(n) (dimension up to 666). A sage symbolic computation reproduced the general-n excess, its value at n = 9, the shift to m = n-7 and the discriminant. another gave the norm gap. The Lean file was compiled with `lake env lean`. All computation is reported as a screen. the positive claims rest on the hand derivations below.

## E1 the family

- Representations: Lambda^2_+ = (1,0,1), Lambda^2_- = (0,1,1), so(n-4) = (0,0,adj), V = (1/2,1/2,vec). For n-4 = 3 or n-4 >= 5 these are four pairwise non-isomorphic irreducibles of real type (symmetric commutant scalars on each), so the invariant symmetric operators are the four-parameter family. The image of SU(2)_+ x SU(2)_- x SO(n-4) is SO(4) x SO(n-4), so this is the full K-invariant family of the symmetric pair (SO(n), SO(4) x SO(n-4)).
- **Correction at n = 8.** so(n-4) = so(4) = Lambda^2_+' + Lambda^2_-' under the second SO(4): five irreducibles, and the invariant symmetric operators are five-parameter. The claim "four pairwise non-isomorphic irreducibles, so the invariant operators are a_+P_+ + a_-P_- + a_sP_s + bP_V" is false there. The conclusion survives: the four-parameter family is still closed under #, because conjugation by diag(I_4, r) with r in O(4), det r = -1, is an isometric automorphism of so(n), commutes with #, fixes P_+, P_-, P_V and swaps the two ideals of the second so(4), so the family is exactly the invariant family of SU(2)_+ x SU(2)_- x O(n-4) for every n. Screen at n = 8: P_s#P_s = 2P_s = (n-6)P_s, P_s#P_V = (3/2)P_V, residuals 0. Suggested repair: use O(n-4) in place of SO(n-4) in the first sentence.
- Constants: P_+-#P_+- = 2P_+- (c_1 = 2 on Lambda^2_+, Cas 4). Trace identity for su(2)_+: sum of d_W Cas(W) = d_k Cas_g(g) = 3 * 2(n-2). contributions 3*4 + 0 + 0 + 4(n-4)kappa, so kappa = 3/2, alpha = 3/4, ratio (3/2)/4 = 3/8. P_s#P_s = (1/2)*2(n-6) = n-6. P_s#P_V = (1/2)(n-5) from the vector Casimir m-1 at m = n-4. trace check d_s*2(n-6) + 4(n-4)(n-5) = (n-4)(n-5)(n-2) = 2(n-2)d_s, as written. Cross products vanish since the ideals commute and so(n-4) centralises so(4). I#I = cI blockwise: on P_+-, 2 + x_+- = n-2 gives x = n-4. on P_s, (n-6) + x_s = n-2 gives x_s = 4. on P_V, 2*2*(3/4) + 2*(n-5)/2 + y = n-2 gives y = 0. x_+-*3 = 3(n-4) = (3/4)*4(n-4) and x_s d_s = 2(n-4)(n-5) = ((n-5)/2)*4(n-4) check. Every constant matches the screen at n = 7, 8, 9, 12 to 2e-15.
- Equations: the P_+- coefficient of C#C is 2a_+-^2 + (n-4)b^2, the P_s coefficient (n-6)a_s^2 + 4b^2, the P_V coefficient 2b((3/4)(a_+ + a_-) + ((n-5)/2)a_s). with b != 0 these are the stated three (four with the two signs).

## E2 the idempotent

- a_+ + a_- = 1/2 in the P_V equation gives (n-5)a_s = 1/4. Then 4b^2 = a_s(1-(n-6)a_s) = (3n-14)/(16(n-5)^2), so b^2 = (3n-14)/(64(n-5)^2). Correct.
- Discriminant: 1/4 - 2(n-4)b^2 has numerator 16(n-5)^2 - 2(n-4)(3n-14) = 10n^2 - 108n + 288 = 2(n-6)(5n-24), positive for n > 6. Correct. at n = 6 the roots merge (a_+ = a_-).
- Roots: sum 1/2, product (n-4)b^2/2 > 0 for n > 14/3, so both positive. a_s > 0. **Addition:** positive definiteness needs b > 0. the equations fix only b^2 and the P_V equation is linear in b after dividing by it, so b = -sqrt is also an idempotent, indefinite. The prose's n = 9 values take b > 0. the bold statement should say b = +sqrt((3n-14))/(8(n-5)).
- Distinct from I/c since a_+ != a_-. Screens: |C#C - C| = 3e-17, 8e-17, 3e-17, 1e-16 at n = 7, 8, 9, 12. least eigenvalue a_- or a_s as expected (1/16 at n = 9, matching the prose).

## E3 norm and instability

- ||C||^2 = 3(a_+^2 + a_-^2) + d_s a_s^2 + d_V b^2 = (53n^2-524n+1296)/(64(n-5)^2). values 0.8789 (n=7), 0.8611 (n=8), 0.8525 (n=9), 0.8418 (n=12) against 0.84, 0.778, 0.735, 0.66. The prose's three figures are right. **Addition:** ||C||^2 - N/(n-2)^2 = 3(n-6)^2(7n^2-44n+48)/(64(n-2)^2(n-5)^2), positive for every n >= 7 (the quadratic's roots are below 5), so "at every n computed" can read "for every n >= 7". Consistent with L259 (3): the trace s is about 4.38 at n = 9 and 5.18 at n = 12, above the window's upper end 2.86 and 4.4.
- H is not orthogonal to C (<H,C> = 1395/1024 at n = 9), and the formula handles this correctly: for H' = H - (<H,C>/q)C, using C#C = C, <C#H',H'> - ||H'||^2/2 = <C#H,H> - ||H||^2/2 - <H,C>^2/(2q). Positive excess puts an eigenvalue of the self-adjoint L_C above 1/2 on C-perp (L_C preserves C-perp since C is an eigenvector).
- The H inner products are symmetric in a_+, a_-: <H,C> = 6a_+a_- + ..., <C#H,H> = 6a_+a_-(a_+ + a_-) + 12(n-4)b^2(a_+ + a_-) + ..., ||H||^2 = 3(a_+^2+a_-^2) + .... Confirmed.
- Symbolic screen reproduces the general formula exactly (difference simplifies to 0), 61389/198656 at n = 9, the shift 249m^4+2132m^3+6186m^2+6828m+1949, and 524^2 - 4*53*1296 = -176. Numerical excess matches the formula at n = 7, 8, 9, 12. Full spectrum of L_C on Sym^2 so(n): top eigenvalues 1 (C itself), then 0.5909 (n=7), 0.6132 (n=8), 0.6236 (n=9), then 0.5 with multiplicity. the value above 1/2 lies in the invariant span (eigenvalues -0.145, 0.179, 0.591, 1 at n = 7). Unstable at every n checked, and by the formula at every n >= 7.

## E4 Lean fidelity

- `son_asym_idem`: hypotheses 5 < n, ap + am = 1/2, ap*am = (n-4)b^2/2, b^2 = (3n-14)/(64(n-5)^2). conclusion the four equations with a_s = 1/(4(n-5)) literally as in the prose. Faithful (positivity and b > 0 are not claimed in Lean or by the prose's table).
- `son_asym_disc`: 2(n-4)(3n-14)/(64(n-5)^2) < 1/4 for n > 6, which is the stated reality condition. Faithful.
- `so9_asym_unstable`: weights 3, 3, 10, 20 are d_+-, d_s, d_V at n = 9. hs = 1/4 = 1/(n-5). hprod 65/2048 and b^2 = 13/1024 are the n = 9 values. each block of CH matches the general C#H coefficients at n = 9 (n-4 = 5, n-6 = 3, (n-5)/2 = 2, a_s = 1/16). conclusion is the projected excess 61389/198656. Faithful. it is an arithmetic identity from the block constants, as the table says.
- `lake env lean HamiltonsCubic/Results/I117LemmaF.lean` compiles with no output. the three proofs contain no sorry.

## E5 other

- Proved results untouched. L261 is the coordinate-diagonal family: C mixes e_01 with e_23 through P_+ - P_- when a_+ != a_-, so it is off that family. L262 covers aP_k + bP_p only. at n = 8 the pair SO(4) x SO(4) is single-Casimir (both so(4)'s have Cas 4) but C, with four distinct coefficients on k, is outside the two-parameter ansatz. L263's criterion and L264 (4) concern two-component families. this is four-component, so "every two-component family in so(n) has y <= 2x" is not contradicted. L264 (3) reduces H to U_s, which survives here. L265 concerns I/c. Only the unproved U (every positive-definite idempotent on a simple h is I/c) is refuted, and it was already refuted on g_2 by L263.
- Closing claim as a report of the record: the other positive-definite idempotents found are L263's (9/28, 3/28) on g_2 (norm 351/392 > 7/8, second eigenvalue 15/28 > 1/2) and batch 40's on SO(4) in G_2 (746/841 > 7/8, excess 7/29 > 0). batch 43's Sp(1)Sp(m) roots with b != 0 were I/c and b < 0 ones. So "each positive-definite idempotent other than I/c found is unstable and heavier than I/c" is accurate. The phrase "as on every other" in the same sentence is an empirical report about found idempotents, and reads correctly only in that sense.
- Mechanism sentence: ratio Cas_+(V)/Cas_+(Lambda^2_+) = (3/2)/4 = 3/8 is right, and as n grows (a_+, a_-, a_s, b) tends to (1/2, 0, 0, 0), so the root does leave P_+/2 in the limit. the "leaves" reading is heuristic, as batch 43 says of its two-ideal case.
- The observation that batch 44's family is the full invariant family of the symmetric pair (SO(n), SO(4) x SO(n-4)), with k carrying two Casimir values for n != 8, could be stated. it places the example beside batch 40's SO(4) in G_2.
