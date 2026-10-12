# Review r1569: batch 44, a positive-definite idempotent on so(n) other than I/c, its instability and norm

Log: agent_logs/r1569.log

Overall: the headline stands. For every n >= 7 the asymmetric root is a positive-definite idempotent on so(n) other than I/c, so U fails on so(n) itself, and it is unstable and heavier than I/c. Three gaps in the written chain need repair: one sentence false at n = 8, one choice of sign left implicit, and one missing enumeration behind "U_s survives on this family". No proved lemma is refuted.

| claim | verdict | reason in one line |
|---|---|---|
| E1 the family and its block constants | PLAUSIBLE (correction) | every block constant and all four equations check by hand and by screen at n = 7, 8, 9, 12. But "four pairwise non-isomorphic irreducibles, so the invariant operators are exactly" is false at n = 8, where so(n-4) = so(4) splits as Lambda^2_+ + Lambda^2_- under SO(4). The four-parameter family is still closed under #, so the idempotent survives |
| E2 the idempotent and its range of n | CONFIRMED (minor gap) | a_s = 1/(4(n-5)), b^2 = (3n-14)/(64(n-5)^2), and the discriminant 5n^2-54n+144 = (n-6)(5n-24) all re-derived. Positive definiteness also needs b > 0, the positive square root, which the text never states. The screen at n = 9 reproduces 1/16 and |C#C-C| ~ 3e-17 |
| E3 norm and instability | CONFIRMED | ||C||^2 = 3/4 + (n-4)b^2 + (n-4)/(32(n-5)) gives 225/256, 873/1024 and 0.8418. The projected excess is the correct Rayleigh excess of H minus its C-component. The general formula reduces to zero difference under the two relations, the n = 9 value is 61389/198656, the m-shift is right and the discriminant is -176. At n = 7 the full L_C spectrum on Sym^2 (screen) has 0.5909 > 1/2 |
| E4 Lean statements | CONFIRMED | son_asym_idem, son_asym_disc and so9_asym_unstable say what the prose says. Weights 3, 3, 10, 20, h_s = 1/4, a_s = 1/16, apam = 65/2048 and b^2 = 13/1024 match, and every C#H coefficient matches the bilinear block table |
| E5 other | PLAUSIBLE (gap) | nothing proved is refuted: C is not coordinate-diagonal (L261), the family is four-component (L262, L263, L264(4)), and L265 concerns I/c alone. "U_s survives on this family" is true but the text omits a step: the a_+ = a_- branch holds only I/c plus a root with b^2 = -(3n-16)/(n-8)^2 < 0, and b = 0 is never positive definite |

## Method

- Read the batch 44 chain link by link, then re-derived each step by hand from the givens: Schur, trace sum rules and I#I = cI read blockwise.
- Screens (seconds each, reported as screens, not proofs):
  - Built so(n) from its bracket at n = 7, 8, 9, 12, with orthonormal basis e_ij under -tr/2, which gives c = n-2 exactly. Formed P_+, P_-, P_s and P_V, computed every pairwise # and its residual off the four-projector span, then C, C#C - C, eig C, ||C||^2 and the excess of H.
  - At n = 7, the full 231 x 231 matrix of L_C on Sym^2.
  - Sage symbolic reduction of the general-n excess modulo 2a^2 - a + (n-4)b^2 and 64(n-5)^2 b^2 - (3n-14).
  - Sage elimination of the symmetric branch.
- Did not build the Lean files. The kernel checked them, so only fidelity was assessed.

## E1

- **Irreducibility.** Under SU(2)_+ x SU(2)_- x SO(n-4) the four spaces are (1,0,1), (0,1,1), (0,0,Lambda^2 R^{n-4}) and (1/2,1/2,R^{n-4}). All are of real type and pairwise non-isomorphic.
  - so(n-4) is irreducible for n-4 = 3 and n-4 >= 5.
  - **At n = 8 it is not.** so(4) = Lambda^2_+ + Lambda^2_- of the second R^4. The invariant symmetric operators then form a five-parameter family, and "exactly the four-parameter family" is false there.
  - The consequence is harmless. P_s#P_s = 2P_s = (n-6)P_s still holds because both su(2) ideals have constant 2, so the four-parameter span is #-closed and its idempotents remain idempotents. The screen at n = 8 gives |C#C-C| = 8e-17, a_+ = 5/12, a_- = a_s = 1/12.
  - **Correction:** say "for n != 8; at n = 8 the four-parameter family is a #-closed subfamily of the invariant operators".
- **Block constants.** For a unit u, sum_w |[u,w]|^2 = 2(n-2), so tr(P_k#I) = d_k(n-2).
  - k = Lambda^2_+: 3(n-2) = 2*3 + alpha*4(n-4), giving alpha = 3/4 (Cas = 3/2). This is the brief's identity divided by 2.
  - k = so(n-4): d_s(n-2) = (n-6)d_s + alpha_s*4(n-4), giving alpha_s = (n-5)/2.
  - The cross products vanish because the subalgebras commute.
  - I#I = cI read blockwise gives x_+ = n-2-2 = n-4, x_s = n-2-(n-6) = 4, and y = n-2-2(3/2+(n-5)/2) = 0.
  - The checks x_+d_+ = 3(n-4) = alpha_+d_V and x_sd_s = 2(n-4)(n-5) = alpha_sd_V both hold.
  - The screen reproduces every constant at n = 7, 9, 12 with residuals <= 2e-15.
- **Equations.** Reading C#C blockwise gives exactly the three stated equations. The V equation has been divided by b, legitimate once b != 0.

## E2

- **Reduction.** a_++a_- = 1/2 in the V equation gives (n-5)a_s = 1/4. The s equation then gives 4b^2 = a_s(1-(n-6)a_s) = (3n-14)/(16(n-5)^2).
- **Discriminant.** 1-8(n-4)b^2 > 0 is equivalent to 16(n-5)^2 > 2(n-4)(3n-14), that is 5n^2-54n+144 = (n-6)(5n-24) > 0. This holds for n >= 7, with a double root at n = 6.
- **Positivity.** The roots have sum 1/2 and positive product, so both are positive, and a_s > 0.
  - The eigenvalues of C are its four coefficients because the projectors are orthogonal and complete. Positive definiteness therefore also needs **b > 0**.
  - b = -sqrt(...) gives an idempotent that is not PSD. The text writes b^2 = ... and then bP_V without fixing the sign. **Correction:** state b = sqrt((3n-14))/(8(n-5)).
- **Distinct from I/c.** a_+ != a_-, while I/c has equal coefficients.
- **n = 9 screen.** Values (0.4254, 0.0746, 0.0625, 0.1127) and least eigenvalue 1/16 (at n = 7 the least eigenvalue is a_- = 0.1034, not a_s; only n = 9 is claimed).

## E3

- **Norm.** ||C||^2 = 3(1/4 - (n-4)b^2) + d_s a_s^2 + 4(n-4)b^2 = 3/4 + (n-4)b^2 + (n-4)/(32(n-5)).
  - This gives 225/256 = 0.879, 873/1024 = 0.853 and 0.8418 against 21/25, 36/49 and 0.66, matching the screen.
  - The claim holds for **every** n >= 7, not only "at every n computed". For n >= 8, ||C||^2 > 3/4 + 1/32 = 0.78125 >= N/(n-2)^2 (0.778 at n = 8, decreasing). The record may strengthen the sentence.
- **H versus C.** H is not orthogonal to C (<H,C> = 1395/1024 at n = 9). The subtracted term handles this: for H' = H - tC with t = <H,C>/||C||^2, using C#C = C,
  - <C#H',H'> - (1/2)||H'||^2 = <C#H,H> - (1/2)||H||^2 - <H,C>^2/(2||C||^2).
  - A positive value therefore gives a Rayleigh quotient above 1/2 on C-perp, which is instability.
- **Excess formula.**
  - Sage reduction: the difference between the computed excess and the stated rational function reduces to zero modulo the two relations. By hand, the residual numerator becomes -5(3n-14)/(n-5) + n/(n-5) + 14 = 0.
  - At n = 9 the value is 9*61389/(2048*873) = 61389/198656.
  - Substituting n = m+7 gives the stated quartic, which has all positive coefficients. 524^2 - 4*53*1296 = -176.
  - The screen matches at n = 7, 8, 9, 12: 0.15227, 0.27319, 0.30902, 0.33312.
  - At n = 7 the full L_C spectrum on Sym^2 is {..., 0.5, 0.5909, 1}, confirming an eigenvalue above 1/2 off C.
- **Symmetric dependence.** HC, HH and CH are symmetric under a_+ <-> a_-, as stated.

## E4

- **son_asym_idem.** Hypotheses n > 5, sum, product and b^2. Conclusions: the two Lambda^2 equations, the s equation with a_s = 1/(4(n-5)), and the V equation in its b-divided form. This matches the prose.
- **son_asym_disc.** 2(n-4)b^2 < 1/4 with b^2 substituted, for n > 6. This matches "real and distinct".
- **Scope of the typing.** Neither declaration types positivity of the roots or b > 0. The prose does not claim they are typed.
- **so9_asym_unstable.**
  - apam = 5*(13/1024)/2 = 65/2048 and b^2 = (27-14)/1024 = 13/1024. The weights are d_+ = d_- = 3, d_s = 10, d_V = 20, and H = (a_-, a_+, 1/4, 4b), with 1/(n-5) = 1/4.
  - CH's P_+ entry is 2a_+h_+ + 5bh_V. The P_s entry is 3a_sh_s + 4bh_V. The P_V entry is (3/4)(a_+h_V + h_+b) + (3/4)(a_-h_V + h_-b) + 2(a_sh_V + h_sb). All three match the bilinear table.
  - q = ||C||^2 with a_s = 1/16. This is faithful.

## E5

- **L261** (coordinate-diagonal PD idempotent is I/(n-2)). Not contradicted. On span(e12, e34), a_+P_+ + a_-P_- has off-diagonal entry (a_+-a_-)/2 != 0, so C is not coordinate-diagonal. It also cannot be conjugate to a coordinate-diagonal PD idempotent, by L261 itself, since C != I/c.
- **L262, L263's criterion, L264(4).** These concern two-component ansätze aP_k + bP_p with p k-irreducible. No such reading of this family exists: the complement of Lambda^2_+ is reducible. L264(4)'s "every two-component family in so(n) has y <= 2x" is untouched.
- **L265.** Concerns I/c only.
- **L259(3).** At n = 9 the trace is s = 3/2 + 5/8 + 20b ~ 4.378. This lies above (n-1)(n-4)/(2(n-2)) = 20/7, so L259 predicts H (||C||^2 >= N/(n-2)^2), which holds. Consistent.
- **What is refuted.** Only the unproved U, which already failed at SU(3) in G2 by L263.
- **Gap: "U_s survives on this family".** This needs every PD idempotent of the family, and the text treats only the asymmetric root. The remaining cases:
  - b = 0 forces zero on V, so no such idempotent is PD.
  - On a_+ = a_- = a, eliminating a_s = (1-3a)/(n-5) and b^2 = (a-2a^2)/(n-4) leaves a quadratic with roots a = 1/(n-2), which is I/c, and a = -(n-4)/(n-8), where b^2 = -(3n-16)/(n-8)^2 < 0 for n >= 7, n != 8. The n = 8 case collapses to I/c alone (Sage elimination, confirmed at n = 7, 8, 9, 12, 20).
  - So the family's PD idempotents are I/c and the asymmetric pair (swapped by an orientation-reversing element of O(4)). The sentence is true once this enumeration is added.
- **"Each positive-definite idempotent other than I/c found is unstable and heavier".** Checked against the one other recorded example, L263's C on g2: 351/392 > 7/8, and it is unstable by L264(4) since x = 1 < y = 4/3 < 2. I did not search the record exhaustively for other found idempotents, so this is PLAUSIBLE as a report.
- **Mechanism sentence.** As n -> infinity, (a_+, a_-, a_s, b) -> (1/2, 0, 0, 0), so C -> P_+/2, consistent with "leaves the subalgebra idempotent".
