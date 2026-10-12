import HamiltonsCubic.Base.WeylIneq
import HamiltonsCubic.Base.BlockValue
import HamiltonsCubic.Base.AltPart

set_option linter.style.longLine false

/-!
# The compression inequality for the negative part

For a symmetric `Y` and an orthogonal projection `Π` on a finite-dimensional real inner product space,
**`trace_negPart_compress`**: `tr((ΠYΠ)₋) ≤ tr(Π Y₋ Π)`. This is [L17](../../../findings/route-a.md)'s compression step
`tr(Π_ASD (P₀HP₀)₋) ≥ tr(B₋)`, the hypothesis `hcompress` of [L17Statement.lean](../Results/L17Statement.lean).

The proof reads both traces in the eigenbasis `fᵢ` of `Z = ΠYΠ`. At `ζᵢ ≥ 0` the left term is `0` and the right one is
`⟪Π fᵢ, Y₋ Π fᵢ⟫ ≥ 0`. At `ζᵢ < 0` the eigenvector lies in the range of `Π`, so the left term is
`−ζᵢ = −⟪fᵢ, Y fᵢ⟫ ≤ ⟪fᵢ, Y₋ fᵢ⟫`, because `Y + Y₋ = Y₊` is positive.
-/

namespace HamiltonsCubic.SpectralFn

open Module HamiltonsCubic.AltLayer

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  {n : ℕ} (hn : finrank ℝ E = n)

/-- **`⟪w, g(Y) w⟫ = ∑ g(λᵢ) ⟪eᵢ, w⟫²`.** -/
theorem inner_specFn_self (g : ℝ → ℝ) {Y : E →ₗ[ℝ] E} (hY : Y.IsSymmetric) (w : E) :
    inner ℝ w (specFn hn g hY w) = ∑ i, g (hY.eigenvalues hn i) * inner ℝ (hY.eigenvectorBasis hn i) w ^ 2 := by
  rw [real_inner_comm, inner_specFn_left]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **A spectral function of a nonnegative `g` is positive.** -/
theorem inner_specFn_nonneg (g : ℝ → ℝ) (hg : ∀ x, 0 ≤ g x) {Y : E →ₗ[ℝ] E} (hY : Y.IsSymmetric) (w : E) :
    0 ≤ inner ℝ w (specFn hn g hY w) := by
  rw [inner_specFn_self]
  exact Finset.sum_nonneg fun i _ => mul_nonneg (hg _) (sq_nonneg _)

/-- **`⟪w, Y w⟫ + ⟪w, Y₋ w⟫ ≥ 0`**, since `Y + Y₋ = Y₊`. -/
theorem inner_add_negPart_nonneg {Y : E →ₗ[ℝ] E} (hY : Y.IsSymmetric) (w : E) :
    0 ≤ inner ℝ (Y w) w + inner ℝ w (specFn hn negPartScalar hY w) := by
  rw [WeylIneq.inner_apply_eq_sum hn hY, inner_specFn_self, ← Finset.sum_add_distrib]
  refine Finset.sum_nonneg fun i _ => ?_
  rw [← add_mul]
  refine mul_nonneg ?_ (sq_nonneg _)
  unfold negPartScalar
  have := neg_abs_le (hY.eigenvalues hn i)
  linarith

/-- **The compression inequality**: `tr((ΠYΠ)₋) ≤ tr(Π Y₋ Π)` for symmetric `Y` and an orthogonal projection `Π`. -/
theorem trace_negPart_compress {Y P : E →ₗ[ℝ] E} (hY : Y.IsSymmetric) (hP : P.IsSymmetric) (hPP : P ∘ₗ P = P)
    (hZ : (P ∘ₗ Y ∘ₗ P).IsSymmetric) :
    LinearMap.trace ℝ E (specFn hn negPartScalar hZ) ≤
      LinearMap.trace ℝ E (P ∘ₗ specFn hn negPartScalar hY ∘ₗ P) := by
  set f := hZ.eigenvectorBasis hn
  rw [LinearMap.trace_eq_sum_inner _ f, LinearMap.trace_eq_sum_inner _ f]
  refine Finset.sum_le_sum fun i _ => ?_
  have hfi : (P ∘ₗ Y ∘ₗ P) (f i) = hZ.eigenvalues hn i • f i := apply_eigvec hn hZ i
  rw [specFn_apply_of_eigen hn negPartScalar hZ hfi, real_inner_smul_right, real_inner_self_eq_norm_sq,
    f.orthonormal.1 i, one_pow, mul_one]
  have hright : inner ℝ (f i) ((P ∘ₗ specFn hn negPartScalar hY ∘ₗ P) (f i)) =
      inner ℝ (P (f i)) (specFn hn negPartScalar hY (P (f i))) := by
    simp only [LinearMap.comp_apply]
    rw [← hP]
  rw [hright]
  by_cases hζ : 0 ≤ hZ.eigenvalues hn i
  · rw [negPartScalar_of_nonneg hζ]
    exact inner_specFn_nonneg hn negPartScalar negPartScalar_nonneg hY _
  · push Not at hζ
    -- the eigenvector lies in the range of `P`
    have hPf : P (f i) = f i := by
      have h1 : P ((P ∘ₗ Y ∘ₗ P) (f i)) = (P ∘ₗ Y ∘ₗ P) (f i) := by
        simp only [LinearMap.comp_apply]
        exact LinearMap.congr_fun hPP _
      rw [hfi, map_smul] at h1
      exact smul_right_injective E hζ.ne h1
    rw [hPf, negPartScalar_of_nonpos hζ.le]
    have hq : inner ℝ (f i) ((P ∘ₗ Y ∘ₗ P) (f i)) = hZ.eigenvalues hn i := by
      rw [hfi, real_inner_smul_right, real_inner_self_eq_norm_sq, f.orthonormal.1 i, one_pow, mul_one]
    have hq' : inner ℝ (f i) ((P ∘ₗ Y ∘ₗ P) (f i)) = inner ℝ (Y (f i)) (f i) := by
      simp only [LinearMap.comp_apply]
      rw [← hP]
      simp only [hPf]
      exact real_inner_comm _ _
    have := inner_add_negPart_nonneg hn hY (f i)
    linarith

end HamiltonsCubic.SpectralFn
