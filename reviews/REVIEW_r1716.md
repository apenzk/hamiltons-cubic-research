# REVIEW r1716: L48Decomp, L48Jensen, L56Spec statement fidelity

**Verdict: every typed statement in the three files is true and says what Lemma L48 and the corrected L56 block say. The L48 row's "proved" is warranted for L48 as the record states it, with the block-diagonal input carried as the hypothesis `hmix`, which is the record's own input and is equivalent to its "block-diagonal and zero on mixed terms" under the other hypotheses. One docstring cites the wrong lemma for the identification `Wfac = Σ_a ‖W_a‖²`, which is true and untyped, and which no proved bound depends on.**

Cold brief from the lean loop session, analysis only. Screens were by hand at single objects (S²×S², the `(2,2,8)` vertex) and are reported as screens. No `lake` command was run. Log: [agent_logs/review-r1716.log](../agent_logs/review-r1716.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | `Wfac R β ρ` is `Σ_a ‖W_a‖²`, the factors' own Weyl norms | PLAUSIBLE (true, untyped, cited to the wrong lemma) |
| C2 | `pair_split`, `inner2_quad`: the pair-level algebra | CONFIRMED |
| C3 | `normSq_decomp`: `‖W‖² = Wfac + (ρ²/2) Σ_i (1/(p_i−1) − 1/(n−1))` for any Weyl split | CONFIRMED |
| C4 | `hmix` is the record's "block-diagonal on Λ² and zero on the mixed terms" | CONFIRMED (equivalent given `hsa`, `hb`) |
| C5 | `B_half` and the regrouping `Σ_i 1/(8(p_i−1)) = Σ_a f(n_a)` in `L48_reducible_bound` | CONFIRMED |
| C6 | `Wfac_eq_zero_iff`: zero exactly at constant curvature on every factor | CONFIRMED |
| C7 | `f_convexOn`, `jensen`: direction and real relaxation | CONFIRMED |
| C8 | `k_f_eq`, `k_mono`, `two_split_B`, `B_ge`: domain covers the use | CONFIRMED |
| C9 | `L48_reducible_bound`: `‖W‖² ≥ n²/(8(n−1)(n−2))` over the record's range | CONFIRMED |
| C10 | `L48_attained`: equality at the balanced product of two constant-curvature factors | CONFIRMED |
| C11 | `diagOp_eigen_entry`, `diagOp_spec`: the Λ² spectrum of `diagOp w` is `{w_ab : a ≠ b}` | CONFIRMED |
| C12 | `vertex_attained_228`: `4/7` attained inside the S⁸ | CONFIRMED |
| C13 | L56Spec closes r1711 Q2 | CONFIRMED (the step is typed, the composition "gap = min over entries" stays prose) |
| C14 | INDEX L48 row reads **proved**, outside it `hmix` and uniqueness of the minimiser | CONFIRMED, two wording defects in the row |

**One line:** the decomposition, Jensen, the monotonicity in `k`, the bound and its attainment are all in the layer at the record's normalisation and range, and the only untyped readings are labels (`Wfac` as `Σ_a ‖W_a‖²`) that no proof step consumes.

## Conventions

- `inner2 X Y = ½ tr(XᵀY)`, so `inner2(φ_ij, φ_ij) = 1` for `i ≠ j` and the `φ_ij`, `i < j`, are orthonormal in Λ².
- `innerOp R S = ½ Σ_{i,j} inner2(Rφ_ij, Sφ_ij)` over ordered pairs, so `normSq R = Σ_{i<j} ‖Rφ_ij‖²`, the Hilbert–Schmidt norm on Λ², `Σ λ²` for self-adjoint `R`.
- `Ric R a b = Σ_c inner2(Rφ_ac, φ_bc)`, so `Ric(Id)(a,a) = n − 1` and `c·Id` has `Ric = c(n−1)δ`.
- `bs β i` is the size of `i`'s factor, `p_i` below, `n = Fintype.card ι`.
- `f m = m/(8(m−1))` (ReducibleConvexity), the record's `f`.
- Record normalisation `λ = ½` is `ρ = ½`, since `Ric = λ g`.

## Hypothesis inventory

| Hypothesis | Where | Record's counterpart | Reading |
|---|---|---|---|
| `hR` (`IsLinOp R`), `hskew`, `hsa`, `hb` | Decomp, Jensen | `R` a curvature operator | algebraic curvature operator on Λ² |
| `hE : Ric R = ρ δ` | Decomp (`ρ` free), Jensen (`ρ = ½`) | each factor Einstein with the same constant, `λ = ½` | equivalent given `hmix` (§1) |
| `hbs : ∀ i, 2 ≤ bs β i` | all | `n_a ≥ 2` | exact |
| `hn : 2 ≤ card ι` | Decomp | implied by `hbs` | redundant, harmless |
| `h2 : 2 ≤ card (image β)` | `L48_reducible_bound` | `k ≥ 2` | exact |
| `hmix : β i ≠ β j → R φ_ij = 0` | Decomp, Jensen | "zero on the mixed terms", and block-diagonal | equivalent given `hsa`, `hb` (§1) |
| `hW : IsWeylOp W`, `hK`, `hsplit` | Decomp, Jensen | `W` the Weyl part of `R` | pins `W φ_ij = Rφ_ij − c φ_ij` by `weylPart_unique`, satisfiable with `W = R − c Id`, `K = c Id` |
| `hbal : 2·bs β i = n` | `L48_attained` | balanced product, `n` even | forces exactly two factors of size `n/2` |
| `hconst` | `L48_attained` | constant curvature on each factor | `R = c_a Id` on each `Λ²(A)` |
| `[Nonempty ι]` | `L48_attained` | none | only to read `card` off an index |
| `hw : w symmetric` | `diagOp_spec` | the weight is symmetric | used only in the `⊇` direction |

## 1. Is `Wfac` the factors' Weyl norms? (question 1)

`Wfac R β ρ = ½ Σ_{β i = β j} ‖Rφ_ij − c_i φ_ij‖²`, `c_i = ρ/(p_i − 1)`. The terms with `i = j` vanish for linear `R` since `φ_ii = 0`.

**Each factor's Ricci is `ρδ`.** For `a, b ∈ A`: `Ric R a b = Σ_c ⟨Rφ_ac, φ_bc⟩`. A term with `c ∉ A` has `φ_ac` mixed, so `Rφ_ac = 0` by `hmix`. What remains is `Σ_{c∈A} ⟨Rφ_ac, φ_bc⟩`, the factor's own Ricci. So `hE` restricted to `A` gives `Ric_A = ρ δ`.

**`R` maps `Λ²(A)` into `Λ²(A)`.** Take `i, j ∈ A`. `Rφ_ij` is skew by `hskew`. Its component on a mixed `φ_kl` is `⟨Rφ_ij, φ_kl⟩ = ⟨φ_ij, Rφ_kl⟩ = 0` by `hsa` and `hmix`. Its component on `φ_kl` with `k, l ∈ B ≠ A` is zero by first Bianchi: `bianchi R i j k l = ⟨Rφ_ij, φ_kl⟩ + ⟨Rφ_ik, φ_lj⟩ + ⟨Rφ_il, φ_jk⟩`, and `φ_ik`, `φ_il` are mixed, so the last two vanish and the first does too. Hence `Rφ_ij ∈ Λ²(A)`, and the restriction `R_A` is a linear, self-adjoint, first-Bianchi operator on `Λ²(ℝ^{n_a})` with `Ric = ρδ`, `n_a ≥ 2`.

**So the identification holds.** `einstein_weylPart` and `weylPart_unique` at the factor give `W_A = R_A − c_A Id`, `c_A = ρ/(n_a − 1)`, and `normSq W_A = ½ Σ_{i,j∈A} ‖Rφ_ij − c_A φ_ij‖²` (the full `inner2` equals the factor's since both sides lie in `Λ²(A)`). Summing over `A` is `Wfac`.

**What the file types and what it does not.** `Wfac` is a definition, and no theorem states `Wfac = Σ_a normSq W_a` for restricted operators. The header says this identity follows "by L48Const.lean's `L48_weyl_zero_iff` reading at each factor". That lemma is an iff about vanishing, and the norm identity needs `einstein_weylPart` with `weylPart_unique` plus the invariance just derived. **The proof does not need the invariance**: `normSq_decomp` is pure algebra over the pairs, and the bound uses only `Wfac ≥ 0` while the attainment uses only `Wfac_eq_zero_iff`. The label is therefore never load-bearing. C1 PLAUSIBLE (true, untyped, citation to be corrected).

**Falsifier sought:** an `R` meeting the hypotheses with some `Rφ_ij`, `i, j ∈ A`, having a component outside `Λ²(A)`. The Bianchi argument above excludes it.

## 2. `normSq_decomp` and `hmix` (question 2)

**`hmix` against the record.** The record says `R` is block-diagonal and zero on the mixed terms. `hmix` states the second. The first follows from `hmix`, `hsa` and `hb` by §1, so under the file's other hypotheses the two are equivalent. It is neither weaker nor stronger in effect. INDEX's "block-diagonal Einstein operator" is accurate.

**The proof.** `hu` pins `W φ_ij = Rφ_ij − c φ_ij`, `c = ρ/(n−1)`. `pair_split` expands `‖(R − c)φ_ij‖²` around `c_i` on within-factor pairs and uses `hmix` on mixed pairs, where `‖(0 − c)φ‖² = c²‖φ‖²`. Row sums use `Σ_j ⟨Rφ_ij, φ_ij⟩ = Ric(i,i) = ρ` and `#{j ≠ i} = n − 1`, `#{j ≠ i : β j = β i} = p_i − 1`. Per row: `2(c_i − c)ρ + c²(n−1) − c_i²(p_i−1) = ρ²/(p_i−1) − ρ²/(n−1)`, checked by hand. The `½` of `normSq` gives the stated `ρ²/2`. C2, C3 CONFIRMED.

**Screen, S²×S², `ρ = ½`.** Each S² has `K = ½`. `c = 1/6`. `W` has eigenvalue `½ − 1/6 = 1/3` on `φ_12`, `φ_34` and `−1/6` on the four mixed pairs, so `normSq W = 2/9 + 4/36 = 1/3`. The decomposition: `Wfac = 0` (`c_i = ½ = K`), and `(1/8)·4·(1 − 1/3) = 1/3`. The bound `16/(8·3·2) = 1/3`. All three agree.

**Cross-check with L56.** At `Wfac = 0`, `ρ = 1`, the per-index term `½(1/(p−1) − 1/(n−1))` equals `½ Σ_j weylE_ij²`, since `(p−1)(1/(p−1) − 1/(n−1))² + (n−p)/(n−1)² = 1/(p−1) − 1/(n−1)`. So `normSq_decomp` and L56Norm's `normSq (diagOp vW)` are one computation.

## 3. `B_half` and the regrouping (question 3)

`B_half`: `(¼/2) Σ_i (1/(p_i−1) − 1/(n−1)) = Σ_i 1/(8(p_i−1)) − n/(8(n−1))`. Correct. In `L48_reducible_bound`, `hgroup` sums fibrewise over `t = image β`: the `m_a` indices of factor `a` each carry `1/(8(m_a−1))`, total `m_a/(8(m_a−1)) = f(m_a)`. `hsum` gives `Σ_a m_a = n`. So `B = Σ_a f(n_a) − n/(8(n−1))`, the record's `B`, depending on the partition alone. The bound `n²/(8(n−1)(n−2))` is the record's. The range `card (image β) ≥ 2` is `k ≥ 2` and `hbs` is `n_a ≥ 2`. C5 CONFIRMED.

`Wfac_eq_zero_iff`: a sum of nonnegative squares is zero exactly when each within-factor `Rφ_ij = c_i φ_ij`. Given §1 that is `R_A = c_A Id` on each `Λ²(A)`, constant sectional curvature `c_A`. C6 CONFIRMED.

## 4. Jensen, `k_mono`, `B_ge` (question 4)

- `f_convexOn` on `(1, ∞)` from `f_two_point`, the record's convexity.
- `jensen`: `ConvexOn.map_sum_le` at weights `1/k` gives `f(mean) ≤ mean of f`, so `k f(n/k) ≤ Σ_a f(m_a)`. Right direction for a lower bound. The sizes enter as reals `m : κ → ℝ` and `n/k` need not be an integer, which is the record's relaxation, safe because the conclusion is a lower bound.
- `k_f_eq`: `k f(n/k) = kn/(8(n−k))` on `0 < k < n`. `k_mono`: the cross-multiplied difference is `−8n²(k'−k) < 0`, strict increase on `0 < k < k' < n`.
- `B_ge`: `n ≥ 2k` from `m_a ≥ 2`. When `k > 2`, `k_mono` is applied at `(2, k, n)` and needs `k < n`, which holds as `n ≥ 2k > k`. When `k = 2` it is equality. Then `2 f(n/2) − n/(8(n−1)) = n²/(8(n−1)(n−2))` by `two_split_B` at `n ≥ 4 > 2`. The domain covers the use.

C7, C8 CONFIRMED. **Falsifier sought:** a family with `k ≥ 2`, `m_a ≥ 2` and `Σ f(m_a) − n/(8(n−1))` below the bound. At `(2,2,8)`: `Σf = 1/4 + 1/4 + 1/7 = 9/14`, `n/(8(n−1)) = 12/88 = 3/22`, `B = 9/14 − 3/22 = 39/77 ≈ 0.506` against `144/(8·11·10) = 9/55 ≈ 0.164`. Consistent.

## 5. `L48_reducible_bound` and `L48_attained` (questions 3, 5)

The bound: `normSq W = Wfac + B ≥ B ≥ n²/(8(n−1)(n−2))`. It is stated for any operator meeting the hypotheses, which includes every product's curvature operator and is stronger than the record's statement. It holds at every `n`, with attainment possible only at even `n`. C9 CONFIRMED.

The attainment: `hbal` makes every factor of size `n/2`, so there are exactly two and `n` is even. `hconst` is `R = c_A Id` on each `Λ²(A)`, `c_A = ½/(n/2 − 1) = 1/(n−2)`. That is the curvature operator of `S^{n/2} × S^{n/2}` and of `RP^{n/2} × RP^{n/2}` at `λ = ½`, the record's balanced product of two space forms of the same positive curvature. The hypotheses are satisfiable: the diagonal operator with weight `1/(n−2)` within factors and `0` across meets every clause, with `W = R − c Id`, `K = c Id`. So the theorem is non-vacuous. The value follows from `Wfac = 0` and `(1/8)·n·(2/(n−2) − 1/(n−1)) = n²/(8(n−1)(n−2))`. C10 CONFIRMED.

**Outside both theorems**, as the INDEX row says: the geometric fact that a Riemannian product (or, by the record's line 289, a locally symmetric Einstein space) has curvature meeting `hmix`, and the converse that equality forces the balanced product. The record's `= 1/(4θ₀(n)²)` is L48.lean's arithmetic, reviewed earlier.

## 6. L56Spec (question 6)

`diagOp w X = w ∘ X` entrywise. The set `{λ | ∃ X skew, X ≠ 0, diagOp w X = λ X}` is the point spectrum of `diagOp w` on Λ². For symmetric `w` the operator preserves Λ² and is self-adjoint there, so this is the whole Λ² spectrum. C11 CONFIRMED.

`diagOp_eigen_entry` picks `X_ab ≠ 0`. Skewness gives `X_aa = −X_aa = 0`, so `a ≠ b`, which is exactly the use of `hX`. Cancelling `X_ab` in `w_ab X_ab = λ X_ab` gives `λ = w_ab`. The `⊇` direction uses `diagOp_phi` with `hw` and `φ_ab ≠ 0` at `a ≠ b`.

`vertex_attained_228`: `beta228` puts indices 4 to 11 in the S⁸, so `4, 5` share a factor. By `vertex_entries`, `vW_45 = −(12 − 8)/7 = −4/7`. Hand screen agrees. C12 CONFIRMED.

**r1711 Q2.** The missing converse is now typed and cites `diagOp_phi` for the other half, so "the smallest modulus of the Λ² spectrum" equals "the smallest modulus of the off-diagonal entries" for every symmetric weight, `vW` among them (`vW_symm`). At `(2,2,8)` the minimum is attained. No single theorem composes `diagOp_spec` with `vertex_min_228` into "the gap is `4/7`", so that composition is still read by the reader, and it is one line. C13 CONFIRMED.

## 7. The INDEX row and docstrings (question 7)

**"Proved" is warranted.** The record's L48 claims: the decomposition with `B` depending on the partition alone (C3, C5), Jensen at fixed `k` and `n` with the real relaxation (C7), monotonicity over `k ≥ 2` (C8), `‖W_a‖² ≥ 0` vanishing exactly at constant curvature (C6 with L48Const), and the minimum at the balanced product at even `n` (C9, C10). Every one is typed. The record's own hypothesis "the space is a product" enters as `hmix`, which the row names as outside.

Docstring and row claims the types do not carry:

1. [L48Decomp.lean:21-22](../lean/HamiltonsCubic/Results/L48Decomp.lean#L21): `Wfac` "is `Σ_a ‖W_a‖²` by L48Const.lean's `L48_weyl_zero_iff` reading at each factor". True, untyped, and the lemma that carries the norm identity is `einstein_weylPart` with `weylPart_unique`, plus the invariance of `Λ²(A)` from `hmix`, `hsa` and `hb` (§1). The row repeats the reading in "`Wfac_eq_zero_iff`, `Σ_a‖W_a‖² = 0`". Should be reworded to say `Wfac` is `Σ_a ‖W_a‖²` by the §1 argument and that no proved step uses the identification.
2. [lean/INDEX.md:288](../lean/INDEX.md#L288) ends "... rather than L48's **statement: typed**". The trailing "statement: typed" contradicts the row's **proved** status and reads as a leftover from the previous status.
3. [lean/INDEX.md:287](../lean/INDEX.md#L287), the SymmetricTheorem row, lists "L48's Jensen step" under **Not claimed**. Accurate for that file, which does not import L48Jensen, but now reads as if the step were absent from the layer. A pointer to L48Jensen would fix it.
4. The row's "the record's clause that the forward direction needs `λ > 0` is stronger than the argument uses" is r1712's finding and stands.

C14 CONFIRMED on the status, with items 1 and 2 to repair.

## Overall verdict

**CONFIRMED on every declaration in L48Decomp.lean, L48Jensen.lean and L56Spec.lean.** The L48 row's **proved** is warranted, and the r1712 owed list (Jensen, `k`-monotonicity, assembly, decomposition) is now discharged. `hmix` is the record's block-diagonal input and is equivalent to it given Bianchi and self-adjointness. L56Spec closes r1711 Q2. **PLAUSIBLE, true but untyped:** `Wfac = Σ_a ‖W_a‖²`, a label no proof consumes, whose docstring cites the wrong lemma. **Repairs owed, wording only:** the L48Decomp header citation, the stray "statement: typed" in INDEX line 288, and optionally the SymmetricTheorem row's "Not claimed: L48's Jensen step".
