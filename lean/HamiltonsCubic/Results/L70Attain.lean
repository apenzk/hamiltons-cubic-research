import HamiltonsCubic.Results.L73b

set_option linter.style.longLine false

/-!
# L70's dimension bounds are attained at `W_{ℂP²}`, `n = 4`

[findings/bounds.md](../../../findings/bounds.md), Lemma L70: saturation forces `dim E_min ≥ n/2` and
`dim E_max ≥ (n − 2)/2`, *"and both are attained exactly at `W_{ℂP²}` at `n = 4`, where they read `2` and `1`"*.
**This file proves the attainment** on [CP2.lean](../Base/CP2.lean)'s `WCP2`, `W_{ℂP²}` in the pair basis of
`Λ²ℝ⁴` (unnormalised, eigenspaces being scale-invariant):

- `WCP2_spectrum`: every eigenvalue is `2`, `−1` or `0`, each coordinate carrying `μ(μ + 1)(μ − 2) = 0`;
- `eigen_minus_span`: `E_{−1} = span{v₁, v₂}`, the two eigenvectors of [L73b.lean](L73b.lean), so `dim E_min = 2`;
- `WCP2_eigen_plus`, `eigen_plus_span`: `E_2` is the line through `e₀₁ + e₂₃`, so `dim E_max = 1`;
- **`L70_attained`**: at `n = 4`, `dim E_min = 2 = n/2` and `dim E_max = 1 = (n − 2)/2`.
-/

namespace HamiltonsCubic.Base

open Matrix

/-- The `2`-eigenvector `e₀₁ + e₂₃`. -/
def vPlus : Fin 6 → ℚ := ![1, 0, 0, 0, 0, 1]

theorem WCP2_eqs (x : Fin 6 → ℚ) :
    (WCP2 *ᵥ x) 0 = x 0 + x 5 ∧ (WCP2 *ᵥ x) 1 = -(1/2) * x 1 + (1/2) * x 4 ∧
    (WCP2 *ᵥ x) 2 = -(1/2) * x 2 - (1/2) * x 3 ∧ (WCP2 *ᵥ x) 3 = -(1/2) * x 2 - (1/2) * x 3 ∧
    (WCP2 *ᵥ x) 4 = (1/2) * x 1 - (1/2) * x 4 ∧ (WCP2 *ᵥ x) 5 = x 0 + x 5 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    simp [WCP2, Matrix.mulVec, dotProduct, Fin.sum_univ_six] <;> ring

theorem WCP2_eigen_plus : WCP2 *ᵥ vPlus = (2 : ℚ) • vPlus := by
  funext i
  obtain ⟨h0, h1, h2, h3, h4, h5⟩ := WCP2_eqs vPlus
  fin_cases i <;> simp_all [vPlus] <;> norm_num

/-- **Every `−1`-eigenvector lies in `span{v₁, v₂}`**, so `E_min` has dimension exactly `2`. -/
theorem eigen_minus_span (x : Fin 6 → ℚ) (hx : WCP2 *ᵥ x = -x) :
    x = x 1 • vMinus₁ + x 2 • vMinus₂ := by
  obtain ⟨h0, h1, h2, h3, h4, h5⟩ := WCP2_eqs x
  have e : ∀ i, (WCP2 *ᵥ x) i = -x i := fun i => congrFun hx i
  rw [e 0] at h0; rw [e 1] at h1; rw [e 2] at h2; rw [e 3] at h3; rw [e 4] at h4; rw [e 5] at h5
  funext i
  fin_cases i <;> simp [vMinus₁, vMinus₂] <;> linarith

/-- **Every `2`-eigenvector lies on the line through `vPlus`**, so `E_max` has dimension exactly `1`. -/
theorem eigen_plus_span (x : Fin 6 → ℚ) (hx : WCP2 *ᵥ x = (2 : ℚ) • x) : x = x 0 • vPlus := by
  obtain ⟨h0, h1, h2, h3, h4, h5⟩ := WCP2_eqs x
  have e : ∀ i, (WCP2 *ᵥ x) i = 2 * x i := fun i => by rw [hx]; simp
  rw [e 0] at h0; rw [e 1] at h1; rw [e 2] at h2; rw [e 3] at h3; rw [e 4] at h4; rw [e 5] at h5
  funext i
  fin_cases i <;> simp [vPlus] <;> linarith

/-- **The spectrum is `{2, −1, 0}`**: every eigenvalue satisfies `μ(μ + 1)(μ − 2) = 0`. -/
theorem WCP2_spectrum (μ : ℚ) (x : Fin 6 → ℚ) (hx0 : x ≠ 0) (hx : WCP2 *ᵥ x = μ • x) :
    μ = 2 ∨ μ = -1 ∨ μ = 0 := by
  obtain ⟨h0, h1, h2, h3, h4, h5⟩ := WCP2_eqs x
  have e : ∀ i, (WCP2 *ᵥ x) i = μ * x i := fun i => by rw [hx]; simp
  rw [e 0] at h0; rw [e 1] at h1; rw [e 2] at h2; rw [e 3] at h3; rw [e 4] at h4; rw [e 5] at h5
  have key : ∀ i, μ * (μ + 1) * (μ - 2) * x i = 0 := by
    intro i
    fin_cases i
    · show μ * (μ + 1) * (μ - 2) * x 0 = 0
      linear_combination (μ + 1) * (μ - 1) * h0 + (μ + 1) * h5
    · show μ * (μ + 1) * (μ - 2) * x 1 = 0
      linear_combination (μ - 2) * (2 * μ + 1) / 2 * h1 + (μ - 2) / 2 * h4
    · show μ * (μ + 1) * (μ - 2) * x 2 = 0
      linear_combination (μ - 2) * (2 * μ + 1) / 2 * h2 - (μ - 2) / 2 * h3
    · show μ * (μ + 1) * (μ - 2) * x 3 = 0
      linear_combination -((μ - 2) / 2) * h2 + (μ - 2) * (2 * μ + 1) / 2 * h3
    · show μ * (μ + 1) * (μ - 2) * x 4 = 0
      linear_combination (μ - 2) / 2 * h1 + (μ - 2) * (2 * μ + 1) / 2 * h4
    · show μ * (μ + 1) * (μ - 2) * x 5 = 0
      linear_combination (μ + 1) * h0 + (μ + 1) * (μ - 1) * h5
  obtain ⟨i, hi⟩ : ∃ i, x i ≠ 0 := by
    by_contra h; push Not at h; exact hx0 (funext h)
  have := key i
  rcases mul_eq_zero.mp this with h | h
  · rcases mul_eq_zero.mp h with h' | h'
    · rcases mul_eq_zero.mp h' with h'' | h''
      · right; right; exact h''
      · right; left; linarith
    · left; linarith
  · exact absurd h hi

/-- **L70's bounds are equalities at `W_{ℂP²}`, `n = 4`**: the extreme eigenvalues are `−1` and `2`, `E_{−1}` is
spanned by two independent eigenvectors and `E_2` by one, and `2 = 4/2`, `1 = (4 − 2)/2`. -/
theorem L70_attained :
    (∀ (μ : ℚ) (x : Fin 6 → ℚ), x ≠ 0 → WCP2 *ᵥ x = μ • x → -1 ≤ μ ∧ μ ≤ 2) ∧
    (WCP2 *ᵥ vMinus₁ = -vMinus₁ ∧ WCP2 *ᵥ vMinus₂ = -vMinus₂ ∧
      (∀ a b : ℚ, (∀ i, a * vMinus₁ i + b * vMinus₂ i = 0) → a = 0 ∧ b = 0) ∧
      ∀ x, WCP2 *ᵥ x = -x → x = x 1 • vMinus₁ + x 2 • vMinus₂) ∧
    (WCP2 *ᵥ vPlus = (2 : ℚ) • vPlus ∧ ∀ x, WCP2 *ᵥ x = (2 : ℚ) • x → x = x 0 • vPlus) ∧
    ((2 : ℚ) = 4 / 2 ∧ (1 : ℚ) = (4 - 2) / 2) := by
  refine ⟨fun μ x hx0 hx => ?_, ⟨WCP2_eigen_minus₁, WCP2_eigen_minus₂, vMinus_independent, eigen_minus_span⟩,
    ⟨WCP2_eigen_plus, eigen_plus_span⟩, by norm_num, by norm_num⟩
  rcases WCP2_spectrum μ x hx0 hx with h | h | h <;> subst h <;> norm_num

end HamiltonsCubic.Base
