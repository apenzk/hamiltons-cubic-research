# REVIEW r1921: B12 step 5, the diagonal sector

**Standfirst.** Gate 2 review of [B12Diag.lean](../lean/HamiltonsCubic/Results/B12Diag.lean) (d624c87e) and [B12DiagTrace.lean](../lean/HamiltonsCubic/Results/B12DiagTrace.lean) (6a57371b), which reduce the `t = ∅` sector of `tr(L_e²)` on `weylModuleS` to `tr((KL w)²|_{𝒟ₙ})` and evaluate it at `t · W_T`, `p, q ≥ 3`. Analysis-only footing: the work is reading, hand derivation and the axiom audit. The one intended numeric screen did not run (numpy is absent on this machine) and nothing rests on it.

| # | Claim | Verdict |
|---|---|---|
| 1 | `Lop_diagW`, `KL_weight`: `L_{diagW w}(diagW v) = diagW (KL w v)` with `KL w v` a weight | CONFIRMED |
| 2 | `trace_diag_sector`: `tr(L_{diagW w}² ∘ P_∅) = tr((KL w)²|_{𝒟ₙ})`, via `diagEquiv` | CONFIRMED |
| 3 | `trace_sq_pieces`: trace over distinct eigen-pieces that span `𝒟ₙ` | CONFIRMED |
| 4 | `trace_diag_sphere` (five pieces at `p ≠ q`, four at `p = q`) | CONFIRMED WITH OBSERVATIONS |
| 5 | Units agree with L27 and L161's `trLe2` diagonal part, after division by `dnθ²` | CONFIRMED WITH OBSERVATIONS |
| 6 | Axiom audit | CONFIRMED (18/18 clean) |

**Summary.** Both files are sound and faithful. The diagonal-sector value divided by `dnθ²` is exactly the sign-fixed part of L161's `trLe2`. The observations concern naming (`dnθ` against L161's `thetaSq`) and one dimension that the theorem never consumes.

## 1. Lop_diagW: Kmat to KL, and the weight property

- `Lop_diag_phi` evaluates `Lop e Y` on `φ_ab` through `Lop_spec` (the Fox product itself, with `Lop e Y` in `weylModuleS` by `leftMulS_exists`), then `foxProd_congr_on_skew` replaces `diagW` by the bare `diagOp` on skew inputs, then `foxProd_diag` gives `Kmat w v a b • φ_ab`. The skewness hypotheses are discharged by `diagW_apply_skew'` and `diagOp_skew`. Sound.
- **The passage from `Kmat` to `KL` is sound on bivectors.** `KL w v` is defined in [L127DnExcl.lean](../lean/HamiltonsCubic/Results/L127DnExcl.lean) as `Kmat w v` with the diagonal set to `0`. Only the entries at `a ≠ b` are read (`hoff`), because `φ_aa = 0` makes the diagonal of `Kmat` invisible to any operator on bivectors. The diagonal of `u` is fixed at `0` by `hu.hollow`, and that matches `KL`'s zeroed diagonal. The `ext` in `huKL` covers both cases.
- **No circularity.** The weight `u` comes from `diagSummand_iff` in [L120Diag.lean](../lean/HamiltonsCubic/Results/L120Diag.lean), whose forward direction is `diag_isotypic` together with `diagWeight_isWeight`. Its inputs are membership in `weylModuleS` (supplied by `(Lop e Y).2`) and sign-fixedness. Sign-fixedness is proved in `hfix` from `Lop_actS` (the step-2 equivariance) and the sign-fixedness of `diagW w` and `diagW v`. Neither input mentions `KL`. `KL w v` enters only afterwards, identified with `u` entrywise through `inner2` against `φ_ab`. So `KL_weight` is derived from, and never assumed by, the sector structure.
- `diagW_inj` uses the same `inner2` read-off and is sound.

## 2. trace_diag_sector

- **Statement fidelity.** The left side is the step-3 sector term `tr((L_e ∘ L_e) ∘ projS ∅)` at `e = diagW w`. The right side is the trace of `KL2 hw`, which is `(KL w ∘ KL w)` restricted to `dnWeights`. That is the intended statement.
- `mem_range_projS_diag`: the forward direction takes the image of `projS ∅` and applies `proj_signMat` with `setChar ∅ = 1`, then `diagSummand_iff`. The reverse direction uses `proj_of_char` with the trivial character. Both are sound.
- `diagEquiv` is `LinearEquiv.ofBijective diagSec`. Injectivity comes from `diagW_inj`, surjectivity from `mem_range_projS_diag`. The linearity proofs of `diagSec` are entrywise on `diagOp`.
- **Basis transport.** `trace_sector_restrict` (step 3, reviewed) turns the left side into the trace of the restriction to `range P_∅`. `hkey` gives `restrict (ψ v) = ψ (KL2 v)` by two applications of `Lop_diagW`. Computing both traces as matrix traces, in the basis `finBasis.map ψ` and in `finBasis` respectively, the two matrices agree entrywise, since `(b.map ψ).repr (ψ x) = b.repr x`. This is the standard conjugation invariance, done by hand and kernel-checked.

## 3. trace_sq_pieces

- **The hypotheses suffice.** `hν` (injective `ν`) makes the eigenspaces `E(ν_i)` of `KL w` on the ambient matrix space independent, by `Module.End.eigenspaces_iSupIndep` composed with `hν`. Independence passes to the pieces `𝒟ₙ ⊓ E(ν_i)` by `iSupIndep.mono` and to the `Finset.univ` subtype by `comp Subtype.val_injective`. `hdn` supplies the equality `p = ⨆ i ∈ s, N i` that `LinearMap.trace_eq_sum_trace_restrict_of_eq_biSup` takes, and the maps-to hypotheses are `piece_maps` and `KL_mapsTo` twice. The ambient space `Matrix ι ι ℝ` is finite-dimensional, which is all the Mathlib lemma needs besides these.
- `trace_piece`: on `E(ν)` the square acts as `ν² · id`, so the trace is `ν² · finrank`. Sound.
- **Use is correct.** The rewrite with `KL2 hw = (KL w ∘ KL w).restrict …` is `rfl`, and the proof term of the maps-to argument matches the one the Mathlib lemma is instantiated with.

## 4. trace_diag_sphere: cover, distinctness, dimensions

- **Cover.** `dn_decomp` ([L127DnSpan.lean](../lean/HamiltonsCubic/Results/L127DnSpan.lean), `p, q ≥ 3`) writes every weight as `c · W_T + lamW_T(h) + lamW_{Tᶜ}(h') + X + Z + Z'` with `Σ_T h = 0`, `Σ_{Tᶜ} h' = 0`, `X` cross, `Z`, `Z'` within. Each summand is placed in its piece by the eigenspace identifications: `dn_eig_line` (span of `W_T`), `dn_eig_lamp` and `dn_eig_lamq` (ranges of `lamMap`, at `p ≠ q`), `dn_eig_lam_eq` (their join, at `p = q`), `dn_eig_cross` (`crossSub`), `dn_eig_zero` (`withinSub T ⊔ withinSub Tᶜ`). At `p = q` the two `λ` summands are grouped before placement. The reverse inclusion is `inf_le_left`. So the five pieces (four at `p = q`) cover `𝒟ₙ`, as claimed.
- **Distinctness under `dn_units`** (`0 < λ_p < 1`, `0 < λ_q < 1`, `dnMu < 0`), after factoring out `dnθ ≠ 0` by `dnθ_mul_ne`. The unit values are `1, λ_p, λ_q, dnMu, 0`. `1` differs from each `λ` because `λ < 1`, and from `dnMu` and `0` by sign. Each `λ` is positive, so it differs from `dnMu < 0` and from `0`. `dnMu ≠ 0` since it is negative. `λ_p ≠ λ_q` exactly when `p ≠ q` (`dnLp_eq_dnLq_iff`), which is why the `p = q` case merges them. By hand: `λ_p = λ_q` means `(p−2)(q−1) = (q−2)(p−1)`, i.e. `p = q`. All pairs are covered.
- **Dimensions**, as the Lean inputs prove them: `finrank_eig_line = 1`; `finrank_eig_lamp = p − 1`; `finrank_eig_lamq = q − 1`; `finrank_eig_lam_eq = 2(p − 1)` (via `lam_disjoint`); `finrank_eig_cross = (p − 1)(q − 1)`; `finrank_eig_zero = (C(p,2) − p) + (C(q,2) − q)`. The theorem uses the first five. `Nat.cast_sub` is guarded by `1 ≤ p`, `1 ≤ q`.
- **Dimension total.** `1 + (p−1) + (q−1) + (p−1)(q−1) = pq`, and `C(p,2) − p = p(p−3)/2`. Then `pq + p(p−3)/2 + q(q−3)/2 = (n² − 3n)/2 = n(n−3)/2`, which is `2 · finrank = n(n−3)` of `diagSummand_finrank_closed` in [L120DiagDim.lean](../lean/HamiltonsCubic/Results/L120DiagDim.lean). Also evaluated at `(3,3), (3,4), (4,4), (3,10), (7,5)`: `9, 14, 20, 65, 54` on both sides.
- **Observation 4a.** The zero piece contributes `0² · dim = 0`, so `finrank_eig_zero` is never consumed and the total above is a consistency check that stands outside the theorem. The trace would be unchanged if that dimension were wrong. What the theorem does need from the zero family is only its eigenvalue `0` and its place in the cover.
- **Observation 4b.** The range is `p, q ≥ 3`. The `p = 2` case has its own eigenspace file ([L127DnTwo.lean](../lean/HamiltonsCubic/Results/L127DnTwo.lean)) with `λ_p = 0`, which would merge with the zero piece, and is a separate step.

## 5. Units against L27 and L161

- The Lean units match the record exactly: `dnLp = (p−2)/(2(p−1))` is `lam p` of [L26Statement.lean](../lean/HamiltonsCubic/Results/L26Statement.lean) and [L27.lean](../lean/HamiltonsCubic/Results/L27.lean). `dnMu = −(p+q−2)/(2(p−1)(q−1))` is `−mu p q` of L26Statement, and L27's value on `S²₀ ⊗ S²₀` is `−μ` ([findings/nondegeneracy.md](../findings/nondegeneracy.md), Lemma L27). Only `μ²` enters the trace, so the sign is immaterial to the value and correct in any case. `dnθ = t(n − 1)` is the `KL` eigenvalue on `W_T` (`dn_eig_line`), so dividing by `dnθ²` normalises `L_e W = W`, L27's value `1` on `⟨W⟩`.
- **The diagonal sector inside L161's `trLe2`.** The sector `t = ∅` is the part fixed by the sign group. Reading off each of L27's ten summands by its sign character: `⟨W⟩` is fixed (dim 1, value 1). `S²₀(ℝᵐ)` has fixed part the traceless diagonal matrices (dim `m − 1`, value `λ_m`). `S²₀ ⊗ S²₀` has fixed part (dim `(p−1)(q−1)`, value `−μ`). `Weylₘ` has fixed part `𝒟ₘ` (value 0). `ℝᵖ ⊗ ℝ^q`, `Λ² ⊗ Λ²` and `X ⊗ ℝ` carry characters `ε_i ε_j` or an odd factor and have no fixed part. So the diagonal part of `trLe2 = 1 + pq/4 + dimS_p λ_p² + dimS_q λ_q² + (dimS_p dimS_q + dimL_p dimL_q) μ²` is `1 + (p−1)λ_p² + (q−1)λ_q² + (p−1)(q−1)μ²`, **exactly** `trace_diag_sphere / dnθ²`. The `pq/4` term and the rest of each `S²₀` summand belong to the other sectors.
- **Observation 5a.** The Lean `dnθ` and L161's `thetaSq` are different objects. `dnθ = t(n−1)` is the eigenvalue scale of an unnormalised `e = diagW(t W_T)`, while `thetaSq = 2(n−1)(p−1)(q−1)/((n−2)pq)` is the scale at the unit-norm critical point. The final B12 assembly must convert between them explicitly (through the norm of `W_T`) and must not read the docstring's "θ²" as L161's `θ²`. As a units check the diagonal part at `(3,4)` is `5/2` against `trLe2 = 65/4`, and at `(5,5)` it is `25/8` against `475/16`.

## 6. Axiom audit

`python3 scripts/misc/axiom_audit.py --only B12Diag`, run in the background: "auditing 18 declarations across 2 files, 18/18 clean, resting on the standard three alone", exit 0. There is no `sorry`, and no axiom beyond `propext`, `Classical.choice` and `Quot.sound`.

## 7. Falsifiers and what was done

- **`Lop_diagW`.** It fails if `Lop_spec`'s Fox product differs from `foxProd_diag`'s on `φ_ab` (a mismatch in `diagW` against `diagOp` on non-skew inputs), or if `diagSummand_iff` needed `KL`. I traced both. `foxProd_congr_on_skew` restricts to skew inputs, and `diagSummand_iff` is independent of `KL`.
- **`trace_diag_sector`.** It fails if `range P_∅` were larger than `diagW(𝒟ₙ)`, i.e. if a sign-fixed Weyl operator were not diagonal. `diag_isotypic` rules this out, and the dimension `n(n−3)/2` agrees.
- **`trace_sq_pieces`.** It fails if two `ν_i` coincide (double counting) or the pieces miss part of `𝒟ₙ`. `hν` and `hdn` exclude both, and I checked by hand how they enter the Mathlib lemma.
- **`trace_diag_sphere`.** It fails if an eigenvalue collision went unhandled (only `λ_p = λ_q`, which is handled at `p = q`), if a dimension is wrong (the sum is checked against `n(n−3)/2`), or if the unit values disagree with L27 (the sign-character count in section 5 agrees term by term). The intended numeric screen of `tr(KL²|_{𝒟ₙ})` could not run because numpy is absent. The kernel check makes it redundant.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** B12 step 5 is sound. `trace_diag_sphere / dnθ²` is exactly the diagonal-sector part of L161's `trLe2`. Before the final assembly, note that `dnθ` is not L161's `θ` (5a) and that the zero-family dimension lies outside the theorem (4a).
