import Mathlib

set_option linter.style.longLine false

/-!
# L162, the composed constant: the checkable steps of its monotonicity proof

[findings/second-order.md](../../../findings/second-order.md), Lemma L162. The statement composes
L156–L158's constants into `F(w₀) = 4s₀/(√(4βs₀ + 1) + 1)²`, and its monotonicity proof rests on the facts below, each
proved here exactly:

- `C_closed` and `C_strictMono`: `C = (4 + 2D)/D` with `D = 2α*`, `α* = (n − 1)/(n − 2)`, is
  `2(2n − 3)/(n − 1) = 4 − 2/(n − 1)`, strictly increasing;
- `theta0Sq_strictMono`: `θ₀(n)² = 2(n − 1)(n − 2)/n²` strictly increases on `n ≥ 2`, so `λ` falls with it;
- `F_form`: `4s/(√(4βs + 1) + 1)² = 2s/(1 + 2βs + √(1 + 4βs))`, the form the proof differentiates;
- `h_strictMonoOn`, `F_antitone_beta`, `F_strictMono_s`: `F = (2/β)h(βs)` rises with `s` (`h` increasing, by comparing
  squares) and falls with `β` (by comparing denominators, in place of the block's elasticity step);
- `theta0Sq_gt`, `lam_strictAnti`, `beta_strictAnti`: `θ₀² > 3/2` on `n ≥ 12`, so `λ` and `β = λ/(2C)` strictly fall;
- **`D_pos`**: `D(n) = 384n²(n − 2)³(n − 4)²(n − 1) − 2P(n)² > 0` for every real `n ≥ 12`, the inequality the block
  reduces "`s₀` rises" to, because `D(12 + x)` has all nine coefficients positive.
-/

namespace HamiltonsCubic.L162

/-- **`C(n) = 2(2n − 3)/(n − 1)`**, from `C = (4 + 2D)/D`, `D = 2α*`, `α* = (n − 1)/(n − 2)`. -/
theorem C_closed (n : ℝ) (hn : 2 < n) :
    (4 + 2 * (2 * ((n - 1) / (n - 2)))) / (2 * ((n - 1) / (n - 2))) = 2 * (2 * n - 3) / (n - 1) := by
  have h1 : n - 1 ≠ 0 := by linarith
  have h2 : n - 2 ≠ 0 := by linarith
  field_simp
  ring

/-- **`C` strictly increases**: `C(n) = 4 − 2/(n − 1)`. -/
theorem C_strictMono {n m : ℝ} (hn : 1 < n) (hnm : n < m) :
    2 * (2 * n - 3) / (n - 1) < 2 * (2 * m - 3) / (m - 1) := by
  have h1 : 0 < n - 1 := by linarith
  have h2 : 0 < m - 1 := by linarith
  rw [div_lt_div_iff₀ h1 h2]
  nlinarith

/-- **`θ₀(n)² = 2(n − 1)(n − 2)/n²` strictly increases on `n ≥ 2`.** -/
theorem theta0Sq_strictMono {n m : ℝ} (hn : 2 ≤ n) (hnm : n < m) :
    2 * (n - 1) * (n - 2) / n ^ 2 < 2 * (m - 1) * (m - 2) / m ^ 2 := by
  have h1 : 0 < n ^ 2 := by positivity
  have h2 : 0 < m ^ 2 := by nlinarith
  rw [div_lt_div_iff₀ h1 h2]
  nlinarith [mul_pos (by linarith : (0 : ℝ) < m - n) (by nlinarith : (0 : ℝ) < 3 * n * m - 2 * n - 2 * m)]

/-- **The form the monotonicity proof differentiates**: `(q + 1)² = 4βs + 2 + 2q` with `q = √(4βs + 1)`. -/
theorem F_form {s β : ℝ} (hs : 0 ≤ s) (hβ : 0 ≤ β) :
    4 * s / (Real.sqrt (4 * β * s + 1) + 1) ^ 2 = 2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s)) := by
  have hq := Real.sq_sqrt (by positivity : (0 : ℝ) ≤ 4 * β * s + 1)
  have hq0 := Real.sqrt_nonneg (4 * β * s + 1)
  have e : (1 + 4 * β * s) = 4 * β * s + 1 := by ring
  rw [e]
  have hd : (Real.sqrt (4 * β * s + 1) + 1) ^ 2 = 2 * (1 + 2 * β * s + Real.sqrt (4 * β * s + 1)) := by
    nlinarith
  rw [hd]
  have hpos : 0 < 1 + 2 * β * s + Real.sqrt (4 * β * s + 1) := by positivity
  field_simp
  ring

/-- The quartic `P(n) = (5/4)n⁴ − (229/2)n³ + 694n² − 1312n + 768`. -/
noncomputable def P (n : ℝ) : ℝ := 5 / 4 * n ^ 4 - 229 / 2 * n ^ 3 + 694 * n ^ 2 - 1312 * n + 768

/-- `D(n) = 384n²(n − 2)³(n − 4)²(n − 1) − 2P(n)²`. -/
noncomputable def D (n : ℝ) : ℝ := 384 * n ^ 2 * (n - 2) ^ 3 * (n - 4) ^ 2 * (n - 1) - 2 * P n ^ 2

/-- **`D(n) > 0` for every real `n ≥ 12`**: at `n = 12 + x` every coefficient is positive. -/
theorem D_pos (n : ℝ) (hn : 12 ≤ n) : 0 < D n := by
  obtain ⟨x, hx, rfl⟩ : ∃ x : ℝ, 0 ≤ x ∧ n = 12 + x := ⟨n - 12, by linarith, by ring⟩
  have e : D (12 + x) = 23798734848 + 22573025280 * x + 8955411328 * x ^ 2 + 1962270976 * x ^ 3
      + 261338576 * x ^ 4 + 21738544 * x ^ 5 + 2209615 / 2 * x ^ 6 + 62753 / 2 * x ^ 7 + 3047 / 8 * x ^ 8 := by
    unfold D P; ring
  rw [e]
  positivity

/-- `h(x) = x/(1 + 2x + √(1 + 4x))`. -/
noncomputable def h (x : ℝ) : ℝ := x / (1 + 2 * x + Real.sqrt (1 + 4 * x))

/-- **`h` strictly increases on `x ≥ 0`**, the block's `h' > 0`, here by comparing squares:
`x√(1 + 4y) < y√(1 + 4x)` for `0 ≤ x < y`. -/
theorem h_strictMonoOn {x y : ℝ} (hx : 0 ≤ x) (hxy : x < y) : h x < h y := by
  have hy : 0 < y := lt_of_le_of_lt hx hxy
  set qx := Real.sqrt (1 + 4 * x) with hqx
  set qy := Real.sqrt (1 + 4 * y) with hqy
  have hqx2 : qx ^ 2 = 1 + 4 * x := Real.sq_sqrt (by linarith)
  have hqy2 : qy ^ 2 = 1 + 4 * y := Real.sq_sqrt (by linarith)
  have hqx0 : 0 ≤ qx := Real.sqrt_nonneg _
  have hqy0 : 0 ≤ qy := Real.sqrt_nonneg _
  have key : x * qy ≤ y * qx := by
    have hsq : (x * qy) ^ 2 ≤ (y * qx) ^ 2 := by
      rw [mul_pow, mul_pow, hqx2, hqy2]
      nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ y - x) (by linarith : (0 : ℝ) ≤ y + x),
        mul_nonneg (mul_nonneg hx hy.le) (by linarith : (0 : ℝ) ≤ y - x)]
    nlinarith [hsq, mul_nonneg hx hqy0, mul_nonneg hy.le hqx0]
  unfold h
  rw [← hqx, ← hqy, div_lt_div_iff₀ (by positivity) (by positivity)]
  nlinarith

/-- **`F` falls as `β` rises**, at fixed `s > 0`: the denominator `1 + 2βs + √(1 + 4βs)` increases in `β`. -/
theorem F_antitone_beta {s β β' : ℝ} (hs : 0 < s) (hβ : 0 ≤ β) (hββ : β < β') :
    2 * s / (1 + 2 * β' * s + Real.sqrt (1 + 4 * β' * s)) < 2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s)) := by
  have hq : Real.sqrt (1 + 4 * β * s) ≤ Real.sqrt (1 + 4 * β' * s) :=
    Real.sqrt_le_sqrt (by nlinarith)
  have h0 : 0 < 1 + 2 * β * s + Real.sqrt (1 + 4 * β * s) := by positivity
  apply div_lt_div_of_pos_left (by linarith) h0
  nlinarith

/-- **`F` rises with `s`**, at fixed `β > 0`: `F = (2/β) h(βs)` and `h` strictly increases. -/
theorem F_strictMono_s {s s' β : ℝ} (hs : 0 ≤ s) (hss : s < s') (hβ : 0 < β) :
    2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s)) < 2 * s' / (1 + 2 * β * s' + Real.sqrt (1 + 4 * β * s')) := by
  have e : ∀ u, 2 * u / (1 + 2 * β * u + Real.sqrt (1 + 4 * β * u)) = 2 / β * h (β * u) := fun u => by
    unfold h
    rw [show 1 + 2 * β * u + Real.sqrt (1 + 4 * β * u) = 1 + 2 * (β * u) + Real.sqrt (1 + 4 * (β * u)) by ring_nf]
    field_simp
  rw [e, e]
  exact mul_lt_mul_of_pos_left (h_strictMonoOn (by positivity) (by nlinarith)) (by positivity)

/-- `θ₀(n)² > 3/2` at `n ≥ 12`, which is `n(n − 12) + 8 > 0`. -/
theorem theta0Sq_gt (n : ℝ) (hn : 12 ≤ n) : 3 / 2 < 2 * (n - 1) * (n - 2) / n ^ 2 := by
  rw [lt_div_iff₀ (by positivity)]
  nlinarith

/-- `λ(n) = 2/√(9(θ₀(n) − √(3/2)))` with `θ₀(n) = √(2(n − 1)(n − 2)/n²)`. -/
noncomputable def lam (n : ℝ) : ℝ :=
  2 / Real.sqrt (9 * (Real.sqrt (2 * (n - 1) * (n - 2) / n ^ 2) - Real.sqrt (3 / 2)))

/-- **`λ` strictly falls on `n ≥ 12`**, because `θ₀` strictly rises there and stays above `√(3/2)`. -/
theorem lam_strictAnti {n m : ℝ} (hn : 12 ≤ n) (hnm : n < m) : lam m < lam n := by
  unfold lam
  have hθ := theta0Sq_strictMono (by linarith : (2 : ℝ) ≤ n) hnm
  have hgt := theta0Sq_gt n hn
  have h1 : Real.sqrt (3 / 2) < Real.sqrt (2 * (n - 1) * (n - 2) / n ^ 2) :=
    Real.sqrt_lt_sqrt (by norm_num) hgt
  have h2 : Real.sqrt (2 * (n - 1) * (n - 2) / n ^ 2) < Real.sqrt (2 * (m - 1) * (m - 2) / m ^ 2) :=
    Real.sqrt_lt_sqrt (by linarith) hθ
  have hpos : 0 < Real.sqrt (9 * (Real.sqrt (2 * (n - 1) * (n - 2) / n ^ 2) - Real.sqrt (3 / 2))) :=
    Real.sqrt_pos.mpr (by linarith)
  apply div_lt_div_of_pos_left (by norm_num) hpos
  exact Real.sqrt_lt_sqrt (by linarith) (by linarith)

/-- **`β = λ/(2C)` strictly falls on `n ≥ 12`**: `λ` falls and `C` rises. -/
theorem beta_strictAnti {n m : ℝ} (hn : 12 ≤ n) (hnm : n < m) :
    lam m / (2 * (2 * (2 * m - 3) / (m - 1))) < lam n / (2 * (2 * (2 * n - 3) / (n - 1))) := by
  have hl := lam_strictAnti hn hnm
  have hC := C_strictMono (by linarith : (1 : ℝ) < n) hnm
  have hCn : 0 < 2 * (2 * n - 3) / (n - 1) := div_pos (by linarith) (by linarith)
  have hlm : 0 < lam m := by
    unfold lam
    have hgt := theta0Sq_gt m (by linarith)
    have h1 : Real.sqrt (3 / 2) < Real.sqrt (2 * (m - 1) * (m - 2) / m ^ 2) := Real.sqrt_lt_sqrt (by norm_num) hgt
    exact div_pos (by norm_num) (Real.sqrt_pos.mpr (by linarith))
  calc lam m / (2 * (2 * (2 * m - 3) / (m - 1))) < lam m / (2 * (2 * (2 * n - 3) / (n - 1))) :=
        div_lt_div_of_pos_left hlm (by positivity) (by linarith)
    _ < lam n / (2 * (2 * (2 * n - 3) / (n - 1))) := div_lt_div_of_pos_right hl (by positivity)

end HamiltonsCubic.L162
