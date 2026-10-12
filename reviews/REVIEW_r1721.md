# REVIEW r1721: L52StairAll, the staircase sentence at every n

**Standfirst.** Cold Gate 2 statement-fidelity review of [L52StairAll.lean](../lean/HamiltonsCubic/Results/L52StairAll.lean) (commit bf454225) against the L52 row of [lean/INDEX.md](../lean/INDEX.md) and [findings/bispectral.md](../findings/bispectral.md) line 503. Analysis only: Lean source and definitions read, no `lake build`. Screens only, all by hand: the triangular induction at n = 4 on `Wst` and on the record's line-503 tensor, and one analytic counterexample screen for the INDEX wording. Heartbeats in [agent_logs/review-r1721.log](../agent_logs/review-r1721.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | `stair k` is the record's staircase ψ_k (Helmert frame) up to normalisation, and the eigen-condition for k ≥ 1 is "the staircase diagonalises K on 𝟏⊥" | CONFIRMED |
| C2 | Symmetric, hollow, zero row sums is the record's Ricci-flat K = (W_abab) | CONFIRMED |
| C3 | `stair_forces_zero`: under C1 and C2, K = 0 | CONFIRMED |
| C4 | `no_unit_stair`: no unit-norm `diagOp w` with Ricci-flat weight has the staircase among w's eigenvectors | CONFIRMED |
| C5 | The INDEX sentence as quoted: "at a Ricci-flat W a staircase diagonalising K forces K = 0, against Σμ² = 1" | REFUTED AS STATED (true for coordinate-diagonal W, which is what the Lean proves) |
| C6 | `Fin (n + 1)` covers every dimension the record means | CONFIRMED |
| C7 | Docstrings carry only what the types carry | PLAUSIBLE (one identification, K = w, is stated in prose and proved in this file only through the hypothesis on w) |

**One line.** The Lean is correct and faithful to the true reading of the sentence (coordinate-diagonal W, K = w). The INDEX's pre-change wording "at a Ricci-flat W" is false for a general Weyl W, since a unit Weyl tensor can have K(F) = 0 in a frame. The contradiction with Σμ² = 1 needs coordinate-diagonality, which `no_unit_stair` correctly assumes.

## Conventions

- Lean indexes coordinates 0..n in `Fin (n + 1)`, so the record's dimension is n + 1. The record indexes 1..n in its line-503 example and I translate to 0-based where needed.
- `stair k i = 1` for i < k, `−k` at i = k, `0` beyond. `stair 0` is the zero vector and is excluded by the hypothesis `0 < k`.
- K_ab = W_abab = R4 R a b a b (`Kmat` in [L54Basis.lean](../lean/HamiltonsCubic/Results/L54Basis.lean)). ψ_k in L54 is diag(v_k) for v_k in 𝟏⊥, so "the staircase ψ_k" means diag of the staircase vectors, and the eigen-condition is on the vectors.

## Hypothesis inventory

- `stair_forces_zero`: K real matrix on `Fin (n + 1)`, `hsym`, `hhol`, `hrow` (the three fields of `IsWeight` in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)), `hst`: for every k with 0 < k there is λ with K *ᵥ stair k = λ • stair k. No condition that the λ are distinct, no normalisation.
- `no_unit_stair`: w with `IsWeight w`, the same `hst` on w. Conclusion `normSq (diagOp w) ≠ 1`, with `normSq R = innerOp R R` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)).
- No Bianchi, no unit-norm or Weyl hypothesis enters `stair_forces_zero`, so it applies to K(F) of any Ricci-flat curvature operator in any frame.

## 1. The staircase and the eigen-condition (C1)

- `stair 1 = (1,−1,0,…)`, `stair 2 = (1,1,−2,0,…)`, `stair 3 = (1,1,1,−3,0,…)`. At n = 4 these are the Helmert vectors `whst` of [L52Staircase.lean](../lean/HamiltonsCubic/Results/L52Staircase.lean) (`(1,−1,0,0)/√2, (1,1,−2,0)/√6, (1,1,1,−3)/√12`) without their normalisation, and the INDEX row calls `whst` the record's staircase. The eigen-condition is scale invariant, so the normalisation is immaterial.
- The ψ_k for k = 1..n are n mutually orthogonal vectors in 𝟏⊥ of the (n+1)-space, so they are a basis of 𝟏⊥. Since K is symmetric with K𝟏 = 0 (`hrow`), K preserves 𝟏⊥, and "the staircase diagonalises K on 𝟏⊥" is exactly "each ψ_k, k ≥ 1, is an eigenvector of K". The compression P K P equals K on 𝟏⊥ under `hrow`, so the two readings agree.
- Orientation: I could not consult Nienhaus–Petersen–Wink's paper for their exact index order. A reversed or permuted staircase is covered by applying the theorem to the correspondingly permuted K, since all three hypotheses are permutation invariant. This is an observation about the mathematics and is not a Lean declaration.
- Falsifier looked for: a staircase vector in the record other than the Helmert one. The record's own n = 4 reading is `whst`, which matches.

## 2. The hypotheses on K (C2)

- K_ab = W_abab is symmetric by pair symmetry, hollow by antisymmetry, and Σ_b K_ab = Ric_aa, which vanishes at a Ricci-flat W. So every Ricci-flat curvature operator's K(F) satisfies `hsym`, `hhol`, `hrow`, and the theorem's K is the record's K.
- At a coordinate-diagonal W = `diagOp w`, K = w. This is `Kmat_Rst` at n = 4 in L52Staircase. At general n there is no `Kmat (diagOp w) = w` lemma in the tree (grep for `Kmat (diagOp` and `Kmat_diagOp`: no hits). `no_unit_stair` puts `hst` on w directly, which is the record's K only through that identification. The identification is a one-line computation (R4 (diagOp w) a b a b = w_ab for a ≠ b, 0 at a = b by hollowness), so this is a presentational gap and the content stands.
- The record's K is the frame matrix, which is what the file takes. The S²₀ block of W̊ enters only through L54's d_ψ = −spec(K|𝟏⊥), so the theorem is about the right object.

## 3. The conclusion (C3, C4) and the triangular induction

- Read the induction from the source. `below_step`: at i > k the i-th entry of K ψ_k is Σ_{j<k} K_ij − k K_ik and that of λψ_k is 0, whatever λ. `row_const`: by strong induction on k, K_ik = K_i0 for 0 < k < i. `col0_zero`: with a_t = K_t0, row t sums to t·a_t + Σ_{j>t} a_j = 0, and downward induction from t = n (n·a_n = 0) kills every a_t, t ≥ 1. `stair_forces_zero` then gives every off-diagonal entry as some a_t, t ≥ 1, and the diagonal by `hhol`. Each step is correct.
- Only ψ_1..ψ_{n−1} and only the rows below each step are used. The statement's hypothesis is stronger than needed, which is harmless.
- `no_unit_stair`: w = 0 gives `diagOp 0 = 0` and `normSq = 0 ≠ 1`. With Σμ² = normSq (`sum_mu_sq` in SpectralTrace, per the INDEX row), `normSq (diagOp w) ≠ 1` is a faithful rendering of "against Σμ² = 1".

## 4. Screen at n = 4 (Fin 4) by hand

- `Wst` (2 on {01, 23}, −1 on {02, 13}, {03, 12}), rows sum to 0. K ψ_1 = (−2, 2, 0, 0) = −2ψ_1: **ψ_1 is an eigenvector.** K ψ_2 = (4, 4, −2, −6), not a multiple of (1, 1, −2, 0): **ψ_2 fails**, and `below_step` at i = 3, k = 2 fails as Σ_{j<2} K_3j = −2 against 2·K_32 = 4. K ψ_3 = (4, 4, −8, 0), not a multiple of (1, 1, 1, −3): **ψ_3 fails.** This agrees with `whst_cross` (h₂ᵀ K h₃ ≠ 0) and with the theorem, since Wst ≠ 0.
- The record's line-503 tensor, 0-based K_01 = K_23 = ½, K_02 = K_13 = −½, K_03 = K_12 = 0. K ψ_1 = (−½, ½, −½, ½), not a multiple of ψ_1: **ψ_1 already fails.** The normalised staircase diagonal is ψᵀKψ = −½, ½, 0, so Σd_ψ² = ½ and Σd² = t_F/2 + ½ = 3/2, which reproduces the record's 3/2 against 3.

## 5. The dimension range (C6)

`Fin (n + 1)` for n : ℕ covers every dimension N ≥ 1. The record's L54 needs N ≥ 4, which is inside that range. At N = 1 and N = 2 the statement is trivially true (hollow with zero row sums already forces K = 0 at N ≤ 2), and it is correct there as well.

## 6. The INDEX sentence at a general Ricci-flat W (C5)

- Falsifier: a unit-norm Weyl W that is not coordinate-diagonal, with K(F) = 0 in some frame F. Then every vector, the staircase included, is an eigenvector of K, and "forces K = 0, against Σμ² = 1" yields no contradiction.
- Analytic screen at N = 4. Write W = A ⊕ B on Λ⁺ ⊕ Λ⁻ with A and B traceless symmetric (a Weyl tensor, whose Λ⁺–Λ⁻ block is traceless Ricci and so zero). With ω_i^± = (e_{0i} ± e_{jk})/√2, K_{0i} = K_{jk} = (A_ii + B_ii)/2. Take A = diag(1, −1, 0) and B = −A, scaled to unit norm. Then K(F) = 0 and W ≠ 0.
- So the sentence as the INDEX quoted it ("at a Ricci-flat W") is false. It is true at a coordinate-diagonal W, which the record's line-503 context is ("the n = 4 coordinate-diagonal tensor") and which `no_unit_stair` assumes through `diagOp w`. The new INDEX text states the coordinate-diagonal form ("no unit-norm `diagOp w` with Ricci-flat weight"), so the proved statement is the correct one. The first half, "forces K = 0", holds at every Ricci-flat W by C2 and C3.
- Recommended repair: where the INDEX or the record still quotes "at a Ricci-flat W … against Σμ² = 1", insert "coordinate-diagonal".

## 7. Docstrings (C7)

- The header says the file proves the sentence "at every n, for K symmetric, hollow and with zero row sums (the weights of a Ricci-flat coordinate-diagonal W)". This is accurate.
- `no_unit_stair`'s docstring says "has its staircase diagonalising K". The hypothesis is on w, and K = w at `diagOp w` is not a declaration at general n (Section 2). This is PLAUSIBLE, true by a one-line computation, and should either be proved (`Kmat_diagOp`) or reworded to "diagonalising w".
- `entry_eq`'s docstring says "The off-diagonal entries are a_{max(i,j)}". The declaration proves only the j < i case, K_ij = K_i0. The symmetric case is used inline in `col0_zero`. Minor.
- "the unnormalised staircase vector" is accurate. "every staircase vector" in the header's `no_unit_stair` bullet excludes ψ_0 (`stair 0 = 0`, record's 𝟏), which is correct on 𝟏⊥.

## Overall verdict

**CONFIRMED WITH GAP.** The seven declarations state and prove the record's staircase claim correctly at every dimension, for K = (W_abab) of any Ricci-flat W (K = 0) and for coordinate-diagonal unit-norm W (contradiction). Gaps: (G1) the pre-change INDEX sentence "at a Ricci-flat W … against Σμ² = 1" is REFUTED AS STATED at a general Weyl W (explicit N = 4 witness, Section 6) and needs "coordinate-diagonal"; (G2) K = w at `diagOp w` is owed as a lemma at general n or the `no_unit_stair` docstring should say w; (G3) `entry_eq`'s docstring overstates its j < i content.
