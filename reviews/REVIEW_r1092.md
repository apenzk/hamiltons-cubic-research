# REVIEW r1092

**Gate 2 comparison round, single reviewer, on the Pfaffian sign layer.** Commits under review: `c84fb266` (the [Levi6Det.lean](../lean/HamiltonsCubic/Base/Levi6Det.lean) part), `c8a04faf`, `76de5e21`, and [I73SharingQuotient.lean](../lean/HamiltonsCubic/Results/I73SharingQuotient.lean) from `de7af6a3`. The kernel has checked every proof, so the review covers statement fidelity, vacuity and prose.

**Footing: analysis only, and honoured.** One Lean process was run (a scratch `#print axioms` file outside the tree, started after another session's `lake build` had exited), and [lean_debts.py](../scripts/misc/lean_debts.py) was run with `--out` pointed at a scratch path. No sweep, census or hunt. Log: [r1092-pfsign.log](../agent_logs/r1092-pfsign.log).

| # | claim | declaration | verdict |
|---|---|---|---|
| C1 | at a permutation, levi6 equals the sign | levi6_perm | **CONFIRMED** |
| C2 | levi6 vanishes on a repeated argument | levi6_eq_zero_of_not_injective | **CONFIRMED** |
| C3 | the full contraction is ε · det A | levi6_contract | **CONFIRMED** |
| C4 | triple6 and pf6 transform by det Q | triple6_conj, pf6_conj | **CONFIRMED** |
| C5 | every complex structure is Q stdJ6 Qᵀ with Q orthogonal | complexStructure_normalForm | **CONFIRMED**, non-vacuous by stdJ6_isComplexStructure |
| C6 | pf6 stdJ6 = -1 | pf6_stdJ6 | **CONFIRMED**, and the sign is the record's under φ = E_ba − E_ab |
| C7 | pf6 J = ±1 at every complex structure | pf6_complexStructure | **CONFIRMED** |
| C8 | StarWedgeIdentity holds | starWedgeIdentity_holds | **CONFIRMED**, with ε_J = pf6 J exactly as the prose says |
| C9 | L184 case 2 holds with no hypothesis | scalar_case_empty_orthonormal_uncond | **CONFIRMED, not vacuous**: dropping only the wedge hypothesis leaves a satisfiable set |
| C10 | sharing quotient closed form and its bound | sharing_quotient_closed_form, sharing_quotient_lt_half | **CONFIRMED**, term by term against the block |
| C11 | the rewritten prose claims no more than the declarations | prose | **REFUTED on completeness**: the commit's "every passage calling the identity owed or unproved was rewritten" leaves nine stale passages, two of them now false, plus one case misattribution in L191 |

## Axioms

All twelve declarations depend on `propext`, `Classical.choice`, `Quot.sound` and nothing else: levi6_perm, levi6_eq_zero_of_not_injective, levi6_contract, triple6_conj, pf6_conj, complexStructure_normalForm, pf6_stdJ6, pf6_complexStructure, starWedgeIdentity_holds, scalar_case_empty_orthonormal_uncond, sharing_quotient_closed_form, sharing_quotient_lt_half. The same scratch file elaborated `example : IsComplexStructure stdJ6 := stdJ6_isComplexStructure` with no error.

## C1 to C4, the determinant layer

The four statements are the textbook ones with no side condition. `levi6_contract` quantifies over every `w : Fin 6 → Fin 6`, injective or not, so it is the full transformation law of the symbol. `triple6_conj` holds for every real `Q`, orthogonal or not, which is what `pf6_conj` inherits and is the correct generality for Pf(QXQᵀ) = det Q · Pf X.

## C5 to C8, the sign and the identity

- **The definition matches the record's hypothesis.** `IsComplexStructure J` is `IsSkew J ∧ J * J = -1` ([SelfDual.lean:643](../lean/HamiltonsCubic/Base/SelfDual.lean#L643)), which is the record's "metric-compatible complex structure" (skew plus J² = −Id, orthogonality following as `IsComplexStructure.orthogonal`). `complexStructure_normalForm` concludes `Qᵀ Q = 1 ∧ J = Q stdJ6 Qᵀ`, the orthogonal normal form, with no orientation restriction on `Q`, which is right since both signs of det Q occur.
- **The Pfaffian normalisation is the standard one.** `pf6 X = triple6 X X X` with the factor `1/48 = 1/(2³·3!)`, the (2^m m!)⁻¹ convention at m = 3. At stdJ6 = φ01 + φ23 + φ45, three blocks with entry (0,1) equal to −1, Pf = (−1)³ = −1, which is the value [diagonal-half.md:875](../findings/diagonal-half.md#L875) records and states the φ convention for.
- **ε_J = Pf(J) is what the proof delivers.** `starWedge_of_adjugate` in [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) opens with `refine ⟨pf6 J, hPf J hJ, ?_⟩`, so the witness eps is literally pf6 J, and `starWedge_of_pf` is that lemma with `adjugate_law` discharged.
- **The Lean predicate is the record's identity.** `StarWedgeIdentity` is ∀ J, IsComplexStructure J → ∃ eps ∈ {1, −1}, star6 (wedgeSelf J) = (2 eps) • J, which is ⋆_V(J∧J) = 2ε_J J at dim V = 6. Since J ≠ 0 the eps is unique, so the ∃ loses nothing against "ε_J well defined".
- **Non-vacuity.** stdJ6_isComplexStructure inhabits the binder of C5, C7 and C8, and the ∃ in C8 cannot be met trivially (eps = ±1 and J ≠ 0 pin both sides).

## C9, case 2 is empty, and the statement is not vacuous

The conclusion is `False`, so the theorem says the five hypotheses cannot hold together, which is exactly "case 2 is empty". **It would say nothing only if the hypotheses were jointly unsatisfiable for a reason unrelated to the wedge, and they are not.** Take the 1-factorisation of K6 by the matchings {01, 23, 45}, {02, 14, 35}, {03, 15, 24}, and set om_i = J_i/√3 with J_i the sum of φ over the i-th matching. Each J_i is skew with J_i² = −1, so om_i is skew with om_i² = −⅓·1 (hscal), inner2 (om_i, om_i) = 1 by `inner2_complexStructure`, and inner2 (om_i, om_j) = 0 for i ≠ j because the supports are disjoint (hon). **Every hypothesis except hwedge holds**, so the wedge condition is load-bearing and the theorem has content. Dropping instead only the off-diagonal orthogonality, om_i = stdJ6/√3 for all i meets the rest. *Both witnesses are constructed by hand, not run.*

## C10, the sharing quotient

`sharing_quotient_closed_form` reads λ_p · ((1/2)·q / ((p−2)(p+q−2))) / ((p+q−3) / (2(p+q−2))) = q / (2(p−1)(p+q−3)). With n = p + q this is λ_p = (p−2)/(2(p−1)), ‖T‖² = q/(2(p−2)(n−2)), ‖π(R)‖² = (n−3)/(2(n−2)), exactly the three quantities of [second-order.md:162](../findings/second-order.md#L162), and the right side is the table's q/(2(p−1)(n−3)). **‖T‖² was rederived independently** as ‖π(R)‖² − ‖W_p(R)‖² = (n−3)/(2(n−2)) − (p−3)/(2(p−2)) = (n−p)/(2(p−2)(n−2)), which is q/(2(p−2)(n−2)). `sharing_quotient_lt_half` is q < (p−1)(n−3), true since (p−1)(n−3) ≥ 2q at p ≥ 3. The hypotheses are over ℝ rather than ℕ, which is more general and harmless. The S⁴×S⁴ example's 2/15 matches the record's coordinate value. **The record's own framing is kept honest**: the block says the bound is L27's and these quotients cannot test it, and the Lean module says the decomposition and eigenvalues are assumed from L27, which is the true split.

## C11, the prose

**Correct as written:**
- [lean/INDEX.md:308](../lean/INDEX.md#L308), "It was the layer's last hypothesis claim". **CONFIRMED against the generator.** At `de7af6a3^` the hypothesis-debt table in [plan-lean.md](../plan-lean.md) had exactly one row, `StarWedgeIdentity`. Regenerated now into a scratch path, the table is empty and the rest of the file matches the committed [plan-lean.md](../plan-lean.md) up to timestamps.
- The rewritten passages in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) (module header near line 51, the `StarWedgeIdentity` and `pm_of_eq_wedgeSelf` docstrings), [L184Statement.lean](../lean/HamiltonsCubic/Results/L184Statement.lean), [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean), [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean), the I67PfSquared module header, [diagonal-half.md:918](../findings/diagonal-half.md#L918), and plan.md's DONE entry on L184.

**Defects, reach one file each unless stated, found with**
`grep -rnE 'HYPOTHESIS-DEBT|still owes|remaining debt|ONE open question|THE TRAP THIS FILE OPENS|blocked on two named|never tried|owed .StarWedgeIdentity' lean/HamiltonsCubic lean/INDEX.md findings/diagonal-half.md scripts/INDEX.md`:

| # | where | text | why it is wrong now |
|---|---|---|---|
| D1 | [lean/INDEX.md:160](../lean/INDEX.md#L160), the I67PfSquared row | "THE TRAP THIS FILE OPENS: composing starWedge_of_pf with pf6_complex_structure … carrying sorryAx, so the identity is NOT proved" | **FALSE.** The same row's first sentence says pf6_complex_structure now cites pf6_complexStructure and carries no `sorry`, and the composition is sorry-free. The row also still says "Gate 2 in flight" and that "the tree carries no declaration under pf6_conj … complexStructure_normalForm" |
| D2 | [lean/INDEX.md:309](../lean/INDEX.md#L309) | "This is the ONE open question left under StarWedgeIdentity" | the row's own status is **proved** |
| D3 | [I67PfSquared.lean:111–115](../lean/HamiltonsCubic/Results/I67PfSquared.lean#L111) | "WHICH ROUTE IS CHEAPER IS NOT SETTLED … the input the chain actually needs is blocked on two named absences" | **FALSE**, and it sits four lines under "The route is COMPLETE" |
| D4 | [I67PfSquared.lean:137–138](../lean/HamiltonsCubic/Results/I67PfSquared.lean#L137) | "both halves of StarWedgeIdentity are in-house, and the route this file names for the first half was never tried" | the route was tried and closed the identity |
| D5 | [SelfDual.lean:595–598](../lean/HamiltonsCubic/Base/SelfDual.lean#L595), section header | "the identity the record owes … records it as HYPOTHESIS-DEBT. The objects it relates are built here; the relation is not." | the relation is proved, in a file this commit edited |
| D6 | [SelfDual.lean:686](../lean/HamiltonsCubic/Base/SelfDual.lean#L686) | "the sign is exactly what the remaining debt needs" | no debt remains |
| D7 | [SelfDual.lean:697](../lean/HamiltonsCubic/Base/SelfDual.lean#L697) and [:709](../lean/HamiltonsCubic/Base/SelfDual.lean#L709) | "which is the sign pf6(J) = ±1 still owes"; "The `sorry` is the passage to ℂ" | nothing is owed, and `det_eq_one_of_complexStructure` has no `sorry` (it is proved by the det(1+J) = det(1−J) argument), so the second sentence was stale before this commit too |
| D8 | [L191Statement.lean:21–22](../lean/HamiltonsCubic/Results/L191Statement.lean#L21) and plan.md's I67 DONE entry | "Cases 2 and 3 run on ⋆_V(J∧J) = 2ε_J J"; "L191's three cases no longer wait on the identity" | the record's L191 proof ([diagonal-half.md:749](../findings/diagonal-half.md#L749)) uses the identity in **case 2 only**. Case 1 is sign algebra and case 3 the cross term in Λ²Q⊗Λ²P. The plan sentence is true only vacuously for cases 1 and 3, and it repeats the retired plan item's "gates … L191's three cases" |
| D9 | [diagonal-half.md:886](../findings/diagonal-half.md#L886) and [:1095](../findings/diagonal-half.md#L1095), [scripts/INDEX.md:402](../scripts/INDEX.md#L402) | "Pf(J) = ±1 follows from the same expansion, so one proof discharges both"; "the identity … is HYPOTHESIS-DEBT … has no computation on file"; "I67's owed StarWedgeIdentity" | historical passages in the present tense. Low severity, but 1095 contradicts 872 in the same file |

**The mathematics is unaffected by every row.** D1 and D3 are the two that state something false about the Lean layer, and D1 is the one a reader of the index meets first. D8 is a small overclaim about which L191 cases benefit, not about what is proved.

## Summary

Every declaration is on the three standard axioms and states what the record means. The determinant layer (C1 to C4) is the textbook transformation law at full generality. The normal form, the base sign and the ±1 (C5 to C7) use the record's definition and the record's φ convention. `starWedgeIdentity_holds` (C8) delivers ⋆(J∧J) = 2 Pf(J) J with the witness literally pf6 J. L184's case 2 (C9) is a contentful emptiness claim, since a 1-factorisation of K6 satisfies every hypothesis but the wedge one. The sharing-quotient pair (C10) encodes λ_p·‖T‖²/‖π(R)‖² term for term, and ‖T‖² checks independently. **The one refutation is C11's completeness claim.** Nine passages across [lean/INDEX.md](../lean/INDEX.md), [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [diagonal-half.md](../findings/diagonal-half.md) and [scripts/INDEX.md](../scripts/INDEX.md) still call the identity or its input owed. Two of them (D1, D3) are now false. L191's prose also credits the identity to case 3, which the record's proof closes without it.
