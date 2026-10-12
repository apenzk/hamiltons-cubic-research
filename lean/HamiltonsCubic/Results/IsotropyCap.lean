import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# The isotropy cap, the free bound is an equivalence, and the pairing factor is `√2`

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s table-retirement block. Four of its
claims are arithmetic.

**`d ≥ n-1` and `C(d,2) ≥ N-d` are the same condition, not one implying the other.** The block
says `d = 4` is forced by `d ≥ n-1`, *"itself free from `C(d,2) ≥ N-d`"*. With `N = C(n,2)` the
second clears to `d(d+1) ≥ n(n-1)`, which for positive integers holds exactly when `d ≥ n-1`,
with **equality at `d = n-1`**, since `(n-1)n = n(n-1)` identically. So the two are equivalent
and the smaller is not a weakening: the bound is tight at the very value it forces.

**The rank argument closes on one subtraction.** Isotropy gives `r ≤ N - dim 𝔪`, which at `n = 6`
is `15 - 6 = 9`; a claimed rank of `15` then forces `dim 𝔪 = 0`, since `9 < 15`.

**The admissible interval is the whole of `[n-1, ⌊n²/4⌋]`.** At `n = 6` that is `[5,9]`, five
integers, against the stale list `{5,6,9}` of three. The general statement supplies
`⌊n/2⌋+1 = 4` of them at `n = 6`, leaving exactly one, `d = 7`, numerical, so the counts agree.

**And the pairing correction is a uniform `√2`.** *"Six values of exactly `√6`"* is `√3` under
the half-trace pairing, and the closed form `√(2p)` is `√p`, both a factor `√2`, checked here
on squares so no root is taken. The rank is unaffected, which is why the criterion survives while
the figures do not.
-/

namespace HamiltonsCubic.IsotropyCap

/-! ## The free bound is an equivalence -/

/-- **`C(d,2) ≥ C(n,2) - d` clears to `d(d+1) ≥ n(n-1)`.** -/
theorem bound_clears (d n : ℚ) :
    d * (d - 1) / 2 - (n * (n - 1) / 2 - d) = (d * (d + 1) - n * (n - 1)) / 2 := by ring

/-- **And it is tight at `d = n-1`**, where `(n-1)n = n(n-1)` identically, so the condition the
block calls free is exactly the condition it is free from. -/
theorem tight_at_n_minus_one (n : ℚ) : (n - 1) * ((n - 1) + 1) = n * (n - 1) := by ring

/-- **`d ≥ n-1` implies it**, for `d` and `n` positive. -/
theorem forward {d n : ℚ} (hn : 1 ≤ n) (h : n - 1 ≤ d) : n * (n - 1) ≤ d * (d + 1) := by
  nlinarith

/-- **And it implies `d ≥ n-1`**, so the two are one condition. -/
theorem backward {d n : ℚ} (hd : 0 ≤ d) (hn : 1 ≤ n) (h : n * (n - 1) ≤ d * (d + 1)) :
    n - 1 ≤ d := by nlinarith

/-! ## The rank argument -/

/-- **`r ≤ 15 - 6 = 9` against a claimed rank `15`**, so `dim 𝔪 = 0` is forced. -/
theorem rank_forces_trivial :
    6 * 5 / 2 = 15 ∧ 15 - 6 = 9 ∧ (9 : ℕ) < 15 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- The same subtraction in general: a rank claim of `N` cannot survive `r ≤ N - dim 𝔪` unless
`dim 𝔪` vanishes. -/
theorem rank_argument_general {N m r : ℚ} (hm : 0 < m) (hr : r ≤ N - m) : r < N := by linarith

/-! ## The admissible interval -/

/-- **At `n = 6` the interval `[n-1, ⌊n²/4⌋]` is `[5,9]`**, five integers, against a stale list
of three. -/
theorem interval_at_six :
    6 - 1 = 5 ∧ 6 * 6 / 4 = 9 ∧ 9 - 5 + 1 = 5 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **The general statement supplies `⌊n/2⌋+1 = 4` of them**, leaving exactly one numerical, so
the two counts are consistent. -/
theorem counts_agree : 6 / 2 + 1 = 4 ∧ 5 - 4 = 1 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## The pairing factor -/

/-- **`√6` becomes `√3`** under the half-trace pairing: a factor `√2`, on squares. -/
theorem six_to_three : (6 : ℚ) / 2 = 3 := by norm_num

/-- **And `√(2p)` becomes `√p`**, the same factor, so the correction is uniform. -/
theorem closed_form_correction (p : ℚ) : 2 * p / 2 = p := by ring

end HamiltonsCubic.IsotropyCap
