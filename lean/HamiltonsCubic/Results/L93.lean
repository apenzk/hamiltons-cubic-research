import Mathlib.Data.Rat.Defs
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Positivity

/-!
# L93, the withdrawn duplicate, and the three defects its copy carried

[bispectral.md](../../../findings/bispectral.md)'s Lemma L93, withdrawn as a number in favour of
[Lemma L55](../../../findings/diagonal-half.md). The mathematics stands under the surviving id;
what is checked here is the set of defects the audit says **this** copy carried beyond its
sibling's, since those are arithmetic rather than bookkeeping.

**The extremal configuration is stated with the wrong sign, and the error is exactly `n-2`.**
For `y = (α,…,α,-(M-1)α)` with `M-1` copies of `α`, the constraint `Σy = 0` holds and
`Σy² = M(M-1)α²`. If `α < 0` then `min y = α` and `|min y| = √(s/(M(M-1)))`, which is the
claimed bound. **If `α > 0` the minimum is the single entry**, `|min y| = (M-1)|α|`, larger by
`M-1 = n-2`. So the displayed configuration is the *maximising* one unless `α < 0`, which the
block does not state.

**The *"wrong functional"* paragraph is impossible on its face.** `min|K| ≤ |min K|` holds for
every finite family, since the left side is at most `|K j|` at the `j` attaining the right, so
no list can exhibit the reverse.

**And the odd-`n` ratio at `n = 9` is `√(21/17)`, not `1.11153`.** The stale figure is strictly
above the true value, bracketed here by squaring.

**The chained bound is sound.** Some row has `s_a ≥ t/n`, and `√(s_a/((n-1)(n-2)))` then gives
`√(t/(n(n-1)(n-2)))`, which is the lemma as stated.
-/

namespace HamiltonsCubic.VertexMatrix

open Finset

/-! ## The extremal configuration, and the missing sign -/

/-- **`y = (α,…,α,-(M-1)α)` has zero sum and `Σy² = M(M-1)α²`**, the block's identity. -/
theorem config_norm (M α : ℚ) :
    (M - 1) * α ^ 2 + ((M - 1) * α) ^ 2 = M * (M - 1) * α ^ 2 := by
  ring

/-- The sum vanishes identically. -/
theorem config_sum (M α : ℚ) : (M - 1) * α + (-((M - 1) * α)) = 0 := by ring

/-- **With `α < 0` the minimum is `α` itself**, giving the claimed bound. -/
theorem min_when_negative {M α : ℚ} (hM : 2 ≤ M) (hα : α < 0) :
    α < -((M - 1) * α) := by nlinarith

/-- **With `α > 0` the minimum is the single entry**, and `|min y| = (M-1)α`, larger than `α`
by the factor `M-1`, which is `n-2`. -/
theorem min_when_positive {M α : ℚ} (hM : 2 ≤ M) (hα : 0 < α) :
    -((M - 1) * α) < α ∧ |(-((M - 1) * α))| = (M - 1) * α := by
  constructor
  · nlinarith
  · rw [abs_neg, abs_of_nonneg (by nlinarith)]

/-- **So the stated configuration overshoots by exactly `M-1 = n-2`** unless `α < 0`. -/
theorem overshoot_factor (n : ℚ) : (n - 1) - 1 = n - 2 := by ring

/-! ## `min|K| ≤ |min K|`, so the paragraph cannot say what it says -/

variable {ι : Type*} [DecidableEq ι]

/-- **The minimum of the moduli never exceeds the modulus of the minimum.** -/
theorem min_abs_le_abs_min (s : Finset ι) (hs : s.Nonempty) (K : ι → ℚ) :
    s.inf' hs (fun i => |K i|) ≤ |s.inf' hs K| := by
  obtain ⟨j, hj, hjeq⟩ := Finset.exists_mem_eq_inf' hs K
  calc s.inf' hs (fun i => |K i|) ≤ |K j| := Finset.inf'_le _ hj
    _ = |s.inf' hs K| := by rw [hjeq]

/-! ## The ratio at `n = 9` -/

/-- **`√(21/17)` is bracketed by `1.111437` and `1.111439`.** -/
theorem ratio_at_nine :
    ((1111437 : ℚ) / 1000000) ^ 2 < 21 / 17
      ∧ (21 : ℚ) / 17 < ((1111439 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-- **And the recorded `1.11153` is strictly above it**, so the transcribed figure overstates. -/
theorem stale_figure_overshoots : (21 : ℚ) / 17 < ((111153 : ℚ) / 100000) ^ 2 := by norm_num

/-! ## The chained bound -/

/-- **`s_a ≥ t/n` gives the lemma's constant.** Cross-multiplied, so no root is taken:
`s_a/((n-1)(n-2)) ≥ t/(n(n-1)(n-2))`. -/
theorem chained_bound {n t s : ℚ} (hn : 3 ≤ n) (ht : 0 ≤ t) (hs : t / n ≤ s) :
    t / (n * ((n - 1) * (n - 2))) ≤ s / ((n - 1) * (n - 2)) := by
  have hn0 : (0:ℚ) < n := by linarith
  have h1 : (0:ℚ) < (n - 1) * (n - 2) := by nlinarith
  have key : t / n / ((n - 1) * (n - 2)) ≤ s / ((n - 1) * (n - 2)) := by gcongr
  rwa [div_div] at key

end HamiltonsCubic.VertexMatrix
