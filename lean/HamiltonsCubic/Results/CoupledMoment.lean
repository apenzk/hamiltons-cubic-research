import Mathlib

/-!
# A coupled fourth moment on the symmetric family, and the `p = 14` steps at `n = 12`

[the per-vector note](../../../reviews/2026-09-25-I73c-per-vector-rows.md),
the paragraphs on `p = 14`.

**`coupled_moment`**: the sphere averages over the unit sphere of `E₀` of the per-vector identity
`tr(−x²A₀) = 2 + 2R₀ − ⟨x∧x, Ω₀⟩`, of the Casimir `R₀ + R₁ + R₂ = n − 2` and of row (B)
`R₂ − R₀ = 1`, with L251's moment formula `p(p+2) E tr x⁴ = 2 tr A₀² + 2p − ‖Ω₀‖²`, give
`(p+2) E tr x⁴ + 2 E R₁ = 2n − 3‖Ω₀‖²/p`. The averages enter as hypotheses: the layer carries no
integration over a sphere.

**The `p = 14` steps**: `p14_decomposable` (the decomposable regime closes the coupled
average), `one_pair_floor` (`6|s|² − (Σs)² + (s₅ + s₆)² ≥ (4 − 2√3)|s|²`), `gap_floor_one`,
`gap_floor_two`, `p14_branch` (the structure bound forces `T₁₆ ≥ 3T` below `τ`) and
`p14_threshold` (L249 at `θ ≥ θ₀(12)` gives `T₁₆ ≤ τ = 7 − √385/3`).
-/

namespace HamiltonsCubic.CoupledMoment

/-- **The coupled fourth moment.** From the averaged per-vector identity, the Casimir, row (B) and
the moment formula, `(p+2) E tr x⁴ + 2 E R₁ = 2n − 3‖Ω₀‖²/p`. -/
theorem coupled_moment (n p E trA2 Om R0 R1 R2 : ℝ) (hp : 0 < p)
    (hid : trA2 = 2 * p + 2 * p * R0 - Om) (hcas : R0 + R1 + R2 = n - 2) (hB : R2 - R0 = 1)
    (hmom : p * (p + 2) * E = 2 * trA2 + 2 * p - Om) :
    (p + 2) * E + 2 * R1 = 2 * n - 3 * Om / p := by
  have hR0 : R0 = (n - 3 - R1) / 2 := by linarith
  have h : p * ((p + 2) * E + 2 * R1) = p * (2 * n - 3 * Om / p) := by
    rw [mul_sub, mul_div_assoc', mul_div_cancel_left₀ _ hp.ne']
    nlinarith [hmom, hid, hR0]
  exact mul_left_cancel₀ hp.ne' h

/-- **The decomposable regime at `p = 14`.** With `T ≤ τ/3`, `τ = 7 − √385/3`, the lower bound
`16((1 − T)² + T²/5) + 3T` on `16 Σ s⁴ + T₁₆` exceeds `12`. -/
theorem p14_decomposable (T : ℝ) (hT0 : 0 ≤ T) (hT : 3 * T ≤ 7 - Real.sqrt 385 / 3) :
    12 < 16 * ((1 - T) ^ 2 + T ^ 2 / 5) + 3 * T := by
  have h385 : Real.sqrt 385 ^ 2 = 385 := Real.sq_sqrt (by norm_num)
  have hs : 19621 / 1000 < Real.sqrt 385 := by nlinarith [Real.sqrt_nonneg 385]
  have hT' : T ≤ 15318 / 100000 := by nlinarith
  nlinarith

/-- **One doubled pair.** `6|s|² − (Σ s)² + (e + f)² ≥ (4 − 2√3)|s|²`, the least eigenvalue of
`6I − J + vvᵀ`, `v` the indicator of the pair. -/
theorem one_pair_floor (a b c d e f : ℝ) :
    (4 - 2 * Real.sqrt 3) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2)
      ≤ 6 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2) - (a + b + c + d + e + f) ^ 2
        + (e + f) ^ 2 := by
  set r := Real.sqrt 3 with hr
  have h3 : r ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h1 : 1 < r := by
    rw [hr, show (1 : ℝ) = Real.sqrt 1 by simp]
    exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  set x := a + b + c + d
  set y := e + f
  have hx : x ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
    nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c),
      sq_nonneg (b - d), sq_nonneg (c - d)]
  have hy : y ^ 2 ≤ 2 * (e ^ 2 + f ^ 2) := by nlinarith [sq_nonneg (e - f)]
  set Q := (r - 1) / 2 * x ^ 2 - 2 * x * y + (1 + r) * y ^ 2 with hQdef
  have hQe : 2 * (r - 1) * Q = ((r - 1) * x - 2 * y) ^ 2 + 2 * (r ^ 2 - 3) * y ^ 2 := by
    rw [hQdef]; ring
  have hQ : 0 ≤ Q := by
    by_contra hneg
    push Not at hneg
    have := mul_neg_of_pos_of_neg (by linarith : (0 : ℝ) < 2 * (r - 1)) hneg
    rw [hQe, h3] at this
    nlinarith [sq_nonneg ((r - 1) * x - 2 * y)]
  have hc : 0 ≤ 2 + 2 * r := by linarith
  have k1 := mul_le_mul_of_nonneg_left hx hc
  have k2 := mul_le_mul_of_nonneg_left hy hc
  have hexp : 6 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2) - (a + b + c + d + e + f) ^ 2
      + (e + f) ^ 2 - (4 - 2 * r) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2)
      = (2 + 2 * r) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) + (2 + 2 * r) * (e ^ 2 + f ^ 2)
        - x ^ 2 - 2 * x * y := by
    simp only [x, y]; ring
  have hQx : Q = (2 + 2 * r) * (x ^ 2 / 4) + (2 + 2 * r) * (y ^ 2 / 2) - x ^ 2 - 2 * x * y := by
    rw [hQdef]; ring
  nlinarith [hexp, hQx, hQ, k1, k2]

/-- **One gap at the top angle.** With `a² + b² = 1`, `(a − b)² + 2b² ≥ 2 − √2`: the bound
`(√u − √(1−u))² + 2(1 − u) ≥ 2 − √2`. -/
theorem gap_floor_one (a b : ℝ) (h : a ^ 2 + b ^ 2 = 1) :
    2 - Real.sqrt 2 ≤ (a - b) ^ 2 + 2 * b ^ 2 := by
  set r := Real.sqrt 2 with hr
  have h2 : r ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hr0 : 0 ≤ r := Real.sqrt_nonneg 2
  set Q := (a - b) ^ 2 + 2 * b ^ 2 - (2 - r) * (a ^ 2 + b ^ 2) with hQdef
  have hQe : (r + 1) * Q = (a - (r + 1) * b) ^ 2 + (r ^ 2 - 2) * (a ^ 2 - b ^ 2 * (r + 1) ^ 2
      + (r + 1) ^ 2 * b ^ 2) := by
    rw [hQdef]; ring
  have hQ : 0 ≤ Q := by
    by_contra hneg
    push Not at hneg
    have := mul_neg_of_pos_of_neg (by linarith : (0 : ℝ) < r + 1) hneg
    rw [hQe, h2] at this
    nlinarith [sq_nonneg (a - (r + 1) * b)]
  rw [hQdef, h] at hQ
  linarith

/-- **Two gaps at the top angle.** With `a² + 2c² = 1`, `2(a − c)² + 2c² ≥ 2 − √2`: the bound
`2(√u − √((1−u)/2))² + (1 − u) ≥ 2 − √2`. -/
theorem gap_floor_two (a c : ℝ) (h : a ^ 2 + 2 * c ^ 2 = 1) :
    2 - Real.sqrt 2 ≤ 2 * (a - c) ^ 2 + 2 * c ^ 2 := by
  set r := Real.sqrt 2 with hr
  have h2 : r ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hr0 : 0 ≤ r := Real.sqrt_nonneg 2
  have hQe : 2 * (a - c) ^ 2 + 2 * c ^ 2 - (2 - r) * (a ^ 2 + 2 * c ^ 2)
      = r * (a - r * c) ^ 2 + (r ^ 2 - 2) * (2 * a * c - r * c ^ 2) := by ring
  rw [h2, h] at hQe
  nlinarith [mul_nonneg hr0 (sq_nonneg (a - r * c))]

/-- **The branch at `p = 14`.** With `T₁₆ ≥ min(4 − 2√3, 3T)` (the structure bound) and
`T₁₆ ≤ τ = 7 − √385/3 < 4 − 2√3`, the second branch holds: `3T ≤ T₁₆`. -/
theorem p14_branch (T16 T : ℝ) (hmin : min (4 - 2 * Real.sqrt 3) (3 * T) ≤ T16)
    (hτ : T16 ≤ 7 - Real.sqrt 385 / 3) : 3 * T ≤ T16 := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h385 : Real.sqrt 385 ^ 2 = 385 := Real.sq_sqrt (by norm_num)
  have hs3 : Real.sqrt 3 < 17321 / 10000 := by nlinarith [Real.sqrt_nonneg 3]
  have hs385 : 19621 / 1000 < Real.sqrt 385 := by nlinarith [Real.sqrt_nonneg 385]
  rcases min_le_iff.mp hmin with h | h
  · exfalso; linarith
  · exact h

/-- **`p = 14` threshold.** If `θ ≥ θ₀(12) = √(220/144)` then `κ = θ√28 ≥ √385/3`, so L249 gives
`T₁₆ = μ₃₈/2 ≤ 7 − κ ≤ τ`. -/
theorem p14_threshold (θ κ : ℝ) (hκ : κ = θ * Real.sqrt 28) (hθ : Real.sqrt (220 / 144) ≤ θ) :
    7 - κ ≤ 7 - Real.sqrt 385 / 3 := by
  have h28 : 0 ≤ Real.sqrt 28 := Real.sqrt_nonneg 28
  have heq : Real.sqrt (220 / 144) * Real.sqrt 28 = Real.sqrt 385 / 3 := by
    rw [← Real.sqrt_mul (by norm_num), show (220 / 144 : ℝ) * 28 = 385 / 9 by norm_num,
      Real.sqrt_div (by norm_num), show (9 : ℝ) = 3 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
  have : Real.sqrt (220 / 144) * Real.sqrt 28 ≤ κ := by
    rw [hκ]; exact mul_le_mul_of_nonneg_right hθ h28
  linarith

/-- **Small `p` at `n = 12`.** With `κ ≤ p − 2` (L249 at one element and the Gram row sum) and
`κ ≥ θ₀(12)√(2p)`, `p ≤ 6` is impossible: `(p − 2)² < (55/36)·2p` there. -/
theorem small_p_scalar (p : ℕ) (hp1 : 1 ≤ p) (hp : p ≤ 6) :
    ((p : ℝ) - 2) ^ 2 < 55 / 36 * (2 * p) := by
  interval_cases p <;> norm_num

/-- **`p = 7` at `n = 12`.** With `κ ≤ 1 + 2√3` (the largest sum of seven angle values is
`4 + 2√3`), `κ² < (55/36)·14 ≤ κ₀²` excludes `θ ≥ θ₀(12)`. -/
theorem p7_scalar : (1 + 2 * Real.sqrt 3) ^ 2 < 55 / 36 * 14 := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hs3 : Real.sqrt 3 < 17321 / 10000 := by nlinarith [Real.sqrt_nonneg 3]
  nlinarith [Real.sqrt_nonneg 3]

/-- **The per-element ceiling at every three-value spectrum, algebraic part.** With L248's row
combination equal to `(n−2)λ₂² − 2λ₂|λ₀| − λ₀² − |λ₀|θ` (hypothesis `hrows`, the three rows
combined), its `{0,1}` block at least `(λ₂−λ₁)²(b₀₀ + 2b₀₁ + b₁₁)` (the ordering), and
`2(b₀₀ + 2b₀₁ + b₁₁) ≥ μ` (Eckart–Young and interlacing, hypothesis `hμ`), the ceiling follows. -/
theorem general_ceiling (n θ l0 l1 l2 b00 b01 b11 μ S : ℝ) (h01 : l0 < l1) (h12 : l1 < l2)
    (hl0 : l0 < 0) (hb00 : 0 ≤ b00) (hb01 : 0 ≤ b01) (hb11 : 0 ≤ b11)
    (hS : S = (l0 - l2) ^ 2 * b00 + 2 * (l0 - l2) * (l1 - l2) * b01 + (l1 - l2) ^ 2 * b11)
    (hrows : S ≤ (n - 2) * l2 ^ 2 - 2 * l2 * (-l0) - l0 ^ 2 - (-l0) * θ)
    (hμ : μ ≤ 2 * (b00 + 2 * b01 + b11)) :
    (-l0) * θ ≤ (n - 2) * l2 ^ 2 - 2 * l2 * (-l0) - l0 ^ 2 - (l2 - l1) ^ 2 * μ / 2 := by
  have hd1 : 0 < l2 - l1 := by linarith
  have hd0 : l2 - l1 ≤ l2 - l0 := by linarith
  have k00 : (l2 - l1) ^ 2 * b00 ≤ (l0 - l2) ^ 2 * b00 := by
    apply mul_le_mul_of_nonneg_right _ hb00; nlinarith
  have k01 : (l2 - l1) ^ 2 * b01 ≤ (l0 - l2) * (l1 - l2) * b01 := by
    apply mul_le_mul_of_nonneg_right _ hb01; nlinarith
  have hsum : (l2 - l1) ^ 2 * (b00 + 2 * b01 + b11) ≤ S := by rw [hS]; nlinarith
  have hμ' : (l2 - l1) ^ 2 * μ / 2 ≤ (l2 - l1) ^ 2 * (b00 + 2 * b01 + b11) := by
    have := mul_le_mul_of_nonneg_left hμ (sq_nonneg (l2 - l1)); linarith
  linarith

/-- **The coupled fourth moment at every three-value spectrum.** At unit `x ∈ E₀` the Casimir
`R₀ + R₁ + R₂ = n − 2` and row (B) `λ₀R₀ + λ₁R₁ + λ₂R₂ = −λ₀` give `R₀`, and with the averaged
wedge identity and the moment formula,
`(p+2) E tr x⁴ + 4(λ₂−λ₁)/(λ₂−λ₀) E R₁ = 6 + 4(λ₀ + (n−2)λ₂)/(λ₂−λ₀) − 3‖Ω₀‖²/p`. -/
theorem general_coupled (n p E trA2 Om R0 R1 R2 l0 l1 l2 : ℝ) (hp : 0 < p) (h02 : l0 < l2)
    (hid : trA2 = 2 * p + 2 * p * R0 - Om) (hcas : R0 + R1 + R2 = n - 2)
    (hB : l0 * R0 + l1 * R1 + l2 * R2 = -l0)
    (hmom : p * (p + 2) * E = 2 * trA2 + 2 * p - Om) :
    (p + 2) * E + 4 * (l2 - l1) / (l2 - l0) * R1
      = 6 + 4 * (l0 + (n - 2) * l2) / (l2 - l0) - 3 * Om / p := by
  have hd : 0 < l2 - l0 := by linarith
  have hR0 : R0 * (l2 - l0) = l0 + (n - 2) * l2 - (l2 - l1) * R1 := by
    have hR2 : R2 = n - 2 - R0 - R1 := by linarith
    rw [hR2] at hB; nlinarith
  have hE : (p + 2) * E = 6 + 4 * R0 - 3 * Om / p := by
    have : p * ((p + 2) * E) = p * (6 + 4 * R0 - 3 * Om / p) := by
      rw [mul_sub, mul_div_assoc', mul_div_cancel_left₀ _ hp.ne']; nlinarith
    exact mul_left_cancel₀ hp.ne' this
  have hR0' : R0 = (l0 + (n - 2) * l2 - (l2 - l1) * R1) / (l2 - l0) := by
    rw [eq_div_iff hd.ne']; linarith
  rw [hE, hR0']; field_simp; ring

end HamiltonsCubic.CoupledMoment
