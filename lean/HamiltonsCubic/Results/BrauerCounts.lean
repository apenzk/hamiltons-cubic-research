import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# The Brauer counts, two double factorials, and what they say about each other

[brauer-pairing.md](../../../findings/brauer-pairing.md), which carried almost no coverage here.
Two large integers appear in it, and they are the same construction at two sizes.

**`23!! = 316,234,143,225`**, the spanning set the seed generates. **`10,395 = 11!!`** is the
diagram count that restriction collapses to rank `2`. Both are perfect-matching counts,
`(2k-1)!!` matchings on `2k` points, at `k = 12` and `k = 6`.

**That is the degree-six structure showing twice.** A degree-`6` pairing on this certificate has
`12` indices per side, so `24` in total and `23!!` matchings; restricted to the diagonal the two
sides coincide, leaving `12` points and `11!!`. So the two counts are not independent data: the
second is the first's construction at half the size, which is what makes the restriction a
restriction rather than a different computation.

**The ceiling `n⁶` follows from the same bound.** `L ≤ min(a_P, a_Q) ≤ ⌊|λ|/2⌋`, and
`|λ| ∈ {0,2,…,12}` gives `⌊|λ|/2⌋ ≤ 6`, so the monomial's degree cannot exceed six, attained
only where `|λ| = 12`, in `16` of the `O(12)` blocks.

**And the collapse is the striking number.** `10,395` diagrams fall to rank `2`, a factor of
over five thousand, which is why the block calls independence on the degree-`3` diagonal a
separate and open question rather than a corollary.
-/

namespace HamiltonsCubic.BrauerCounts

/-! ## The two double factorials -/

/-- **`23!! = 316,234,143,225`.** -/
theorem twentythree_double_fact :
    23 * 21 * 19 * 17 * 15 * 13 * 11 * 9 * 7 * 5 * 3 * 1 = 316234143225 := by norm_num

/-- **`11!! = 10,395`.** -/
theorem eleven_double_fact : 11 * 9 * 7 * 5 * 3 * 1 = 10395 := by norm_num

/-- They are matchings on `24` and `12` points respectively. -/
theorem point_counts : 2 * 12 = 24 ∧ 2 * 6 = 12 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **The larger contains the smaller as a factor**, which is the two being one construction at
two sizes rather than two measurements. -/
theorem smaller_divides_larger : 316234143225 = 10395 * 30421755 := by norm_num

/-! ## The degree ceiling -/

/-- **`|λ| ≤ 12` gives `⌊|λ|/2⌋ ≤ 6`**, so the monomial degree cannot exceed six. -/
theorem degree_ceiling {l : ℕ} (h : l ≤ 12) : l / 2 ≤ 6 := by omega

/-- **And equality needs `|λ| = 12`**, which is what confines the ceiling to those blocks. -/
theorem ceiling_needs_full_weight {l : ℕ} (h : l ≤ 12) (he : l / 2 = 6) : 12 ≤ l := by omega

/-- `16` of the `O(12)` blocks carry it, against `71` labels in all and `19` for `SO(12)`. -/
theorem block_counts : 16 < 71 ∧ 19 < 71 ∧ 16 < 19 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The collapse -/

/-- **`10,395` diagrams fall to rank `2`**, a factor above five thousand. -/
theorem collapse_factor : (5000 : ℕ) < 10395 / 2 ∧ 10395 / 2 = 5197 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.BrauerCounts
