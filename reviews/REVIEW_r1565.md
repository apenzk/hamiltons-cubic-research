# Review r1565: batches 42 and 43, three approaches to U_s at their obstacles, the support test, and the Sp(1)Sp(m) and U(3) families

Log: agent_logs/r1565.log

Overall: CONFIRMED WITH GAPS. Every computation checks. Three statements claim more than their argument carries: the quarter-circle obstacle, the branch assignment of I/c, and the closing scope sentence.

| claim | verdict | reason in one line |
|---|---|---|
| D1 the diagonal problem and the quarter-circle example | PLAUSIBLE | Every identity checks and the cubic turns inside (0, 1/2) exactly when 5C < 1. But the toy cubic has T_111 = 1, and a bracket law has T_ijk = 0 whenever an index repeats, so the toy lies outside the diagonal problem it is offered as a witness for. |
| D2 averaged stability | CONFIRMED | Schur, the correction term and kappa >= tau^2(3 - 2tau) all check. The sum runs over the nontrivial components (left implicit). The obstacle is accurate. |
| D3 F on orbit tangents | CONFIRMED | The third-order expansion checks, and D_X C = 2C#D_X C and (1 - 2L_C)D_Y D_X C = 2u_X#u_Y are right with their signs and factors, so F(u_X,u_Y,u_Z) = 0. |
| D4 the support test | CONFIRMED | P_V is orthogonal to C, the hh block is Cas_h(V) dim V/(2d) I_h, tr C <= d/Cas_h(V) follows, and all three examples check. |
| D5 Sp(1)Sp(m) and U(3) families | CONFIRMED | Every block constant, the trace and symmetry checks, the m = 2 quadratic and its roots, the U(3) double root, and (as a screen) m = 3..6. |
| D6 the branch mechanism | PLAUSIBLE (with corrections) | I/c lies on the (-,-) branch only when c_i <= c/2, which fails for so(8)+so(3) in so(11). The seeding rule is a heuristic and has no proof. Batch 40's idempotent is on (+,-), which is correct. |
| D7 scope of the closing claims | PLAUSIBLE (with corrections) | Sp(1)Sp(m) is settled only for m <= 6 (m = 2 by hand). For the two-component table, "only positive-definite idempotent" says more than L264 (4), which gives U_s. |
| D8 Lean statements | CONFIRMED | The file builds clean and all three theorems are faithful. Two nits: the quarter_circle_turn docstring says u* < 1/2 when 0 < 3C < 1, and the brief's table says "only I/6" where sigma/6 also qualifies. |

## Method

- Every step was derived by hand from the givens: the bracket law, the Schur averages, the derivation D_X, and the block constants from the trace identities.
- The record's inner product was pinned as <X,Y> = -(1/2)tr(XY) on so(n), which gives c = n - 2 and Cas(vector) = n - 1.
- Screen (sage's python with sympy, a few seconds): an exact solve of the Sp(1)Sp(m) system for m = 2..6. This is a screen, not a proof.
- Build: `lake env lean HamiltonsCubic/Results/I117LemmaF.lean` finished clean in 7 s.

## D1

- **The law.** <[v_i,v_j],v_k> is totally antisymmetric by ad-invariance, so its square is symmetric and the law is exchangeable.
- **Normalisation.** The total mass is sum_i ||ad_{v_i}||^2 = tr Cas = 2cd.
- **Marginals.** The row sum -tr(ad_{v_i}^2) = 2c is constant on a simple algebra (Killing form proportional to the inner product), so each marginal is 1/d.
- **The diagonal.** c(C#C)_ii = (1/(2c)) sum_jk x_j x_k T_ijk = E[x_J x_K | I = i]. This checks.
- **The moments.** E[x_I x_J] = E[E[x_J x_K | I]] = tau by exchangeability. E[x_I x_J x_K] = E[x_I^2] = kappa. This checks.
- **Lemma C.** Symmetrise E[x_J x_K / x_I] and use ab/c + bc/a + ca/b >= a + b + c. That gives 1 >= tau. This checks.
- **Diagonal stability.** <C#H,H> = d E[x_I h_J h_K] and (1/2)||H||^2 = (d/2)E h^2.
- **The test direction.** h = 1 - (tau/kappa)x has E[xh] = 0. The two sides are tau - tau^2/kappa and (1 - tau^2/kappa)/2, which gives kappa(2tau - 1) <= tau^2. This checks.
- **The cubic.** Put s = a_1 + a_2 and u = a_1 a_2. Then f = s(1 - u + 3Cu) and df/du = (3C + u(9C - 3))/s.
    - u runs over [0, 1/2], with 1/2 at the diagonal.
    - For 0 < 5C < 1 the sign turns from + to - at u* in (0, 1/2), which gives two interior maxima and a minimum at the diagonal.
    - At C = 1/5 the diagonal is the unique maximum. For C > 1/5 there is no turn inside.
    - So "exactly when" is right.
- **Gap.** The coefficient tensor of any bracket law vanishes on triples with a repeated index ([v_i,v_i] = 0). The toy has T_111 = T_222 = 1.
    - The toy therefore shows only that exchangeability plus uniform marginals, with mass allowed on the diagonal, admit several interior maxima.
    - That is not the diagonal problem of approach 1. The repeated-index zeros are a constraint of the diagonal problem that needs no Jacobi.
    - The conclusion "the Lie structure has to enter" may still be true.
    - Repair: build an example on blocks of size >= 3 with vanishing repeated-index coefficients, or reword the obstacle to name the relaxation actually tested.

## D2

- **Averaging.** For unit H in an irreducible V, the Ad-average of H tensor H is P_V/dim V. The only symmetric invariant operator on V is the identity, for real, complex or quaternionic type alike.
- **Trace of L_C on V.** tr(L_C|_V) = <C, sum_a E_a # E_a>. The sum is invariant, so it equals mu I with mu d = dim V (c - Cas_V/4) by L265. The left side is therefore (t/d)(c - Cas_V/4).
- **The correction term.** Project out C. With H' = H - <H,C>C/||C||^2, we get <C#H',H'> = <C#H,H> - <H,C>^2/||C||^2 and ||H'||^2 = 1 - <H,C>^2/||C||^2. The Ad-average of <gH,C>^2 is ||C_V||^2/dim V. This gives the stated bound exactly.
- **The summed identity.** Summing (c - Cas_V/4)||C_V||^2 over all V gives F(I,C,C) = t. The trivial component contributes c t^2/d. So t - (c/d)t^2 is the sum over the nontrivial V only, and the summation must exclude the trivial one. This is left implicit.
- **The resulting bound.** In tau and kappa: tau^2(1 - tau) <= (kappa - tau^2)/2 + (nonnegative 1/dim V terms), which is kappa >= tau^2(3 - 2tau) minus those terms. This checks.
- **The obstacle.** With tau <= 1 the left side is at most (c - Cas_V/4)/c, and that is below 1/2 whenever Cas_V > 2c. So each averaged bound holds automatically and carries no information about C. The obstacle is accurately stated.

## D3

- **The expansion.** Take H in the 1/2-eigenspace. H is orthogonal to C by self-adjointness, since L_C C = C.
    - F(C+sH) = ||C||^2 + (3/2)s^2||H||^2 + s^3 F(H).
    - ||C+sH||^2 = ||C||^2 + s^2||H||^2.
    - The ratio is ||C||^{-1}(1 + s^3 F(H)/||C||^2 + O(s^4)).
    - At a local maximum the odd term vanishes, and F vanishes on the whole eigenspace by polarisation. This checks.
- **Orbit tangents.** # is Aut-equivariant (conjugation by g in Aut(g) maps vv^T to (gv)(gv)^T and brackets to brackets). So D_X A = [ad_X, A] is a derivation of #.
- **The identities.** Differentiating C = C#C gives D_X C = 2C#D_X C, so u_X is in the 1/2-eigenspace. Differentiating again gives D_Y D_X C = 2u_Y#u_X + 2C#D_Y D_X C, which is the stated identity.
- **The vanishing.** Self-adjointness then gives F = (1/2)<D_Y D_X C,(1 - 2L_C)u_Z> = 0.
- **Remark.** "The known counterexamples offer none to test" is loosely put. Those idempotents are unstable, so none of them is a local maximum and the third-order condition does not bind at them in any case.

## D4

- **Orthogonality.** C is supported on the hh block and P_V on V, which is orthogonal to h, so <C,P_V> = 0.
- **The hh block.** For u in h, <u,(P_V#P_V)u> = (1/2)sum_ab <[e_a,e_b],u>^2 = (1/2)tr_V(-ad_u^2), using [h,V] in V. The block is h-invariant, so it is a scalar on simple h, with trace (1/2)Cas_h(V) dim V. This checks.
- **The trace bound.** Stability at H = P_V/sqrt(dim V) gives tr C <= d/Cas_h(V).
- **At I_h/c_h.** Here c_h = Cas_h(h)/2, since # of elements supported on h uses only the brackets of h. The bound becomes Cas_h(V) <= Cas_h(h)/2.
- **Examples.**
    - so(k) block: Cas(vector) = k - 1 against k - 2 in the record's normalisation, so it fails.
    - Lambda^2_+: c = 2, and R^4 is spin 1/2 with Casimir (3/8)(4) = 3/2 <= 2, so it passes.
    - G_2 in SO(7): Cas(7)/Cas(14) = 1/2, so equality holds.
    - All three check.

## D5

- **The sp(1) block.**
    - ||L_i||^2 = 2m and [u_1,u_2] = L_k/m has squared norm 2/m, so c_1 = 2/m.
    - p is spin 1, so alpha_1 = c_1 = 2/m.
    - The trace identity 3c_1 + alpha_1 d_p = 3c holds, with d_p = 3(2m+1)(m-1). The record's check is this identity doubled.
- **The sp(m) block.**
    - Cas(omega_2)/Cas(2omega_1) = 4m/(4m+4) = m/(m+1).
    - c_2 d_2 + (m/(m+1))c_2 d_p = c d_2 gives c_2 = m+1 and alpha_2 = m.
    - Sanity check at m = 1: both ideals of so(4) have c = 2.
- **The remaining constants.**
    - x_1 = 4m - 2 - 2/m, x_2 = 3m - 3 and y = 2m - 2 - 4/m.
    - x_i d_i = alpha_i d_p holds for both ideals.
    - The cross blocks vanish because the k-modules k_1, k_2 and p are pairwise non-isomorphic. The coefficient equations are as stated.
- **m = 2.**
    - The equations are a_1^2 + 5b^2 = a_1, 3a_2^2 + 3b^2 = a_2 and 2a_1 + 4a_2 = 1. They give 3a_2^2 - 5a_2 + 3/4 = 0 with roots 1/6 and 3/2.
    - b = +1/6 gives I/6 and b = -1/6 gives sigma/6. At a_2 = 3/2, a_1 = -5/2 (and b^2 < 0).
    - The constants agree with the block so(3)+so(5) in so(8) (c = 1 and 3, x_1 = 5), which is consistent with triality.
- **Screen, m = 3..6.** Four roots each, which is complete by Bezout. They are I/c, one real root with b < 0, and two complex roots. This matches the record.
- **U(3) in so(6).**
    - c_1 = 3, since Cas(adj) = 6 in the form -tr_C.
    - Cas(Lambda^2 C^3) = 8/3, a ratio of 4/9, so alpha = 4/3.
    - For u(1), J/sqrt 3 acts with charge 2 on p, giving 2/3.
    - y = 0, x = 1 and x_{u(1)} = 4.
    - The system gives (4a - 1)^2 = 0, with a = e = 1/4 and b^2 = 1/16. This checks.
    - The reading as L265's marginal case is consistent: the family span meets the adjoint copy in Sym^2 su(4).

## D6

- **Correction to "I/c sits on the (-,-) branch".** a_i = 1/c lies on the minus branch iff 1/c <= 1/(2c_i), that is iff c_i <= c/2.
    - The inequality holds for Sp(1)Sp(m) when m >= 3. It is an equality at m = 2 for sp(2) (c_2 = 3 = c/2), where the branches meet.
    - It is also an equality at SO(4) in G_2 for su(2)_L. There c_L = 2 = c/2, from c_i(3 + 8r_i) = 12 with r_L = 3/8.
    - It is not automatic with two ideals. For so(8)+so(3) in so(11), c_1 = 6 > 9/2, so I/c lies on the (+,-) branch.
    - The sentence needs the hypothesis c_i <= c/2, or it must be restricted to the families named.
- **The b -> 0 value.** On (+,-) the last equation's left side tends to 2alpha_1/c_1 = 2 Cas_{k_1}(p)/Cas_{k_1}(k_1). This checks.
- **The seeding rule is a heuristic, not a result.** "A positive root on that branch leaves P_k1/c1 when the ratio is below 1/2" is an intermediate-value picture. Two things would be needed to make it a result:
    - a proof that the left side reaches 1 before the branch ends at 4c_i x_i b^2 = 1;
    - a proof that a start value >= 1 excludes roots on that branch, which is what "neither branch starts below 1" is used for.
    - Neither is proved. For one ideal, L263 does give the exact criterion y > x.
- **Batch 40's idempotent.** c_L = 2, c_S = 2/3, x_L = 2, x_S = 10/3, alpha_L = 3/4, alpha_S = 5/4 and y = 0. At (11/29, 5/29, b^2 = 77/1682) all three equations hold.
    - 11/29 > 1/(2c_L) = 1/4, so a_1 is on the plus branch.
    - 5/29 < 1/(2c_S) = 3/4, so a_2 is on the minus branch.
    - So the idempotent is on (+,-). This is correct.

## D7

- **Sp(1)Sp(m).** Only m = 2 is proved, and m <= 6 is screened. Listing the family without a bound overstates.
- **The two-component table.** L264 (4) proves U_s (stability) on the ansatz for y <= 2x. For x < y < 2x a positive-definite second root exists and is unstable.
    - "Only positive-definite idempotent" therefore requires y <= x for every entry of the table.
    - I could not check that from the givens. As stated, the claim goes beyond L264 (4).
- **U(m).** Only U(3) is in scope here.
    - For U(m), the ratio Cas_{su(m)}(Lambda^2)/Cas(adj) = (m-2)(m+1)/m^2 is at least 1/2 for m >= 4.
    - That is consistent with the claim, but the earlier batches were not re-verified.
- **Coordinate-diagonal and single-Casimir symmetric pairs** rest on earlier batches that were not reviewed here.
- **The final sentence.** "A proof of U on so(n) would leave H needing only the support to be all of so(n)" is correct given L264 (1)-(3). There is one caveat: U (all positive-definite idempotents) is stronger than U_s, and U_s is all that is needed.

## D8

- **quarter_circle_turn** proves the arithmetic iff under 0 < C and 3C < 1. That is faithful, since there is no turn for 3C >= 1.
    - Docstring error: "changes sign at u* < 1/2 when 0 < 3C < 1". For 1/5 <= C < 1/3, u* >= 1/2. It should read 5C < 1.
    - The derivative computation itself stays in prose.
- **sp1sp2_idem** takes the m = 2 equations (b != 0 already divided out) and a_1 > 0, and concludes a_1 = a_2 = 1/6 and b^2 = 1/36. That is faithful.
    - The brief's row "the only solution with a1 > 0, b != 0 is I/6" is imprecise, because sigma/6 (b = -1/6) also has a_1 > 0 and b != 0.
    - The Lean conclusion b^2 = 1/36 is the accurate form.
- **u3su4_double** is faithful to the stated system.
