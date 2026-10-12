import HamiltonsCubic.Results.L225Matrix

set_option linter.style.longLine false

/-!
# L124(iii)'s sharp determinant bound: `|det X| ≤ ‖X‖³/(3√6)` on traceless symmetric `3 × 3`

[findings/second-order.md](../../../findings/second-order.md), Lemma L124(iii): on the half-flat four-set family
`θ = 9 det V₊`, and *"the sharp bound `|det X| ≤ ‖X‖³/(3√6)` on traceless symmetric `3×3` then gives
`θ² ≤ (3/2)ρ²`"* at unit norm. The bound is [L225](L225Matrix.lean) at `k = 3`, with `c = √6`:

- `trace_cube_eq_three_det`: `tr X³ = 3 det X` for a `3 × 3` matrix with `tr X = 0`;
- `trace_cube_sq_le`: `(tr X³)² ≤ (tr X²)³/6`, from `matrix_cube_le_unnormalised` at `X` and `−X`;
- **`det_sq_le`**: `(det X)² ≤ (tr X²)³/54`, the sharp bound squared;
- **`theta_sq_le`**: with `θ = 9 det X`, `θ² ≤ (3/2)(tr X²)³`;
- `det_sq_eq`: at equality and unit norm, `X` or `−X` has the spectrum `(2, −1, −1)/√6` of `±W_{ℂP²}/√6`;
- `sigma_of_sum_zero`: L124(i), `A + B + C = 0` gives `Σ = (3/2)(A² + B² + C²)`.
-/

namespace HamiltonsCubic.L124Det

open Matrix

/-- **`tr X³ = 3 det X`** on traceless `3 × 3` matrices. -/
theorem trace_cube_eq_three_det (X : Matrix (Fin 3) (Fin 3) ℝ) (h : X.trace = 0) :
    (X ^ 3).trace = 3 * X.det := by
  have h22 : X 2 2 = -X 0 0 - X 1 1 := by
    simp [Matrix.trace, Fin.sum_univ_three] at h; linarith
  rw [Matrix.det_fin_three]
  simp only [pow_succ, pow_zero, Matrix.one_mul, Matrix.trace, Matrix.diag, Matrix.mul_apply, Fin.sum_univ_three]
  rw [h22]
  ring

/-- **`(tr X³)² ≤ (tr X²)³/6`** on traceless symmetric `3 × 3`. -/
theorem trace_cube_sq_le (X : Matrix (Fin 3) (Fin 3) ℝ) (hX : X.IsHermitian) (h : X.trace = 0) :
    (X ^ 3).trace ^ 2 ≤ (X ^ 2).trace ^ 3 / 6 := by
  have hc : Real.sqrt 6 ^ 2 = (Fintype.card (Fin 3) : ℝ) * ((Fintype.card (Fin 3) : ℝ) - 1) := by
    rw [Real.sq_sqrt (by norm_num)]; norm_num
  have hc0 : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have hk : 2 ≤ Fintype.card (Fin 3) := by simp
  have up := HamiltonsCubic.L225Statement.matrix_cube_le_unnormalised X hX _ hc0 hc hk h
  have hXn : (-X).IsHermitian := hX.neg
  have hn : (-X).trace = 0 := by rw [Matrix.trace_neg, h, neg_zero]
  have lo := HamiltonsCubic.L225Statement.matrix_cube_le_unnormalised (-X) hXn _ hc0 hc hk hn
  have e3 : ((-X) ^ 3).trace = -(X ^ 3).trace := by
    rw [show (-X) ^ 3 = -(X ^ 3) by noncomm_ring, Matrix.trace_neg]
  have e2 : ((-X) ^ 2).trace = (X ^ 2).trace := by rw [show (-X) ^ 2 = X ^ 2 by noncomm_ring]
  rw [e3, e2] at lo
  simp only [Fintype.card_fin] at up lo
  have ht : 0 ≤ (X ^ 2).trace := by
    rw [HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues X hX 2]
    exact Finset.sum_nonneg fun j _ => sq_nonneg _
  have hr2 : Real.sqrt ((X ^ 2).trace) ^ 2 = (X ^ 2).trace := Real.sq_sqrt ht
  have hr0 : 0 ≤ Real.sqrt ((X ^ 2).trace) := Real.sqrt_nonneg _
  set r := Real.sqrt ((X ^ 2).trace)
  set b := ((3 : ℕ) - 2 : ℝ) / Real.sqrt 6 * r ^ 3 with hb
  have hsq : (X ^ 3).trace ^ 2 ≤ b ^ 2 := sq_le_sq' (by linarith) up
  have hb2 : b ^ 2 = r ^ 6 / 6 := by
    rw [hb, mul_pow, div_pow, Real.sq_sqrt (by norm_num)]; push_cast; ring
  have hr6 : r ^ 6 = (X ^ 2).trace ^ 3 := by rw [show r ^ 6 = (r ^ 2) ^ 3 by ring, hr2]
  rw [hb2, hr6] at hsq
  exact hsq

/-- **`(det X)² ≤ (tr X²)³/54`**: the sharp bound `|det X| ≤ ‖X‖³/(3√6)`, squared. -/
theorem det_sq_le (X : Matrix (Fin 3) (Fin 3) ℝ) (hX : X.IsHermitian) (h : X.trace = 0) :
    X.det ^ 2 ≤ (X ^ 2).trace ^ 3 / 54 := by
  have := trace_cube_sq_le X hX h
  rw [trace_cube_eq_three_det X h] at this
  nlinarith

/-- **L124(iii)'s conclusion**: `θ = 9 det X` gives `θ² ≤ (3/2)(tr X²)³`. -/
theorem theta_sq_le (X : Matrix (Fin 3) (Fin 3) ℝ) (hX : X.IsHermitian) (h : X.trace = 0) (θ : ℝ)
    (hθ : θ = 9 * X.det) : θ ^ 2 ≤ 3 / 2 * (X ^ 2).trace ^ 3 := by
  have := det_sq_le X hX h
  rw [hθ]
  nlinarith

/-- **L124(i)**: `A + B + C = 0` gives `Σ = A² + B² + C² − AB − BC − CA = (3/2)(A² + B² + C²)`. -/
theorem sigma_of_sum_zero (A B C : ℝ) (h : A + B + C = 0) :
    A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A = 3 / 2 * (A ^ 2 + B ^ 2 + C ^ 2) := by
  have hC : C = -A - B := by linarith
  subst hC; ring

/-- **The equality case of the determinant bound**: at `(det X)² = 1/54` with `tr X² = 1`, `X` or `−X` has every
eigenvalue `2/√6` or `−1/√6`, exactly one `2/√6`: the spectrum of `±W_{ℂP²}/√6`. -/
theorem det_sq_eq (X : Matrix (Fin 3) (Fin 3) ℝ) (hX : X.IsHermitian) (h : X.trace = 0)
    (h2 : (X ^ 2).trace = 1) (heq : X.det ^ 2 = 1 / 54) :
    ((∀ i, hX.eigenvalues i = 2 / Real.sqrt 6 ∨ hX.eigenvalues i = -1 / Real.sqrt 6) ∧
      (Finset.univ.filter fun i => hX.eigenvalues i = 2 / Real.sqrt 6).card = 1) ∨
    ((∀ i, hX.neg.eigenvalues i = 2 / Real.sqrt 6 ∨ hX.neg.eigenvalues i = -1 / Real.sqrt 6) ∧
      (Finset.univ.filter fun i => hX.neg.eigenvalues i = 2 / Real.sqrt 6).card = 1) := by
  have hc : Real.sqrt 6 ^ 2 = (Fintype.card (Fin 3) : ℝ) * ((Fintype.card (Fin 3) : ℝ) - 1) := by
    rw [Real.sq_sqrt (by norm_num)]; norm_num
  have hc0 : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have hk : 2 ≤ Fintype.card (Fin 3) := by simp
  have e := trace_cube_eq_three_det X h
  have hs : (X ^ 3).trace ^ 2 = (1 / Real.sqrt 6) ^ 2 := by
    rw [e, div_pow, Real.sq_sqrt (by norm_num)]; nlinarith
  have hval : ((Fintype.card (Fin 3) : ℝ) - 2) / Real.sqrt 6 = 1 / Real.sqrt 6 := by simp; norm_num
  have hval1 : ((Fintype.card (Fin 3) : ℝ) - 1) / Real.sqrt 6 = 2 / Real.sqrt 6 := by simp; norm_num
  rcases sq_eq_sq_iff_eq_or_eq_neg.mp hs with hp | hm
  · left
    have := HamiltonsCubic.L225Statement.matrix_cube_eq X hX _ hc0 hc hk h h2 (by rw [hp, hval])
    rw [← hval1]; exact this
  · right
    have hn : (-X).trace = 0 := by rw [Matrix.trace_neg, h, neg_zero]
    have hn2 : ((-X) ^ 2).trace = 1 := by rw [show (-X) ^ 2 = X ^ 2 by noncomm_ring, h2]
    have hn3 : ((-X) ^ 3).trace = ((Fintype.card (Fin 3) : ℝ) - 2) / Real.sqrt 6 := by
      rw [show (-X) ^ 3 = -(X ^ 3) by noncomm_ring, Matrix.trace_neg, hm, hval, neg_neg]
    have := HamiltonsCubic.L225Statement.matrix_cube_eq (-X) hX.neg _ hc0 hc hk hn hn2 hn3
    rw [← hval1]; exact this

end HamiltonsCubic.L124Det
