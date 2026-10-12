import HamiltonsCubic.Results.L225Statement
import HamiltonsCubic.Results.SpectralTrace

set_option linter.style.longLine false

/-!
# L225 in matrix form: `tr(M⁰)³ ≤ (k − 2)/√(k(k − 1)) ‖M⁰‖³`

[L225Statement.lean](L225Statement.lean) proves the per-block cubic bound for a real vector on the unit
trace-free sphere. The matrix form is that bound read on the eigenvalues, through
[SpectralTrace.lean](SpectralTrace.lean)'s `trace_pow_eq_sum_eigenvalues`.

- **`matrix_cube_le`**: a real symmetric `k × k` matrix with `tr M = 0` and `tr M² = 1` has
  `tr M³ ≤ (k − 2)/c`, `c² = k(k − 1)`;
- **`matrix_cube_attained`**: the bound is sharp, attained on the eigenvalue pattern `(α, −β, …, −β)`;
- **`matrix_cube_eq`**: and only there, every eigenvalue being `α` or `−β` with exactly one `α`;
- **`matrix_cube_le_unnormalised`**: `tr M³ ≤ (k − 2)/c · (tr M²)^{3/2}` for every trace-free symmetric `M`.
-/

namespace HamiltonsCubic.L225Statement

open Finset Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Case–Tyrrell's bound in matrix form**: `tr M = 0`, `tr M² = 1` give `tr M³ ≤ (k − 2)/c`. -/
theorem matrix_cube_le (M : Matrix ι ι ℝ) (hM : M.IsHermitian) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι)
    (h1 : M.trace = 0) (h2 : (M ^ 2).trace = 1) : (M ^ 3).trace ≤ ((Fintype.card ι : ℝ) - 2) / c := by
  have e1 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 1
  have e2 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 2
  have e3 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 3
  rw [pow_one] at e1
  simp only [pow_one] at e1
  rw [e3]
  exact cube_sum_le hM.eigenvalues c hc0 hc hk (by rw [← e1, h1]) (by rw [← e2, h2])

theorem trace_diagonal_pow (v : ι → ℝ) (n : ℕ) : ((Matrix.diagonal v) ^ n).trace = ∑ j, v j ^ n := by
  rw [Matrix.diagonal_pow, Matrix.trace_diagonal]
  rfl

/-- **The matrix bound is sharp**: the diagonal matrix with one entry `(k − 1)/c` and the rest `−1/c` is symmetric,
trace-free, of unit norm, and has `tr M³ = (k − 2)/c`. -/
theorem matrix_cube_attained (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (i₀ : ι) :
    ∃ M : Matrix ι ι ℝ, M.IsHermitian ∧ M.trace = 0 ∧ (M ^ 2).trace = 1 ∧
      (M ^ 3).trace = ((Fintype.card ι : ℝ) - 2) / c := by
  obtain ⟨h1, h2, h3⟩ := cube_sum_attained (ι := ι) c hc0 hc i₀
  refine ⟨Matrix.diagonal fun j => if j = i₀ then ((Fintype.card ι : ℝ) - 1) / c else -1 / c, ?_, ?_, ?_, ?_⟩
  · exact Matrix.isHermitian_diagonal_of_self_adjoint _ (by ext j; simp)
  · rw [Matrix.trace_diagonal]; exact h1
  · rw [trace_diagonal_pow]; exact h2
  · rw [trace_diagonal_pow]; exact h3

/-- **The matrix equality case**: at `tr M³ = (k − 2)/c` every eigenvalue is `(k − 1)/c` or `−1/c`, and exactly one
is `(k − 1)/c`. -/
theorem matrix_cube_eq (M : Matrix ι ι ℝ) (hM : M.IsHermitian) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι)
    (h1 : M.trace = 0) (h2 : (M ^ 2).trace = 1) (heq : (M ^ 3).trace = ((Fintype.card ι : ℝ) - 2) / c) :
    (∀ i, hM.eigenvalues i = ((Fintype.card ι : ℝ) - 1) / c ∨ hM.eigenvalues i = -1 / c) ∧
    (univ.filter fun i => hM.eigenvalues i = ((Fintype.card ι : ℝ) - 1) / c).card = 1 := by
  have e1 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 1
  have e2 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 2
  have e3 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 3
  simp only [pow_one] at e1
  have s1 : ∑ j, hM.eigenvalues j = 0 := by rw [← e1, h1]
  have s2 : ∑ j, hM.eigenvalues j ^ 2 = 1 := by rw [← e2, h2]
  have s3 : ∑ j, hM.eigenvalues j ^ 3 = ((Fintype.card ι : ℝ) - 2) / c := by rw [← e3, heq]
  exact ⟨cube_sum_eq _ c hc0 hc hk s1 s2 s3, cube_sum_eq_card _ c hc0 hc hk s1 s2 s3⟩

/-- **The unnormalised form**: `tr M³ ≤ (k − 2)/c · ‖M‖³` with `‖M‖² = tr M²`, for every trace-free symmetric `M`. -/
theorem matrix_cube_le_unnormalised (M : Matrix ι ι ℝ) (hM : M.IsHermitian) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι)
    (h1 : M.trace = 0) :
    (M ^ 3).trace ≤ ((Fintype.card ι : ℝ) - 2) / c * Real.sqrt ((M ^ 2).trace) ^ 3 := by
  have e1 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 1
  have e2 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 2
  have e3 := HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 3
  simp only [pow_one] at e1
  set l := hM.eigenvalues
  have s1 : ∑ j, l j = 0 := by rw [← e1, h1]
  rw [e2, e3]
  set r := Real.sqrt (∑ j, l j ^ 2) with hr
  have hr2 : r ^ 2 = ∑ j, l j ^ 2 := Real.sq_sqrt (Finset.sum_nonneg fun j _ => sq_nonneg _)
  have hr0 : 0 ≤ r := Real.sqrt_nonneg _
  have hk2 : (0 : ℝ) ≤ (Fintype.card ι : ℝ) - 2 := by
    have : (2 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hk
    linarith
  rcases hr0.eq_or_lt with h0 | hpos
  · -- `r = 0`: every eigenvalue vanishes
    have hz : ∀ j, l j = 0 := fun j => by
      have hs : ∑ j, l j ^ 2 = 0 := by rw [← hr2, ← h0]; ring
      have := (Finset.sum_eq_zero_iff_of_nonneg fun j _ => sq_nonneg (l j)).mp hs j (Finset.mem_univ _)
      exact pow_eq_zero_iff (two_ne_zero) |>.mp this
    simp [hz, ← h0]
  · have hn : ∑ j, (l j / r) = 0 := by rw [← Finset.sum_div, s1, zero_div]
    have hn2 : ∑ j, (l j / r) ^ 2 = 1 := by
      simp only [div_pow]; rw [← Finset.sum_div, ← hr2]; field_simp
    have hb := cube_sum_le (fun j => l j / r) c hc0 hc hk hn hn2
    have e : ∑ j, (l j / r) ^ 3 = (∑ j, l j ^ 3) / r ^ 3 := by
      simp only [div_pow]; rw [← Finset.sum_div]
    rw [e, div_le_iff₀ (by positivity)] at hb
    exact hb

end HamiltonsCubic.L225Statement
