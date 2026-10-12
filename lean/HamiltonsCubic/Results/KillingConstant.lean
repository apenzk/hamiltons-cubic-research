import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# The Killing constant, its two normalisations, and a value that means two things

[algebra.md](../../../findings/algebra.md)'s boxed `κ_F(n) = (2n-1)(n-1)/4`. The closed form and
its anchoring at `n = 4` check out; the paragraph closing the block contains a collision and a
factor that is not what it looks like.

**`21/16` is two different quantities on the same page.** The block states that at `n = 4` the
formula gives `21/16` **in Fox's normalisation**, and four sentences later writes the balanced
`n = 8` value as *"`21/16 · 20 = 26.25`"*. That second `21/16` is **`θ₀(8)²`**, not the `n = 4`
Killing constant (`2·7·6/8² = 21/16`) and the two are unrelated. A reader carrying the first
reading finds a `κ_F(4)` where a `θ₀(8)²` stands.

**And the factor `3/2` is `θ²` at one point, not a universal constant.** The block writes
`κ = 3/2 · Σmᵢrᵢ²`. At `W_{ℂP²}` that is right because `θ² = 3/2` *there*; the general relation
is `κ = θ² · tr(L_e²)` at every unit critical point, from Fox's Theorem 1.3,
`tr(L_x L_y) = κ ⟨x, y⟩`, at `x = y = e = W/θ`. At the
balanced product in `n = 8` the same relation needs `θ₀(8)² = 21/16` in place of `3/2`, and that
substitution is exactly what the `21/16` above is doing, so the block uses the general form
while stating the special one.

**Both consistency checks pass.** `κ_F(4) = 21/4` Frobenius is `21/16` in Fox's, the metrics
differing by the recorded factor `4`; and `κ_F(8) = 105/4 = 26.25` agrees with `21/16 · 20`. The
multiplicities `(1,16,54,148,81)` sum to `300 = dim 𝒲₈`, so the point is `n = 8` as required.
-/

namespace HamiltonsCubic.KillingConstant

/-- `κ_F(n) = (2n-1)(n-1)/4` in the Frobenius normalisation. -/
def kappaF (n : ℚ) : ℚ := (2 * n - 1) * (n - 1) / 4

/-- Fox's normalisation, the metric being complete contraction, exactly `4×` Frobenius. -/
def kappaFox (n : ℚ) : ℚ := (2 * n - 1) * (n - 1) / 16

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
def theta0Sq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-! ## The normalisations differ by the recorded factor -/

theorem normalisations_differ_by_four (n : ℚ) : kappaF n = 4 * kappaFox n := by
  unfold kappaF kappaFox; ring

/-- **`κ_F(4) = 21/4` Frobenius, `21/16` in Fox's**, his Theorem 1.5(2). -/
theorem anchor_at_four : kappaF 4 = 21 / 4 ∧ kappaFox 4 = 21 / 16 := by
  refine ⟨by unfold kappaF; norm_num, by unfold kappaFox; norm_num⟩

/-! ## The collision at `21/16` -/

/-- **`θ₀(8)² = 21/16` as well**, and it is a different quantity from `κ_Fox(4)`. -/
theorem theta0_eight_is_also_21_16 : theta0Sq 8 = 21 / 16 := by unfold theta0Sq; norm_num

/-- **The two agree in value and in nothing else**: one is a Killing constant at `n = 4`, the
other a sphere-product value at `n = 8`, and the formulas disagree everywhere else, at `n = 6`
they are `55/16` and `10/9`. -/
theorem collision_is_accidental :
    kappaFox 4 = theta0Sq 8 ∧ kappaFox 6 = 55 / 16 ∧ theta0Sq 6 = 10 / 9
      ∧ kappaFox 6 ≠ theta0Sq 6 := by
  refine ⟨by unfold kappaFox theta0Sq; norm_num, by unfold kappaFox; norm_num,
    by unfold theta0Sq; norm_num, by unfold kappaFox theta0Sq; norm_num⟩

/-! ## The `n = 8` arithmetic -/

/-- **`κ_F(8) = 105/4 = 26.25`**, and `21/16 · 20` gives the same, with the `21/16` being
`θ₀(8)²` and the `20` being `tr(L_e²)` there. -/
theorem eight_value : kappaF 8 = 105 / 4 ∧ (21 / 16 : ℚ) * 20 = 105 / 4 := by
  refine ⟨by unfold kappaF; norm_num, by norm_num⟩

/-- **The relation is `κ = θ² · tr(L_e²)`**, so `tr(L_e²) = 20` at the balanced product in
`n = 8`. -/
theorem trace_at_eight : kappaF 8 / theta0Sq 8 = 20 := by
  unfold kappaF theta0Sq; norm_num

/-- The multiplicities sum to `dim 𝒲₈ = 300`, confirming the dimension. -/
theorem multiplicities_sum : 1 + 16 + 54 + 148 + 81 = 300 ∧ (8:ℚ) * 9 * 10 * 5 / 12 = 300 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## The `3/2` is `θ²` at one point -/

/-- **At `W_{ℂP²}` the relation gives `κ_F(4) = 3/2 · 7/2`**, and the `3/2` is `θ²` there, as
[L25](L25.lean) records with `tr L_e² = 7/2`. -/
theorem cp2_relation : (3 / 2 : ℚ) * (7 / 2) = 21 / 4 ∧ kappaF 4 = 21 / 4 := by
  refine ⟨by norm_num, by unfold kappaF; norm_num⟩

/-- **But `3/2` is not the factor at the balanced product**, where `θ₀(8)² = 21/16`, so the
stated form is the special case and `κ = θ²·tr(L_e²)` is the general one. -/
theorem three_halves_is_not_universal : (3 / 2 : ℚ) ≠ theta0Sq 8 := by
  unfold theta0Sq; norm_num

end HamiltonsCubic.KillingConstant
