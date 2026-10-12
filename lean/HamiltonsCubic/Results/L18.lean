import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L18, the unregistered threshold, the understated price, and a window shared with L13

[problem.md](../../../findings/problem.md)'s Lemma L18, split at audit into an unconditional
pricing lemma and an observation on two grants. The geometry stays imported; each numerical
claim the audit questions is settled here.

**`θ̃₀(n)` is `Θₙ`.** The audit screens `θ̃₀(13) = 1.2483756` and reports it digit-for-digit
equal to `Θ₁₃`. It is: `Θₙ² = 2(n-1)(n-3)/((n-2)(n+1))` gives `120/77` at `n = 13`, and
`1.2483755² < 120/77 < 1.2483757²`. So the threshold carrying this result is the record's own
odd-`n` formula under a third name, and `θ̃₀`, `θ̂₀` and `Θₙ` are one object.

**The window this block measures is the quantity [L13](L13.lean) divides by.** L18 reports
*"a window of width `0.011` at `n = 12`"*; that width is `θ₀(12) - √(3/2)`, and L13's disputed
excess figure is `(bound - θ₀)/(θ₀ - √(3/2))`, the same difference, as denominator. **Two
blocks in two files turn on one number**, and neither names the other. The width is `0.0112`
to three places, bracketed below without taking a root.

**The stated price is the numerator of a larger quantity.** The chain penalty is
`(J₄ - J₅)/√(1-e²)`; the block quotes `J₄ - J₅` and never mentions `e`, then draws a dichotomy
needing the divided form. Since `0 < 1-e² < 1` whenever `e ≠ 0`, the divided form is strictly
larger, so the quoted cost understates it, in the direction that makes the dichotomy easier.

**And *"one exactly-priced term"* is three entries.** The source records a second `24δ²`
alongside a favourable `-6.4δ²`, so the net is `208/5 · δ²` against the block's `24δ²`, a
factor `26/15`, larger by two thirds.
-/

namespace HamiltonsCubic.PricedTerm

/-! ## `θ̃₀(n)` is `Θₙ` -/

/-- `Θₙ² = 2(n-1)(n-3)/((n-2)(n+1))` at odd `n`. -/
def ThetaOddSq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1))

/-- **At `n = 13` it is `120/77`.** -/
theorem theta_thirteen_sq : ThetaOddSq 13 = 120 / 77 := by unfold ThetaOddSq; norm_num

/-- **And its root is the screened `1.2483756`**, bracketed by squaring. -/
theorem theta_thirteen_bracket :
    ((12483755 : ℚ) / 10000000) ^ 2 < 120 / 77
      ∧ (120 : ℚ) / 77 < ((12483757 : ℚ) / 10000000) ^ 2 := by
  constructor <;> norm_num

/-! ## The window, and L13's denominator -/

/-- `θ₀(12)² = 55/36`. -/
theorem theta0_twelve_sq : 2 * (12 - 1 : ℚ) * (12 - 2) / 12 ^ 2 = 55 / 36 := by norm_num

/-- **The window `θ₀(12) - √(3/2)` has width between `0.0112` and `0.0113`**, this block's
`0.011`, and the denominator [L13](L13.lean) divides by. -/
theorem window_width {t s : ℚ}
    (ht1 : (1236033 : ℚ) / 1000000 < t) (ht2 : t < (1236034 : ℚ) / 1000000)
    (hs1 : (1224744 : ℚ) / 1000000 < s) (hs2 : s < (1224745 : ℚ) / 1000000) :
    (112 : ℚ) / 10000 < t - s ∧ t - s < (113 : ℚ) / 10000 := by
  constructor <;> linarith

/-! ## The quoted cost is the numerator of a larger quantity -/

/-- **Dividing by `√(1-e²)` strictly increases a positive cost whenever `e ≠ 0`.** Stated on
squares, so no root is taken: `x²/(1-e²) > x²`. -/
theorem divided_form_is_larger {x e : ℚ} (hx : 0 < x) (he : 0 < e) (he1 : e < 1) :
    x ^ 2 < x ^ 2 / (1 - e ^ 2) := by
  have hd : (0 : ℚ) < 1 - e ^ 2 := by nlinarith
  rw [lt_div_iff₀ hd]
  nlinarith [mul_pos (pow_pos hx 2) (pow_pos he 2)]

/-- So quoting the numerator alone understates the penalty, in the direction that makes the
dichotomy easier to satisfy. -/
theorem understates_in_the_easy_direction {x e : ℚ} (hx : 0 < x) (he : 0 < e) (he1 : e < 1) :
    x ^ 2 ≠ x ^ 2 / (1 - e ^ 2) :=
  ne_of_lt (divided_form_is_larger hx he he1)

/-! ## The constant `24`, and the three entries -/

/-- **`Alt(|W|) = 2 Alt(W₋)` because `Alt(W) = 0`**, so the norm picks up `2² = 4` and
`tr D = 6 · 4 δ² = 24 δ²`. The constant is right. -/
theorem constant_twentyfour : 2 ^ 2 = 4 ∧ 6 * 4 = 24 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **But the source records three entries, not one**: a second `24δ²` with a favourable
`-6.4δ²` beside it, netting `208/5`. -/
theorem three_entries_net : (24 : ℚ) + 24 - 32 / 5 = 208 / 5 := by norm_num

/-- **Against the block's `24` that is a factor `26/15`**, larger by two thirds. -/
theorem understated_by : (208 / 5 : ℚ) / 24 = 26 / 15 ∧ (26 : ℚ) / 15 - 1 = 11 / 15 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.PricedTerm
