# REVIEW r1712: statement fidelity of L48Const.lean

**Standfirst.** Cold Gate 2 brief, statement fidelity of [L48Const.lean](../lean/HamiltonsCubic/Results/L48Const.lean) against Lemma L48 of [problem.md](../findings/problem.md) (line 318 onward) and the L48 row of [lean/INDEX.md](../lean/INDEX.md) (line 288). Analysis only: definitions and proofs were read, no `lake build` or `lake env` was run. The only computation is a screen of seconds, exact rationals in plain Python, of `L48_weyl_zero_iff`'s two sides at four concrete operators at `m = 4`, reported as a screen and never as evidence for a positive claim. Log: [agent_logs/review-r1712.log](../agent_logs/review-r1712.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | `bianchi_id`: the identity on `Λ²` is first-Bianchi | CONFIRMED |
| C2 | `einstein_weylPart`: at a linear, bivector-preserving, self-adjoint, first-Bianchi `R` with `Ric R = ρ δ`, `m ≥ 2`, the map `R − (ρ/(m−1))·Id` is `IsWeylOp` | CONFIRMED |
| C3 | `scalar_orth`: `c·Id` is orthogonal to every linear Ricci-flat operator | CONFIRMED |
| C4 | `normSq_eq_zero_iff`: `normSq W = 0` iff `W φ_ij = 0` for all `i, j` | CONFIRMED |
| C5 | `L48_weyl_zero_iff` is the record's "‖W_a‖² vanishes exactly when that factor has constant curvature", pointwise | CONFIRMED |
| C6 | INDEX row: the record's `λ > 0` clause is stronger than the argument uses, `S¹×S^{m−1}` failing by being non-Einstein | CONFIRMED |
| C7 | INDEX row: pointwise to global, "at every point with the same `c`, since `ρ` is the factor's Einstein constant" | CONFIRMED (prose bridge, sound) |
| C8 | INDEX row: the only item still owed is the factorwise decomposition `‖W‖² = Σ‖W_a‖² + B` | REFUTED AS STATED |
| C9 | L48Const header: "L48.lean and ReducibleConvexity.lean prove the rest of the argument" | REFUTED AS STATED |

**Summary.** Every theorem in L48Const.lean says what the record's clause says, at the right normalisation and at any sign of `ρ`. The INDEX row and the file header overstate what the rest of the L48 block has in the layer: Jensen's multi-point step and the monotonicity of `k f(n/k)` in `k` are both absent.

## Conventions

- `inner2 X Y = ½ tr(Xᵀ Y)` ([WeylReal.lean:39](../lean/HamiltonsCubic/Base/WeylReal.lean#L39)), so `inner2 (φ_ij) (φ_ij) = 1` for `i ≠ j` and `φ_ii = 0`.
- `Ric R a b = Σ_c inner2 (R φ_ac) (φ_bc)` ([WeylReal.lean:106](../lean/HamiltonsCubic/Base/WeylReal.lean#L106)). With `R = Id` this is `(m−1) δ_ab`, proved as `Ric_id_eq` ([L208RicciFoxSquare.lean:120](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L120)). The unit sphere is `+Id` in the layer (`sectProd` in [L2SphereWeyl.lean](../lean/HamiltonsCubic/Results/L2SphereWeyl.lean)), so the sign convention is the geometric one: constant curvature `c` gives `Ric = (m−1)c g`, hence `c = ρ/(m−1)`.
- `innerOp R S = ½ Σ_{i,j} inner2 (R φ_ij) (S φ_ij)` over ordered pairs, so `normSq R = Σ_{i<j} |R φ_ij|²`, the standard operator norm on `Λ²` for an operator preserving `Λ²`.
- `IsWeylOp = IsLinOp ∧ IsWeyl`, with `IsWeyl` bivector-preserving, self-adjoint on skew inputs, first-Bianchi, Ricci-flat ([FoxProduct.lean:110](../lean/HamiltonsCubic/Base/FoxProduct.lean#L110), [WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)).

## Hypothesis inventory for `einstein_weylPart` and `L48_weyl_zero_iff`

| Hypothesis | Role | Status |
|---|---|---|
| `hR : IsLinOp R` (on all matrices) | linearity clause of `IsWeylOp` | harmless: a geometric `R` on `Λ²` extends linearly (precompose with the skew projection), and every conclusion is read at `φ_ij` |
| `hskew` | `R` preserves `Λ²` | needed, it is `IsWeyl`'s first clause |
| `hsa` (skew inputs only) | pair symmetry | the right quantifier |
| `hb` | first Bianchi | needed |
| `hE : Ric R = ρ δ`, `ρ` any real | Einstein at the point | the right normalisation (see Conventions) |
| `hm : 2 ≤ m` | division by `m − 1` | matches the record's `n_a ≥ 2` |
| `hW : IsWeylOp W`, `hK`, `hsplit` | the split `R = W + K` | nonvacuous: `W = R − c Id`, `K = c Id` meets them by C2 and C3 |

No hypothesis is vacuous and none is missing for an algebraic curvature operator plus pointwise Einstein. `hK` quantifies over every linear Ricci-flat `R'`, which is stronger than orthogonality to `𝒲`. The record's own split (`W_a` plus `c Id`) meets it by `scalar_orth`, so the record's `W_a` is inside the theorem's range, and `weylPart_unique` makes every admissible `W` agree with it on bivectors.

## 1. Is the conclusion constant curvature, and is `W` the record's `W_a`?

- `∀ i j, R φ_ij = c φ_ij` with `IsLinOp R` gives `R = c Id` on the span of the `φ_ij`, which is all of `Λ²`, hence the statement is frame independent. For an algebraic curvature operator, `R = c Id` on `Λ²` is exactly constant sectional curvature `c` (sectional curvature of the `e_i e_j` plane is `inner2 (R φ_ij) φ_ij = c`, and conversely constant sectional curvature determines `R` through the curvature identities). CONFIRMED.
- `W` is the record's `W_a`. The record's `W_a` is the factor's intrinsic Weyl part: at `λ = ½` the non-Weyl part `c_a Id`, `c_a = λ/(n_a−1)`, has norm² `c_a² · n_a(n_a−1)/2 = n_a/(8(n_a−1)) = f(n_a)`, which is exactly the record's `f`, so `W_a = R_a − c_a Id`, the same `W` the Lean theorem pins down. `normSq W = 0` is `‖W_a‖² = 0` up to the positive normalisation, which does not affect vanishing. CONFIRMED.

## 2. Hypotheses and normalisation

Covered by the inventory. `Ric_id_eq` gives `Ric Id = (m−1) δ`, the geometric value on the unit sphere, so `ρ` is the geometric Einstein constant `λ` and `c = ρ/(m−1)` is the sectional curvature. CONFIRMED.

## 3. The `λ > 0` clause

- The pointwise equivalence holds at every sign of `ρ`. At `ρ = 0`, `W = 0` forces `R = 0` (flat). At `ρ < 0` it forces a hyperbolic space form. Both directions of the record's clause hold there too.
- `S¹×S^{m−1}` at `m ≥ 3` has `Ric = diag(0, m−2, …, m−2)`, not scalar, so it is excluded by Einstein, and `λ > 0` does no additional work there. At `m = 2` it is the flat torus, Einstein with `λ = 0` and constant curvature `0`, which satisfies the clause.
- Where `λ > 0` genuinely matters is the Theorem's equality set (positive space forms `S^{n_a}`, `ℝP^{n_a}`) and the passage through L210/L211 to compact type. Inside L48 it is moot, since the block fixes `λ = ½`.
- So the INDEX row's reading is correct. The record's sentence should read that the forward direction needs Einstein, with the sign moved to where it is spent. CONFIRMED.

## 4. Pointwise versus global

- Einstein means `Ric = λ g` with `λ` constant. Then at each point, in an orthonormal frame, `hE` holds with the same `ρ = λ`, and `‖W_a‖²(p) = 0` gives `R_p = (λ/(n_a−1)) Id` with one `c` for all `p`. Constant curvature follows with no appeal to Schur's lemma, because the constancy of `λ` is part of the hypothesis. On a symmetric space `‖W_a‖²` is constant anyway, so "vanishes" at one point is vanishing everywhere.
- At `m = 2` and `m = 3`, `𝒲 = 0`, so `‖W_a‖²` vanishes identically and the Lean theorem says `R = c Id` always under `hE`. That matches geometry only because Einstein carries a constant `λ`: in dimension 2, `Ric = K g` holds for every surface, and it is the constancy that makes `K` constant. The record's shared constant `λ = ½` supplies it. Nothing else is needed.
- The bridge (orthonormal frame, identification of the geometric curvature operator with the layer's `R`) is prose, which the row states. CONFIRMED.

## 5. What else in the L48 block is outside the layer

The row lists one owed item. Reading [L48.lean](../lean/HamiltonsCubic/Results/L48.lean) and [ReducibleConvexity.lean](../lean/HamiltonsCubic/Results/ReducibleConvexity.lean) in full, at least three more are absent:

1. **Jensen's multi-point step.** ReducibleConvexity proves only the two-point inequality `f_two_point`. No `ConvexOn` value is constructed and `ConvexOn.map_sum_le` is never invoked (neither name occurs in either file). The row's *"Jensen is then `ConvexOn.map_sum_le`"* and *"closed in ReducibleConvexity"* describe a citation that the layer does not carry. It is a short step, but it is not in the layer.
2. **`k f(n/k)` increases in `k` over `k ≥ 2`.** L48.lean has `k_f_identity`, an algebraic identity (`8n(n−k)` on both sides), and `two_factors` at `k = 2`. No monotonicity in `k` is stated or proved, here or in [SymmetricTheorem.lean](../lean/HamiltonsCubic/Results/SymmetricTheorem.lean).
3. **The assembly** "the reducible minimum sits at the balanced product" (combining decomposition, Jensen, the `k` step and `‖W_a‖² ≥ 0`, including the integer-to-real relaxation) is prose. `balanced_B` is only the cross-multiplied value of `B` at `k = 2`.
4. Minor: two different `f`s, over `ℚ` in L48.lean and over `ℝ` in ReducibleConvexity, with no bridge.

The decomposition `‖W‖² = Σ‖W_a‖² + B` is correctly listed as owed. L48Const already contains most of it at one factor (`‖R_a‖² = ‖W_a‖² + ‖c_a Id‖²` follows from C2, C3 and linearity), so it is nearer than the row suggests. C8 REFUTED AS STATED.

## 6. Docstring claims the types do not carry

- [L48Const.lean header](../lean/HamiltonsCubic/Results/L48Const.lean#L10): *"L48.lean and ReducibleConvexity.lean prove the rest of the argument"*. False for the three items in section 5. REFUTED AS STATED.
- Stale "sphere" wording: [L48.lean:9](../lean/HamiltonsCubic/Results/L48.lean#L9) (*"vanishes exactly at a sphere factor"*, *"the reducible minimum sits at `S^{n/2}×S^{n/2}`"*), [ReducibleConvexity.lean](../lean/HamiltonsCubic/Results/ReducibleConvexity.lean) header (*"vanishes exactly at sphere factors"*, *"the third is geometry this layer has no types for"*), and the ReducibleConvexity row of [lean/INDEX.md:620](../lean/INDEX.md#L620) (*"narrows to its third item alone ... sphere factors, which is geometry"*). The record corrected "sphere" to "constant curvature" (`ℝP^{n_a}` qualifies), and the third item is now typed.
- The L48Const theorem docstrings themselves are faithful. `L48_weyl_zero_iff`'s *"constant sectional curvature"* is carried by the conclusion together with `hR`. *"The Einstein constant ρ has any sign here"* is correct.

## Falsifiers sought and the screen

| Statement | Falsifier would be | What was done |
|---|---|---|
| C1 | a four-index tuple with nonzero cyclic sum at `Id` | derived: `inner2 (φ_ij) (φ_kl) = δ_ik δ_jl − δ_il δ_jk`, cyclic sum vanishes, and a screen at `m = 4` gives max `0` |
| C2 | Einstein `R` with `Ric(R − c Id) ≠ 0` | derived from `Ric_id_eq`, and screened `Ric W = 0` at the four objects below |
| C3 | a Ricci-flat linear `R'` with `⟨c Id, R'⟩ ≠ 0` | `⟨c Id, R'⟩ = (c/2) Σ_a Ric(R')_aa`, so none exists |
| C4 | nonzero `W` on some `φ_ij` with `normSq W = 0` | sum of squares, none exists |
| C5 | Einstein, non-constant-curvature `R` with `normSq W = 0`, or a space form with `normSq W > 0` | screen below |
| C8, C9 | a step of the L48 block with no Lean counterpart | found three, section 5 |

**Screen (exact rationals, layer's definitions transcribed, `m = 4`):**

| Object | Bianchi | Einstein, `ρ` | `c` | `normSq W` | RHS (`R φ = c φ`) |
|---|---|---|---|---|---|
| `S²×S²` (`diagOp sectProd`, `S = {0,1}`) | 0 | yes, 1 | 1/3 | 4/3 | false |
| `S⁴` (`Id`) | 0 | yes, 3 | 1 | 0 | true |
| `H⁴` (`−Id`) | 0 | yes, −3 | −1 | 0 | true |
| `T⁴` (`0`) | 0 | yes, 0 | 0 | 0 | true |

`S²×S²` is Einstein and not constant curvature, and both sides are false, as the theorem requires. `c = 1/3` agrees with L2SphereWeyl's `c = 1/(1 + ½(q/(p−1) + p/(q−1)))` at `p = q = 2`. The space forms at all three signs have both sides true, which is the screen-level content of C6.

## Overall verdict

**L48Const.lean CONFIRMED on all statements**: it proves the record's "‖W_a‖² vanishes exactly when the factor has constant curvature" pointwise, at the right normalisation, for Einstein constants of any sign, and the INDEX row's reading of the `λ > 0` clause and of the pointwise-to-global passage is correct. **The row's owed list is REFUTED AS STATED**: besides the factorwise decomposition, Jensen's multi-point step, the monotonicity of `k f(n/k)` in `k`, and the assembly are not in the layer, and the L48Const header's *"prove the rest of the argument"* should be withdrawn. The row stays **partial**, with those items added, and the stale "sphere" wording in L48.lean, ReducibleConvexity.lean and INDEX line 620 should become "constant curvature".
