import Mathlib

/-! # Smoke test, the three capabilities the verification slice needs. -/

open Matrix

/-- Exact rational matrix arithmetic, as an `L61`-style certificate check needs. -/
example : (!![2, -1; -1, 2] : Matrix (Fin 2) (Fin 2) ℚ).det = 3 := by
  simp [Matrix.det_fin_two_of]; norm_num

/-- Positive-semidefiniteness of a rational Gram matrix, decided exactly. -/
example : (0 : ℚ) ≤ 2 * 2 - (-1) * (-1) := by norm_num

/-- The threshold `n = 6 + 2√7` is a root of `n² - 12n + 8`. -/
example : (6 + 2 * Real.sqrt 7) ^ 2 - 12 * (6 + 2 * Real.sqrt 7) + 8 = 0 := by
  have h : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  nlinarith [h]
