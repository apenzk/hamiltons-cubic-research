# Review r1561: batches 40 and 41, the SO(4) in G2 idempotent and the Casimir criterion for the stability of I/c

Log: agent_logs/r1561.log

Overall: CONFIRMED WITH ONE CORRECTION. Batch 40 is right throughout. Batch 41 is right except the E7 ratio: the 1539 component has Casimir ratio 14/9, the record says 4/3. The conclusion (stable) is unchanged.

| claim | verdict | reason in one line |
|---|---|---|
| C1 SO(4) in G2 block constants and idempotent | CONFIRMED | indices 1 and 3, p = (1/2, 3/2), Casimirs 4, 3/2, 4/3, 5/2, Schur kills the L-S block of P_p#P_p, 116a^2-49a+5=0, (11/29, 5/29, sqrt(77/1682)), 746/841 all rederived |
| C2 its instability and I/4's eigenvalues | CONFIRMED | the quadratic form rederived (its 4v^2 coefficient is 2(3a1+5a2), so it holds only at the b != 0 idempotents), H is orthogonal to C, the excess is 7/29, and I/4 has eigenvalues 1, 5/12, -1/4 (trace 7/6, det -5/48) |
| C3 the formula c - Cas_V/4 | CONFIRMED | ad_v X ad_v^T corresponds to ad_v tensor ad_v, and Cas_{h x h} = Cas x 1 + 1 x Cas - 2 sum ad tensor ad gives the factor 1/4. The so(n) Casimirs 0, 2n, 4n-4, 4n-16 give n-2, (n-4)/2, -1, 2 |
| C4 the stability criterion | CONFIRMED | Sym^2 h of simple h has a one-dimensional trivial part, so H orthogonal to I means nontrivial components, and (c - Cas_V/4)/c <= 1/2 iff Cas_V >= 2c. The ratio is independent of how the form is normalised |
| C5 the per-algebra classification | REFUTED (with corrections) at one entry | E7: 1539 = [omega_6] has Cas 56 against Cas(adj) 36, ratio 14/9, not 4/3. It is still stable. All other decompositions and ratios check |
| C6 what it says about U_s | CONFIRMED | U_s with I/c unstable does force "no stable PD idempotent" on sp(m). 2/sqrt3 > 3/sqrt10 checks. The su(m) degeneracy is real, and the wording "off the orbit directions (there are none)" is unclear (see C8) |
| C7 Lean statements | CONFIRMED | all six declarations state the prose's equations with the prose's numbers. No sorry, native_decide or axiom in the file |
| C8 other | NOTE | (a) the <C#H,H> formula holds only at idempotents with b != 0. (b) The title says "outweighs" (strict) while the bold claim says "at least". (c) Screen: on su(3) the degenerate direction carries a nonzero cubic F(H,H,H), so I/c is a third-order saddle and not a local maximiser there |

## Method

Every claim was derived by hand from the definitions and the three quoted lemmas. The Lean file was read declaration by declaration. There was one screen of a few seconds (sage-python, numpy): su(3) built in an orthonormal basis for -tr(AB), # implemented as X#Y = (1/2) sum_ab X_ab ad_a Y ad_b^T, and I#I = 3I checked, then the adjoint copy {d_Z} inside Sym^2 su(3) was tested. It is reported as a screen only. The brief's rules were kept: no other reviewer's material was read and the author's note was not opened.

## C1

- Indices: g2 = (1,0) + (0,1) + (1/2, 3/2) under su(2) x su(2). With Dynkin index I(1/2) = 1, I(1) = 4, I(3/2) = 10, the factor that carries spin 1/2 on p sums to 4 + 4*1 = 8, and the factor that carries spin 3/2 sums to 4 + 2*10 = 24. The ratio 1:3 puts spin 3/2 on the short-root (index 3) factor, so p = (1/2, 3/2) with L first.
- Casimirs: in g2's form (Cas(adj) = 8, long roots of length^2 2), L carries the standard su(2) form, where Cas(j) = 2j(j+1). That gives 4 on L and 3/2 on p. S carries three times that form, so Cas(j) = 2j(j+1)/3, which gives 4/3 on S and 5/2 on p.
- Blocks: P_k#P_k = (1/2)Cas_k on k for a subalgebra k, and P_k#P_p = (1/2)Cas_k on p. This gives 2P_L, (2/3)P_S, (3/4)P_p and (5/4)P_p. P_L#P_S = 0 because [L,S] = 0. P_p#P_p maps into k because [p,p] lies in k, and it is K-invariant. L and S are inequivalent irreducible K-modules, so Schur gives no cross block and a scalar on each. Reading I#I = 4I on L and S gives 2 and 10/3, and its p-part reproduces 4 automatically.
- Equations: expanding C#C gives exactly the three stated equations. Eliminating with a1 = (2 - 5a2)/3 and b^2 = (3a2 - 2a2^2)/10 gives 232a2^2 - 98a2 + 10 = 0, which is the stated quadratic. Its discriminant is 81 and its roots are 1/4 (then b = +-1/4, which are I/4 and sigma/4) and 5/29. The root 5/29 gives a1 = 11/29 and b^2 = 385/8410 = 77/1682. All coefficients are positive for b > 0, so C is positive definite and distinct from I/4 and sigma/4. Its norm is (363 + 75 + 308)/841 = 746/841 > 7/8.

## C2

- C#H = (2a1u1 + 2bv)P_L + ((2/3)a2u2 + (10/3)bv)P_S + ((3/4)(a1v + bu1) + (5/4)(a2v + bu2))P_p. Pairing with weights 3, 3, 8 gives 6a1u1^2 + 2a2u2^2 + (6a1 + 10a2)v^2 + 12bu1v + 20bu2v. The coefficient 6a1 + 10a2 equals 4 only on 3a1 + 5a2 = 2, which is the p-equation divided by b. The formula is therefore valid at both b != 0 roots, including I/4, and nowhere else.
- Orthogonality: 3(6/29) + 8b(-(261/154)b) = 18/29 - 1044/1682 = 0.
- Excess: v^2 = 81/616 and bv = -9/116. Then <C#H,H> = 76/29 + 81/154 + 18/29 and (1/2)||H||^2 = 3 + 81/154, so the difference is 7/29.
- I/4: the matrix is [[1/2,0,1/2],[0,1/6,5/6],[3/16,5/16,1/2]]. Its row sums are 1, its trace is 7/6 and its determinant is -5/48, so the other two eigenvalues sum to 1/6 with product -5/48, which gives 5/12 and -1/4.

## C3

- (vv^T)#X = (1/2)ad_v X ad_v^T holds on rank ones, both sides are linear in X, and rank ones span Sym^2. For C = sum lambda_i v_i v_i^T with lambda_i >= 0 this is a Kraus form, hence completely positive.
- Under a b^T <-> a tensor b, A X B^T corresponds to (A tensor B), so I# corresponds to (1/2)sum ad_k tensor ad_k. Since Cas_{h x h} = -sum(ad tensor 1 + 1 tensor ad)^2 = Cas tensor 1 + 1 tensor Cas - 2 sum ad tensor ad, the operator is (1/4)(Cas tensor 1 + 1 tensor Cas - Cas_{h x h}). No sign issue arises, because ad_v^T = -ad_v enters only through this correspondence. On V it is (1/4)(4c - Cas_V).
- so(n), with an orthonormal epsilon basis and Cas(adj) = 2n - 4: 2e1 gives 4 + 2(n-2) = 2n, 2e1+2e2 gives 4n-4, e1+..+e4 gives 4n-16. At n = 4 and n = 8 the Weyl and Lambda^4 parts split into halves of equal Casimir. At n = 4, Lambda^4 is trivial (Casimir 0).

## C4

Confirmed as written. L_{I/c} = (1/c)I#. acts on every irreducible by (c - Cas_V/4)/c = 1 - Cas_V/(2Cas(adj)), which is a ratio and so independent of the normalisation of the form. The criterion is intrinsic to Sym^2 h. Ambient stability in Sym^2 so(n) restricts to it, since h's # is the ambient # restricted, so the use in U_s is sound.

## C5

Every ratio below uses Cas(lambda) = <lambda, lambda + 2 rho> with long roots of length^2 2.

- so(n) and su(2): confirmed. The Lambda^4 ratio (4n-16)/(2n-4) is at least 1 iff n >= 6.
- su(m), m >= 3: confirmed. Sym^2 = 1 + adj + [2w1+2w_{m-1}] + [w2+w_{m-2}]. With Cas(adj) = 2m the last two have Casimirs 4m+4 and 4m-4, both above 2m. So the adjoint copy (the d-tensor) is the only marginal component.
- sp(m), m >= 2: confirmed. Sym^4 W stays irreducible, and S_(2,2)W restricts to [2w2] + [w2] + 1 (Littlewood restriction, dimensions 35+14+5+1 = 55 at m = 2). With <e_i,e_j> = delta/2 and rho = (m,...,1): Cas(2e1) = 2m+2, Cas(e1+e2) = 2m, Cas(2e1+2e2) = 4m+2 and Cas(4e1) = 4m+8. The eigenvalue at w2 is (m+2)/(2(m+1)), which is 2/3 at m = 2.
- g2: confirmed. With <w1,w1> = 2/3, <w1,w2> = 1, <w2,w2> = 2 and rho = w1+w2: Cas(7) = 4, Cas(14) = 8, Cas(27) = 28/3 (ratio 7/6, eigenvalue 5/12) and Cas(77) = 20 (ratio 5/2, eigenvalue -1/4). These match batch 40's values.
- The 2 theta component: Cas = 8 + 2(2h - 2) = 4h + 4, ratio 2 + 2/h. Confirmed.
- f4: 324 = [2w4], and Cas(26) = 12 gives Cas = 4 + 2*11 = 26. The ratio is 26/18 = 13/9. Confirmed.
- e6: 650 = [w1+w6], with <lambda,lambda> = 4 and <w1,2rho> = 16. Cas = 36, ratio 3/2. Confirmed.
- e8: 3875 = [w1], with (w1,w1) = 4 and a row sum of 46. Cas = 96, ratio 8/5. Confirmed.
- **e7: REFUTED as stated.** Sym^2(133) = 1 + 1539 + 7371 (the dimensions sum to 8911), and 1539 = [w6] (Bourbaki). The w6 row of E7's inverse Cartan matrix is (2,3,4,6,5,4,2). That gives (w6,w6) = 4 and <w6,2rho> = 52, so Cas = 56. The same computation calibrates to Cas(adj) = 36 and Cas(56) = 57/2. **The ratio is 56/36 = 14/9, not 4/3.**
- Independent check of the e7 value: across the series the ratio for Y2* is 1 + (2h/3 - 2)/h. This fits g2 (7/6), f4 (13/9), e6 (3/2) and e8 (8/5), and gives e7 14/9.
- **Correction:** replace "4/3" by "14/9" in the f4..e8 bullet. The verdict (stable) stands.
- Decompositions: each one's completeness was checked by dimension count.

## C6

- sp(m): I/c is unstable there, so U_s as worded does assert that no positive-definite idempotent on sp(m) is stable. This is a strong claim, and the record states it correctly.
- sp(2): 2/sqrt3 ~ 1.155 against 3/sqrt10 ~ 0.949. On so(4), I#I = 2I = P_+#P_+ + P_-#P_-, so P_+#P_+ = 2P_+ and F/||P_+||^3 = 6/3^{3/2}. The inclusion so(4) in so(5) preserves the form. Confirmed.
- For m >= 3, "the maximiser is not I/c" rests on the second-order condition. Along a unit H orthogonal to a unit X, F(X+tH)/||X+tH||^3 has t^2 coefficient 3F(X,H,H) - (3/2)F(X), so instability excludes I/c as a local maximiser. Confirmed.
- su(m): the degeneracy is real. The parenthesis "off the orbit directions (there are none, I being invariant)" is unclear, and should say plainly that the eigenvalue-1/2 space is the adjoint copy and that symmetry does not account for it.

## C7

- g2_so4_witness states the three coefficient equations with (11/29, 5/29, b), where b^2 = 77/1682.
- g2_so4_unstable states the orthogonality 3u1a1 + 3u2a2 + 8vb = 0 and the excess 7/29 using the prose's quadratic form verbatim, including its 4v^2 term.
- g2_so4_norm states 746/841 and the comparison with 14/16.
- so_sharp_scalars states the four subtractions.
- stable_iff_cas states the equivalence with c > 0.
- sp_omega2_unstable states the equality and the strict inequality for m > 0.
- Positive definiteness and distinctness from I/4 are not in Lean. The table does not claim them, and they are immediate from the numbers.

## C8

- (a) Batch 40's formula for <C#H,H> is stated for "H in the span" without saying that its 4v^2 coefficient uses 3a1 + 5a2 = 2. For a general C in the span the coefficient is 6a1 + 10a2. Suggested fix: say "at an idempotent with b != 0".
- (b) Batch 41's heading says every component "outweighs" the adjoint, which reads as strict. The bold claim and the su(m) bullet use "at least", with equality allowed. Suggested fix: align the heading to "at least as heavy as".
- (c) Screen, su(3). On the adjoint copy {d_Z : Z in su(3)} in Sym^2 su(3), the Peirce eigenvalue of I/c is exactly 1/2 (numerically 0.5). The invariant cubic F(H,H,H) is 0.274 at a random unit H, so it is nonzero.
- Along +-H orthogonal to I, the t^3 coefficient of F/||.||^3 at I/sqrt(N) is F(H,H,H), because F(X,X,H) = 0. So I/c is a third-order saddle on su(3), not a local maximiser of F. The "degenerate second-order test" therefore resolves against I/c at m = 3.
- Consequence: U_s (a statement about second-order stability) still permits I/c on su(3), and the maximiser of F on Sym^2 su(3) is not I/c. This is a screen, not a proof. For general m it needs the hand argument that F restricted to the adjoint copy is a nonzero multiple of the d-cubic.
