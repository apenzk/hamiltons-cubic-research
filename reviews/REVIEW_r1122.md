# Review r1122: I73 seven-frame lemma, star side (Gate 2)

Log: agent_logs/r1122.log. Screen script (scratchpad, seconds of compute on constructed objects): r1122_screen.py.

**Verdict: the star side holds after one repair.** Step 6 substitutes `κ_j ≤ ‖K_j‖²` where step 3 only gives `κ_j ≤ ‖K_j‖²/(1-‖R_j‖²)`. With the Lean chain's linearised `φ`, the leak constants `(0.5, 2.3)` then fail at an explicit point. Raising `λ_M` to `2.4` restores the count with margin `0.013` in `x`. That repair needs a restated `lam_pos` in the variables `(‖K‖², ‖R‖)`.

| # | Item | Verdict |
|---|---|---|
| 1 | Overall logic and case split | CONFIRMED |
| 2 | Step 1 weighted Ky Fan budget | CONFIRMED |
| 3 | Step 1 split and gap minima | CONFIRMED |
| 4 | Step 3 Gram computation and normalisation of κ | REFUTED as written (Gram identity correct; the normalisation breaks step 6's substitution), repairable |
| 5 | Step 3 alignment and distance | CONFIRMED (with κ normalised) |
| 6 | Step 4 deficit of distance | CONFIRMED, with "proved" overstated for the plateau |
| 7 | Step 5 leak constants | CONFIRMED as statements in normalised κ |
| 8 | Step 6 count | PLAUSIBLE: arithmetic correct, inherits item 4, repair closes it |
| 9 | Scope and hidden assumptions | CONFIRMED |

## 1. Overall logic: CONFIRMED

- If `T > 54.064` then `Σδ_i < 1.936`, so the least deficit is `x < 1.936/7 = 0.276571`. Then `S6(X0) ≥ row0 > 7.72 > 7.6`, and the neighbourhood lemma makes the top three-slot set a `+` triangle or a `+` star.
- The enumeration is exhaustive on nonnegative angles once ties are broken towards `+` slots. A `−` slot or a kernel slot `a_k²` in the top set forces the dominating `(a_k+a_l)²` slots into it too, so every top set is a dominance-closed class and sign variants of the triangle and star (the two-minus triangle, a star with a minus slot) never occur as the top set.
- Ties at the 6/7 boundary are impossible in the star case: step 2 gives `g_K, g_M > 0` whenever `y ≤ 0.277`, and `y ≤ x` holds for any choice of top space. The same holds on the triangle side by L239's gap lemma.
- No kernel: the kernel slots are absent, `K` reduces to slots to further planes (or vanishes when `X0` has exactly four planes), and nothing else changes.

## 2. Step 1 budget: CONFIRMED

- `row0 = tr(AΠ) = Σ_c μ_c w_c` with `w_c = ⟨Πe_c,e_c⟩ ∈ [0,1]`, `Σw_c = 6`. On `E`, `Σ_{c∈E} μ_c(w_c−1) ≤ μ6 Σ_{c∈E}(w_c−1) = −μ6 Σ_{c∉E} w_c`. So `row0 ≤ (8−y) − Σ_{c∉E}(μ6−μ_c)w_c`, which is the budget. The `E` weights drop out exactly here.
- `K` and `R` are sums of slot spaces, so `Σ_{c∈K} w_c = Σ_j‖K_j‖²` and the same for `R`.
- The `±` slots from `π1` to a further plane have eigenvalues `(a±b)² ≤ (a+b)²`, and the kernel slots of `π1` have `a² ≤ (a+b)²`. So `μ6 − μ_c ≥ g_K` on all of `K`, correctly charged.

## 3. Step 1 split and gap minima: CONFIRMED

Every eigendirection outside `E` falls in exactly one class:

| Class | Eigenvalue | Assigned | Covered by |
|---|---|---|---|
| `so(π1)`, each leaf's and further plane's `so(2)`, kernel-kernel | `0` | R | trivial |
| `π1` to kernel | `a²` | K | `sgK` (`a² ≤ (a+b)²`) |
| `π1` to further plane, `±` | `(a±b)²` | K | `sgK` |
| `π1` to leaf, `−` | `(a−l)²` | R | `sgM_minus_same`, `sgM_minus_other` |
| leaf-leaf `±` | `(l±l')² ≤ (l+l')²` | R | `sgM_leaves_in`; `R_leaves_out` + `sgM_bulk` |
| leaf to further plane `±` | `≤ (l+b)²` | R | `R_leaf_b_in`, `R_leaf_b_out` + `sgM_bulk` |
| leaf to kernel | `l² ≤ (l+l')²` | R | as leaf-leaf |
| further-further, further-kernel | `≤ 2B` | R | `sgM_mass` |

- `μ6 = (a+l_min)²`, and every Lean statement is symmetric in its leaf labels, so `l1 = l_min` is a legal instance.
- `K`, the whole `π1 ⊗ (complement of π1 and leaves)` block, is a sum of eigenspaces, as step 1 needs.

## 4. Step 3 Gram and normalisation: REFUTED as written, repairable

- **Gram identity, correct.** An element of `p = π1⊗π1^⊥` is `p∧Mp + q∧Mq` for `M: π1 → π1^⊥`, and its two angles are the singular values of `M`. Each `+` slot to a leaf is a conformal (scaled reflection) `2×2` map, so `M_Y^T M_Y = ρ0² I`. `K`'s images lie orthogonal to the leaves, so `Gram = ρ0² I + N^T N` and `α²−β² = ν1−ν2 ≤ ‖K_j‖²` in absolute terms.
- **The defect.** The alignment bound and `ρ(κ)` are functions of the NORMALISED angles, `κ_j = (α²−β²)/(α²+β²)`. Since `R ⊥ Y+K`, `α²+β² = ‖Y_j+K_j‖² = 1−m_j²`, so `κ_j ≤ ‖K_j‖²/(1−m_j²)`. Step 3 states this correctly. Step 6 then bounds `Σ(½κ_j + 2.3m_j²)` by `max(0.5/g_K, 2.3/g_M)(g_KΣ‖K_j‖² + g_MΣm_j²)`, which needs `κ_j ≤ ‖K_j‖²`. That inequality is not available.
- **The loss is real on the Lean chain.** At `‖K‖² = 0.21`, `m = 0.371` (so `κ = 0.2435`, `ρ = 0.5096`, `e² = 0.01921`), the linearised damage `0.5359 − 5.86e² = 0.42334` exceeds `0.5‖K‖² + 2.3m² = 0.42157`. On a grid, `λ_K = 0.5` needs `λ_M ≈ 2.313` with the linearised `φ` (`phi_low`) and `2.2975` with the exact `φ`. So the stated constants survive only on the exact `φ`, by 0.1%, and fail on the chain the proof actually cites.
- **The crude repair fails.** `κ ≤ k/(1−m²) ≤ k + m²` (using `k ≤ 1−m²`) gives `λ_M = 2.8`, hence `D ≤ 6.32x`. The final inequality then needs `x < 0.2405`, below `0.27657`.
- **The repair that works.** Prove the damage bound directly in `(k, m)` = `(‖K‖², ‖R‖)` with `κ = k/(1−m²)`, for example `0.5359 − 5.86(ρ(k/(1−m²)) − m)² ≤ 0.5k + 2.4m²` on `k + m² ≤ 1`. The screen gives worst `2.313 < 2.4`. The count then reads `D ≤ (2.4·0.677/0.3)x = 5.416x`, and `3.21539 − 5.416x > 1.936 − x` holds for `x < 0.2897`, which covers `x < 0.27657` with margin `0.013`. The admissible window at `λ_K = 0.5` is `λ_M < 2.493`.

## 5. Alignment and distance: CONFIRMED, with κ normalised

- Von Neumann: for real skew `Z, W`, `⟨Z,W⟩ = ½tr(ZW^T) ≤ ½Σσ_i(Z)σ_i(W) = Σ` sorted angle products. For rank-four `Z` only `W`'s two largest angles enter, which gives the star branch `(√3/2)α + β/√12` and the triangle branch `(α+β)/√3`.
- Squaring the star branch with `α² = (1+κ)/2`, `β² = (1−κ)/2`, `αβ = c/2` gives `5/12 + κ/3 + c/4`, so `ρ² = 7/12 − κ/3 − c/4` matches. The difference from the triangle branch is `1/12 + κ/3 − c/12 ≥ 0` on `[0,1]` (`star_ge_tri`).
- `dist(Z,Ext)² ≥ min_r (r² + 1 − 2rc) = 1 − c²` for unit `Ext`, and the triangle inequality gives `dist(X_j) ≥ ρ(κ_j) − ‖R_j‖`. Both correct.

## 6. Deficit of distance: CONFIRMED, "proved" overstated

- When `X_j`'s top set is a triangle or a star, `W` is the pattern element on the same planes, `|X_j − W|² = 2 − 2p`, and the identity gives `δ_j ≥ 6(1−p²) ≥ 6d²(1−d²/4)`, since `d ≤ d_W` and `t(1−t/4)` increases on `[0,2]`. `p ≥ 0` because the angles are nonnegative.
- Otherwise `δ_j ≥ 8 − 2(2+√3) = 4 − 2√3`. This needs the EXACT ceilings of the seventeen classes. The Lean file types only `19/5`, which would give a plateau of `0.4` and break the count (`x < 0.111`).
- The screen confirms the ceilings: path_loop `2+√3`, path and pm_edge `2+√2`, path_loop_end `3.247`, the rest `≤ 3`, and the specialisation edge + double loop `2+√2`. They are integer-matrix eigenvalues and easy to type.
- Rounding: `6(4−2√3) = 3.215390 < 3.2154`. This is harmless.

## 7. Leak constants: CONFIRMED as statements

- `lam_pos` and `lam_neg` state the damage bound in normalised `κ` (the `κ² + c² = 1` hypothesis), which is correct as far as it goes.
- `phi_low` covers `e² ≤ 0.0914`. For the window `e² ∈ (0.0914, 0.091405)`, where `6e²(1−e²/4)` is still `3·10⁻⁵` below the plateau, the linear bound still dominates, since `(0.5359 − 5.86e²) − (plateau − 6e²(1−e²/4)) = 2·10⁻⁶ + e²(0.14 − 1.5e²) > 0`.
- The defect lies in how step 6 consumes them (item 4), not in the statements.

## 8. Count: PLAUSIBLE

- The arithmetic checks: `x < 1.936/7 = 0.276571`, `(x−y)/(0.3−y)` decreases in `y` for `x ≤ 0.3`, and `3.2154 − 5.19x > 1.936 − x` iff `x < 0.3053`.
- Two roundings go the wrong way, both harmless: `2.3·0.677 = 1.5571` (not `1.557`, giving `5.1903x`) and `3.2154` (see item 6).
- The line `D ≤ max(0.5/g_K, 2.3/g_M)(x−y)` is unjustified (item 4). With `λ_M = 2.4` the count closes at `x < 0.2897`.

## 9. Scope: CONFIRMED

- `n ≥ 8` is forced by four planes, and the kernel's presence or absence is covered (item 1).
- Repeated angles: `E` is defined as a top eigenspace and every tie between `E` and its complement is excluded by `g_K, g_M > 0`.
- A fifth plane with `b → l_min` forces `g_K → 0`, so `sgK` puts that `X0` at `y ≥ 0.3`, outside the case.
- Partner weights satisfy `w_c ≤ 1` because `Π` is a projector, so they cannot exceed step 1's allowance.
- One further hidden hypothesis is benign: `R ⊥ Y+K`, which holds because `R` is a sum of other slot spaces. Items 4 and 5 use it.
