import HamiltonsCubic.Base.SelfDual

set_option linter.style.longLine false

/-!
# The six-index Levi-Civita symbol is the permutation sign, and its contraction is `det`

**`levi6` is a product of pairwise `sgnR` factors, so at a permutation it is that permutation's
sign and at a repeated index it is zero.** *A full contraction against it therefore sums over
permutations only, which is `Matrix.det_apply'` with the rows selected by the free indices.*

`levi6_contract` is the result: `∑ ε_{abcdef} A_{w₀a} ⋯ A_{w₅f} = ε_{w₀⋯w₅} · det A`. The
injective case is `Matrix.det_permute`, the other is `Matrix.det_zero_of_row_eq`.
-/

namespace HamiltonsCubic.SelfDualLayer

open Equiv

/-- Off the diagonal `sgnR` is the `±1` that `Equiv.Perm.sign_eq_prod_prod_Ioi` multiplies. -/
theorem sgnR_of_ne {x y : Fin 6} (h : x ≠ y) :
    sgnR x y = (((if x < y then 1 else -1 : ℤˣ) : ℤ) : ℝ) := by
  unfold sgnR
  rcases lt_trichotomy x y with hxy | hxy | hxy
  · simp [hxy]
  · exact absurd hxy h
  · simp [hxy, not_lt.2 hxy.le]

/-- **`levi6` AT A PERMUTATION IS ITS SIGN**, read off `Equiv.Perm.sign_eq_prod_prod_Ioi`, which writes the sign as the same product over pairs. -/
theorem levi6_perm (σ : Perm (Fin 6)) :
    levi6 (σ 0) (σ 1) (σ 2) (σ 3) (σ 4) (σ 5) = ((Perm.sign σ : ℤ) : ℝ) := by
  have hne : ∀ i j : Fin 6, i ≠ j → σ i ≠ σ j := fun i j h => σ.injective.ne h
  rw [Perm.sign_eq_prod_prod_Ioi]
  have h0 : Finset.Ioi (0 : Fin 6) = {1, 2, 3, 4, 5} := by decide
  have h1 : Finset.Ioi (1 : Fin 6) = {2, 3, 4, 5} := by decide
  have h2 : Finset.Ioi (2 : Fin 6) = {3, 4, 5} := by decide
  have h3 : Finset.Ioi (3 : Fin 6) = {4, 5} := by decide
  have h4 : Finset.Ioi (4 : Fin 6) = {5} := by decide
  have h5 : Finset.Ioi (5 : Fin 6) = ∅ := by decide
  simp only [Fin.prod_univ_six, h0, h1, h2, h3, h4, h5]
  rw [Finset.prod_insert (by decide), Finset.prod_insert (by decide), Finset.prod_insert (by decide),
    Finset.prod_insert (by decide), Finset.prod_singleton, Finset.prod_insert (by decide),
    Finset.prod_insert (by decide), Finset.prod_insert (by decide), Finset.prod_singleton,
    Finset.prod_insert (by decide), Finset.prod_insert (by decide), Finset.prod_singleton,
    Finset.prod_insert (by decide), Finset.prod_singleton, Finset.prod_singleton, Finset.prod_empty]
  unfold levi6
  rw [sgnR_of_ne (hne 0 1 (by decide)), sgnR_of_ne (hne 0 2 (by decide)), sgnR_of_ne (hne 0 3 (by decide)),
    sgnR_of_ne (hne 0 4 (by decide)), sgnR_of_ne (hne 0 5 (by decide)), sgnR_of_ne (hne 1 2 (by decide)),
    sgnR_of_ne (hne 1 3 (by decide)), sgnR_of_ne (hne 1 4 (by decide)), sgnR_of_ne (hne 1 5 (by decide)),
    sgnR_of_ne (hne 2 3 (by decide)), sgnR_of_ne (hne 2 4 (by decide)), sgnR_of_ne (hne 2 5 (by decide)),
    sgnR_of_ne (hne 3 4 (by decide)), sgnR_of_ne (hne 3 5 (by decide)), sgnR_of_ne (hne 4 5 (by decide))]
  push_cast
  ring

/-- `sgnR` vanishes on the diagonal. -/
theorem sgnR_self (x : Fin 6) : sgnR x x = 0 := by simp [sgnR]

/-- **`levi6` VANISHES ON A REPEATED INDEX**, since the product then carries `sgnR x x = 0`. -/
theorem levi6_eq_zero_of_not_injective (v : Fin 6 → Fin 6) (h : ¬ Function.Injective v) :
    levi6 (v 0) (v 1) (v 2) (v 3) (v 4) (v 5) = 0 := by
  obtain ⟨i, j, hv, hij⟩ : ∃ i j, v i = v j ∧ i ≠ j := by
    by_contra hc; push Not at hc; exact h fun i j e => hc i j e
  fin_cases i <;> fin_cases j <;> simp_all [levi6, sgnR_self]
/-- Splitting a sum over functions out of `Fin (n+1)` at the first coordinate. -/
theorem sum_fun_succ {n : ℕ} (g : (Fin (n+1) → Fin 6) → ℝ) :
    ∑ v, g v = ∑ a, ∑ t : Fin n → Fin 6, g (Fin.cons a t) := by
  rw [← (Fin.consEquiv fun _ => Fin 6).sum_comp, Fintype.sum_prod_type]
  rfl

/-- A sum over all maps `Fin 6 → Fin 6` is six nested sums over the tuple's entries. -/
theorem sum_fun_fin6 (g : (Fin 6 → Fin 6) → ℝ) :
    ∑ v, g v = ∑ a, ∑ b, ∑ c, ∑ d, ∑ e, ∑ f, g ![a, b, c, d, e, f] := by
  simp only [sum_fun_succ, Fintype.sum_unique]
  rfl

/-- The sum over all tuples collapses onto permutations, since the repeats contribute nothing. -/
theorem sum_levi6_prod_eq_sum_perm (F : (Fin 6 → Fin 6) → ℝ) :
    ∑ v : Fin 6 → Fin 6, levi6 (v 0) (v 1) (v 2) (v 3) (v 4) (v 5) * F v
      = ∑ σ : Perm (Fin 6), ((Perm.sign σ : ℤ) : ℝ) * F σ := by
  classical
  have hsub : (Finset.univ.map ⟨fun σ : Perm (Fin 6) => (⇑σ : Fin 6 → Fin 6), DFunLike.coe_injective⟩)
      ⊆ Finset.univ := Finset.subset_univ _
  rw [← Finset.sum_subset hsub, Finset.sum_map]
  · exact Finset.sum_congr rfl fun σ _ => by simp [levi6_perm]
  · intro v _ hv
    have hni : ¬ Function.Injective v := by
      intro hinj
      apply hv
      refine Finset.mem_map.2 ⟨Equiv.ofBijective v (Finite.injective_iff_bijective.mp hinj), Finset.mem_univ _, rfl⟩
    simp [levi6_eq_zero_of_not_injective v hni]

/-- **THE FULL `levi6` CONTRACTION IS A DETERMINANT**: `∑ ε_{abcdef} A_{w₀a} ⋯ A_{w₅f} = ε_{w₀⋯w₅} · det A`.

*This is the transformation law of the six-index Levi-Civita symbol, and the step
[Pfaffian6.lean](Pfaffian6.lean) names between `triple6` and `Matrix.det_mul`.* -/
theorem levi6_contract (A : Matrix (Fin 6) (Fin 6) ℝ) (w : Fin 6 → Fin 6) :
    ∑ a, ∑ b, ∑ c, ∑ d, ∑ e, ∑ f,
      levi6 a b c d e f * (A (w 0) a * A (w 1) b * A (w 2) c * A (w 3) d * A (w 4) e * A (w 5) f)
      = levi6 (w 0) (w 1) (w 2) (w 3) (w 4) (w 5) * A.det := by
  classical
  have h := sum_fun_fin6 fun v => levi6 (v 0) (v 1) (v 2) (v 3) (v 4) (v 5) *
    ∏ k, A (w k) (v k)
  simp only [Fin.prod_univ_six, Matrix.cons_val] at h
  rw [← h, sum_levi6_prod_eq_sum_perm]
  -- the permutation sum is det of the row-selected matrix, transposed
  have hdet : ∑ σ : Perm (Fin 6), ((Perm.sign σ : ℤ) : ℝ) * ∏ k, A (w k) (σ k)
      = (A.submatrix w id).det := by
    rw [← Matrix.det_transpose, Matrix.det_apply']
    rfl
  simp only [Fin.prod_univ_six] at hdet
  rw [hdet]
  by_cases hw : Function.Injective w
  · set τ := Equiv.ofBijective w (Finite.injective_iff_bijective.mp hw)
    have : A.submatrix w id = A.submatrix τ id := rfl
    rw [this, Matrix.det_permute]
    have := levi6_perm τ
    simp only [τ, Equiv.ofBijective_apply] at this
    rw [this]
  · obtain ⟨i, j, hv, hij⟩ : ∃ i j, w i = w j ∧ i ≠ j := by
      by_contra hc; push Not at hc; exact hw fun i j e => hc i j e
    rw [Matrix.det_zero_of_row_eq hij (by ext k; simp [hv]), levi6_eq_zero_of_not_injective w hw]
    ring

end HamiltonsCubic.SelfDualLayer
