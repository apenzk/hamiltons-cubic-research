import HamiltonsCubic.Results.L35ResidualMid
import HamiltonsCubic.Results.L35c

set_option linter.style.longLine false

/-!
# L35's residual inequality, closed in the kernel

[findings/stratum-two-negative.md](../../../findings/stratum-two-negative.md), Lemma L35, the residual gap: on
`A ∈ (0, √(2/3)]` and `0 ≤ t ≤ (2√2/3)A`,
`g(A) + αt + βt² + γt³ ≤ √(3/2)`, with `g(A) = A³ − (1 − A²)^{3/2}/√2 + 3A(1 − A²)`, `α = K₀(2 − 3A²)`,
`β = (3/4)√(2 − 2A²) − 3A`, `γ = 1 − 3K₀`, `K₀ = 3/(2√2)`. The record closes it by 200-bit interval arithmetic
on `(1/3, 0.7096]` and bisection near the endpoint. **This file proves it** in three bands:

- `band1`, `(0, 1/3]`: `β ≥ 0` there, so `t` goes to the cap, the cubic drops, and the capped value
  `5A − 23A³/3 + √(2 − 2A²)(7A²/6 − 1/2)` is at most `8/9`, the record's closed form;
- `middle`, `[1/3, 0.6733]`: 32 pieces of rational interval arithmetic ([L35ResidualMid.lean](L35ResidualMid.lean));
- `endpoint_band`, `[0.6733, √(2/3)]`: drop the cubic, bound `αt + βt² ≤ α²/(−4β)` at `β < 0`, and scale
  `A = wa`, `√(2 − 2A²) = wv`, `w = √6/3`, onto the ellipse `2a² + v² = 3`. Parametrised through the tangent point
  `(1, 1)` by `a = (m² − 2m − 2)/(m² + 2)`, the inequality is `(m + 2)² Q(m)/(m² + 2)⁴ ≥ 0` with `Q > 0` on
  `[−2, −8/5]` (`Q_pos`, `endpoint_param`), the double root at `m = −2` being the equality at `A = √(2/3)`, `t = 0`.

**`L35_residual`** assembles them in the record's own variables.
-/

namespace HamiltonsCubic.L35Residual


theorem band1 (A s q t : ℝ) (hq : q ^ 2 = 2) (hq0 : 0 < q) (hs : s ^ 2 = 1 - A ^ 2) (hs0 : 0 ≤ s)
    (hA0 : 0 < A) (hA1 : A ≤ 1 / 3) (ht0 : 0 ≤ t) (ht1 : t ≤ 2 * q / 3 * A) :
    Fres A s q t ≤ 8 / 9 := by
  unfold Fres
  have hq2 : 7 / 5 < q := by nlinarith
  have hqs2 : (q * s) ^ 2 = 2 - 2 * A ^ 2 := by rw [mul_pow, hq, hs]; ring
  have hqs0 : 0 ≤ q * s := mul_nonneg hq0.le hs0
  have hqs : 4 / 3 ≤ q * s := by nlinarith
  have hbeta : 0 ≤ 3 / 4 * q * s - 3 * A := by nlinarith
  have halpha : 0 ≤ 3 * q / 4 * (2 - 3 * A ^ 2) := by nlinarith
  have hgam : 1 - 9 * q / 4 ≤ 0 := by nlinarith
  -- drop the cubic and push `t` to the cap
  have hT : 3 * q / 4 * (2 - 3 * A ^ 2) * t + (3 / 4 * q * s - 3 * A) * t ^ 2 + (1 - 9 * q / 4) * t ^ 3
      ≤ 3 * q / 4 * (2 - 3 * A ^ 2) * (2 * q / 3 * A) + (3 / 4 * q * s - 3 * A) * (2 * q / 3 * A) ^ 2 := by
    have h1 := mul_le_mul_of_nonneg_left ht1 halpha
    have h2 : t ^ 2 ≤ (2 * q / 3 * A) ^ 2 := pow_le_pow_left₀ ht0 ht1 2
    have h3 := mul_le_mul_of_nonneg_left h2 hbeta
    have h4 : (1 - 9 * q / 4) * t ^ 3 ≤ 0 := mul_nonpos_of_nonpos_of_nonneg hgam (by positivity)
    linarith
  -- the capped value is `5A − 23A³/3 + qs(7A²/6 − 1/2)`
  have hcap : A ^ 3 - s ^ 3 * q / 2 + 3 * A * s ^ 2 + (3 * q / 4 * (2 - 3 * A ^ 2) * (2 * q / 3 * A)
      + (3 / 4 * q * s - 3 * A) * (2 * q / 3 * A) ^ 2)
      = 5 * A - 23 / 3 * A ^ 3 + (q * s) * (7 / 6 * A ^ 2 - 1 / 2) := by
    have : s ^ 3 * q = (q * s) * s ^ 2 := by ring
    rw [this, hs]
    have e : (2 * q / 3 * A) ^ 2 = 8 / 9 * A ^ 2 := by rw [mul_pow, div_pow, mul_pow, hq]; ring
    rw [e]
    have e2 : 3 * q / 4 * (2 - 3 * A ^ 2) * (2 * q / 3 * A) = A * (2 - 3 * A ^ 2) := by
      have : q * q = 2 := by nlinarith
      linear_combination (A * (2 - 3 * A ^ 2) / 2) * this
    rw [e2]; ring
  have hneg : 7 / 6 * A ^ 2 - 1 / 2 ≤ 0 := by nlinarith
  have hlow : (q * s) * (7 / 6 * A ^ 2 - 1 / 2) ≤ 4 / 3 * (7 / 6 * A ^ 2 - 1 / 2) :=
    mul_le_mul_of_nonpos_right hqs hneg
  have hpoly : 5 * A - 23 / 3 * A ^ 3 + 4 / 3 * (7 / 6 * A ^ 2 - 1 / 2) ≤ 8 / 9 := by
    nlinarith [mul_nonneg hA0.le (sub_nonneg.mpr hA1), mul_nonneg (mul_nonneg hA0.le hA0.le) (sub_nonneg.mpr hA1),
      sq_nonneg (A - 1 / 3)]
  linarith


/-- The endpoint polynomial's cofactor is positive on the arc `m ∈ [−2, −8/5]`. -/
theorem Q_pos (m : ℝ) (h0 : -2 ≤ m) (h1 : m ≤ -8 / 5) :
    0 < -400 / 3 + 160 * m - 240 * m ^ 2 - 112 / 3 * m ^ 3 + 116 * m ^ 4 - 24 * m ^ 5 - 10 / 3 * m ^ 6 := by
  nlinarith [mul_nonneg (sub_nonneg.mpr h0) (sub_nonneg.mpr h1), sq_nonneg (m + 2), sq_nonneg (m + 9 / 5),
    mul_nonneg (mul_nonneg (sub_nonneg.mpr h0) (sub_nonneg.mpr h1)) (sq_nonneg m),
    pow_two_nonneg (m ^ 2), mul_nonneg (sub_nonneg.mpr h0) (sq_nonneg (m ^ 2))]

/-- **The endpoint band, parametrised**: at `a = (m² − 2m − 2)/(m² + 2)`, `v = (−m² − 4m + 2)/(m² + 2)`, the
relaxed inequality is `(m + 2)² Q(m) / (m² + 2)⁴ ≥ 0`. -/
theorem endpoint_param (m : ℝ) (h0 : -2 ≤ m) (h1 : m ≤ -8 / 5) :
    let a := (m ^ 2 - 2 * m - 2) / (m ^ 2 + 2)
    let v := (-m ^ 2 - 4 * m + 2) / (m ^ 2 + 2)
    (9 / 8) * (2 - 2 * a ^ 2) ^ 2
      ≤ (2 / 3) * (3 / 2 - (2 / 3) * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2)) * (12 * a - 3 * v) := by
  intro a v
  have hD : 0 < m ^ 2 + 2 := by positivity
  have hQ := Q_pos m h0 h1
  have key : (2 / 3) * (3 / 2 - (2 / 3) * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2)) * (12 * a - 3 * v)
      - (9 / 8) * (2 - 2 * a ^ 2) ^ 2
      = (m + 2) ^ 2 * (-400 / 3 + 160 * m - 240 * m ^ 2 - 112 / 3 * m ^ 3 + 116 * m ^ 4 - 24 * m ^ 5
          - 10 / 3 * m ^ 6) / (m ^ 2 + 2) ^ 4 := by
    simp only [a, v]
    field_simp
    ring
  have : 0 ≤ (m + 2) ^ 2 * (-400 / 3 + 160 * m - 240 * m ^ 2 - 112 / 3 * m ^ 3 + 116 * m ^ 4 - 24 * m ^ 5
          - 10 / 3 * m ^ 6) / (m ^ 2 + 2) ^ 4 := by positivity
  linarith


/-- **The endpoint band in `(a, v)`**: `2a² + v² = 3`, `v ≥ 0`, `a ∈ [47/57, 1]`. -/
theorem endpoint_av (a v : ℝ) (hv : v ^ 2 = 3 - 2 * a ^ 2) (hv0 : 0 ≤ v) (ha0 : 47 / 57 ≤ a) (ha1 : a ≤ 1) :
    (9 / 8) * (2 - 2 * a ^ 2) ^ 2
      ≤ (2 / 3) * (3 / 2 - (2 / 3) * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2)) * (12 * a - 3 * v) := by
  rcases eq_or_lt_of_le ha1 with h1 | h1
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
    have ha : a = (m ^ 2 - 2 * m - 2) / (m ^ 2 + 2) := by
      rw [eq_div_iff hD.ne']; linarith
    have hv' : v = (-m ^ 2 - 4 * m + 2) / (m ^ 2 + 2) := by
      rw [hmv, ha]; field_simp; ring
    -- the range of `m`
    have hneg : a - 1 < 0 := by linarith
    have hup : v ≤ 3 - 2 * a := by nlinarith
    have hlo : 1 + 8 / 5 * (1 - a) ≤ v := by
      have h2 : (1 + 8 / 5 * (1 - a)) ^ 2 ≤ v ^ 2 := by rw [hv]; nlinarith
      nlinarith [sq_nonneg (v - (1 + 8 / 5 * (1 - a)))]
    have hm0 : -2 ≤ m := by
      rw [hm, le_div_iff_of_neg hneg]; linarith
    have hm1 : m ≤ -8 / 5 := by
      rw [hm, div_le_iff_of_neg hneg]; linarith
    have := endpoint_param m hm0 hm1
    simp only at this
    rw [ha, hv']
    exact this


/-- **The endpoint band in the record's variables**: `A ∈ [0.6733, w]`, `w = √6/3`, bound `3w/2 = √(3/2)`. -/
theorem endpoint_band (A s q w t : ℝ) (hq : q ^ 2 = 2) (hq0 : 0 < q) (hw : w ^ 2 = 2 / 3) (hw0 : 0 < w)
    (hs : s ^ 2 = 1 - A ^ 2) (hs0 : 0 ≤ s) (hA0 : 6733 / 10000 ≤ A) (hA1 : A ≤ w) (ht0 : 0 ≤ t) :
    Fres A s q t ≤ 3 * w / 2 := by
  unfold Fres
  have hw1 : w ≤ 8165 / 10000 := by nlinarith
  set a := A / w with ha
  set v := q * s / w with hv
  have hAa : A = w * a := by rw [ha]; field_simp
  have hqs : q * s = w * v := by rw [hv]; field_simp
  have hv2 : v ^ 2 = 3 - 2 * a ^ 2 := by
    have h1 : (w * v) ^ 2 = 2 - 2 * (w * a) ^ 2 := by rw [← hqs, ← hAa, mul_pow, hq, hs]; ring
    rw [mul_pow, mul_pow, hw] at h1
    linarith
  have hv0 : 0 ≤ v := by rw [hv]; positivity
  have ha1 : a ≤ 1 := by rw [ha, div_le_one hw0]; exact hA1
  have ha0 : 47 / 57 ≤ a := by rw [ha, le_div_iff₀ hw0]; nlinarith
  have hkey := endpoint_av a v hv2 hv0 ha0 ha1
  -- β < 0 and the quadratic bound
  have hbeta : 3 / 4 * q * s - 3 * A = w * (3 / 4 * v - 3 * a) := by rw [mul_assoc, hqs, hAa]; ring
  have hbneg : 3 / 4 * v - 3 * a < 0 := by nlinarith
  have hgam : 1 - 9 * q / 4 ≤ 0 := by nlinarith
  have hcubic : (1 - 9 * q / 4) * t ^ 3 ≤ 0 := mul_nonpos_of_nonpos_of_nonneg hgam (pow_nonneg ht0 3)
  set al := 3 * q / 4 * (2 - 3 * A ^ 2)
  have hal2 : al ^ 2 = 9 / 8 * (2 - 2 * a ^ 2) ^ 2 := by
    have e : al ^ 2 = 9 * q ^ 2 / 16 * (2 - 3 * A ^ 2) ^ 2 := by simp only [al]; ring
    rw [e, hq, hAa, mul_pow, hw]; ring
  have hB : 0 < w * (12 * a - 3 * v) := by nlinarith
  -- αt + βt² ≤ α²/(−4β)
  have hquad : 4 * (w * (3 * a - 3 / 4 * v)) * (al * t + w * (3 / 4 * v - 3 * a) * t ^ 2) ≤ al ^ 2 := by
    nlinarith [sq_nonneg (al - 2 * (w * (3 * a - 3 / 4 * v)) * t)]
  -- g in (a, v)
  have hg : A ^ 3 - s ^ 3 * q / 2 + 3 * A * s ^ 2
      = w ^ 3 * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2) := by
    have e1 : s ^ 3 * q / 2 = (q * s) ^ 3 / (2 * q ^ 2) := by field_simp
    have e2 : 3 * A * s ^ 2 = 3 * A * (q * s) ^ 2 / q ^ 2 := by field_simp
    rw [e1, e2, hqs, hAa, hq]
    ring
  have hw3 : w ^ 3 = 2 / 3 * w := by rw [pow_succ, hw]
  rw [hbeta, hg]
  -- combine: 4w(3a − 3v/4) = w(12a − 3v)
  have hfin : w * (12 * a - 3 * v) * (w ^ 3 * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2)
      + al * t + w * (3 / 4 * v - 3 * a) * t ^ 2) ≤ w * (12 * a - 3 * v) * (3 * w / 2) := by
    have e : w * (12 * a - 3 * v) * (3 * w / 2) - w * (12 * a - 3 * v) * (w ^ 3 * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2))
        = (2 / 3) * (3 / 2 - (2 / 3) * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2)) * (12 * a - 3 * v) := by
      linear_combination (12 * a - 3 * v) * (3 / 2 - (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2) * (w ^ 2 + 2 / 3)) * hw
    have hX : w * (12 * a - 3 * v) = 4 * (w * (3 * a - 3 / 4 * v)) := by ring
    have h1 : w * (12 * a - 3 * v) * (al * t + w * (3 / 4 * v - 3 * a) * t ^ 2) ≤ al ^ 2 := by rw [hX]; exact hquad
    have hsplit : w * (12 * a - 3 * v) * (w ^ 3 * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2)
        + al * t + w * (3 / 4 * v - 3 * a) * t ^ 2)
        = w * (12 * a - 3 * v) * (w ^ 3 * (a ^ 3 - v ^ 3 / 4 + 3 / 2 * a * v ^ 2))
          + w * (12 * a - 3 * v) * (al * t + w * (3 / 4 * v - 3 * a) * t ^ 2) := by ring
    linarith [h1, hal2, hkey, e, hsplit]
  have := le_of_mul_le_mul_left hfin hB
  linarith

/-- **L35'S RESIDUAL INEQUALITY**, in the record's variables. -/
theorem L35_residual (A t : ℝ) (hA0 : 0 < A) (hA1 : A ^ 2 ≤ 2 / 3) (ht0 : 0 ≤ t)
    (ht1 : t ≤ 2 * Real.sqrt 2 / 3 * A) :
    HamiltonsCubic.L35c.g A + 3 / (2 * Real.sqrt 2) * (2 - 3 * A ^ 2) * t
      + (3 / 4 * Real.sqrt (2 - 2 * A ^ 2) - 3 * A) * t ^ 2 + (1 - 3 * (3 / (2 * Real.sqrt 2))) * t ^ 3
      ≤ Real.sqrt (3 / 2) := by
  set q := Real.sqrt 2 with hqdef
  have hq : q ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hq0 : 0 < q := Real.sqrt_pos.mpr (by norm_num)
  set s := Real.sqrt (1 - A ^ 2) with hsdef
  have hA1' : A ^ 2 ≤ 1 := by linarith
  have hs : s ^ 2 = 1 - A ^ 2 := Real.sq_sqrt (by linarith)
  have hs0 : 0 ≤ s := Real.sqrt_nonneg _
  have hqs : Real.sqrt (2 - 2 * A ^ 2) = q * s := by
    rw [hqdef, hsdef, ← Real.sqrt_mul (by norm_num)]; congr 1; ring
  have hF : HamiltonsCubic.L35c.g A + 3 / (2 * q) * (2 - 3 * A ^ 2) * t
      + (3 / 4 * Real.sqrt (2 - 2 * A ^ 2) - 3 * A) * t ^ 2 + (1 - 3 * (3 / (2 * q))) * t ^ 3 = Fres A s q t := by
    have e1 : (1 - A ^ 2) * s / q = s ^ 3 * q / 2 := by
      rw [← hs, div_eq_iff hq0.ne']; linear_combination (-(s ^ 3) / 2) * hq
    have e2 : 3 / (2 * q) = 3 * q / 4 := by
      rw [div_eq_iff (by positivity)]; linear_combination (-3 / 2) * hq
    unfold HamiltonsCubic.L35c.g Fres
    rw [hqs, e2, e1, ← hs]
    ring
  rw [hF]
  have hc : (122474 / 100000 : ℝ) ≤ Real.sqrt (3 / 2) := by
    rw [Real.le_sqrt (by norm_num) (by norm_num)]; norm_num
  have hq1 : (141421 / 100000 : ℝ) ≤ q := by nlinarith
  have hq2 : q ≤ (70711 / 50000 : ℝ) := by nlinarith
  rcases le_or_gt A (1 / 3) with h1 | h1
  · have := band1 A s q t hq hq0 hs hs0 hA0 h1 ht0 ht1
    have : (8 / 9 : ℝ) ≤ Real.sqrt (3 / 2) := by
      rw [Real.le_sqrt (by norm_num) (by norm_num)]; norm_num
    linarith
  rcases le_or_gt A (6733 / 10000) with h2 | h2
  · have := middle A s q t hq1 hq2 hs hs0 h1.le h2 ht0 ht1
    linarith
  · set w := Real.sqrt 6 / 3 with hwdef
    have hw : w ^ 2 = 2 / 3 := by rw [hwdef, div_pow, Real.sq_sqrt (by norm_num)]; norm_num
    have hw0 : 0 < w := by positivity
    have hAw : A ≤ w := by nlinarith
    have := endpoint_band A s q w t hq hq0 hw hw0 hs hs0 h2.le hAw ht0
    have hcw : 3 * w / 2 = Real.sqrt (3 / 2) := by
      rw [hwdef, ← HamiltonsCubic.L35c.sqrt_six_half]; ring
    linarith

end HamiltonsCubic.L35Residual
