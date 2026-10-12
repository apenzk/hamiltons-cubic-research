import HamiltonsCubic.Results.L35Residual

set_option linter.style.longLine false

/-!
# L35's two-variable relaxation: `R₂(A, d) ≤ √(3/2)` everywhere

[findings/stratum-two-negative.md](../../../findings/stratum-two-negative.md), Lemma L35, the middle of the proof
(transcribed from [REVIEW_r63](../../../reviews/REVIEW_r63.md) §(ii)): after decoupling, LP duality and three
elementary bounds, `G ≤ R(A, s, u)`, and monotonicity puts `R` on `b = c`, leaving
`R₂(A, u) = A³ + min(A, √d)d + min(A, K₀√d)(2 − 3u) − (2 − 2u)^{3/2}/4 + 3A(1 − u)`, `d = u − A²`.
**This file proves `R₂ ≤ √(3/2)` on the whole domain** `A > 0`, `d ≥ 0`, `A² + d ≤ 1`:

- `d ≥ 8A²/9`: both minima are at most `A`, `K₀√d ≥ A` makes the second one `A`, and `R₂ ≤ 5A(1 − u) − (2 − 2u)^{3/2}/4`,
  at most `6/5` under `17A²/9 ≤ u` (`region12`, the record's two regions at once, whose maxima are `1.017` and `1.068`);
- `d ≤ 8A²/9`: the minima are `√d` and `K₀√d`, the tangent line of `x^{3/2}` (`tangent32`) gives
  `R₂ ≤ g(A) + ψ(√d)`, and then [L35Residual.lean](L35Residual.lean)'s `L35_residual` at `A ≤ √(2/3)`, or at
  `A > √(2/3)` the signs `α ≤ 0`, `β < 0`, `γ < 0` and `g_beyond`, `g ≤ √(3/2)` past the endpoint, proved like the
  endpoint band on the other arc of the ellipse (`beyond_av`, `(m + 2)² C(m) ≥ 0` on `[−5, −2]`).
-/

namespace HamiltonsCubic.L35Residual

theorem region12 (A p : ℝ) (hA : 0 ≤ A) (hp : 0 ≤ p) (hc : A ^ 2 ≤ 9 / 17 * (1 - p ^ 2 / 2)) :
    5 / 2 * A * p ^ 2 - p ^ 3 / 4 ≤ 6 / 5 := by
  have hp2 : p ^ 2 ≤ 2 := by nlinarith
  have hA1 : A ≤ 3 / 4 := by nlinarith
  nlinarith [sq_nonneg (A - 12 / 25), sq_nonneg (p - 107 / 100), mul_nonneg hA hp, mul_nonneg (mul_nonneg hA hp) hp,
    sq_nonneg (A * p - 51 / 100), mul_nonneg hp (sq_nonneg (p - 107 / 100))]

theorem C_pos (m : ℝ) (h0 : -5 ≤ m) (h1 : m ≤ -2) :
    0 < 10 - 16 * m + 24 * m ^ 2 - 4 * m ^ 3 - m ^ 4 / 2 := by
  nlinarith [mul_nonneg (sub_nonneg.mpr h0) (sub_nonneg.mpr h1), sq_nonneg (m + 2), sq_nonneg (m + 7 / 2),
    mul_nonneg (mul_nonneg (sub_nonneg.mpr h0) (sub_nonneg.mpr h1)) (sq_nonneg m)]

theorem tangent32 (p r : ℝ) (hp : 0 ≤ p) (hr : 0 ≤ r) : r ^ 3 - 3 / 2 * r * (r ^ 2 - p ^ 2) ≤ p ^ 3 := by
  nlinarith [mul_nonneg (sq_nonneg (p - r)) (by linarith : 0 ≤ p + r / 2)]

/-- **`g` beyond the endpoint, on the ellipse**: `a ≥ 1`, `2a² + v² = 3`, `v ≥ 0` give
`a³ − v³/4 + (3/2)av² ≤ 9/4`, as `(m + 2)² C(m)/(m² + 2)³ ≥ 0` on `m ∈ [−5, −2]`. -/
theorem beyond_av (a v : ℝ) (hv : v ^ 2 = 3 - 2 * a ^ 2) (hv0 : 0 ≤ v) (ha : 1 ≤ a) :
    a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2 ≤ 9 / 4 := by
  rcases eq_or_lt_of_le ha with h1 | h1
  · subst h1
    have : v = 1 := by nlinarith
    subst this; norm_num
  · set m := (v - 1) / (a - 1) with hm
    have ha1' : a - 1 ≠ 0 := by linarith
    have hmv : v = 1 + m * (a - 1) := by rw [hm]; field_simp; ring
    have hD : 0 < m ^ 2 + 2 := by positivity
    have hquad : (a - 1) * (2 * (a + 1) + 2 * m + m ^ 2 * (a - 1)) = 0 := by
      have : 2 * a ^ 2 + (1 + m * (a - 1)) ^ 2 = 3 := by rw [← hmv]; linarith
      linear_combination this
    have hlin : 2 * (a + 1) + 2 * m + m ^ 2 * (a - 1) = 0 := (mul_eq_zero.mp hquad).resolve_left ha1'
    have ha' : a = (m ^ 2 - 2 * m - 2) / (m ^ 2 + 2) := by rw [eq_div_iff hD.ne']; linarith
    have hv' : v = (-m ^ 2 - 4 * m + 2) / (m ^ 2 + 2) := by rw [hmv, ha']; field_simp; ring
    have hpos : 0 < a - 1 := by linarith
    have hup : v ≤ 3 - 2 * a := by
      have h32 : 0 ≤ 3 - 2 * a := by nlinarith
      by_contra h
      push Not at h
      have := mul_self_lt_mul_self h32 h
      nlinarith
    have hlo : 6 - 5 * a ≤ v := by
      rcases le_or_gt (6 - 5 * a) 0 with h | h
      · linarith
      · nlinarith
    have hm1 : m ≤ -2 := by rw [hm, div_le_iff₀ hpos]; linarith
    have hm0 : -5 ≤ m := by rw [hm, le_div_iff₀ hpos]; linarith
    have hC := C_pos m hm0 hm1
    have key : 9 / 4 - (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2)
        = (m + 2) ^ 2 * (10 - 16 * m + 24 * m ^ 2 - 4 * m ^ 3 - m ^ 4 / 2) / (m ^ 2 + 2) ^ 3 := by
      rw [ha', hv']; field_simp; ring
    have : 0 ≤ (m + 2) ^ 2 * (10 - 16 * m + 24 * m ^ 2 - 4 * m ^ 3 - m ^ 4 / 2) / (m ^ 2 + 2) ^ 3 := by positivity
    linarith

/-- **`g ≤ √(3/2)` beyond the endpoint**: `A² ≥ 2/3`, `A ≤ 1`, in `(A, s, q, w)` with `w = √6/3`. -/
theorem g_beyond (A s q w : ℝ) (hq : q ^ 2 = 2) (hq0 : 0 < q) (hw : w ^ 2 = 2 / 3) (hw0 : 0 < w)
    (hs : s ^ 2 = 1 - A ^ 2) (hs0 : 0 ≤ s) (hA0 : 2 / 3 ≤ A ^ 2) (hA : 0 ≤ A) :
    A ^ 3 - s ^ 3 * q / 2 + 3 * A * s ^ 2 ≤ 3 * w / 2 := by
  set a := A / w with ha
  set v := q * s / w with hv
  have hAa : A = w * a := by rw [ha]; field_simp
  have hqs : q * s = w * v := by rw [hv]; field_simp
  have hv2 : v ^ 2 = 3 - 2 * a ^ 2 := by
    have h1 : (w * v) ^ 2 = 2 - 2 * (w * a) ^ 2 := by rw [← hqs, ← hAa, mul_pow, hq, hs]; ring
    rw [mul_pow, mul_pow, hw] at h1
    linarith
  have hv0 : 0 ≤ v := by rw [hv]; positivity
  have ha1 : 1 ≤ a := by
    have : w ≤ A := by nlinarith
    rw [ha, le_div_iff₀ hw0]; linarith
  have hG := beyond_av a v hv2 hv0 ha1
  have hg : A ^ 3 - s ^ 3 * q / 2 + 3 * A * s ^ 2 = w ^ 3 * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2) := by
    have e1 : s ^ 3 * q / 2 = (q * s) ^ 3 / (2 * q ^ 2) := by field_simp
    have e2 : 3 * A * s ^ 2 = 3 * A * (q * s) ^ 2 / q ^ 2 := by field_simp
    rw [e1, e2, hqs, hAa, hq]
    ring
  have hw3 : w ^ 3 = 2 / 3 * w := by rw [pow_succ, hw]
  rw [hg, hw3]
  nlinarith

/-- `R₂(A, d)`, REVIEW_r63's two-variable relaxation, `u = A² + d`. -/
noncomputable def R2 (A d : ℝ) : ℝ :=
  A ^ 3 + min A (Real.sqrt d) * d + min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) * (2 - 3 * (A ^ 2 + d))
    - (2 - 2 * (A ^ 2 + d)) * Real.sqrt (2 - 2 * (A ^ 2 + d)) / 4 + 3 * A * (1 - (A ^ 2 + d))

/-- **`R₂ ≤ √(3/2)`** on the whole domain `A > 0`, `d ≥ 0`, `A² + d ≤ 1`. -/
theorem R2_le (A d : ℝ) (hA : 0 < A) (hd : 0 ≤ d) (hu : A ^ 2 + d ≤ 1) : R2 A d ≤ Real.sqrt (3 / 2) := by
  set q := Real.sqrt 2 with hqdef
  have hq : q ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hq0 : 0 < q := Real.sqrt_pos.mpr (by norm_num)
  set t := Real.sqrt d with htdef
  have ht2 : t ^ 2 = d := Real.sq_sqrt hd
  have ht0 : 0 ≤ t := Real.sqrt_nonneg _
  set p := Real.sqrt (2 - 2 * (A ^ 2 + d)) with hpdef
  have hp2 : p ^ 2 = 2 - 2 * (A ^ 2 + d) := Real.sq_sqrt (by linarith)
  have hp0 : 0 ≤ p := Real.sqrt_nonneg _
  have hK : 3 / (2 * q) = 3 * q / 4 := by
    rw [div_eq_iff (by positivity)]; linear_combination (-3 / 2) * hq
  have hc65 : (6 / 5 : ℝ) ≤ Real.sqrt (3 / 2) := by
    rw [Real.le_sqrt (by norm_num) (by norm_num)]; norm_num
  unfold R2
  rw [← htdef, ← hpdef, hK]
  have hcube : (2 - 2 * (A ^ 2 + d)) * p = p ^ 3 := by rw [← hp2]; ring
  rw [hcube]
  rcases le_total (8 / 9 * A ^ 2) d with hreg | hreg
  · -- regions I and II
    have hKt : A ≤ 3 * q / 4 * t := by
      have h1 : A ^ 2 ≤ (3 * q / 4 * t) ^ 2 := by
        rw [mul_pow, div_pow, mul_pow, hq, ht2]; nlinarith
      nlinarith [sq_nonneg (A - 3 * q / 4 * t), mul_nonneg (by positivity : (0:ℝ) ≤ 3 * q / 4) ht0]
    rw [min_eq_left hKt]
    have hmin : min A t * d ≤ A * d := mul_le_mul_of_nonneg_right (min_le_left _ _) hd
    have hreg12 := region12 A p hA.le hp0 (by nlinarith)
    have e : A ^ 3 + A * d + A * (2 - 3 * (A ^ 2 + d)) - p ^ 3 / 4 + 3 * A * (1 - (A ^ 2 + d))
        = 5 / 2 * A * p ^ 2 - p ^ 3 / 4 := by rw [hp2]; ring
    linarith
  · -- region III
    have htA : t ≤ 2 * q / 3 * A := by
      have h1 : t ^ 2 ≤ (2 * q / 3 * A) ^ 2 := by rw [mul_pow, div_pow, mul_pow, hq, ht2]; nlinarith
      nlinarith [sq_nonneg (t - 2 * q / 3 * A), mul_nonneg (by positivity : (0:ℝ) ≤ 2 * q / 3) hA.le]
    have hq1 : q < 3 / 2 := by nlinarith
    have htA' : t ≤ A := by nlinarith
    have hKt : 3 * q / 4 * t ≤ A := by nlinarith
    rw [min_eq_right htA', min_eq_right hKt]
    have hA2 : A ^ 2 ≤ 1 := by nlinarith
    set s := Real.sqrt (1 - A ^ 2) with hsdef
    have hs : s ^ 2 = 1 - A ^ 2 := Real.sq_sqrt (by linarith)
    have hs0 : 0 ≤ s := Real.sqrt_nonneg _
    set r := q * s with hr
    have hr0 : 0 ≤ r := mul_nonneg hq0.le hs0
    have hr2 : r ^ 2 = 2 - 2 * A ^ 2 := by rw [hr, mul_pow, hq, hs]; ring
    have htan := tangent32 p r hp0 hr0
    have hrp : r ^ 2 - p ^ 2 = 2 * t ^ 2 := by rw [hr2, hp2, ht2]; ring
    rw [hrp] at htan
    -- R₂ ≤ g(A) + ψ(t)
    have hbound : A ^ 3 + t * d + 3 * q / 4 * t * (2 - 3 * (A ^ 2 + d)) - p ^ 3 / 4 + 3 * A * (1 - (A ^ 2 + d))
        ≤ (A ^ 3 - s ^ 3 * q / 2 + 3 * A * s ^ 2) + 3 * q / 4 * (2 - 3 * A ^ 2) * t
          + (3 / 4 * r - 3 * A) * t ^ 2 + (1 - 9 * q / 4) * t ^ 3 := by
      have e1 : r ^ 3 = 2 * q * s ^ 3 := by rw [hr, mul_pow, pow_succ q 2, hq]
      rw [← ht2]
      have key : ((A ^ 3 - s ^ 3 * q / 2 + 3 * A * s ^ 2) + 3 * q / 4 * (2 - 3 * A ^ 2) * t
          + (3 / 4 * r - 3 * A) * t ^ 2 + (1 - 9 * q / 4) * t ^ 3)
          - (A ^ 3 + t * t ^ 2 + 3 * q / 4 * t * (2 - 3 * (A ^ 2 + t ^ 2)) - p ^ 3 / 4 + 3 * A * (1 - (A ^ 2 + t ^ 2)))
          = (p ^ 3 - (r ^ 3 - 3 / 2 * r * (2 * t ^ 2))) / 4 := by
        linear_combination (1 / 4) * e1 + 3 * A * hs
      linarith
    rcases le_or_gt (A ^ 2) (2 / 3) with hA23 | hA23
    · have hres := L35_residual A t hA hA23 ht0 (by rw [← hqdef]; exact htA)
      have hF : HamiltonsCubic.L35c.g A + 3 / (2 * Real.sqrt 2) * (2 - 3 * A ^ 2) * t
          + (3 / 4 * Real.sqrt (2 - 2 * A ^ 2) - 3 * A) * t ^ 2 + (1 - 3 * (3 / (2 * Real.sqrt 2))) * t ^ 3
          = (A ^ 3 - s ^ 3 * q / 2 + 3 * A * s ^ 2) + 3 * q / 4 * (2 - 3 * A ^ 2) * t
            + (3 / 4 * r - 3 * A) * t ^ 2 + (1 - 9 * q / 4) * t ^ 3 := by
        have hqs : Real.sqrt (2 - 2 * A ^ 2) = r := by
          rw [hr, hqdef, hsdef, ← Real.sqrt_mul (by norm_num)]; congr 1; ring
        have e1 : (1 - A ^ 2) * s / q = s ^ 3 * q / 2 := by
          rw [← hs, div_eq_iff hq0.ne']; linear_combination (-(s ^ 3) / 2) * hq
        rw [← hqdef, hK, hqs]
        unfold HamiltonsCubic.L35c.g
        rw [← hqdef, ← hsdef, e1, ← hs]
        ring
      linarith
    · -- beyond the endpoint: ψ ≤ 0 and g ≤ √(3/2)
      obtain ⟨w, hwdef⟩ : ∃ w : ℝ, w = Real.sqrt 6 / 3 := ⟨_, rfl⟩
      have hw : w ^ 2 = 2 / 3 := by rw [hwdef, div_pow, Real.sq_sqrt (by norm_num)]; norm_num
      have hw0 : 0 < w := by rw [hwdef]; positivity
      have hg := g_beyond A s q w hq hq0 hw hw0 hs hs0 hA23.le hA.le
      have hcw : 3 * w / 2 = Real.sqrt (3 / 2) := by rw [hwdef, ← HamiltonsCubic.L35c.sqrt_six_half]; ring
      have hal : 3 * q / 4 * (2 - 3 * A ^ 2) * t ≤ 0 :=
        mul_nonpos_of_nonpos_of_nonneg (mul_nonpos_of_nonneg_of_nonpos (by positivity) (by linarith)) ht0
      have hr1 : r < 1 := by
        have h : r ^ 2 < 1 ^ 2 := by rw [hr2]; linarith
        exact lt_of_pow_lt_pow_left₀ 2 (by norm_num) h
      have hA8 : 4 / 5 < A := by
        have h : (4 / 5 : ℝ) ^ 2 < A ^ 2 := by linarith
        exact lt_of_pow_lt_pow_left₀ 2 hA.le h
      have hbe : (3 / 4 * r - 3 * A) * t ^ 2 ≤ 0 :=
        mul_nonpos_of_nonpos_of_nonneg (by linarith) (sq_nonneg t)
      have hga : (1 - 9 * q / 4) * t ^ 3 ≤ 0 :=
        mul_nonpos_of_nonpos_of_nonneg (by nlinarith) (pow_nonneg ht0 3)
      clear_value s r t p q
      exact le_trans hbound (by linarith only [hg, hcw, hal, hbe, hga])

end HamiltonsCubic.L35Residual
