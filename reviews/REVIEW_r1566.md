# Review r1566: batches 42 and 43, three approaches to U_s at their obstacles, the support test, and the Sp(1)Sp(m) and U(3) families

Log: agent_logs/r1566.log

Overall: CONFIRMED WITH GAPS. Every computation re-derives. The gaps are in how two conclusions are stated: the branch mechanism (D6) is presented as a mechanism but is a heuristic, and the closing scope sentence (D7) runs ahead of what is proved.

| claim | verdict | reason in one line |
|---|---|---|
| D1 the diagonal problem and the quarter-circle example | CONFIRMED | Law, conditional diagonal, tau, kappa, the h-test and the cubic's turn at u* = C/(1-3C) all re-derive. |
| D2 averaged stability | CONFIRMED | Averaged bound, the identity t - (c/d)t^2 = sum over nontrivial V, and kappa >= tau^2(3-2tau) up to the 1/dim V terms re-derive, and the obstacle is accurate. |
| D3 F on orbit tangents | CONFIRMED | The cubic expansion and (1-2L_C)D_Y D_X C = 2u_X#u_Y re-derive, so F vanishes on orbit tangents. The closing "counterexamples offer none to test" is unchecked and beside the point. |
| D4 the support test | CONFIRMED | The hh-block of P_V#P_V is Cas_h(V) dim V/(2d) I_h, giving tr C <= d/Cas_h(V). The three examples come out as k-1 > k-2, 3/2 <= 2, and equality. |
| D5 Sp(1)Sp(m) and U(3) families | CONFIRMED | All block constants, both trace checks and the m = 2 quadratic re-derive. A screen reproduces m = 3..6. The U(3) constants give (4a-1)^2 = 0. |
| D6 the branch mechanism | PLAUSIBLE (with corrections) | I/c on (-,-) needs c_i <= c/2, which is unstated (SO(4) in G2 has c_L = c/2 exactly). "Seeds a positive root" is an intermediate-value picture that is not proved. |
| D7 scope of the closing claims | PLAUSIBLE (with corrections) | Sp(1)Sp(m) is covered for m <= 6 only. L264(4)'s y <= 2x leaves x < y < 2x open, which would give a second positive-definite root, so "only I/c" on the two-component table needs y <= x row by row. |
| D8 Lean statements | CONFIRMED | All three declarations state what the table says. The quarter_circle_turn docstring is wrong: it gives u* < 1/2 for 0 < 3C < 1, and the correct range is 5C < 1. |

## Method

- Read each step of the quoted text against the givens (L263, L264, L265 and the definitions), then derived each step by hand in the notation d = dim h, t = tr C, tau = ct/d, kappa = c^2 ||C||^2/d.
- One screen, labelled as such: a Sage/Singular real variety of the Sp(1)Sp(m) system for m = 2..8, 10, 20, which ran in seconds (scratchpad sp1spm.sage). It is reported as a screen and supports no positive claim beyond what the record already labels a screen.
- Read the Lean declarations quarter_circle_turn, sp1sp2_idem and u3su4_double in lean/HamiltonsCubic/Results/I117LemmaF.lean for fidelity. I did not rebuild them.

## D1

- **Law.** s_ijk = <[v_i,v_j],v_k> is totally antisymmetric by ad-invariance, so s^2 is totally symmetric and the law is exchangeable. Its row sum is sum_jk s_ijk^2 = 2 (I#I)_ii = 2c, so the total mass is 2cd and each marginal is 1/d.
- **Diagonal.** (C#C)_kk = (1/2) sum_ij lambda_i lambda_j s_ijk^2. Multiplying by c gives sum x_i x_j s^2/(2c) = x_k, and the left side is exactly E[x_J x_K | I = k] = d sum_jk x_j x_k s^2/(2cd).
- **Moments.**
  - E x = tau by definition.
  - E[x_I x_J] = E[x_J x_K] = E[E[x_J x_K | I]] = E x_I = tau, by exchangeability.
  - E[x_I x_J x_K] = E[x_I^2] = kappa.
  - "Lemma C is E[x_J x_K/x_I] = 1 >= tau" is compressed but true. Symmetrising with bc/a + ca/b + ab/c >= a + b + c for positive a, b, c gives 1 >= E x = tau.
- **h-test.**
  - For diagonal H = sum h_i v_i v_i^T we get <C#H,H> = d E[x_I h_J h_K] and ||H||^2 = d E h^2.
  - With r = tau/kappa, E[xh] = 0. The left side is tau - tau^2/kappa and E h^2 = 1 - tau^2/kappa.
  - The inequality rearranges to kappa(2tau - 1) <= tau^2, as the record says.
- **Quarter circle.**
  - Write s = a1 + a2, so s^2 = 1 + 2u, and f = s(1 + (3C-1)u).
  - Then df/du = (3C + u(9C-3))/s, which matches the record.
  - The derivative is positive on (0, u*) and negative on (u*, 1/2) when 0 < 3C < 1 and u* < 1/2, that is 5C < 1. For 3C >= 1 it is positive throughout.
  - As the angle runs from 0 to pi/2, u runs 0 to 1/2 and back to 0. So there are two interior maxima and a minimum at the diagonal exactly when 0 < 5C < 1.
  - Cosmetic: the constant C clashes with the idempotent C.

## D2

- **Correction term.** For H' = H - <H,C>C/||C||^2, using C#C = C and <C#C,H> = <C,H>, stability reads <C#H,H> <= 1/2 + <H,C>^2/(2||C||^2) for unit H.
- **Averaging.**
  - The average of (gH)#(gH) over the group is invariant, so it equals (<I#H,H>/d) I = ((c - Cas_V/4)/d) I by L265.
  - The average of <gH,C>^2 is ||C_V||^2/dim V by Schur. This uses V of multiplicity one in Sym^2 h. It also holds for complex type, since a symmetric equivariant map is then real scalar.
  - Together these give the displayed bound.
- **Identity.** sum over all V of (c - Cas_V/4)||C_V||^2 = <I#C,C> = tr(C#C) = t. The trivial component contributes c t^2/d, which gives the stated identity over nontrivial V.
- **Summing.** Summing over nontrivial V and scaling by c^2/d gives tau^2(1-tau) <= (kappa - tau^2)/2 + (1/dim V terms), that is kappa >= tau^2(3 - 2tau) - (nonnegative terms). "Up to the 1/dim V terms" is the accurate qualifier.
- **Obstacle.** Where I/c is strictly stable, c - Cas_V/4 < c/2 on nontrivial V. The left side is then below tau/2 <= 1/2, so every averaged bound holds for any C with tau <= 1 and excludes nothing. That is the stated obstacle.

## D3

- **Expansion.** Along C + sH with H perpendicular to C and L_C H = H/2:
  - F(C+sH) = ||C||^2 + (3/2)s^2||H||^2 + s^3 F(H,H,H), using F(C,C,H) = <C,H> = 0.
  - Dividing by (||C||^2 + s^2||H||^2)^(3/2) cancels the s^2 term and leaves ||C||^{-1}(1 + s^3 F(H,H,H)/||C||^2 + O(s^4)). The record's formula holds.
  - At a local maximum the odd term must vanish. By polarisation F vanishes on the eigenspace as a trilinear form.
- **Orbit tangents.**
  - Conjugation by Ad_g preserves # because Ad_g is a bracket automorphism and an isometry, so D_X = [ad_X, .] is a derivation.
  - D_X C = 2C#D_X C, and u_X is perpendicular to C (trace of a commutator).
  - Applying D_Y gives D_Y D_X C = 2u_Y#u_X + 2C#D_Y D_X C, so (1 - 2L_C)D_Y D_X C = 2u_X#u_Y.
  - Self-adjointness then gives F(u_X,u_Y,u_Z) = (1/2)<D_Y D_X C, (1-2L_C)u_Z> = 0. Signs and factors are right.
- **Minor.**
  - The condition also binds on mixed terms F(u,u,W) and F(u,W,W) with W off the orbit, which "1/2-eigenvectors off the orbit" covers if read as all non-orbit vectors of the eigenspace.
  - I did not screen "the known counterexamples offer none to test". It is also moot: those idempotents are unstable, so they are not local maxima and the third-order condition says nothing about them.

## D4

- **Orthogonality.** C lies in the hh-block and P_V in the VV-block, so <P_V, C> = 0.
- **The hh-block.**
  - <h_i, (P_V#P_V) h_j> = (1/2) sum_a <[h_i,e_a],[h_j,e_a]> = -(1/2) tr_V(ad_{h_i} ad_{h_j}), using [h,V] in V.
  - This is an invariant form on simple h, hence a scalar, and its trace over an orthonormal basis is Cas_h(V) dim V. That gives Cas_h(V) dim V/(2d) I_h.
  - Only h-invariance of V is used, so irreducibility is not needed.
- **Stability.** The stability here is L264(1)'s ambient one on Sym^2 so(n). It gives (Cas_h(V) dim V/(2d)) t <= dim V/2, that is t <= d/Cas_h(V). At C = I_h/c_h this becomes Cas_h(V) <= c_h.
- **Examples.** The form is -(1/2)tr, which gives c = n-2 and Cas(vector) = n-1.
  - For the so(k) block: vector Casimir k-1 against c = k-2, so it fails.
  - For Lambda^2_+: the orthonormal basis has [f1,f2] = sqrt(2) f3, so c = 2. R^4 is spin 1/2 with Casimir (3/8)·4 = 3/2 <= 2, so it passes. Lambda^2_- and the remaining so(n-4) summands are trivial.
  - For G2 in SO(7): Cas(7)/Cas(14) = 1/2, so equality holds.

## D5

- **Sp(1)Sp(m) constants, all re-derived.**
  - |L_i|^2 = 2m and [L_i,L_j] = 2L_k, so ||[u1,u2]||^2 = 2/m and c1 = 2/m.
  - p is spin 1 for sp(1), so alpha1 = 2/m. The trace check 12/m + 4d_p/m = 6(4m-2) returns d_p = 6m^2 - 3m - 3 = 3(2m+1)(m-1), the correct dimension.
  - For C_m with rho = (m,...,1): (omega2, omega2 + 2rho) = 4m and (2e1, 2e1 + 2rho) = 4m + 4, so the ratio is m/(m+1).
  - The sp(m) trace identity gives Cas_adj = 2(m+1). Hence c2 = m+1 and alpha2 = m.
  - x1 = c - 2/m, x2 = 3m - 3 and y = 2m - 2 - 4/m. Both x_i d_i = alpha_i d_p checks hold.
  - Cross blocks vanish: [k1,k2] = 0, p is not isomorphic to k1 or k2, and p is of real type.
- **Equations at m = 2.** The equations are as stated. At m = 2 (y = 0), eliminating gives -a2^2 + (5/3)a2 - 1/4 = 0, that is 3a2^2 - 5a2 + 3/4 = 0, with roots 1/6 and 3/2.
  - a2 = 1/6 gives a1 = 1/6 and b = ±1/6, which are I/6 and sigma/6.
  - a2 = 3/2 gives a1 = -5/2. It also gives b^2 = (a2 - 3a2^2)/3 < 0, so this root is not even real.
- **Screen for m = 3..6.** Solutions with b ≠ 0 are I/c and one real root with b < 0. The screen confirms this for m = 3..6 and also at m = 7, 8, 10, 20. No proof covers general m.
- **U(3) in SU(4).**
  - The su(3) in so(6) embedding is the one inside G2, so c1 = 3 and alpha = 4/3 (ratio 4/9).
  - J has |J|^2 = 3 and ad_J^2 = -4 on V, so alpha_u1 = 2/3.
  - y = 4 - 8/3 - 4/3 = 0, x1 = 1 and x2 = 4. Both x_i d_i = alpha_i d_V checks hold (8 = 8 and 4 = 4).
  - Eliminating gives 48a^2 - 24a + 3 = 0, that is (4a-1)^2 = 0, with a = e = 1/4 and b^2 = 1/16, which is I/4.
  - The link to L265's marginal adjoint copy is a consistent reading: su(4)'s adjoint copy in Sym^2 carries a U(3)-invariant vector. It is offered as an observation, which is appropriate.

## D6

- **Correction 1: the branch condition.** 1/c lies on the (-) branch of ideal i exactly when 1/c <= 1/(2c_i), that is c_i <= c/2. The record states "I/c sits on the (-,-) branch" with no condition.
  - For Sp(1)Sp(m) the condition holds. At m = 2, c2 = 3 = c/2: I/6 sits at the sp(2) branch point, with discriminant 1 - 4·3·3/36 = 0.
  - For SO(4) in G2, trace identities give c_L = 2 = c/2 and c_R = 2/3, with alpha_L = 3/4, alpha_R = 5/4, y = 0, x_L = 2 and x_R = 10/3. So I/4 sits at the branch point of su(2)_L.
- **Batch 40's idempotent.**
  - (11/29, 5/29) satisfies 3a1 + 5a2 = 2, and both ideal equations give the same b^2 = 77/1682.
  - a1 = 11/29 > 1/(2c_L) = 1/4 puts it on (+) for L, and a2 < 1/(2c_R) = 3/4 puts it on (-) for R. So it is on (+,-).
  - The record's test "a1 above 1/c" is the right test only because 1/c = 1/(2c_L) here.
- **Value at b -> 0.** It is 2alpha1/c1 = 2 Cas_k1(p)/Cas_k1(k1), which is correct.
- **Correction 2: the mechanism.** "A positive root on that branch leaves P_k1/c1 when the ratio is below 1/2" is not established.
  - Let g(b) be the left side of the last equation along the (+,-) branch. Then g(0) < 1 yields a root only if g reaches 1 before the branch ends. The record says nothing about g at the far end, which is where the (+) and (-) branches of k1 join.
  - Conversely, "Sp(1)Sp(m) has ratios 1 and m/(m+1), so neither branch starts below 1" does not exclude a root, since g need not be monotone. The m <= 6 screen is what carries the Sp(1)Sp(m) conclusion.
  - The root also does not sit at P_k1/c1 when b = 0 unless the ratio is exactly 1/2, so "leaves" is a picture.
  - The bold "the mechanism is the one L263 isolates" should read as a heuristic. L263's criterion (y > x, that is ratio < 1/2) is proved for one ideal only.

## D7

- **What the quoted text proves and screens.**
  - Sp(1)Sp(m) is proved for m = 2 and screened for m = 3..6. It is unaddressed for m >= 7 (my spot screen agrees there, as a screen), so the unqualified "Sp(1)Sp(m)" in the list overstates.
  - U(3) in SU(4) is proved.
  - "U(m)", the coordinate-diagonal family and the single-Casimir symmetric pairs are asserted from earlier batches outside the quoted text, and I could not check them from the givens.
- **The two-component table.** L264(4) gives y <= 2x on so(n), n >= 7, and says that for x < y < 2x the positive-definite second root exists (and is unstable). So "I/c as the only positive-definite idempotent" on the table needs y <= x in every row, a stronger statement than L264(4) records.
  - G2 in SO(7) (ratio exactly 1/2, so y = x) gives b = 0, which is not positive definite on so(7).
  - Spin(7) in SO(8) has ratio 3/5 > 1/2.
  - Correction: cite y <= x per row, or say "U_s holds" (which is what L264(4) gives) rather than "only positive-definite idempotent".
- **Range mismatch.** "U on so(n), n >= 7, would leave H needing only the support" is inconsistent with L264(3), which delivers H at n >= 9. The range should match.

## D8

- **sp1sp2_idem.** h1: a1^2 + 5b^2 = a1 (c1 = 1, x1 = 5). h2: 3a2^2 + 3b^2 = a2. h3: 2a1 + 4a2 = 1 (y = 0). With a1 > 0 it concludes a1 = a2 = 1/6 and b^2 = 1/36.
  - This is faithful. h3 is the b-divided equation, which matches "b ≠ 0".
  - The conclusion admits b = -1/6 (sigma/6), so "the only solution ... is I/6" means the only positive one.
- **u3su4_double.** Faithful.
- **quarter_circle_turn.** It proves the iff under 0 < C and 3C < 1. The range C >= 1/3, where there is no turn, is outside it, which is harmless.
  - The docstring is wrong: "changes sign at u* = C/(1 - 3C) < 1/2 when 0 < 3C < 1" fails for 1/5 <= C < 1/3. It should read "when 0 < 5C < 1".
  - The declaration locates u* only. The derivative-sign formula and the two-maxima conclusion are prose.
