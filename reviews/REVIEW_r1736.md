# REVIEW r1736: L268Uniform.lean, the uniform clause of L268 in both directions

**Verdict: CONFIRMED WITH OBSERVATIONS.** The file states the record's last sentence of L268 faithfully and its proofs are sound as read. `lake build` was not run (another session holds the build), so the axiom audit is the author's, taken on report.

Reviewed: [L268Uniform.lean](../lean/HamiltonsCubic/Results/L268Uniform.lean) against [findings/second-order.md](../findings/second-order.md) Lemma L268 and the definitions `torusOp`, `TorusSystem`, `dvec`, `Amu`, `IsPairWeights`, `sum_off_one`, `sum_off_two`, `L268_uniform`, `L268_torus_idem` in [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean), and the L268 row of [lean/INDEX.md](../lean/INDEX.md).

## (1) `uniM` is the record's μ ≡ 1/c

- `uniM m u` is `0` on the diagonal and `u` off it, and `uniM_pair` shows it symmetric with zero diagonal, the `IsPairWeights` shape.
- In `torusOp`, `U i j` multiplies `cPart`, the J-commuting part of the (i, j) block, the root plane of ε_i − ε_j, and `V i j` multiplies `aPart`, the root plane of ε_i + ε_j. The file passes `uniM m (1/c)` for both, so every positive root carries weight 1/c, which is μ ≡ 1/c. The U/V assignment is immaterial here because the two are equal.

## (2) `uniform_first`'s reduction is right

- `dvec i = Σ_l (U_il² + V_il²) = (m − 1)·2u²` by `sum_off_one`, and `(UU + VV)_ij = 2·Σ_l U_il U_lj = 2(m − 2)u²` by `sum_off_two` (the terms l = i and l = j vanish on the zero diagonal).
- The first conjunct of `TorusSystem` then reads u(1 − 4(m − 1)u² + 2(u² − u²)) = 2(m − 2)u², which is the stated form. Its left side is literally the first conjunct at U = V = `uniM`, so `(hsys _ _ hne).1` feeds `.mp` without a coercion gap.
- Cross-check against the record's root form: μ = 4μ³ + μ·4(m − 2)μ² + 2(m − 2)μ² at μ = u divides to 1 = 4(m − 1)u² + 2(m − 2)u, the same equation.

## (3) The forward algebra, and c > 0

- Times c³ with uc = 1: c² − 4(m − 1) = 2(m − 2)c, and c² − 2(m − 2)c − 4(m − 1) = (c − 2(m − 1))(c + 2). Checked by hand. The `linear_combination` coefficient on `huc` is the exact cofactor: c³·h − goal = (uc − 1)(c² − 4(m − 1)(u²c² + uc + 1) − 2(m − 2)c(uc + 1)).
- `hc` is used twice (in `field_simp` for `huc` and in the `linarith` excluding c = −2) and it is needed twice. Screen (hand arithmetic at m = 3, reported as a screen): c = −2 gives u = −1/2, d = 1, and both pair equations read 1/2 = 1/2, so c = −2 is a genuine solution with negative weights. And c = 0 gives `1/0 = 0` in Lean, the zero matrix, which solves `TorusSystem` trivially while 0 ≠ 2(m − 1). The record's "μ > 0" is what `hc` encodes.
- The forward half uses m ≥ 2 only (for the pair ⟨0⟩, ⟨1⟩), and m ≥ 3 enters through `L268_uniform` and `L268_torus_idem`. Harmless.
- Backward half: `rw [h]` turns `uniM m (1/(2(m − 1)))` into the `Matrix.of` form that `L268_uniform` states after its `show`. Sound as read.

## (4) `L268_uniform_op`'s hypotheses

- `hm`, `hc`, `A`, `hA : Aᵀ = A` are exactly `L268_torus_idem`'s hypotheses plus `hc`, with `IsPairWeights` discharged by `uniM_pair`. None is vacuous: `A` ranges over all symmetric matrices, and the conclusion pins it to `Amu`, which at the uniform point is (1/c)·I on the Cartan (d = 2(m − 1)/c², off-diagonal V² − U² = 0), so the operator is I/c at c = 2(m − 1).
- Observation: the record's clause lives in "positive-definite idempotent". The typed statement drops positive definiteness, which is correct because at c > 0 the weights are positive and `L268_torus_pd` supplies it at A = A_μ. Nothing is lost, and the equivalence is stated for idempotency alone.

## (5) The INDEX row

- The added sentence claims `L268_uniform_iff` and `L268_uniform_op` with the typed hypotheses (m ≥ 3, c > 0, A symmetric) and the factorisation, and nothing more. Accurate.
- The owed item, that every T-invariant symmetric operator is a `torusOp`, is right: it is the record's first sentence ("A T-invariant symmetric operator is C = A ⊕ ⊕ μ_α I_{R_α}") and no declaration types it. It is correctly left owed, and the row stays **partial**.
- Observation (owed list, minor): the record's system is displayed per root with β ∼ α and β ± γ = ±α sums, and `TorusSystem` is its pair-coordinate transcription. The transcription is screened (docstring) and cross-checked above at the uniform point, but the general identity between the displayed root form and `TorusSystem` is untyped. The row could say so beside the T-invariance item.

## Observations outside the file

- [findings/second-order.md](../findings/second-order.md) L268's provenance line still says "the idempotency equivalence is prose" and then, in the next sentence, that `L268_torus_idem` is proved. The first clause is stale, and the line does not yet cite [L268Uniform.lean](../lean/HamiltonsCubic/Results/L268Uniform.lean). Repair belongs to the research loop.
- Line 724 of [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) imports the file, so it is in the build graph.

## What would falsify the statement

- An m ≥ 3 and c > 0 with c ≠ 2(m − 1) at which `uniM m (1/c)` satisfies both pair equations of `TorusSystem`, equivalently a second positive root of c² − 2(m − 2)c − 4(m − 1). The quadratic's roots are 2(m − 1) and −2, so none exists.
- For the operator form: a symmetric A ≠ `Amu` with `torusOp A (uniM 1/c) (uniM 1/c)` idempotent, which `L268_torus_idem` excludes.
