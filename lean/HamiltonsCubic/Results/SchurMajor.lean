import HamiltonsCubic.Results.L54Statement
import Mathlib.Analysis.Matrix.Spectrum
import HamiltonsCubic.Results.DoublyStochastic

set_option linter.style.longLine false

/-!
# Schur's theorem: the diagonal of a real symmetric matrix is majorised by its spectrum

[L54Statement.lean](L54Statement.lean) carries *"Schur–Horn enters as a named hypothesis"*, citing
Schur (1923), and [L52](L52.lean) uses the same step. Mathlib names Schur–Horn in a docstring of
`Mathlib.Analysis.InnerProductSpace.Spectrum` and proves neither half. **This file proves Schur's
half against L54Statement's own `Majorizes`**:

- `exists_top_set`: among the `k`-subsets a maximiser `T` of `∑_T μ` exists, and it dominates by
  exchange, `μ j ≤ μ i` for `i ∈ T`, `j ∉ T`;
- `weights_le_top`: for weights `0 ≤ c ≤ 1` with `∑ c = k`, `∑ c_j μ_j ≤ ∑_T μ`, by
  `s (X − Y) = ∑_{i∈T} ∑_{j∉T} (1−c_i) c_j (μ_i − μ_j) ≥ 0`;
- `majorizes_of_doublyStochastic`: a doubly stochastic image `P μ` is majorised by `μ`;
- `diag_doublyStochastic`: the diagonal of a real symmetric `A` is `P λ` with `P_ij = U_ij²` doubly
  stochastic, through the spectral theorem `A = U diag(λ) Uᵀ`;
- `schur_majorizes`: **a real symmetric `A` has `Majorizes (eigenvalues A) (diag A)`**;
- `diag_convex_le_spectrum`: `∑ g(A_ii) ≤ ∑ g(λ_j)` for `g` convex on `ℝ`; L52's half-line form
  is [L52Bound.lean](L52Bound.lean)'s `sum_convexOn_diag`.
-/

namespace HamiltonsCubic.L54Statement

open Finset

variable {N : Type*} [Fintype N] [DecidableEq N]

/-- **A top `k`-set**: some `T` of size `k` maximises `∑_T μ`, and then no outside entry exceeds an
inside one. -/
theorem exists_top_set (μ : N → ℝ) (k : ℕ) (hk : k ≤ Fintype.card N) :
    ∃ T : Finset N, T.card = k ∧ ∀ i ∈ T, ∀ j ∉ T, μ j ≤ μ i := by
  have hne : (powersetCard k (univ : Finset N)).Nonempty :=
    powersetCard_nonempty.mpr (by rwa [card_univ])
  obtain ⟨T, hT, hmax⟩ := exists_max_image _ (fun T => ∑ i ∈ T, μ i) hne
  rw [mem_powersetCard] at hT
  refine ⟨T, hT.2, fun i hi j hj => ?_⟩
  by_contra hlt
  push Not at hlt
  set T' := insert j (T.erase i) with hT'
  have hcard : T'.card = k := by
    rw [hT', card_insert_of_notMem (fun h => hj (mem_of_mem_erase h)), card_erase_of_mem hi, hT.2]
    have : 0 < k := hT.2 ▸ card_pos.mpr ⟨i, hi⟩
    omega
  have hle := hmax T' (mem_powersetCard.mpr ⟨subset_univ _, hcard⟩)
  rw [hT', sum_insert (fun h => hj (mem_of_mem_erase h))] at hle
  have := add_sum_erase T μ hi
  linarith

/-- **Fractional weights never beat the top set**: `0 ≤ c ≤ 1`, `∑ c = |T|`, and `T` dominating
its complement give `∑ c_j μ_j ≤ ∑_T μ`. -/
theorem weights_le_top (μ c : N → ℝ) (hc0 : ∀ j, 0 ≤ c j) (hc1 : ∀ j, c j ≤ 1) (T : Finset N)
    (hsum : ∑ j, c j = T.card) (hT : ∀ i ∈ T, ∀ j ∉ T, μ j ≤ μ i) :
    ∑ j, c j * μ j ≤ ∑ i ∈ T, μ i := by
  set U := univ \ T with hU
  have hsplit : ∀ f : N → ℝ, ∑ j, f j = ∑ j ∈ T, f j + ∑ j ∈ U, f j := fun f => by
    rw [hU, ← sum_union disjoint_sdiff, union_sdiff_of_subset (subset_univ _)]
  -- `s = ∑_T (1 − c) = ∑_U c`
  have hs : ∑ i ∈ T, (1 - c i) = ∑ j ∈ U, c j := by
    have := hsplit c
    rw [sum_sub_distrib, sum_const, nsmul_eq_mul, mul_one]
    linarith
  set X := ∑ i ∈ T, (1 - c i) * μ i
  set Y := ∑ j ∈ U, c j * μ j
  have hdouble : 0 ≤ ∑ i ∈ T, ∑ j ∈ U, (1 - c i) * c j * (μ i - μ j) :=
    sum_nonneg fun i hi => sum_nonneg fun j hj =>
      mul_nonneg (mul_nonneg (by linarith [hc1 i]) (hc0 j))
        (by linarith [hT i hi j (by rw [hU] at hj; exact (mem_sdiff.mp hj).2)])
  have hexp : ∑ i ∈ T, ∑ j ∈ U, (1 - c i) * c j * (μ i - μ j)
      = X * (∑ j ∈ U, c j) - (∑ i ∈ T, (1 - c i)) * Y := by
    have e1 : ∑ i ∈ T, ∑ j ∈ U, (1 - c i) * c j * (μ i - μ j)
        = ∑ i ∈ T, ((1 - c i) * μ i) * (∑ j ∈ U, c j)
          - ∑ i ∈ T, (1 - c i) * (∑ j ∈ U, c j * μ j) := by
      rw [← sum_sub_distrib]
      refine sum_congr rfl fun i _ => ?_
      rw [mul_sum, mul_sum, ← sum_sub_distrib]
      exact sum_congr rfl fun j _ => by ring
    rw [e1, ← sum_mul, ← sum_mul]
  rw [hexp, hs] at hdouble
  -- `0 ≤ s·X − s·Y`
  have hgoal : ∑ i ∈ T, μ i - ∑ j, c j * μ j = X - Y := by
    rw [hsplit (fun j => c j * μ j)]
    simp only [X, Y, sub_mul, one_mul, sum_sub_distrib]
    ring
  by_cases hpos : 0 < ∑ j ∈ U, c j
  · have : 0 ≤ X - Y := by nlinarith
    linarith
  · -- `s = 0`: every weight is `1` on `T` and `0` off it
    have hs0 : ∑ j ∈ U, c j = 0 := le_antisymm (not_lt.mp hpos) (sum_nonneg fun j _ => hc0 j)
    have hU0 := (sum_eq_zero_iff_of_nonneg fun j _ => hc0 j).mp hs0
    have hT0 := (sum_eq_zero_iff_of_nonneg fun i _ => by linarith [hc1 i]).mp (hs ▸ hs0)
    have hX : X = 0 := sum_eq_zero fun i hi => by rw [hT0 i hi, zero_mul]
    have hY : Y = 0 := sum_eq_zero fun j hj => by rw [hU0 j hj, zero_mul]
    linarith

/-- **A doubly stochastic image is majorised**: `P ≥ 0` with unit row and column sums gives
`Majorizes μ (P μ)`. -/
theorem majorizes_of_doublyStochastic (P : N → N → ℝ) (hP0 : ∀ i j, 0 ≤ P i j)
    (hrow : ∀ i, ∑ j, P i j = 1) (hcol : ∀ j, ∑ i, P i j = 1) (μ : N → ℝ) :
    Majorizes μ (fun i => ∑ j, P i j * μ j) := by
  refine ⟨?_, fun S => ?_⟩
  · rw [sum_comm]
    exact sum_congr rfl fun j _ => by rw [← sum_mul, hcol j, one_mul]
  · have hk : S.card ≤ Fintype.card N := card_le_univ S
    obtain ⟨T, hTc, hT⟩ := exists_top_set μ S.card hk
    refine ⟨T, hTc, ?_⟩
    set c : N → ℝ := fun j => ∑ i ∈ S, P i j
    have hc0 : ∀ j, 0 ≤ c j := fun j => sum_nonneg fun i _ => hP0 i j
    have hc1 : ∀ j, c j ≤ 1 := fun j => by
      rw [← hcol j]
      exact sum_le_sum_of_subset_of_nonneg (subset_univ S) fun i _ _ => hP0 i j
    have hcs : ∑ j, c j = T.card := by
      simp only [c]
      rw [sum_comm, hTc]
      simp [hrow]
    have hlhs : ∑ i ∈ S, ∑ j, P i j * μ j = ∑ j, c j * μ j := by
      simp only [c, sum_mul]; exact sum_comm
    rw [hlhs]
    exact weights_le_top μ c hc0 hc1 T hcs hT

/-- **The diagonal is a doubly stochastic image of the spectrum**: for a real symmetric `A` there
is a doubly stochastic `P` (namely `P_ij = U_ij²` for the diagonalising orthogonal `U`) with
`A_ii = ∑_j P_ij λ_j`. This is the one import [DoublyStochastic.lean](DoublyStochastic.lean) and
[L52Statement.lean](L52Statement.lean) carried. -/
theorem diag_doublyStochastic (A : Matrix N N ℝ) (hA : A.IsHermitian) :
    ∃ P : N → N → ℝ, DoublyStochastic.IsDoublyStochastic P ∧
      ∀ i, A i i = ∑ j, P i j * hA.eigenvalues j := by
  set U := (hA.eigenvectorUnitary : Matrix N N ℝ) with hUdef
  have hU : U * star U = 1 := Matrix.mem_unitaryGroup_iff.mp hA.eigenvectorUnitary.2
  have hU' : star U * U = 1 := Matrix.mem_unitaryGroup_iff'.mp hA.eigenvectorUnitary.2
  have hent : ∀ i x, U i x = (hA.eigenvectorBasis x) i := fun i x => rfl
  refine ⟨fun i x => U i x ^ 2, ⟨fun _ _ => sq_nonneg _, fun i => ?_, fun x => ?_⟩, fun i => ?_⟩
  · have h := congrFun (congrFun hU i) i
    simp [Matrix.mul_apply, Matrix.star_apply] at h
    simpa [sq] using h
  · have h := congrFun (congrFun hU' x) x
    simp [Matrix.mul_apply, Matrix.star_apply] at h
    simpa [sq] using h
  · have h := congrFun (congrFun hA.spectral_theorem i) i
    rw [Unitary.conjStarAlgAut_apply] at h
    simp [Matrix.mul_apply, Matrix.diagonal] at h
    rw [h]
    exact Finset.sum_congr rfl fun x _ => by show _ = U i x ^ 2 * _; rw [hent]; ring

/-- **SCHUR'S THEOREM**: the diagonal of a real symmetric matrix is majorised by its spectrum. -/
theorem schur_majorizes (A : Matrix N N ℝ) (hA : A.IsHermitian) :
    Majorizes hA.eigenvalues (fun i => A i i) := by
  obtain ⟨P, hP, hdiag⟩ := diag_doublyStochastic A hA
  have e : (fun i => A i i) = fun i => ∑ j, P i j * hA.eigenvalues j := funext hdiag
  rw [e]
  exact majorizes_of_doublyStochastic P hP.nonneg hP.rows hP.cols _

/-- **The convex form on the whole line**: `∑ g(A_ii) ≤ ∑ g(λ_j)` for every `g` convex on `ℝ`, from
`diag_doublyStochastic` and [DoublyStochastic.lean](DoublyStochastic.lean)'s Jensen step. -/
theorem diag_convex_le_spectrum (A : Matrix N N ℝ) (hA : A.IsHermitian) {g : ℝ → ℝ}
    (hg : ConvexOn ℝ Set.univ g) : ∑ i, g (A i i) ≤ ∑ j, g (hA.eigenvalues j) := by
  obtain ⟨P, hP, hdiag⟩ := diag_doublyStochastic A hA
  have := DoublyStochastic.diagonal_le_spectrum hP hg hA.eigenvalues
  simpa [hdiag, smul_eq_mul] using this

end HamiltonsCubic.L54Statement
