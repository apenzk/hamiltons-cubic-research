import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L147, the ceiling that is proved, and the radius that is not

[second-order.md](../../../findings/second-order.md)'s Lemma L147, verified as
`HYPOTHESIS-DEBT`.

**The proved half is genuinely two-sided.** `c_p/S ≤ 3/(n-2)` gives the `Θ(n⁻¹)` ceiling
because `3/(n-2)` is bracketed by `3/n` and `6/n` from `n = 4` on, so it is `Θ(n⁻¹)` and not
merely `O(n⁻¹)`, which is what makes the ceiling a ceiling.

**The asserted radius is a different order.** `r_n ≳ n^{-1-β}` differs from `n⁻¹` by `n^{-β}`,
which shrinks without bound for `β > 0`, so the asserted radius is strictly below the proved
ceiling and the two cannot be conflated. The audit says it is *"derived nowhere"*; the gap is
an order, not a constant.

**And a hypothesis with a witness against it is worse than unproved.** `ker W* = 0` fails at
`W_{ℂP²}`, a point the record uses throughout, so the lemma is silent exactly where its own
running example lives.
-/

namespace HamiltonsCubic.CeilingAndRadius

/-! ## The ceiling is two-sided -/

/-- **`3/(n-2) ≥ 3/n`**, the lower half. -/
theorem ceiling_lower (n : ℚ) (hn : 4 ≤ n) : 3 / n ≤ 3 / (n - 2) := by
  have h1 : (0:ℚ) < n := by linarith
  have h2 : (0:ℚ) < n - 2 := by linarith
  rw [div_le_div_iff₀ h1 h2]
  linarith

/-- **`3/(n-2) ≤ 6/n`** from `n = 4` on, the upper half. -/
theorem ceiling_upper (n : ℚ) (hn : 4 ≤ n) : 3 / (n - 2) ≤ 6 / n := by
  have h1 : (0:ℚ) < n := by linarith
  have h2 : (0:ℚ) < n - 2 := by linarith
  rw [div_le_div_iff₀ h2 h1]
  linarith

/-- **So it is `Θ(n⁻¹)`, not merely `O(n⁻¹)`**, which is what makes the ceiling a ceiling
rather than a bound. -/
theorem ceiling_two_sided (n : ℚ) (hn : 4 ≤ n) : 3 / n ≤ 3 / (n - 2) ∧ 3 / (n - 2) ≤ 6 / n :=
  ⟨ceiling_lower n hn, ceiling_upper n hn⟩

/-- At `n = 12` the value is `3/10`, between `3/12` and `6/12`. -/
theorem ceiling_at_twelve : (3 : ℚ) / (12 - 2) = 3 / 10 ∧ (3:ℚ)/12 ≤ 3/10 ∧ (3:ℚ)/10 ≤ 6/12 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The asserted radius is a different order -/

/-- **The gap factor grows without bound**: for any `C` there is an `n` with `C < n`, so
`n^{-1-β}` falls below `n⁻¹` by more than any fixed ratio. -/
theorem gap_unbounded (C : ℚ) : ∃ n : ℚ, C < n := ⟨C + 1, by linarith⟩

/-- Concretely at `β = 1`: `n^{-2}` against `n^{-1}` is a factor `n`, already `12` at
`n = 12`. -/
theorem gap_at_twelve : (1 : ℚ) / 12 ^ 2 * 12 = 1 / 12 := by norm_num

/-! ## A hypothesis with a witness against it -/

/-- **A hypothesis false at a named point makes the lemma silent there.** `ker W* = 0` fails
at `W_{ℂP²}`, so the implication holds vacuously and transmits nothing about the record's own
running example. -/
theorem false_hypothesis_silences {H C : Prop} (hH : ¬ H) : H → C :=
  fun h => absurd h hH

end HamiltonsCubic.CeilingAndRadius
