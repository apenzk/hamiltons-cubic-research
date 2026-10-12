import HamiltonsCubic.Results.L182Statement
import HamiltonsCubic.Results.L162Limit

set_option linter.style.longLine false

/-!
# L182 without its binder

[L182Statement.lean](L182Statement.lean) proves `λ(n)F(n) > 0.5923` at every `n ≥ 12` from the binder
`hF : F 12 ≤ F n`, which it imports from [L162](../../../findings/second-order.md). L162's monotonicity is proved
([L162Mono.lean](L162Mono.lean)'s `F_gt_twelve`), and the two files define `F` through the same constants, so:

* **`F_eq_Fn`**: L182's `F n` is L162's `Fn n` at every `n > 2`;
* **`F_twelve_le`**: `F 12 ≤ F n` at every `n ≥ 12`, the binder discharged;
* **`lam_mul_F_floor'`**: **`λ(n)F(n) > 0.5923` at every `n ≥ 12`**, with no hypothesis.
-/

namespace HamiltonsCubic.L182

/-- **L182's `F` is L162's `F`.** -/
theorem F_eq_Fn {n : ℝ} (hn : 2 < n) : F n = HamiltonsCubic.L162.Fn n := by
  have hθ : theta0 n = HamiltonsCubic.L162.q n / n := by
    unfold theta0 theta0sq HamiltonsCubic.L162.q
    rw [Real.sqrt_div' _ (by positivity : (0 : ℝ) ≤ n ^ 2), Real.sqrt_sq (by linarith : (0 : ℝ) ≤ n)]
  have hS : cp n + rhoEff n * w0 n ^ 2 = HamiltonsCubic.L162.Sfun n := by
    unfold cp rhoEff w0 HamiltonsCubic.L162.Sfun; rw [hθ]
  have hl : lam n = HamiltonsCubic.L162.lam n := rfl
  unfold F HamiltonsCubic.L162.Fn beta s0 Cn
  rw [hS, hl]

/-- **The binder, discharged**: `F 12 ≤ F n` at every `n ≥ 12`. -/
theorem F_twelve_le {n : ℝ} (hn : 12 ≤ n) : F 12 ≤ F n := by
  rcases eq_or_lt_of_le hn with h | h
  · rw [h]
  · rw [F_eq_Fn (by norm_num), F_eq_Fn (by linarith)]
    exact (HamiltonsCubic.L162.F_gt_twelve h).le

/-- **L182's floor with no hypothesis**: `λ(n)F(n) > 0.5923` at every `n ≥ 12`. -/
theorem lam_mul_F_floor' (n : ℝ) (hn : 12 ≤ n) : (5923 : ℝ) / 10000 < lam n * F n :=
  lam_mul_F_floor n hn (F_twelve_le hn)

end HamiltonsCubic.L182
