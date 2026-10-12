import HamiltonsCubic.Results.L42b

/-!
# L35's closing lemma is L42's dual weight, and two of its elementary bounds

[L35](../../../findings/stratum-two-negative.md)'s proof says, in its own words:

> **The closing lemma is the sharp dual weight.** For a triple of positives the dual
> `z_{αβ} = μ · (3/2) λ_α λ_β` is feasible exactly when `μ` is at least the triple's
> harmonic mean, so the binding value is `h`, the harmonic mean of the three largest
> positives, and `3M(λ_P) ≤ h (s² - u)`. With `h ≤ min(λ₁, (3/(2√2))√d)` and two further
> elementary bounds, …

**That is [L42](../../../results.md), quoted inside L35.** The feasibility half is
already checked in [L42b.lean](HamiltonsCubic/Results/L42b.lean); this file adds the
elementary bound `h ≤ λ₁` that L35 then uses, and checks the two region caps against the
target.

Everything is `linarith` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.L35d

open HamiltonsCubic.L42

/-- **`h ≤ λ₁`**: the harmonic mean of a triple never exceeds its largest entry. This is
the first of the two bounds L35 puts on the dual weight. -/
theorem harmMean_le_max {a b c : ℚ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hab : a ≤ c) (hbc : b ≤ c) :
    harmMean a b c ≤ c := by
  have hpos : 0 < a * b + a * c + b * c := by positivity
  rw [harmMean, div_le_iff₀ hpos]
  nlinarith [mul_pos ha hb, mul_pos ha hc, mul_pos hb hc,
             mul_nonneg (mul_nonneg ha.le hb.le) (sub_nonneg.mpr hab),
             mul_nonneg (mul_nonneg ha.le hb.le) (sub_nonneg.mpr hbc)]

/-- And it is at least the smallest entry, so the dual weight sits inside the triple's
own range, which is why bounding it by `λ₁` loses nothing at the binding triple. -/
theorem min_le_harmMean {a b c : ℚ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hab : a ≤ b) (hac : a ≤ c) :
    a ≤ harmMean a b c := by
  have hpos : 0 < a * b + a * c + b * c := by positivity
  rw [harmMean, le_div_iff₀ hpos]
  nlinarith [mul_pos hb hc, mul_nonneg ha.le (sub_nonneg.mpr hab),
             mul_nonneg ha.le (sub_nonneg.mpr hac),
             mul_nonneg (mul_nonneg ha.le ha.le) (sub_nonneg.mpr hab)]

/-! ## The three regions, against the target

L35 closes `(1/3, 0.7096]` by interval arithmetic and reports the regions capped at
`1.017217` and `1.067666`, with an envelope whose maximum is exactly `√(3/2)` at
`A = √(2/3)`. **Whether those caps clear the target is arithmetic**, whatever produced
them: both are below `√(3/2)`, and with room.
-/

theorem region_cap_one : (1.017217 : ℚ) ^ 2 < 3 / 2 := by norm_num

theorem region_cap_two : (1.067666 : ℚ) ^ 2 < 3 / 2 := by norm_num

/-- Neither cap is close to the target: both are below `1.14`, against `√(3/2) > 1.22`. -/
theorem caps_have_room : (1.067666 : ℚ) ^ 2 < 1.14 ∧ (1.22 : ℚ) ^ 2 < 3 / 2 := by
  constructor <;> norm_num

/-- The envelope's maximum is the target exactly, at `A² = 2/3`: `A = √(2/3)` gives
`F² = 3/2`, the same value [L61b.lean](HamiltonsCubic/Results/L61b.lean) shows is
two-sided and [L62.lean](HamiltonsCubic/Results/L62.lean) reaches from `W₀`'s spectrum. -/
theorem envelope_target : (2 / 3 : ℚ) * (3 / 2) ^ 2 = 3 / 2 := by norm_num

/-! ## What this settles

**Settled**: that L35's closing lemma is L42's, so its feasibility half needs no separate
work; the bound `h ≤ λ₁`, and that the dual weight lies inside the triple's own range;
and that both reported region caps clear the target with room.

**Owed**: the `200`-bit interval arithmetic on `(1/3, 0.7096]`, `73` adaptive boxes and
`21` more, which is the one part of this record that a kernel would check better than a
person, and which needs the function written down in Lean before any of it can run.
**That is the real content of L35's `blocked` row**, and the two caps above are its
reported outputs rather than its argument.
-/

end HamiltonsCubic.L35d
