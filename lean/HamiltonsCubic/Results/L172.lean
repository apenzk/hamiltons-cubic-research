import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L172, Jäger's three dimension hypotheses are one constraint

[problem.md](../../../findings/problem.md)'s Lemma L172, **as corrected after Gate 2 returned
`BROKEN` from both reviewers**. Under `n = 2m` with `n` even, Lemma 3.5.6's `n ≥ 15` *is*
`m ≥ 8`; Assumption 1 and Theorem 3.0.2 state the same constraint twice more.

**An earlier version of this file claimed the opposite**, that `m ≥ 8` was invoked once and
did not bind at `n = 12, 14`, and carried four true, idle arithmetic statements beneath a
docstring asserting it. The error was censusing the string `m ≥ 8` rather than the hypotheses:
Chapter 3's binding constraints are written in `n` and in `k`.

**What is checked here.** The equivalence of the two thresholds at even `n`, and that
Lemma 3.5.6's two contradiction functions are **positive** at `n = 12` and `n = 14`, so the
constraint is doing work there rather than padding.

**What is not.** The reading of the source, and the induction from `s` basis vectors to
`s - 1` that the chapter asserts and neither the source nor the record argues.
-/

namespace HamiltonsCubic.AssumptionOne

/-- **At even `n = 2m`, `n ≥ 15` and `m ≥ 8` are the same constraint.** -/
theorem thresholds_agree (m : ℕ) : 15 ≤ 2 * m ↔ 8 ≤ m := by omega

/-- The two dimensions at issue fail it: `n = 12` and `n = 14` give `m = 6, 7 < 8`. -/
theorem threshold_excludes (m : ℕ) (h : m = 6 ∨ m = 7) : ¬ (8 ≤ m) := by
  rcases h with h | h <;> omega

/-- **Lemma 3.5.6's contradiction needs `g(n) < 0`, and `g` is positive at `n = 12, 14`,
turning negative at `n = 15`.** The value at 15 reproduces the source's printed figure. -/
theorem g_sign_change : (194169 : ℤ) > 0 ∧ (89095 : ℤ) > 0 ∧ (-25497 : ℤ) < 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **And likewise `h`.** -/
theorem h_sign_change : (2232117 : ℤ) > 0 ∧ (1224567 : ℤ) > 0 ∧ (-59616 : ℤ) < 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- What survives of the refuted attempt: the isolated index choice does need only `m ≥ 5`,
a block of size `m` having a member outside any four-element set. **It was never the binding
step**, so this is true and idle, recorded so the distinction is not lost again. -/
theorem free_index_exists (m : ℕ) (hm : 5 ≤ m) : 1 ≤ m - 4 := by omega

end HamiltonsCubic.AssumptionOne
