# REVIEW r1677: L52, `staircase_strict` (e28295c9), r1676's repairs (inside 8ad3ad60), and whether the row is **proved**

**Verdict: CONFIRMED WITH GAPS on the new mathematics, REFUTED on the row's state.** `staircase_strict` is correct, kernel-checked and non-vacuous, and r1676's G1–G4 are all repaired. The witness is read in a basis of `S²` that no reading of the record's `S²₀` basis produces, so it witnesses the `S²` form of the claim and leaves the record's staircase (the Helmert `ψ_k` on `𝟏^⊥`) undeclared, though the same `Rst` settles it by a one-entry computation. Five sentences of the block have no declaration, one of them inside the equality clause the row says is fully declared, so **proved** overstates the row under this brief's test. The axiom audit is clean on all fourteen files. The canon's L52 entry in [results.md](../results.md) carries a claim L52.lean's own docstring calls false.

## Claims

| # | Claim | Verdict |
|---|---|---|
| 1 | `Rst` is coordinate-diagonal, first Bianchi, unit norm | **CONFIRMED** |
| 2 | `wst` is complete and `wst_cross` is right | **CONFIRMED** (by hand) |
| 3 | `staircase_strict` is non-vacuous in `Mp`, `m` | **CONFIRMED** |
| 4 | `staircase_strict` renders the record's staircase sentence | **CONFIRMED WITH GAPS** (G1, G2) |
| 5 | r1676 G1–G4 repaired | **CONFIRMED** |
| 6 | Every sentence of the L52 block has a declaration, so **proved** | **REFUTED** (G3–G6) |
| 7 | Row text is consistent with the layer after e28295c9 | **CONFIRMED WITH GAPS** (G7, G8) |
| 8 | Axiom audit, fourteen files | **CONFIRMED**, every count as the row states |
| 9 | The canon's L52 statement is consistent with the layer | **REFUTED** (G9, record defect) |

## 1. The witness ([L52Staircase.lean](../lean/HamiltonsCubic/Results/L52Staircase.lean))

- **`Wst`** ([:28-29](../lean/HamiltonsCubic/Results/L52Staircase.lean#L28)): `i + j ∈ {1, 5}` selects exactly the pairs `{0,1}` and `{2,3}`, the other four sums being `2, 3, 3, 4`. So the weight is `2` on `{01, 23}` and `−1` on `{02, 03, 12, 13}`, symmetric and hollow. Every row sums to `2 − 1 − 1 = 0`, so `diagOp Wt` is Ricci-flat, a Weyl tensor (the file does not state this, G2).
- **Coordinate-diagonal.** `R4_Rst` gives `R4 i j k l = Wt i j (δ_ik δ_jl − δ_jk δ_il)`, and `Rst_coordDiag` checks it against [IsCoordDiag](../lean/HamiltonsCubic/Results/L54Basis.lean#L186) directly. Correct.
- **Unit norm.** Twelve ordered-pair weights squared sum to `2(4 + 4 + 1 + 1 + 1 + 1) = 24` over ordered pairs, `12` over unordered, and `t² = 1/12`. `Rst_unit` closes it through `diagOp_normSq_smul`. `normSq` is the convention `L52_record` and `sum_mu_sq` use, so `Σμ² = 1` is the record's `‖M‖_F = 1`.
- **Bianchi, skew, self-adjoint, linear**: the Families lemmas at a symmetric weight. Correct.
- **`wst`.** Rows `(1,1,0,0)/√2`, `(0,0,1,1)/√2`, `(1,−1,0,0)/√2`, `(0,0,1,−1)/√2` are orthonormal, so `WᵀW = I` for the square family. `wst_complete` states that.
- **Cross term by hand.** `w₀ᵀ K w₁ = s² t (W₀₂ + W₀₃ + W₁₂ + W₁₃) = −4ts² = −2t`. The docstring's `−2t` and the commit's `−4ts²` agree.
- **Spectrum of `K`**, derived to see why the witness works: `Wst` has `𝟏 ↦ 0`, `(1,1,−1,−1) ↦ 4`, and a `−2` eigenplane `{v₀ = −v₁, v₂ = −v₃}`. `wst`'s last two members are eigenvectors, its first two span `{𝟏, (1,1,−1,−1)}` and mix eigenvalues `0` and `4`, hence the nonzero cross term.

## 2. Non-vacuity

- `hμ` and `hω` bound finitely many real eigenvalues, so `Mp := Σ_j |μ_j|` and `m := Σ_j |ω_j|` satisfy both. Not exhibited in Lean, and one line by hand. The conclusion is `<` for every such pair, which is the record's "strict" read over every admissible constant.

## 3. Is it the record's sentence?

- **The record's staircase is on `S²₀`.** [bispectral.md:75](../findings/bispectral.md#L75) puts `ψ_k` in `𝟏^⊥`, and [bispectral.md:503](../findings/bispectral.md#L503) names the staircase as Nienhaus–Petersen–Wink's frame-fixed `ψ_k`. In the layer that reading is `L52_record` at a complete `w` whose members are `𝟏/√n` and a basis of `𝟏^⊥`, since then the `S²` diagonal is the `S²₀` diagonal plus one `0` (`dpsi_split`, `sum_diag_split`).
- **`wst` has no member along `𝟏`.** Its `ψ` diagonal is `(−2t, −2t, 2t, 2t)` with no zero entry, while any `S²₀` reading produces a zero entry. So `staircase_strict` is strictness of the **`S²` display at a basis outside the record's family**. It proves "the `S²` 'if' half is false without the stipulation", which is the layer's statement, and leaves the record's own sentence at the record's staircase without a declaration (G1).
- **The record's staircase fails at the same `Rst`**, derived by hand: with Helmert `h₂ = (1,1,−2,0)/√6`, `h₃ = (1,1,1,−3)/√12`, `Wst h₃ ∝ (4, 4, −8, 0)`, so `h₂ᵀ K h₃ = t · 24/√72 = 2√2 t ≠ 0`. The same proof, `L52_record` plus `L52_eq_diagonalises` at `(k, l) = (2, 3)` of `w = (𝟏/2, h₁, h₂, h₃)`, closes it. This is r1676 §5's sketch, which named the Helmert frame.
- **"Any complete frame not diagonalising `K` witnesses the same falsity"** ([:19-20](../lean/HamiltonsCubic/Results/L52Staircase.lean#L19), the commit and the row) is true of `L52_record` and is how the file justifies its substitution. It is the `S²` statement standing in for the `S²₀` one without saying so (G1).
- **The record's sentence is universal in form** ("At a coordinate-diagonal `W` read in the staircase basis ... the bound is strict"), and it is false at coordinate-diagonal `W` whose `K` the staircase happens to diagonalise, which [bispectral.md:503](../findings/bispectral.md#L503) itself allows. A single witness is the right thing to declare for "the 'if' half is false". The universal wording is a record imprecision, noted under G1.

## 4. r1676's gaps

- **G1** (pair–pair conjunct): [L52EqS20.lean:114](../lean/HamiltonsCubic/Results/L52EqS20.lean#L114) states it, proved as `hW (inl p) (inl q)`. Repaired.
- **G2** (ψ–ψ needs no equality): header [:20-21](../lean/HamiltonsCubic/Results/L52EqS20.lean#L20) "Separately, with no equality needed", docstring [:110-111](../lean/HamiltonsCubic/Results/L52EqS20.lean#L110). Repaired.
- **G3** (stale header): [:18-21](../lean/HamiltonsCubic/Results/L52EqS20.lean#L18) lists both new theorems and states the restriction as done. Repaired.
- **G4**: the row carries one count for L52EqS20 (3/3), [L52Statement.lean:75](../lean/HamiltonsCubic/Results/L52Statement.lean#L75) names `S20_basis_diag`, and [L52RecordEq.lean:15-16](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L15) reads "the basis of `S²` the record's stipulation picks". Repaired.

## 5. The block, sentence by sentence

| Record sentence ([bispectral.md:69-102](../findings/bispectral.md#L69)) | Declaration | State |
|---|---|---|
| `M_{(ij),(ij)} = W_ijij`, `⟨W̊φ_ij, φ_ij⟩ = W_ijij` | `Mpair_diag` ([L54Schur.lean:35](../lean/HamiltonsCubic/Results/L54Schur.lean#L35)), `Bw_diag_pair` | declared |
| `K'` in the stipulated basis, `ψ`-block `−κ` | `Bw_diag_psi`, `psi_block`, `dpsi_split` | declared |
| "the `ψ`-block carries `O(n−1)` of further freedom" | `L52_record` quantifies over every complete `w` | read, adequate |
| Schur: `K ≺ μ`, `K' ≺ ω` | `diag_doublyStochastic` | declared |
| convexity and concavity on the ranges | `convexOn_g`, `concaveOn_h` | declared |
| the display, on `S²` and on `S²₀` | `L52_record`, `L52_record_S20`, `L52_matrix_bound` | declared |
| no Karamata, Jensen row by row | DoublyStochastic, `jensen_rows_*` | declared |
| "if" half false without the stipulation | `staircase_strict` at a non-record basis | **G1** |
| "only if" by counting | `rowwise_const`, `eq_rearrangement`, `eq_multiset` | declared |
| "`U` need not be a permutation: a `π/4` rotation inside a degenerate eigenplane is row-tight" | docstring only, [DoublyStochasticEq.lean:19](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean#L19) | **G3** |
| shared frame from `Σ K_i² = ‖M‖²` | `offDiag_zero_of_diag_spectrum`, `L52_matrix_eq_frame`, `L52_record_eq`, `L52_eq_S20`, `S20_basis_diag` | declared |
| strictness on the closed ranges | `strictConvexOn_g`, `strictConcaveOn_h` | declared |
| stipulation sufficient / forced | `L52_if_psi`, `L52_if_psi_S20` / `L52_eq_diagonalises` | declared |
| identity on the whole diagonal family | `L52_if_psi` | declared |
| `3.9804` at padded `W_CP²`, `θ = √(3/2)`, one-line `2.4495` | none (`Mm_sq` brackets `1.632993` only, with no link to padded `W_CP²`) | **G4** |
| the second display `θ ≤ (t_F/2)^{3/2} Θ_n + (9/2)C(1 − t_F/2)` | none (L52.lean's `penalty` is its penalty term as a definition) | **G5** |
| `(1+u+u²)/(1+u) ≤ 3/2` on `[0,1]`, hence `C ≤ Θ_n/3` and then `θ ≤ Θ_n/2` | none | **G5** |
| informative only at `t_F = 2` | `penalty_at_two`, `penalty_antitone` carry the shape, and "only" rests on the previous row | **G5** |
| Verification: "the discarded difference is sign-indefinite" | none | **G6** |

- **"Strictly loose at every unit Weyl tensor"** is absent from the current block ([bispectral.md](../findings/bispectral.md) has no such phrase). `strictly_loose` ([L52.lean:62](../lean/HamiltonsCubic/Results/L52.lean#L62)) proves the arithmetic tail on an abstract vector with `Σμ = 0`. The step "equality in `θ ≤ (3/2)(M₊ + m)` needs every `μ_i ∈ {0, M₊}`" (termwise `μ³ ≤ M₊μ²`) and `Σμ = 0` for `Mpair` have no declaration, and L52.lean's other theorems (`cap_identity`, `penalty_sum_bracket` at `3.674235`, `threshold_nonempty`) cite text the block no longer carries (G7).

## 6. The canon's L52 statement

- [results.md:344](../results.md) and [results.md:1177](../results.md) say "off that family [the bound] loses to the one-line `θ ≤ (3/2)(M₊ + m)`". **That is false as a universal claim**, derived by hand:
  - the one-line bound is strict at every unit Weyl tensor, since equality needs `μ_i ∈ {0, M₊}` for all `i`, which `Σμ = 0`, `Σμ² = 1` exclude (`strictly_loose`).
  - at a coordinate-diagonal `W` the L52 bound equals `θ` (`L52_if_psi`), so it is strictly below the one-line bound there, for any admissible `M₊ > max μ`, `m > −min ω`.
  - both bounds are continuous in `W` at fixed constants (in the stipulated basis `K'` is `K` on the pairs and `−spec(K|𝟏^⊥)`, continuous as a multiset), so the strict inequality holds on a neighbourhood.
  - the coordinate-diagonal locus has positive codimension (`diagonal_locus_proper`), so that neighbourhood contains off-family points where L52 beats the one-line bound.
- [L52.lean:96-98](../lean/HamiltonsCubic/Results/L52.lean#L96) already says the canon's "off the diagonal family it loses" is "false on a range with interior". The block's own text is narrower (one point, padded `W_CP²`). The canon was never brought into line (G9).

## 7. Axiom audit

`python3 scripts/misc/axiom_audit.py --only X.lean`, rerun here, every declaration on the standard three alone: L52 11/11, L52Bound 5/5, L52Frame 19/19, L52S20 5/5, L52Equality 5/5, L52RecordEq 3/3, L52IfPsi 4/4, L52EqS20 3/3, L52Staircase 18/18, DoublyStochastic 5/5, DoublyStochasticEq 3/3, CubicConvexity 7/7, SchurMajor 6/6, SpectralTrace 11/11. Every count matches the row.

## Gaps

- **G1, [L52Staircase.lean:19-20](../lean/HamiltonsCubic/Results/L52Staircase.lean#L19), [:88-89](../lean/HamiltonsCubic/Results/L52Staircase.lean#L88), [lean/INDEX.md:384](../lean/INDEX.md#L384).** `wst` has no member along `𝟏`, so it is outside every `S²₀` reading, and the record's staircase is a basis of `𝟏^⊥`. Fix: add `w = (𝟏/2, h₁, h₂, h₃)` (Helmert), its completeness, `h₂ᵀ K h₃ = 2√2 t`, and `staircase_strict_helmert` by the same three lines, or state in the docstring and row that the witness is at `S²` and name the record's basis as undeclared.
- **G2 (minor), [L52Staircase.lean](../lean/HamiltonsCubic/Results/L52Staircase.lean).** The block's `W ∈ Weyl_n`, and the file never states `Ric Rst = 0`. Fix: one lemma from the zero row sums of `Wst`.
- **G3, [DoublyStochasticEq.lean:19](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean#L19).** The `π/4` rotation example is in the "only if" bullet and has no declaration. Fix: a `2 × 2` doubly stochastic `P = (1/2)·𝟙` with `μ = (v, v)` meeting `eq_multiset`'s hypotheses, not a permutation.
- **G4.** `3.9804`, `θ = √(3/2)` and `2.4495` at padded `W_CP²` have no declaration linking them to the display.
- **G5.** The second display, the `3/2` inequality and its consequence, and "informative only at `t_F = 2`" have no declaration. The block itself says the display is "derived and not reproduced here", so the row must either declare it or list it as outside the Lean scope.
- **G6.** The Verification paragraph's sign-indefiniteness has no declaration.
- **G7, [L52.lean:9-27](../lean/HamiltonsCubic/Results/L52.lean#L9), [:96-98](../lean/HamiltonsCubic/Results/L52.lean#L96) and the row's opening.** L52.lean and the row's first sentences cite a cap identity, `3.674235`, "strictly loose" and a `t_F = 4/3` threshold that the current block does not carry. Fix: re-anchor to the block's present text or say which earlier version they formalise.
- **G8, [lean/INDEX.md:384](../lean/INDEX.md#L384).** The L52RecordEq clause still says the staircase condition is "checked by hand at `n = 4` in r1669, no declaration", beside the new `staircase_strict` clause. Fix: point it at `staircase_strict` (with G1's caveat).
- **G9, record defect, [results.md:344](../results.md) and [results.md:1177](../results.md).** "Off that family it loses to the one-line bound" is false near the diagonal family (§6). Owned by the research loop. Fix: narrow to the block's padded-`W_CP²` point, or state where it loses.
- **Row state.** With G1 and G3–G6 open, "Every part of L52's statement and equality clause is declared" is false (G1, G3 are inside the equality clause) and **proved** holds only in the axiom-audit sense. Fix: **partial** with the owed list, or close G1 and G3 and list G4–G6 as record data outside the layer.

## What would break each claim, and what was done

- **Claim 1:** a nonzero `R4` entry off the two pairings, or a norm other than `1`. Derived `R4_Rst`'s form, recomputed `Σ W² = 12` over unordered pairs, read the proofs.
- **Claim 2:** a `wst` row pair with nonzero dot product, or a cross term of zero. Recomputed all six dot products and `w₀ᵀ K w₁`, and the spectrum of `Wst`.
- **Claim 3:** an eigenvalue set no real constant bounds. Impossible for a finite spectrum.
- **Claim 4:** a reading of the record under which `wst` is a staircase of `S²₀`. The zero entry every `S²₀` reading carries rules it out. Then checked that the record's Helmert staircase still fails at this `Rst`, by hand.
- **Claim 5:** stale text at the four r1676 sites. Read each at HEAD.
- **Claim 6:** a sentence of the block with no declaration. Read [bispectral.md:69-102](../findings/bispectral.md#L69) sentence by sentence against the row and grepped the layer for each object (`3.9804`, `Θ_n`, `1 + u + u`, `permutation`).
- **Claim 8:** a non-standard axiom. Reran the audit on all fourteen files.
- **Claim 9:** a point off the diagonal family where L52 beats the one-line bound. Exhibited by strictness at the family plus continuity plus positive codimension, all by hand.

*Analysis-only footing: the one run was the per-file axiom audit, minutes on the files in hand. The Helmert cross term and the canon counterexample are hand derivations and are recorded as such.*
