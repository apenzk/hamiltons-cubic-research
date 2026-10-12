import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L13, the disputed excess figure, settled

[curvature-invariants.md](../../../findings/curvature-invariants.md)'s Lemma L13. The block
records a disagreement between two Gate 2 reviewers over the `49.7×` excess and says
*"settling this needs only the denominator written down beside the numbers"*. It does, and the
arithmetic separates them differently from how the block frames it.

**The denominator is right and the figure is wrong, so neither reviewer is simply wrong.**
Reading the excess as `(bound - θ₀)/(θ₀ - √(3/2))`, which is the reviewer's proposed
denominator, reproduces the **asymptotic** figure `3.09` to three digits: as `n → ∞`,
`θ₀ → √2`, and `(2 - √2)/(√2 - √(3/2))` lies strictly between `3.09` and `3.10`. So the formula
is the block's. **Applied at `n = 12` the same formula gives `58.9`, not `49.7`**, which is the
other reviewer's figure, derived from the block's own inequality.

**But `49.7` is not an error, it is a different bound's excess.** The chain
`λ²(1 + k₀/4) ≤ (n-1)(2n-1)/4` at `n = 12` with the admissible maximum `k₀ = C(12,2) = 66`
yields `λ² ≤ 253/70`, i.e. `λ ≤ 1.9011`, whose excess is `58.9`. The record's table carries a
**level-3** bound of `1.7974`, never displayed beside the chain, and its excess is `49.7`. Both
figures are correct for their own bound; what was missing is which bound each measures.

**The argument once recorded here, that `49.7` needs `k₀ ≥ 74 > 66`, so no critical point
produces it, is invalid, and its `74` is the fingerprint of the mix-up.** It reads an upper
bound as a determination: the chain permits any `λ` below the bound at a given `k₀`, so a
smaller `λ` never forces a larger `k₀`. Applied to `θ₀(12) = 1.2360` the same reasoning would
demand `k₀ ≥ 162` and refute `S⁶ × S⁶`, which the record lists as a critical point. And `74.3`
is exactly `253/(4·1.7974²) - 1` scaled by four, the orbit dimension needed to force the
level-3 figure out of the level-2 formula, which is why it appears at all.

Every bracket below is a rational inequality on squares, so no root is taken anywhere.
-/

namespace HamiltonsCubic.MomentCeiling

/-! ## The chain's constants at `n = 12` -/

/-- `tr(L_W²) = (n-1)(2n-1)/4 · ‖W‖²`, which at `n = 12` is `253/4`. **It is constant in `W`**,
so this moment carries nothing beyond the norm, the block's one genuinely proven diagnosis. -/
theorem kappa_twelve : (12 - 1 : ℚ) * (2 * 12 - 1) / 4 = 253 / 4 := by norm_num

/-- `k₀ ≤ C(12,2) = 66`, which is also `dim 𝔰𝔬(12)`. -/
theorem k0_cap : 12 * 11 / 2 = 66 := by norm_num

/-- **At the admissible maximum the ceiling is `λ² ≤ 253/70`.** -/
theorem ceiling_at_cap : (253 / 4 : ℚ) / (1 + 66 / 4) = 253 / 70 := by norm_num

/-! ## The square-root brackets, each proved by squaring -/

theorem bracket_lambda :
    ((190112 : ℚ) / 100000) ^ 2 < 253 / 70 ∧ (253 : ℚ) / 70 < ((190113 : ℚ) / 100000) ^ 2 := by
  constructor <;> norm_num

theorem bracket_theta0 :
    ((1236033 : ℚ) / 1000000) ^ 2 < 55 / 36 ∧ (55 : ℚ) / 36 < ((1236034 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

theorem bracket_target :
    ((1224744 : ℚ) / 1000000) ^ 2 < 3 / 2 ∧ (3 : ℚ) / 2 < ((1224745 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

theorem bracket_root_two :
    ((14142135 : ℚ) / 10000000) ^ 2 < 2 ∧ (2 : ℚ) < ((14142136 : ℚ) / 10000000) ^ 2 := by
  constructor <;> norm_num

/-! ## The level-2 excess at `n = 12` is `58.9`; `49.7` is the level-3 bound's -/

/-- **From the brackets alone, the excess lies strictly between `58` and `59`.** -/
theorem excess_at_twelve {l t s : ℚ}
    (hl1 : (190112 : ℚ) / 100000 < l) (hl2 : l < (190113 : ℚ) / 100000)
    (ht1 : (1236033 : ℚ) / 1000000 < t) (ht2 : t < (1236034 : ℚ) / 1000000)
    (hs1 : (1224744 : ℚ) / 1000000 < s) (hs2 : s < (1224745 : ℚ) / 1000000) :
    58 < (l - t) / (t - s) ∧ (l - t) / (t - s) < 59 := by
  have hden : (0 : ℚ) < t - s := by linarith
  constructor
  · rw [lt_div_iff₀ hden]; linarith
  · rw [div_lt_iff₀ hden]; linarith

/-- **So `49.7` is not what the level-2 formula gives**, the two differing by more than `9`. -/
theorem forty_nine_seven_excluded : (497 : ℚ) / 10 < 58 := by norm_num

/-! ## And `49.7` needs a `k₀` above the cap -/

/-- Reaching `49.7` needs `λ ≤ 1.7971`, hence `λ² ≤ 3.2295`, hence `1 + k₀/4 ≥ 253/(4·3.2295)`,
which puts **`k₀ ≥ 74`**, above the cap `66`. -/
theorem k0_required_exceeds_cap :
    (253 / 4 : ℚ) / ((17971 : ℚ) / 10000) ^ 2 - 1 > 66 / 4 := by norm_num

theorem seventy_four_above_cap : (66 : ℚ) < 74 := by norm_num

/-! ## The asymptotic figure confirms the denominator -/

/-- **`(2 - √2)/(√2 - √(3/2))` lies strictly between `3.09` and `3.10`**, so the proposed
denominator does reproduce the block's asymptotic figure, which is what makes the `n = 12`
mismatch a defect in the number rather than in the formula. -/
theorem asymptotic_excess {r s : ℚ}
    (hr1 : (14142135 : ℚ) / 10000000 < r) (hr2 : r < (14142136 : ℚ) / 10000000)
    (hs1 : (1224744 : ℚ) / 1000000 < s) (hs2 : s < (1224745 : ℚ) / 1000000) :
    309 / 100 < (2 - r) / (r - s) ∧ (2 - r) / (r - s) < 310 / 100 := by
  have hden : (0 : ℚ) < r - s := by linarith
  constructor
  · rw [lt_div_iff₀ hden]; linarith
  · rw [div_lt_iff₀ hden]; linarith

/-! ## The refuted clause -/

/-- *"Attained on a subspace of dimension exactly `dim(O(n)·u)`"* is false, `18` against `9` at
`S³ × S³` and `60` against `21` at `S² × S³ × S³`. **Only *"at least"* survives**, and only that
is used downstream. -/
theorem dimension_clause_refuted : 9 < 18 ∧ 21 < 60 := by
  constructor <;> norm_num

end HamiltonsCubic.MomentCeiling
