# Review r1560: batches 40 and 41, the SO(4) in G2 idempotent and the Casimir criterion for the stability of I/c

Log: agent_logs/r1560.log

Overall: CONFIRMED WITH ONE CORRECTION. Every number in batch 40 reproduces by hand. Batch 41's formula and criterion are right. One entry of the per-algebra list is wrong: the e7 ratio is 14/9, and the stability conclusion for e7 stands.

| claim | verdict | reason in one line |
|---|---|---|
| C1 SO(4) in G2 block constants and idempotent | CONFIRMED | Casimirs follow from indices 1 and 3 (2s(s+1)/j), the trace check forces p = (1/2, 3/2), P_p#P_p = 2P_L + (10/3)P_S follows exactly from I#I = 4I, and the quadratic, the solution and 746/841 reproduce |
| C2 its instability and I/4's eigenvalues | CONFIRMED | the quadratic form (coefficient of v^2 is 6a1+10a2 = 4 at the idempotent), H ⊥ C, the excess 7/29 and the spectrum 1, 5/12, -1/4 (trace 7/6, det -5/48) all reproduce |
| C3 the formula c - Cas_V/4 | CONFIRMED | A X A^T corresponds to (A⊗A)X, so I# = (1/2)Σ ad⊗ad = (1/4)(Cas⊗1 + 1⊗Cas - Cas_{h⊗h}), and so(n)'s Casimirs 0, 2n, 4n-4, 4n-16 are right |
| C4 the stability criterion | CONFIRMED | L_{I/c} is equivariant and acts by one scalar on each isotypic component, and H ⊥ I is exactly the nontrivial part. Wording note: the title's "outweighs" reads as strict, the statement says "at least" |
| C5 the per-algebra classification | REFUTED (one entry, corrected) | e7: Sym^2(133) = 1 + [2ω1] + [ω6] with Cas(ω6) = 56 against Cas(adj) = 36, ratio 14/9, not 4/3. e7 stays stable. Every other decomposition and ratio checks |
| C6 what it says about U_s | CONFIRMED | the implications and 2/sqrt3 against 3/sqrt10 are right. U_s has to be read as "every stable PD idempotent equals I/c", because on sp(m) the reading "I/c is the stable one" is false |
| C7 Lean statements | CONFIRMED | all six say what the prose says with the prose's numbers, and the file compiles clean. Nit: the docstring of sp_omega2_unstable says m ≥ 1, while [ω2] exists only for m ≥ 2 |
| C8 anything else | notes | the U_s wording (C6), the non-strict criterion (C4), and multiplicity handled correctly. No hidden hypothesis found |

## Method

I read the chain link by link from the brief's definitions and derived every step by hand. Screens (reported as screens, used as evidence for no positive claim): (a) Casimirs <λ, λ+2ρ> computed from inverse Cartan matrices in the normalisation with long roots of squared length 2, for g2, f4, e6, e7, e8; (b) Sage's WeylCharacterRing symmetric square of the adjoint for E7, F4, E6, C3, C4, G2, A3, A2. Each ran in seconds. I also compiled lean/HamiltonsCubic/Results/I117LemmaF.lean with `lake env lean` (clean, about 13 s) and read the six declarations.

## C1

- **Formula used for the block constants.** (vv^T)#X = (1/2) ad_v X ad_v^T (see C3). So for a subalgebra k with orthonormal basis e_i and a k-invariant V, P_k#P_V = -(1/2)Σ ad_i P_V ad_i = (1/2)Cas_k(V) P_V, because ad_i commutes with P_V. Applied to each ideal L and S separately, this gives P_L#P_L = 2P_L, P_S#P_S = (2/3)P_S, P_L#P_p = (3/4)P_p and P_S#P_p = (5/4)P_p. P_L#P_S = 0 because ad_L kills S.
- **Casimirs.** In g2's form (Cas(adj) = 8 = 2h^vee), an su(2) of embedding index j has Cas(spin s) = 2s(s+1)/j. Index 1 gives 4 on L and 3/2 on spin 1/2. Index 3 gives 4/3 on S and 5/2 on spin 3/2. Long and short su(2) have indices 1 and 3 (squared-length ratio 3), and g2 = (1,0) + (0,1) + (1/2,3/2) under L × S.
- **Which factor acts by spin 3/2.** The trace identity forces it: tr_g Cas_k = d_k Cas_g(g) = 24. Swapping the spins would give 12 + 8·(15/2) = 72 for L. The record's checks 24 = 24 hold.
- **P_p#P_p.** Expanding I#I = 4I gives P_p#P_p = 4I - 2P_L - (2/3)P_S - (3/2)P_p - (5/2)P_p = 2P_L + (10/3)P_S, with no P_p term. The identity fixes it exactly, so it has no L-S cross block. This is also consistent with [p,p] ⊂ k.
- **Coefficient equations.** C#C = (2a1^2 + 2b^2)P_L + ((2/3)a2^2 + (10/3)b^2)P_S + b(3a1/2 + 5a2/2)P_p, which gives the three equations as stated.
- **Solving.** With b ≠ 0, a1 = (2-5a2)/3, and equating the two expressions for b^2 gives -232a2^2 + 98a2 - 10 = 0, that is 116a2^2 - 49a2 + 5 = 0. The discriminant is 81, so a2 = 1/4 or 5/29. a2 = 1/4 gives a1 = 1/4, b = ±1/4 (I/4 and σ/4). a2 = 5/29 gives a1 = 11/29 and b^2 = 385/8410 = 77/1682.
- **Positive definiteness.** It holds with the positive root b = +sqrt(77/1682), which the record takes. The negative root is indefinite (its σ-conjugate).
- **Norm.** 3·121/841 + 3·25/841 + 8·77/1682 = 746/841 ≈ 0.887 > 7/8.

## C2

- **Quadratic form.** C#H has P_L-coefficient 2a1u1 + 2bv, P_S-coefficient (2/3)a2u2 + (10/3)bv, and P_p-coefficient (3/4)(a1v + bu1) + (5/4)(a2v + bu2). Pairing with weights 3, 3, 8 gives 6a1u1^2 + 2a2u2^2 + (6a1 + 10a2)v^2 + 12bu1v + 20bu2v. At the idempotent, 6a1 + 10a2 = 116/29 = 4, so the record's 4v^2 is valid there (and only there, which is how it is used).
- **Orthogonality.** 3(11/29) - 3(5/29) + 8(-261/154)(77/1682) = 18/29 - 522/841 = 0.
- **The excess.** With bv = -9/116 and v^2 = 81/616: <C#H,H> = 76/29 + 81/154 + 72/116 = 94/29 + 81/154, and (1/2)‖H‖^2 = 3 + 81/154. The difference is 7/29.
- **I/4's spectrum.** The matrix on coefficients is [[1/2, 0, 1/2], [0, 1/6, 5/6], [3/16, 5/16, 1/2]]. (1,1,1) has eigenvalue 1, the trace is 7/6, and the determinant is -5/48, so the other two are 5/12 and -1/4. These agree with batch 41's g2 values (Cas 28/3 and 20).

## C3

- **The formula on rank ones.** (vv^T)#(ww^T) = (1/2)[v,w][v,w]^T = (1/2)ad_v(ww^T)ad_v^T. Rank ones span Sym^2, so the identity holds for every symmetric X. Summing λ_i ≥ 0 terms gives a Kraus form, so C#· is completely positive.
- **Sign and factor.** Under X ↔ Σ X_ab e_a⊗e_b, A X A^T ↔ (A⊗A)X, so the transpose introduces no sign. Cas_{h⊗h} = -Σ(ad⊗1 + 1⊗ad)^2 = Cas⊗1 + 1⊗Cas - 2Σ ad⊗ad. Hence I# = (1/4)(Cas⊗1 + 1⊗Cas - Cas_{h⊗h}), which is c - Cas_V/4 when Cas_h(h) = 2c. The h-action on matrices, X ↦ [ad_u, X], matches the tensor action.
- **so(n) Casimirs** (roots ±ε_i±ε_j, ρ_i = n/2 - i). 2ε1 gives 2n. 2ε1+2ε2 gives 8 + 4n - 12 = 4n-4. ε1+…+ε4 gives 4 + 4n - 20 = 4n-16. The adjoint gives 2n-4. The scalars are n-2, (n-4)/2, -1, 2.
- **Small n.** The splittings at n = 4 and n = 8 (W±, Λ^4±) carry equal Casimirs, so nothing changes.

## C4

- **Criterion.** L_{I/c} = (1/c)I# is self-adjoint and equivariant. It is a polynomial in Casimirs, so it is one scalar on each isotypic component, multiplicities included. The trivial component of Sym^2 h is R·I (the adjoint of a compact simple h is absolutely irreducible). So H ⊥ I/c exactly spans the nontrivial components, and (c - Cas_V/4)/c ≤ 1/2 holds iff Cas_V ≥ 2c.
- **Criterion is non-strict.** The criterion is correct as stated ("at least"). The batch title's "outweighs" suggests strict inequality. su(m) meets the non-strict bound, which is why the list calls it marginal.

## C5

Checked by hand and by screens (a) and (b), in the form with Cas(adj) = 2h^vee.

- **so(n).** Four components (dimension-complete). The ratios are as stated, with Λ^4 at 1 exactly at n = 6 and 2/3 at n = 5. The conclusion (stable for n ≥ 7) is correct.
- **su(m).** m = 3: 1 + 8 + 27. m ≥ 4: 1 + adj + [2θ] + [ω2+ω_{m-2}] (screen: A2, A3). The extra components have Casimirs 4m+4 and 4m-4 against 2m, and the adjoint copy has ratio 1, so the case is marginal. This is correct.
- **sp(m).** Sym^2(Sym^2 V) = Sym^4 V + S_(2,2)V, and S_(2,2)V restricted to Sp is [2ω2] + [ω2] + [0] (screen: C3, C4, and dimension 55 at m = 2). With <ε_i,ε_j> = δ/2 and ρ = (m, …, 1): Cas(2ω1) = 2m+2, Cas(ω2) = 2m, Cas(2ω2) = 4m+2, Cas(4ω1) = 4m+8. The eigenvalue (m+2)/(2(m+1)) is correct, and 2/3 at m = 2 matches so(5).
- **g2.** 1 + 27 + 77. Cas 28/3 and 20 against 8, ratios 7/6 and 5/2. Correct.
- **f4.** [2ω4] (324) Cas 26 against 18 gives 13/9. 2θ Cas 40 gives 20/9 = 2 + 2/9. Correct.
- **e6.** [ω1+ω6] (650) Cas 36 against 24 gives 3/2. Correct.
- **e7 (wrong in the record).** Sym^2(133) = 1 + [2ω1] + [ω6] (1539) by screen (b). Cas(ω6) = 56 against Cas(adj) = 36 by screen (a). Independently, 1539 ⊂ Λ^2 56 has Dynkin index 54·12 = 648, and 648·133/1539 = 56. **The ratio is 14/9, not 4/3.** In Vogel's parametrisation (t = h^vee, β = m+4, γ = 2m+4) the surviving component is Y2(β) with ratio (2t-β)/t on the whole exceptional line: 7/6, 13/9, 3/2, 14/9, 8/5. The record's 4/3 is Y2(γ)'s value, which is the zero module for e7. The conclusion "stable" is unaffected.
- **e8.** [ω1] (3875) Cas 96 against 60 gives 8/5. Correct.
- **2θ in general.** Cas = 4h^vee + 4, ratio 2 + 2/h^vee. Correct.
- **su(2).** Spin 2 has Cas 12 against 4, ratio 3, eigenvalue -1/2. Correct.
- **Correction to make in batch 41.** Replace "$\tfrac43$" by "$\tfrac{14}9$" in the e7 slot.

## C6

- **The sp(m) consequence.** On sp(m), m ≥ 2, I/c is unstable (C5). So U_s, read as "every stable positive-definite idempotent equals I/c", asserts that none exists on sp(m). That is correct, and it is exactly what L264 (3) needs.
- **Scope correction.** L264's wording "the only stable positive-definite idempotent is I/c" also admits the reading "I/c is stable and unique", which is false on sp(m) by batch 41. That wording should be tightened to the implication form so the record does not state a false U_s.
- **The sp(2) comparison.** F(C,C,C)/‖C‖^3 = 1/‖C‖ for an idempotent. I/3 on so(5) has ‖·‖^2 = 10/9, ratio 3/sqrt10. The Λ^2_+ ideal of so(4) ⊂ so(5) has c1 = (1/2)·4 = 2 in the restricted form, idempotent P/2 with ‖·‖^2 = 3/4, ratio 2/sqrt3. Correct.
- **What the comparison shows.** It shows the maximiser is not I/c. It does not show that the maximiser is supported off the full sp(2), which is what U_s on sp(2) would require. The record claims no more than the first.
- **su(m).** Degeneracy is correct: the adjoint copy sits at eigenvalue exactly 1/2 and is not an orbit direction (the Ad-orbit of I is a point).

## C7

- **g2_so4_witness.** States the three equations at (11/29, 5/29, b) with b^2 = 77/1682. Faithful. It checks the witness, not the quadratic's derivation or completeness, which the table does not claim.
- **g2_so4_unstable.** States the orthogonality with weights (3,3,8) and the excess 7/29, using the quadratic form with 4v^2. Faithful to the prose, which also uses the at-idempotent form.
- **g2_so4_norm.** 746/841 and > 14/16 = 7/8. Faithful.
- **so_sharp_scalars.** The four subtractions. Faithful.
- **stable_iff_cas.** (c - Cas_V/4)/c ≤ 1/2 ↔ 2c ≤ Cas_V for c > 0. Faithful.
- **sp_omega2_unstable.** The identity and > 1/2 for m > 0. Faithful, with a weaker hypothesis than the prose. Docstring nit: it says "On sp(m), m ≥ 1", while [ω2] exists only for m ≥ 2.
- **Build.** The file compiles with no errors or warnings shown (on-disk working-tree version).

## C8

- **Stability "on Sym^2 h" versus L264's ambient stability.** Ambient stability implies stability within Sym^2 h (fewer test directions), and Sym^2 h is closed under # because [h,h] ⊂ h. So batch 41's intrinsic criterion is the right one to set against U_s. No gap.
- **"Third" positive-definite idempotent on g2.** Justified: the norms 7/8, 351/392 and 746/841 are distinct.
- **"Every positive-definite idempotent found other than I/c is unstable."** Holds: SU(3) ⊂ G2 has x = 1 < y = 4/3 < 2x, which is unstable by L264 (4).
- **Beyond the e7 number and the two wording points above, I found no hidden hypothesis and no excluded case.**
