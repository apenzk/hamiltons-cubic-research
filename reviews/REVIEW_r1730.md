# REVIEW r1730: L237 at n = 3, L52's one_line_value, and the r1726/r1729 repairs (commit ea0580d1)

*Cold Gate 2 review of commit ea0580d1. Lean source read, no `lake build` or `lake env` run. Two screens, reported as screens only: a pure-Python evaluation of Lagrange's identity in the layer's normalisation (the witness plus 2000 random skew pairs), and a check that the committed `.olean` files postdate their sources. Log: agent_logs/review-r1730.log.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `lagrange3` is Lagrange's identity in the layer's `inner2 = ½ tr(XᵀY)`, `br = XY − YX` | **CONFIRMED** |
| 2 | `cap3` + `attains3_one`, `attains3_two` give κ₁ = 1 and κ₂ = 2 at n = 3, bound and attainment | **CONFIRMED** |
| 3 | `cap3` at every r, including r ≥ 3 | **CONFIRMED** (true, sharp only at r ≤ 2, see §2) |
| 4 | `one_line_value` is the record's value reading θ = P/‖W‖³ at every unit R (r1726 G1) | **CONFIRMED** |
| 5 | r1726 G2 (docstring anchor) and G3 (INDEX hypotheses) repaired | **CONFIRMED** |
| 6 | r1729 G2: `rot4` docstring names L52Rot's `U4` | **CONFIRMED** |
| 7 | The INDEX L237 and L52 rows claim only what is typed | **CONFIRMED WITH GAPS** (G1, G2) |

One line: the mathematics is correct and faithful. The L237 row still owes a value it now proves, and the L52 row says every r1726 gap is repaired while the file-column half of G4 is still open.

## 1. lagrange3

- Statement: for skew 3×3 real `X`, `Y`, `inner2 (br X Y) (br X Y) = inner2 X X * inner2 Y Y − inner2 X Y ^ 2`. Under the isomorphism so(3) ≅ ℝ³ with `inner2` the Euclidean product (`inner2 φᵢⱼ φᵢⱼ = 1`), the bracket is the cross product up to sign, and this is |x × y|² = |x|²|y|² − (x·y)². The ½ in `inner2` is consistent on both sides because it scales each side by the same factor once `inner2 φ φ = 1` fixes the unit.
- Proof route: `skew_rel` pins the six entries of a skew matrix, then `inner2_eq_sum`, `Fin.sum_univ_three`, and `ring`. A polynomial identity in six variables, which is exactly what `ring` closes.
- Screen at X = φ₀₁, Y = φ₀₂: `br` = φ₁₂ (entries −1 at (1,2), +1 at (2,1)), left side 1, right side 1·1 − 0² = 1. Random skew pairs: largest residual 2.1e−14. Screen only.

## 2. cap3 and the two attainments

- `cap3` proves the identity Σⱼ‖[X,yⱼ]‖² = r‖X‖² − Σⱼ⟨X,yⱼ⟩² and the bound ≤ r‖X‖² for orthonormal skew yⱼ. With `Attains` ([L237Attain.lean](../lean/HamiltonsCubic/Results/L237Attain.lean)'s definition: some skew X with ⟨X,X⟩ > 0 and orthonormal skew yⱼ with Σ = κ⟨X,X⟩), the ratio is at most r at every X ≠ 0 and equals r at the witness, so the supremum is exactly r at r = 1, 2. That is κ₁ = 1 and κ₂ = 2 at n = 3, as the record's Statement (second-order.md L237: *"κ₁,κ₂=2,4 for n≥4 (1,2 at n=3)"*) and r1685 G1 mean, with both halves typed.
- The witnesses: X = φ₀₁, y = φ₀₂ gives 1·1 − 0 = 1. y = (φ₀₂, φ₁₂) is orthonormal (Gram = identity, screened) and gives 1 + 1 = 2. The ratio convention (sup over orthonormal y, equal to the Ky Fan sum of top eigenvalues of −ad_X²) is the one r1685 accepted for the rest of the row.
- r ≥ 3: at r = 3 the yⱼ are an orthonormal basis of so(3), so Σⱼ⟨X,yⱼ⟩² = ‖X‖² and the identity gives 2‖X‖². The bound 3‖X‖² is true but not sharp (κ₃ = 2 at n = 3, screened at X = φ₀₁). At r ≥ 4 the hypotheses are unsatisfiable in a 3-dimensional space, so the statement is vacuous. Neither case is a defect: the record claims no n = 3 value at r ≥ 3, and the typed identity carries the exact value when anyone needs it.
- The brief says 4 declarations. The file has six theorems (`skew_rel`, `lagrange3`, `cap3`, `phi_skew3`, `attains3_one`, `attains3_two`). The INDEX sentence gives no count, so nothing in the record is wrong here, but see G1.
- Screen: `L237N3.olean` is timestamped 23:04, after the source's 23:03:38, consistent with a successful build. Axioms were not printed by this review.

## 3. one_line_value (r1726 G1)

- `theta` resolves to `RealLayer.theta R = Pcubic R / norm R ^ 3` ([WeylReal.lean:180](../lean/HamiltonsCubic/Base/WeylReal.lean#L180)) through the file's `open HamiltonsCubic.RealLayer`. `FamilyLayer.theta_of_unit` ([Families.lean:636](../lean/HamiltonsCubic/Base/Families.lean#L636)) rewrites it to `Pcubic R` at `normSq R = 1`, and `one_line_record` closes the goal with identical hypotheses. This is exactly the fix r1726 G1 asked for: the value θ = P/‖W‖³ at every unit R, with no criticality hypothesis.
- G2: the strictness docstring now quotes *"the strict one-line bound"*, which appears verbatim at [bispectral.md:86](../findings/bispectral.md#L86). The phrase "it is exact there" in that sentence refers to the coupling bound, not the one-line bound, so the anchor does not contradict `one_line_strict`.
- G3: the row now reads "a unit R that is linear, preserves and is self-adjoint on bivectors and is first-Bianchi", matching `hR`, `hskew`, `hsym` and `hB`.
- The row's "L52OneLine 4/4 on the standard three" matches the four theorems now in the file.

## 4. rot4 docstring (r1729 G2)

- The docstring now reads "([L52Rot.lean](L52Rot.lean)'s `U4`, `U4_sq`)". L52Rot declares `U4` and `U4_sq : U4_ij² = rot4 i j`, so the pointer is accurate. The "(not declared)" is gone.

## Gaps

- **G1, lean/INDEX.md L237 row, owed list.** The commit removed "the values κ₁ = 1 and κ₂ = 2 at n = 3" from the owed list but left "the values below n = r + 2 at r = 2, 4". At r = 2 the only n below 4 that holds two orthonormal skew matrices is n = 3, and that value is now proved by `attains3_two` + `cap3`. So the row owes, at r = 2, a value that the next sentence marks PROVED. Fix: "the values below n = r + 2 at r = 4 (κ₄ = 4 at n = 4, 3 + √5 at n = 5)". The new sentence also lacks the "N/N on the standard three" and Gate 2 marker that the other entries carry. That half is format only.
- **G2, lean/INDEX.md L52 row.** The row says r1726 was *"CONFIRMED WITH GAPS, all repaired"*. r1726 G4 had two halves: an axiom count, now present, and the file column, which still omits L52OneLine.lean (also L52Rot, L52DisplayTF, L52StairAll). Fix: add those files to the row's file column, or narrow "all repaired" to G1 to G3 and the count.

## Overall verdict

**CONFIRMED WITH GAPS.** `lagrange3`, `cap3` and the two attainments establish κ₁ = 1 and κ₂ = 2 at n = 3 exactly, both the bound and attainment, in the record's normalisation. `one_line_value` is the record's value reading of the one-line bound. The r1726 G2, G3 and r1729 G2 repairs are accurate. G1 and G2 are INDEX bookkeeping, and neither touches the mathematics.
