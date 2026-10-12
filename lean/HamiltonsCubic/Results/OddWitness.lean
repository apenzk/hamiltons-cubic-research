import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L20's final step at odd `n`, a second threshold polynomial

[route-a.md](../../../findings/route-a.md)'s Lemma L20. Its index row records two gaps; the
radius is settled in [TubeRadius](TubeRadius.lean), which derives the cubic `s³+s²+s=1` and
brackets its root. **This file carries only the other gap**: *"its final step's witness does not
exist at odd `n`"*.

**The witness exists, under `Θₙ` rather than `θ₀(n)`.** The step needs a unit Weyl operator above
`√(3/2)`. At odd `n` the balanced product carries `Θₙ`, not `θ₀(n)`, so the witness *as written*
is unavailable, which is the row's complaint, and correct. But `Θₙ² > 3/2` clears to

`n² - 13n + 18 > 0`,

negative at `n = 11` and positive at `n = 12`. So a witness exists at **every** `n ≥ 12` in both
parities, and the lemma's conclusion is unaffected once the constant is corrected, the same
repair [L0](L0.lean) makes for the biconditional.

**And this is a different polynomial from the record's `n² - 12n + 8`.** They differ by `10 - n`
and have discriminants `97` against `112`, so their roots are `(13±√97)/2 ≈ 11.42` and
`6±2√7 ≈ 11.29`. Both cross between `11` and `12`, so the threshold `n ≥ 12` is reached here by
arithmetic independent of the polynomial the record calls *"the same polynomial a fifth time"*.
-/

namespace HamiltonsCubic.OddWitness

/-- `Θₙ²` at odd `n`. -/
def ThetaOddSq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))

/-- **`Θₙ² > 3/2` clears to `n² - 13n + 18 > 0`.** -/
theorem witness_condition (n : ℚ) (hn : 4 ≤ n) :
    3 / 2 < ThetaOddSq n ↔ 0 < n ^ 2 - 13 * n + 18 := by
  unfold ThetaOddSq
  have hpos : (0:ℚ) < (n + 1) * (n - 2) := by nlinarith
  rw [div_lt_div_iff₀ (by norm_num : (0:ℚ) < 2) hpos]
  constructor <;> intro h <;> nlinarith [h]

/-- **Negative at `n = 11`, positive at `n = 12`.** -/
theorem threshold_at_twelve :
    (11 : ℚ) ^ 2 - 13 * 11 + 18 = -4 ∧ (12 : ℚ) ^ 2 - 13 * 12 + 18 = 6 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **A different polynomial from `n² - 12n + 8`**, differing by `10 - n`. -/
theorem polynomials_differ (n : ℚ) :
    (n ^ 2 - 13 * n + 18) - (n ^ 2 - 12 * n + 8) = 10 - n := by ring

/-- Their discriminants are `97` and `112`, so the roots are genuinely distinct. -/
theorem discriminants_differ :
    (13 : ℚ) ^ 2 - 4 * 18 = 97 ∧ (12 : ℚ) ^ 2 - 4 * 8 = 112 ∧ (97 : ℚ) ≠ 112 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- Both roots lie between `11` and `12`, bracketed without taking a root: for
`n² - 13n + 18` the values are `-4` and `6`; for `n² - 12n + 8` they are `-3` and `8`. -/
theorem both_cross_between_eleven_and_twelve :
    (11 : ℚ) ^ 2 - 12 * 11 + 8 = -3 ∧ (12 : ℚ) ^ 2 - 12 * 12 + 8 = 8 := by
  refine ⟨by norm_num, by norm_num⟩

/-- `Θ₁₃² = 120/77 > 3/2`, so the odd witness is explicit at the first odd dimension. -/
theorem thirteen_witness : ThetaOddSq 13 = 120 / 77 ∧ (3 : ℚ) / 2 < 120 / 77 := by
  refine ⟨by unfold ThetaOddSq; norm_num, by norm_num⟩

end HamiltonsCubic.OddWitness
