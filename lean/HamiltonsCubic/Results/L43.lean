import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

/-!
# L43, the criterion at `a = 0` demands exactly `θ₀(n)`

[problem.md](../../../findings/problem.md)'s Lemma L43. Two of its three corrections turn on
arithmetic that can be carried here; the collapse itself needs Böhm–Wilking's `F`, which the
base layer has no types for and which stays imported.

**The Einstein/Ricci-flat correction, made quantitative.** The block says naming the slice
*Ricci-flat* "states as hypothesis the one value `c` cannot take". The mechanism is the
boundary ratio: `∂Ω₀` meets the slice where `⟨W,Q(W)⟩ = c(n-1)‖W‖²`, and the criterion reads
`⟨W,Q(W)⟩ = θ₀(n)‖W‖³` there, so `c/‖W‖ = θ₀(n)/(n-1)`, **a single nonzero ratio**. Hence
`c = 0` forces `‖W‖ = 0` outright, which is `ratio_forces_zero` below.

**The dropped cone clause.** `F` is even in `R`, so without `scal(R) > 0` the sublevel set is
a double cone whose `c < 0` nappe reads `⟨W,Q(W)⟩ ≤ -θ₀(n)‖W‖³`. Every sphere product has
`θ > 0`, so it violates that at once, proved below from the family's own closed form, with
no appeal to a numerical value.
-/

namespace HamiltonsCubic.ConeSlice

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`, the square of the block's `√(2(n-1)(n-2))/n`. -/
def theta0Sq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- `‖I‖² = C(n,2) = n(n-1)/2`, one of the four inputs the block lists. -/
def normISq (n : ℚ) : ℚ := n * (n - 1) / 2

theorem normISq_choose_six : Nat.choose 6 2 = 15 ∧ normISq 6 = 15 := by
  constructor
  · decide
  · unfold normISq; norm_num

theorem normISq_choose_twelve : Nat.choose 12 2 = 66 ∧ normISq 12 = 66 := by
  constructor
  · decide
  · unfold normISq; norm_num

/-- `θ₀(n) > 0` for `n ≥ 3`, which is what makes the ratio below nonzero. -/
theorem theta0Sq_pos (n : ℚ) (hn : 3 ≤ n) : 0 < theta0Sq n := by
  unfold theta0Sq
  have hpos : (0:ℚ) < n ^ 2 := by nlinarith [hn]
  apply div_pos _ hpos
  nlinarith [hn]

/-! ## The boundary ratio, and why the slice is Einstein rather than Ricci-flat -/

/-- **`∂Ω₀` meets the slice at one ratio.** Where the boundary equation
`⟨W,Q(W)⟩ = c(n-1)‖W‖²` meets the criterion's equality `⟨W,Q(W)⟩ = θ₀‖W‖³`, the ratio
`c/‖W‖` is pinned to `θ₀/(n-1)`, no other value occurs on the slice. -/
theorem boundary_ratio {c nrm θ₀ n : ℚ} (hn : 1 < n) (hnrm : nrm ≠ 0)
    (hbdry : c * (n - 1) * nrm ^ 2 = θ₀ * nrm ^ 3) : c / nrm = θ₀ / (n - 1) := by
  have hn1 : n - 1 ≠ 0 := by intro h; linarith
  have hsq : nrm ^ 2 ≠ 0 := pow_ne_zero 2 hnrm
  have key : c * (n - 1) = θ₀ * nrm := by
    refine mul_right_cancel₀ hsq ?_
    linarith [hbdry]
  field_simp
  linarith [key]

/-- **So `c = 0` forces `‖W‖ = 0`.** Ricci-flatness on this slice additionally demands `c = 0`,
and there the boundary carries only the zero tensor, which is why naming it the Ricci-flat
slice states as hypothesis the one value `c` cannot take. -/
theorem ratio_forces_zero {nrm θ₀ n : ℚ} (hn : 1 < n) (hθ : 0 < θ₀)
    (hbdry : 0 * (n - 1) * nrm ^ 2 = θ₀ * nrm ^ 3) : nrm = 0 := by
  have h : θ₀ * nrm ^ 3 = 0 := by linarith [hbdry]
  rcases mul_eq_zero.1 h with h' | h'
  · linarith
  · exact pow_eq_zero_iff (n := 3) (by norm_num) |>.1 h'

/-- The slice is Einstein: `R_{ric₀} = 0` kills the trace-free Ricci part and leaves `c` free,
so `c ≠ 0` is available, and it is exactly what Ricci-flatness would remove. -/
theorem einstein_not_ricci_flat {c nrm θ₀ n : ℚ} (hn : 1 < n) (hθ : 0 < θ₀)
    (hnrm : nrm ≠ 0) (hbdry : c * (n - 1) * nrm ^ 2 = θ₀ * nrm ^ 3) : c ≠ 0 := by
  intro hc
  exact hnrm (ratio_forces_zero hn hθ (by rw [← hc]; exact hbdry))

/-! ## The dropped `scal(R) > 0` clause makes it a double cone -/

/-- `θ(Sᵖ × S^q)² = 2(n-1)(p-1)(q-1)/((n-2)pq)`, the family's closed form. -/
def sphereThetaSq (p q : ℚ) : ℚ :=
  2 * (p + q - 1) * (p - 1) * (q - 1) / ((p + q - 2) * p * q)

/-- **Every sphere product has `θ² > 0`, hence `θ > 0`.** -/
theorem sphereThetaSq_pos (p q : ℚ) (hp : 2 ≤ p) (hq : 2 ≤ q) : 0 < sphereThetaSq p q := by
  unfold sphereThetaSq
  have h1 : (0:ℚ) < p - 1 := by linarith
  have h2 : (0:ℚ) < q - 1 := by linarith
  have h3 : (0:ℚ) < p + q - 1 := by linarith
  have h4 : (0:ℚ) < p + q - 2 := by linarith
  have hp0 : (0:ℚ) < p := by linarith
  have hq0 : (0:ℚ) < q := by linarith
  exact div_pos (mul_pos (mul_pos (mul_pos (by norm_num : (0:ℚ) < 2) h3) h1) h2)
    (mul_pos (mul_pos h4 hp0) hq0)

/-- **So the lower nappe is violated at every sphere product.** With `θ > 0` and `θ₀ > 0`,
`θ ≤ -θ₀` is false, the `c < 0` half of the double cone contains no sphere product, which is
the block's witness that `scal(R) > 0` cannot be dropped. -/
theorem lower_nappe_violated {θ θ₀ : ℚ} (hθ : 0 < θ) (hθ₀ : 0 < θ₀) : ¬ (θ ≤ -θ₀) := by
  push_neg; linarith

/-- The balanced product returns `θ₀` exactly: `sphereThetaSq (n/2) (n/2) = θ₀(n)²`, so the
constant the criterion demands is attained inside the family it was derived without. -/
theorem balanced_returns_theta0 (m : ℚ) (hm : 2 ≤ m) :
    sphereThetaSq m m = theta0Sq (2 * m) := by
  unfold sphereThetaSq theta0Sq
  have h1 : m ≠ 0 := by intro h; linarith
  have h2 : m - 1 ≠ 0 := by intro h; linarith
  have hm0 : (0:ℚ) < m := by linarith
  have hmm : (0:ℚ) < m + m - 2 := by linarith
  have hd1 : (0:ℚ) < (m + m - 2) * m * m := mul_pos (mul_pos hmm hm0) hm0
  have hd2 : (0:ℚ) < (2 * m) ^ 2 := by positivity
  rw [div_eq_div_iff (ne_of_gt hd1) (ne_of_gt hd2)]
  ring

end HamiltonsCubic.ConeSlice
