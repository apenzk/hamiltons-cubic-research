# REVIEW r1738: L260 (4)'s converse at so(n), L260Converse.lean

**Verdict: CONFIRMED WITH OBSERVATIONS.** The file states the record's "equality exactly at I/(n-2)" faithfully at h = so(n), its three proofs are sound as read, and the INDEX edits claim only what is typed. Read from the working tree (the file is uncommitted). No build was run, per the brief.

Scope: [L260Converse.lean](../lean/HamiltonsCubic/Results/L260Converse.lean), the `L273_F_bound` docstring edit in [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean), the L260 and L273 rows of [lean/INDEX.md](../lean/INDEX.md), against [second-order.md](../findings/second-order.md) Lemma L260 (4).

## (1) innerOp2 C idOp is tr C, and normSq2 idOp is N

- [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) defines `innerOp2 R S = ½ Σ_{i,j} inner2 (R φ_ij) (S φ_ij)` with `inner2 X Y = ½ tr(XᵀY)` and `phi i j = E_ji - E_ij` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)).
- `inner2 φ_ij φ_ij = ½ · 2 = 1` for i ≠ j, so {φ_ij : i < j} is orthonormal. The ordered double sum counts each pair twice with the same term (φ_ji = -φ_ij) and φ_ii = 0, so the outer ½ cancels the doubling: `innerOp2 C idOp = Σ_{i<j} ⟨C φ_ij, φ_ij⟩ = tr C`.
- In the same normalisation `normSq2 idOp = Σ_{i<j} 1 = N`. The equation is (n-2) tr C = N, which is tr(CK) = d at K = (n-2)I, d = N. This is the normalisation in which `sharpMapCL_id` proves I # I = (n-2) I, so K is the record's K.
- Falsifier: a φ with `inner2 φ φ ≠ 1`, which would scale both sides by different powers. None exists.

## (2) IsIdem and the quadratic scaling

- `IsIdem C := sharpMapCL C = C`, and `sharpMapCL` is `sharpMap` bundled (`sharpMapCL_apply` is rfl), which is the record's C # C = C.
- `idem_Ic`: `sharpMapCL_smul` gives c² • sharpMapCL I, `sharpMapCL_id` gives c² • ((n-2) • I), `smul_smul` gives (c²(n-2)) • I, and `field_simp` closes c²(n-2) = c at c = 1/(n-2), n - 2 ≠ 0. Quadratic scaling is used in the right direction.
- Screen (by hand, n = 3): N = 3, K = I, I # I = I, so C = I is idempotent with (n-2) tr C = 3 = N.
- Falsifier: a card-≥3 index type where I/(n-2) # I/(n-2) ≠ I/(n-2), impossible given `sharpMapCL_id`.

## (3) pd_Ic

- Self-adjointness is `isSelfAdjoint2_smul idOp_isSelfAdjoint2`, sound.
- The `show` rewrites `((c • idOp) X : Matrix)` as `c • (X : Matrix)`. This is definitional: `ContinuousLinearMap.smul_apply` and `id_apply` reduce by rfl, and `Submodule.coe_smul` is rfl. The rest is `inner2 (c • X) X = c · inner2 X X` by `transpose_smul`, `smul_mul`, `trace_smul`, with `inner2 X X > 0` from nonnegativity and definiteness at X ≠ 0 (`Subtype.ext` transfers X ≠ 0 to the matrix). c > 0 from n ≥ 3.
- Falsifier: a nonzero skew X with `inner2 X X = 0`, which `inner2_self_eq_zero` excludes.

## (4) The iff renders "equality exactly at I/(n-2)"

- Forward is `(L260_trace_bound ...).2`, the existing equality-forcing clause. Reverse: `innerOp2_smul_left`, `mul_assoc`, `mul_one_div_cancel`, `one_mul`, and `rfl` against `normSq2 := innerOp2 R R`. Sound.
- Together with `L260_trace_bound`.1, (4) at h = so(n) reads: every self-adjoint PD idempotent has (n-2) tr C ≤ N, with equality iff C = I/(n-2). That is the record's clause with ⊕Π_i/c_i = I/(n-2) at one simple ideal.
- Nothing is vacuous: `idem_Ic` and `pd_Ic` exhibit I/(n-2) inside the hypothesis class for every n ≥ 3, so the iff's right side is attained.
- Screen: L263's g2 witness C = 9/28 P_su(3) + 3/28 P_p in so(7) has tr C = 72/28 + 18/28 = 90/28, (n-2) tr C = 450/28 ≈ 16.1 < 21 = N. It is PSD rather than PD on Λ²(ℝ⁷), so it sits outside the hypotheses, and it agrees with the inequality anyway.
- Falsifier: a self-adjoint PD idempotent on Λ²(ℝⁿ), n ≥ 3, other than I/(n-2), with (n-2) tr C = N.
- The record's "positive-definite" carries symmetry implicitly. The Lean hypothesis `IsSelfAdjoint2` makes it explicit, which matches the record.

## (5) INDEX rows and the docstring

- L260 row: the new bold clause names `idem_Ic`, `pd_Ic`, `L260_trace_eq_iff` and states exactly their content. The old "(4)'s converse is untyped" was correctly removed from the Earlier italic.
- `L273_F_bound`'s docstring now points at `L273_F_eq`, which exists in [L273Owed.lean](../lean/HamiltonsCubic/Results/L273Owed.lean) with A = s • Amu, s ≥ 0, the record's equality case. Correct.
- L273 row: `psi_fails` is now glossed as its typed strict inequality κ(1+a0²)^{3/2} - 3 a0 g < λ_m(1-g²), with Ψ_κ(g) below it only by definition. This matches the declaration and discharges r1737's O1.

## Observations

- **O1.** The L260 row's closing clause "(4) at a proper semisimple h with K = ⊕c_iΠ_i is typed only at h = so(n)" reads as a contradiction (a proper h is by definition not so(n)). Suggest a positive statement: "(4) is typed at h = so(n), and at a proper semisimple h with K = ⊕c_iΠ_i it is prose."
- **O2.** The record's provenance line for L260 in [second-order.md](../findings/second-order.md) still says "(4) without its converse" and does not cite L260Converse.lean. It is stale once this file lands and should be updated in the same commit or the next.
- **O3.** The L273 row's "(Ψ_κ itself is not a declaration ...)" is a negation. Positive form: "Ψ_κ lives in the record only".
