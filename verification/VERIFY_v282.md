# Verifier v282, Lemma L9: triality as an automorphism of W_8, the identification HP^2 = tau(S^3 x S^5), L27 at (3,5), the transfer to HP^2, strict transverse maximality, the consequences in results.md, and the Lean files

The brief ([BRIEF_L09.md](BRIEF_L09.md)) was cold. No numerical work was done: no scripts, no computations run, every value exact and obtained by hand in closed form. Log: [agent_logs/verify-L09-v282.log](../agent_logs/verify-L09-v282.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | tau is an orthogonal automorphism of W_8 preserving #, W^2, Q and W_8 (Passage A, proof sentence 1) | CONFIRMED |
| 2 | HP^2 = tau(S^3 x S^5) (Passage A, proof sentence 1) | HYPOTHESIS-DEBT |
| 3 | L27 at (p,q) = (3,5): 1/2 - mu = 1/8 > 0, dim E(1/2) = 15 = dim O | CONFIRMED |
| 4 | tau normalises the inner automorphisms, orbit tangents correspond, the 1/2-eigenspace identity transfers | CONFIRMED |
| 5 | With L24's Hessian this is strict local maximality transverse to the orbit | HYPOTHESIS-DEBT |
| 6a | HP^2 has nonzero defect, so nonzero defect does not force instability (Passages A and B) | HYPOTHESIS-DEBT |
| 6b | Ruling out defective rivals requires sensitivity to the value (Passage B) | GAP |
| 6c | The landscape carries several peaks below the two named ones, so eliminating rivals cannot be a stability argument (Passage B) | HYPOTHESIS-DEBT |
| 7 | Scope: the claim is at n = 8 and reaches no padded HP^2 | CONFIRMED |
| 8a | Lean: theorem L9 in L9Statement.lean | HYPOTHESIS-DEBT |
| 8b | Lean: the arithmetic theorems of both files | CONFIRMED AS ALGEBRA |
| 8c | Lean: L9.lean docstring "the gap at n = 8 is 11/90" | REFUTED |
| 9 | Boundary: SO(8) against O(8), and the kernel | CONFIRMED |

**Summary: the transport of transverse strict maximality from tau-preimage to image is correct, but the identification HP^2 = tau(S^3 x S^5), the sign theta > 0, and the defect and landscape consequences have no argument on file.**

## 0. Conventions, fixed once

- W_8 is the space of algebraic Weyl tensors on R^8, read as symmetric operators on so(8) = Lambda^2 R^8 with the Frobenius inner product. dim W_8 = 8^2(8^2-1)/12 - 8·9/2 = 336 - 36 = 300. dim S^2(so(8)) = 28·29/2 = 406.
- Q(W) = W^2 + W^#, P(W) = <W, Q(W)>, a critical point satisfies Q(W) = theta W (with Q read through the orthogonal projection to W_8 where needed), e = W/theta, L_e = e∘(·).
- sigma denotes a triality automorphism of the Lie algebra so(8), an element of Aut(so(8)) whose class generates the order-3 part of Aut/Int = S_3. T denotes the induced map on operators, T(W) = sigma W sigma^{-1}. The passage writes tau for both.
- O denotes the O(8)-orbit, acting by W -> Ad(g) W Ad(g)^{-1}. Its tangent at W is {[ad X, W] : X in so(8)}, the same for SO(8) and O(8).
- W_{3,5} is the normalised Weyl tensor of S^3 x S^5, W_HP2 that of HP^2. P_p, P_q, P_m denote the orthogonal projections of so(8) onto so(3), so(5) and R^3 ⊗ R^5 for the splitting R^8 = R^3 + R^5.
- Everything written as a "screen" below is exact hand algebra used only to test whether a candidate finding survives step (2) of the discrepancy protocol. It is never offered as a repair or as evidence for a positive claim of the record.

## Hypothesis inventory

| Hypothesis | Source | Used where | Stated in the passages | Satisfiable / holds |
|---|---|---|---|---|
| sigma is a Lie algebra automorphism of so(8) of triality class | Passage A | step 1 | yes, named "triality" | yes, filed: [Yokota](../references/yokota-2009-exceptional-lie-groups/notes.md) Theorem 1.3.5, Lemma 1.3.2, read at source (txt lines 393-500) |
| sigma is orthogonal for the inner product on so(8) | Passage A ("preserves ... the inner product") | step 1 | asserted, no argument | holds: every automorphism preserves the Killing form, a negative multiple of the trace form on simple so(8). Standard, unfiled |
| S^2(so(8)) = 1 + 35_v + 35_+ + 35_- + W_8, multiplicity free | Passage A ("the complement is ...") | step 1 | asserted | holds, dims 1+35+35+35+300 = 406. Standard (scalar, traceless Ricci S^2_0 R^8, Lambda^4 = Lambda^4_+ + Lambda^4_-), unfiled |
| W_{3,5} is a critical point with theta != 0 | L27 (presupposed by e = W/theta) | step 2 | implicit in L27 | taken as given |
| L27: p, q >= 3, (p,q) != (3,3), n = p+q | L27 statement | step 2 | yes | holds at (3,5), n = 8 |
| HP^2 = tau(S^3 x S^5), in the normalisation fixed by the brief | Passage A | steps 2-4 | asserted, no argument, no source | see Section 2: HYPOTHESIS-DEBT |
| theta > 0 at the representative called HP^2 | L24 statement ("theta = P(W) > 0") | step 4 | **not stated** | screen in Section 5 finds it holds for the geometric sign, but no argument is on file |
| L24's Hessian formula 6 theta (L_e - 1/2 Id) at a critical point with theta > 0 | L24 | step 4 | yes | given |
| A negative-definite transverse Hessian at a Morse-Bott critical orbit gives a local maximum | implicit in "strict local maximality" when read as a local-max statement | Passage B consequence, Lean L9 | not stated | standard (slice theorem plus second-derivative test), unfiled |
| HP^2 has nonzero defect, "defect" defined | Passages A, B | 6a | neither defined nor argued | Section 6: HYPOTHESIS-DEBT |
| values of "the two named ones" and of HP^2 | Passage B | 6c | not in the passages | Section 6: HYPOTHESIS-DEBT |

## 1. tau is an orthogonal automorphism of W_8 preserving Q and W_8

**Quotation.** Passage A, [graded-half.md](../findings/graded-half.md) line 266: "an orthogonal automorphism of $\mathcal W_8$: it preserves the bracket and the inner product, hence $\#$ and $W^2$, hence $Q$; and it preserves $\mathcal W_8$ because the complement is $1+35_v+35_++35_-$, whose three $35$s it permutes." Checked verbatim against the source line.

**Derivation, link by link.**

1. sigma in Aut(so(8)) exists: filed, Yokota Theorem 1.3.5 (read at source, txt line 488), with kappa, pi automorphisms by Lemma 1.3.2 (txt line 393).
2. sigma is orthogonal on so(8): B(sigma X, sigma Y) = B(X, Y) for any automorphism, B = 6 tr(XY) on so(8), so sigma preserves -1/2 tr(XY). Standard, unfiled. Then sigma^{-1} = sigma^T.
3. T(W) = sigma W sigma^T is symmetric when W is, and <T A, T B> = tr(sigma A sigma^T sigma B sigma^T) = <A, B>. So T is orthogonal on S^2(so(8)).
4. W^2: T(W)^2 = sigma W sigma^T sigma W sigma^T = T(W^2).
5. W^#: in an orthonormal basis, (W^#)_{ab} = 1/2 c_{acd} c_{bef} W_{ce} W_{df} with c_{acd} = <[e_a, e_c], e_d>. sigma maps the basis to an orthonormal basis with the same structure constants, so (T W)^# = T(W^#). Hence Q(T W) = T Q(W) and P(T W) = P(W).
6. T preserves W_8: T intertwines the Int-action twisted by sigma, since T(Ad(g) W Ad(g)^{-1}) = Ad(g') T(W) Ad(g')^{-1} with Ad(g') = sigma Ad(g) sigma^{-1} in Int(so(8)). So T maps Int-invariant irreducible subspaces to Int-invariant irreducible subspaces of the same dimension. The decomposition of S^2(so(8)) is multiplicity free with summands of dimensions 1, 35, 35, 35, 300, so T sends each 35 to a 35 (the permutation the passage names), fixes the line of Id, and hence preserves the 106-dimensional complement and its orthogonal complement W_8. The dimensions check: 406 - 106 = 300.
7. Because T preserves W_8 and is orthogonal, it commutes with the orthogonal projection onto W_8, so the critical-point equation is T-equivariant whether Q is read with or without projection.

**Verdict: CONFIRMED.** The chain is correct. It rests on two standard facts that are unfiled (automorphisms preserve the Killing form, and the SO(8)-decomposition of S^2(Lambda^2 R^8)). The passage's "permutes" needs only multiplicity freeness plus dimension, which is how step 6 reads it.

**Falsifier sought.** An automorphism of so(8) failing to preserve the trace form, or a 35 mapped into W_8. Neither exists: step 2 excludes the first, and irreducibility of W_8 (dimension 300) excludes the second.

## 2. HP^2 = tau(S^3 x S^5)

**Quotation.** Passage A, line 266: "$\mathbb{HP}^2=\tau(S^3\times S^5)$ with $\tau$ triality".

**What is on file.** The passage asserts the identification with no argument. The filed triality sources do not carry it: the [Yokota notes](../references/yokota-2009-exceptional-lie-groups/notes.md) say explicitly that "the record's witness ($S^3\times S^5$ against $\mathbb{HP}^2$, both at isotropy dimension $13$), remains the record's own", and [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md) supplies only Aut/Int = S_3 with no construction. [Holland-Ion](../references/holland-ion-2012-symmetric-spaces/notes.md) lists symmetric pairs and says nothing of triality. The Lean file [L9.lean](../lean/HamiltonsCubic/Results/L9.lean) offers "the two closed forms agree", theta^2(HP^2) = theta^2(S^3 x S^5) = 56/45. That is a necessary condition only: equal theta^2 holds for any two critical points with the same value and is blind to the sign of theta.

**Three-step record.**

1. Location: line 266 as quoted, and the brief's normalisation "the normalised Weyl tensors of those symmetric spaces".
2. Failure exhibited: no argument or source on file establishes that T(W_{3,5}) equals W_HP2 rather than another unit critical point of W_8 with theta^2 = 56/45, or rather than -W_HP2. What would have to be proved: (i) sigma(so(3) + so(5)) is Int-conjugate to the isotropy algebra sp(1) + sp(2) of HP^2 acting on H^2 = R^8, with so(3) -> sp(1) and so(5) -> sp(2); (ii) the Sp(1)Sp(2)-invariant subspace of W_8 is one-dimensional, so T(W_{3,5}) = ±W_HP2; (iii) the sign is +. A screen of these by hand (the branching 8_s|Spin(3)xSpin(5) = (2,4), dimension counts of invariants, and the positivity of the curvature operator of a compact symmetric space) finds all three consistent with the claim, so no counterexample exists as far as this screen reaches.
3. Opposite reading: the identification is classical and the record may regard it as common knowledge. Against this, the filed Yokota notes record that the record's own sources do not state it, and the claim that HP^2 (the named quaternionic-Kähler operator) is the peak rests entirely on it. Without it, Passage A proves only that tau(W_{3,5}) is a transverse strict local maximum.

**Verdict: HYPOTHESIS-DEBT.** Owed: steps (i)-(iii) above, or a filed source for them.

## 3. L27 at (p,q) = (3,5)

**Hypotheses.** p = 3 >= 3, q = 5 >= 3, (3,5) != (3,3), n = 8 = p + q. All hold.

**Values.** L27's formula: 1/2 - mu = ((p-2)(q-2) - 1)/(2(p-1)(q-1)) = (1·3 - 1)/(2·2·4) = 2/16 = 1/8 > 0. Equivalently mu = (n-2)/(2(p-1)(q-1)) = 6/16 = 3/8 (as in [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) half_minus_mu). The remaining L27 values on W^perp: lambda_3 = 1/4, lambda_5 = 3/8, -mu = -3/8, and 0, all strictly below 1/2. So the 1/2-eigenspace is the summand R^3 ⊗ R^5, of dimension pq = 15. L27 states dim E(1/2) = pq = dim(orbit), which at (3,5) is 15 = dim O as Passage A says.

**Cross-check of dim O.** The stabiliser algebra contains so(3) + so(5) (dim 13), which is maximal in so(8) because R^3 ⊗ R^5 is irreducible under it, and it is proper because W_8 has no nonzero so(8)-invariant. So dim O = 28 - 13 = 15, agreeing with L27.

**Verdict: CONFIRMED.** Falsifier sought: a second 1/2 value at (3,5), which would need mu = 1/2 or lambda_m = 1/2. mu = 3/8 and lambda_m < 1/2 for all m, so none.

## 4. The transfer under tau

**Quotation.** Line 266: "$\tau$ normalises the inner automorphisms, so orbit tangents correspond and the $\tfrac12$-eigenspace identity transfers."

**Derivation.**

1. Eigen-structure: T(X∘Y) = TX∘TY by polarisation of step 5 of Section 1. theta(T W) = P(T W) = P(W) = theta. So e' = T e and L_{e'} = T L_e T^{-1}, hence E'(lambda) = T E(lambda) for every lambda, and T maps W^perp ∩ W_8 onto (TW)^perp ∩ W_8 by orthogonality.
2. Criticality transfers: Q(TW) = T Q(W) = theta TW.
3. Orbit tangents: T([ad X, W]) = [sigma ad X sigma^{-1}, TW] = [ad(sigma X), TW], since sigma is a Lie algebra automorphism. sigma is onto so(8), so T maps the orbit tangent at W onto the orbit tangent at TW. This identity is what "normalises the inner automorphisms" delivers at the Lie algebra level.
4. Conclusion: at TW, E(1/2) ∩ W^perp = T(orbit tangent at W_{3,5}) = orbit tangent at TW, of dimension 15.

**Reflections.** Conjugation by a reflection r in O(8) is an outer automorphism of so(8), and sigma Ad(r) sigma^{-1} is in general outside Ad(O(8)). So T does not intertwine the full O(8)-action. This does not touch the argument: the orbit tangent is determined by so(8) alone, and near W the O(8)-orbit coincides with the SO(8)-orbit of W (distinct SO(8)-orbits are disjoint compact sets).

**Verdict: CONFIRMED.** Falsifier sought: a vector in E(1/2) at TW outside the orbit tangent. By step 1 it would pull back to one at W_{3,5}, which Section 3 excludes.

## 5. Strict local maximality transverse to the orbit

**Quotation.** Line 266: "With [Lemma L24](second-order.md)'s Hessian $6\theta(L_e-\tfrac12\mathrm{Id})$ this is strict local maximality transverse to the orbit." The statement at line 264 glosses the claim as "its second variation is negative on the whole tangent space apart from the directions along its orbit".

**Derivation under the passage's own gloss.** At TW the tangent space of the unit sphere of W_8 is (TW)^perp ∩ W_8, L_e-invariant by L24 (L125). On it the Hessian is 6 theta (L_e - 1/2 Id). By Section 4 the eigenvalues of L_e there are 1/2 on the 15-dimensional orbit tangent and at most 3/8 on its orthogonal complement. So the Hessian is 0 on the orbit tangent and at most 6 theta (3/8 - 1/2) = -(3/4) theta on the complement. This is negative definite **exactly when theta > 0**.

**Candidate 5.1, the sign of theta.** Three-step record:

1. Location: L24's statement (Passage C) requires "$\theta=P(W)>0$". Passages A and B never state the sign of theta at HP^2 or at W_{3,5}, and L27 (Passage D) concerns L_e, which is invariant under W -> -W, so it does not fix the sign either.
2. Failure: P is odd, so P(-W) = -P(W) and the Hessian at -W is the negative of that at W. Of ±W_HP2 exactly one is a transverse strict local maximum and the other a transverse strict local minimum. Which one "the quaternionic-Kähler operator" names is not argued. A concrete failure would be theta(W_HP2) < 0 for the geometric sign. Screen: the Weyl line of S^3 x S^5 in the invariant basis is W ∝ 20 P_p + 6 P_q - 8 P_m (Ricci-free: 2·20 + 5·(-8) = 0 and 4·6 + 3·(-8) = 0), with <R, W> > 0 for the product curvature operator R = a P_p + b P_q, a, b > 0, so this is the geometric sign. With the structure-constant sums C_ppp = 6, C_qqq = 60, C_pmm = 30, C_qmm = 60 (normalised by Id^# = (n-2) Id), tr W^3 = 8000·3 + 216·10 - 512·15 = 18480 and <W, W^#> = 1/2(48000 + 12960 + 115200 + 69120) = 122640, so P(W) = 141120 > 0, with |W|^2 = 2520 and theta^2 = 141120^2/2520^3 = 56/45, matching the record's value. The screen finds theta > 0 at the geometric W_{3,5}, and T preserves theta. So no failure is exhibited.
3. Opposite reading: "normalised" in the brief may include the choice theta > 0, and the L9Statement Lean theorem is existential, where the sign is free.

The failure could not be exhibited, so no REFUTED finding stands. The hypothesis theta > 0 is nevertheless used by the step and stated nowhere in the passages, which makes it a debt: what must be proved is theta(W_HP2) > 0 in the record's normalisation (for instance theta(W_{3,5}) > 0 together with the sign clause (iii) of Section 2).

**Candidate 5.2, from the Hessian to a local maximum.** Under the gloss at line 264 the claim is the second-variation statement and the chain above completes it. Passage B's consequence ("does not force instability") and the Lean theorem L9 (IsLocalMaxOn) read it as an actual local maximum of P on the sphere. That step needs the standard Morse-Bott argument (slice through TW transverse to the orbit, second-derivative test on the slice, P constant on the orbit). It is a standard theorem, unfiled and unstated, and it applies here since the orbit is a compact embedded submanifold and the transverse Hessian is definite. Reported as an unfiled import, not as a gap.

**Verdict: HYPOTHESIS-DEBT** (theta > 0 at HP^2 is used and not stated). Conditional on theta > 0 the step is correct.

## 6. Passage A's framing and Passage B's consequences

**6a. "nonzero defect does not force instability".** Passage A line 264 and Passage B lines 140 and 485. "Defect" is defined in neither passage nor in the brief's definitions. The only definition on disk is in [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) (altNormSq Wm != 0 for the spectral splitting W = Wp - Wm), with the value 2/63 for HP^2 stated as a bare number (hp2_defect_nonzero proves only 2/63 != 0). Three steps: (1) located as quoted; (2) the chain in Passage A proves maximality and says nothing of the defect, so the logical force of "counterexample" rests on an unargued fact; (3) charitably, the defect of HP^2 may be established elsewhere in the record, but nothing in the passages cites it. **HYPOTHESIS-DEBT**: owed is a definition of the defect and a proof that it is nonzero at HP^2 (with the sign of Section 5, since W -> -W swaps Wp and Wm).

**6b. "ruling out defective rivals requires sensitivity to the value, not the defect alone".** Granting 6a, what follows is: no argument whose only input is "defect != 0" can show a critical point is not a local maximum. That any correct exclusion must use the value theta specifically, as against other invariants (the full spectrum of L_e, the stabiliser, n), is not argued. Three steps: (1) line 140 and line 485 "has to be sensitive to the value and not only to the defect"; (2) the falsifying object is an exclusion criterion depending on an invariant other than defect and theta, whose existence the passages do not rule out; (3) charitably "the value" stands for "information beyond the defect", in which reading the claim is proven given 6a. **GAP**: proven is "defect alone is insufficient", stated is "the value is required".

**6c. "the landscape carries several peaks below the two named ones rather than a single ridge, so eliminating rivals cannot be a stability argument".** The passages exhibit one peak (the orbit of tau(W_{3,5})). "The two named ones" are not identified in Passages A or B, and no values are given there. The Lean files supply 56/45 < 21/16 and 56/45 < 3/2 as bare inequalities, with theta_0(8)^2 = 21/16 and 3/2 unexplained in the passages. "Several" and "below" therefore have no argument on file, and "cannot be a stability argument" needs HP^2 to be non-global, which needs the same values. Three steps: (1) line 485 as quoted; (2) the object that would falsify "below" is a named peak with value at most 56/45, and the passages give no value to compare; (3) charitably the record defines the named ones elsewhere, but these passages do not cite it. **HYPOTHESIS-DEBT**: owed are the identities and values of the two named critical points at n = 8, a proof that they exceed theta^2 = 56/45, and a second peak for "several". (The Section 5 screen notes that W_{3,5} itself satisfies the same transverse criterion, which would give a second peak at n = 8 if argued, but no passage argues it.)

## 7. Scope

Passage A and the detail line 485 both say "at $n=8$". The landscape bullet at line 140 names no n.

- Candidate: line 140 reaches padded HP^2 at n > 8. See the withdrawn list.
- Every step of the proof is n = 8 specific: triality exists only for so(8) (Ziller Prop. 4.43 and Example 4.45, filed), and L27 requires n = p + q with padding destroying nondegeneracy.

**Verdict: CONFIRMED.** No claim in the passages reaches padded HP^2.

## 8. The Lean files

**8a. theorem L9, [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean).** It types: there exist W, Wp, Wm on bivectors of R^8 with W Weyl, normSq W = 1, W = Wp - Wm a spectral splitting, altNormSq Wm != 0, and IsLocalMaxOn Pcubic on the unit sphere at W. The proof is sorry. Its own docstring records that the sorry stands for the construction of the HP^2 operator, which needs triality and L27's decomposition. Compared with the lemma: it is existential (it names no HP^2), non-strict (IsLocalMaxOn), has no orbit and no transversality, and carries the defect clause as nonzero altNormSq. It states a weakening of L9 and proves nothing of it. **HYPOTHESIS-DEBT.**

**8b. The arithmetic.** hess_neg_of_not_half_eigenvector is an abstract, fully proved criterion: for symmetric L with <Lx, x> <= 1/2 |x|^2 on all of V and theta > 0, the form 6 theta(<Lv, v> - 1/2|v|^2) is negative at every v that is not a 1/2-eigenvector. It is correct and it makes theta > 0 an explicit hypothesis, the very one Section 5 finds unstated in the prose. It is never instantiated at HP^2 (V would have to be W^perp, since L_e e = e). half_minus_mu (3/8, 1/8), eigenspace_matches_orbit (3·5 = 15), triality_value_agreement and L9.lean's hp2_theta_sq, s3s5_theta_sq (both 56/45: 16·7/90 = 112/90 and 2·7·2·4/90 = 112/90), peak_below_competitors, theta0_eight (2·7·6/64 = 21/16) and gap_at_eight (21/16 - 56/45 = (945 - 896)/720 = 49/720) are all correct. **CONFIRMED AS ALGEBRA.** None of them bears on the identification or on maximality.

**8c. The L9.lean docstring.** Three steps: (1) [L9.lean](../lean/HamiltonsCubic/Results/L9.lean), docstring of gap_at_eight: "So both named peaks are under the competitor, and the gap at `n = 8` is `11/90`."; (2) the theorem it documents proves 21/16 - 56/45 = 49/720, and 11/90 = 88/720 != 49/720, while 3/2 - 56/45 = 23/90, so 11/90 is neither gap; (3) no reading of "the gap" found gives 11/90. **REFUTED** (a docstring error, not a defect of the lemma). The same file calls the n = 6 point with theta^2 = 10/9 a "peak" ("The `n = 6` peak likewise") with no argument, while L9Statement.lean calls CP^3 at that value an ordinary saddle. That word is unsupported in the files.

## 9. The boundary: SO(8) against O(8), and the kernel

- SO(8) against O(8): the orbit tangent, dim O = 15, and the transfer of Section 4 depend only on so(8). The O(8)-orbit is locally the SO(8)-orbit, and at W_{3,5} a reflection of R^3 lies in the stabiliser O(3) x O(5) anyway. T intertwines Int but not the reflection class, which the argument never needs. No finding.
- The Hessian kernel at HP^2 is exactly the orbit tangent (Sections 3-4). L27's four summands with L_e-value 0 are not in the kernel: the Hessian there is -3 theta, negative under theta > 0.
- The kernel of W_HP2 as an operator is not used by the argument. Screen: the invariant form 20 P_p + 6 P_q - 8 P_m has no zero coefficient, so ker W_{3,5} = 0, and T carries this to TW.

**Verdict: CONFIRMED.**

## Item 7 of the standing list: falsifying objects and the search for each

| Claim | Falsifying object | What was done |
|---|---|---|
| 1 | automorphism of so(8) moving a 35 into W_8, or not preserving the trace form | excluded by irreducibility and dimension, and by Killing-form invariance |
| 2 | a unit critical point with theta^2 = 56/45 and Sp(1)Sp(2) symmetry other than T(W_{3,5}), or the sign -1 | screened via invariant counts and curvature positivity, none found, argument owed |
| 3 | a second 1/2-value at (3,5) | all L27 values evaluated exactly, none |
| 4 | a 1/2-eigenvector at TW off the orbit tangent | pulls back under T to W_{3,5}, excluded by 3 |
| 5 | theta(W_HP2) < 0 for the geometric sign | screened exactly, theta > 0, hypothesis still unstated |
| 6a | HP^2 with zero defect | no definition or value on file in the passages |
| 6b | an exclusion criterion sensitive to neither defect nor value | the passages do not address it |
| 6c | a named peak with value <= 56/45, or HP^2 the only peak | no values on file in the passages |
| 7 | a claim asserting maximality at n > 8 | none in Passages A, B |
| 8 | a Lean proof of L9 | theorem L9 is sorry |
| 9 | a reflection needed by the transfer | tangent is so(8)-determined, none |

## Withdrawn candidates

- **"Strict local maximum" is false literally, since P is constant on the orbit** (line 140). (1) Located: line 140 says "is a strict local maximum" with no qualifier. (2) Failure: Ad(exp tX) W_HP2 for X outside the stabiliser algebra is a different point with the same value arbitrarily close. (3) Opposite reading: the canonical detail at line 485 and Passage A both gloss the phrase as negativity apart from orbit directions, so the record's usage is "strict modulo the orbit". **Withdrawn at step 3.** A reader of the landscape bullet alone would still read it literally, and the wording "strict transverse to the orbit" would remove the ambiguity.
- **The landscape bullet reaches padded HP^2 at n > 8.** (1) Line 140 names no dimension. (2) No failure: HP^2's operator lives on Lambda^2 R^8, and a padded version is a different object that no sentence mentions. (3) The detail line 485 fixes n = 8. **Withdrawn at step 2.**
- **"tau normalises the inner automorphisms" is false once O(8) is included.** (1) Line 266. (2) True: sigma Ad(r) sigma^{-1} for a reflection r need not lie in Ad(O(8)). (3) The passage says "inner automorphisms", which is Int(so(8)) = Ad(SO(8)), and for that group the statement is true. The argument needs only the Lie algebra identity of Section 4. **Withdrawn at step 3.**

## Overall verdict

**HYPOTHESIS-DEBT.** The transport argument is correct: tau is an orthogonal, Q-preserving automorphism of W_8, L27 applies at (3,5) with 1/2 - mu = 1/8, and the 1/2-eigenspace equals the orbit tangent at tau(W_{3,5}). What is owed:

- the identification HP^2 = tau(S^3 x S^5) with its sign, argued or sourced (the filed triality sources disclaim it)
- theta > 0 at HP^2, required by L24 and stated nowhere in the passages
- a definition of the defect and a proof that it is nonzero at HP^2
- the values of the two named peaks and a second peak, for Passage B's landscape consequences.

The gap is that "the value" is required where only "the defect alone is insufficient" follows. The Lean files state a weakening under sorry, and L9.lean has a wrong docstring gap (11/90 for 49/720).
