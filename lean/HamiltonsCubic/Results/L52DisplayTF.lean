import Mathlib
import HamiltonsCubic.Results.L52Remarks

set_option linter.style.longLine false

/-!
# L52's second display in the record's variable `t_F`

[L52Remarks.lean](L52Remarks.lean)'s `display_needs_small_C` is stated in `u` with the display
`θ ≤ u³ Θ + (9/2) C (1 - u²)`; the record writes it in `t_F ∈ [0, 2]` with `u² = t_F/2`, and the L52 row
owes *"the change of variables $u=\sqrt{t_F/2}$ on $t_F\in[0,2]$ behind `display_needs_small_C`"*:

* `u_of_tF`: `u = √(t_F/2)` lies in `[0, 1]`, is `< 1` exactly when `t_F < 2`, and has `u² = t_F/2`,
  `u³ = (t_F/2)^{3/2}`;
* `display_needs_small_C_tF`: if the display `θ ≤ (t_F/2)^{3/2} Θ + (9/2) C (1 - t_F/2)` returns `Θ` at some
  `t_F ∈ [0, 2)`, then `C ≤ Θ/3`, so by `one_line_half` the one-line bound already gives `θ ≤ Θ/2`.
-/

namespace HamiltonsCubic.L52DisplayTF

open HamiltonsCubic.L52Remarks

/-- **The change of variables**: `u = √(t_F/2)`. -/
theorem u_of_tF {tF : ℝ} (h0 : 0 ≤ tF) (h2 : tF ≤ 2) :
    0 ≤ Real.sqrt (tF / 2) ∧ Real.sqrt (tF / 2) ≤ 1 ∧ Real.sqrt (tF / 2) ^ 2 = tF / 2 ∧
      Real.sqrt (tF / 2) ^ 3 = (tF / 2) ^ ((3 : ℝ) / 2) ∧ (tF < 2 ↔ Real.sqrt (tF / 2) < 1) := by
  have hnn : 0 ≤ tF / 2 := by positivity
  have hsq : Real.sqrt (tF / 2) ^ 2 = tF / 2 := Real.sq_sqrt hnn
  refine ⟨Real.sqrt_nonneg _, ?_, hsq, ?_, ?_⟩
  · rw [Real.sqrt_le_one]; linarith
  · rw [Real.sqrt_eq_rpow, ← Real.rpow_natCast, ← Real.rpow_mul hnn]
    norm_num
  · constructor
    · intro h
      rw [Real.sqrt_lt' (by norm_num)]
      linarith
    · intro h
      have : tF / 2 < 1 := by
        have h' := (Real.sqrt_lt' (by norm_num : (0 : ℝ) < 1)).mp h
        linarith
      linarith

/-- **The second display in `t_F`**: returning `Θ` at some `t_F ∈ [0, 2)` forces `C ≤ Θ/3`. -/
theorem display_needs_small_C_tF {tF Θ C : ℝ} (h0 : 0 ≤ tF) (h2 : tF < 2) (hΘ : 0 ≤ Θ) (hC : 0 ≤ C)
    (h : (tF / 2) ^ ((3 : ℝ) / 2) * Θ + (9 / 2) * C * (1 - tF / 2) ≤ Θ) : C ≤ Θ / 3 := by
  obtain ⟨hu0, -, hu2, hu3, hlt⟩ := u_of_tF h0 h2.le
  refine display_needs_small_C hu0 (hlt.mp h2) hΘ hC ?_
  rw [hu3, hu2]
  exact h

end HamiltonsCubic.L52DisplayTF
