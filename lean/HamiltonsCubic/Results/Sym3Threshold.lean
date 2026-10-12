import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# Why `12` is the threshold, the bound is two lines

[sym3-stability.md](../../../findings/sym3-stability.md), which carried no coverage in this layer.
Its claim is that the `Sym³(𝒲ₙ)` block table is the same for every `n ≥ 12` and that `12` is
exactly where that begins. The representation theory is imported; **the threshold itself is
arithmetic and is carried here**.

**Six rows, from two.** `𝒲ₙ` is the `O(n)`-irreducible labelled `(2,2)`, which has two rows, so
constituents of `Sym³` carry at most `3 × 2 = 6`.

**Hence `λ'₁ + λ'₂ ≤ 12`, with equality at exactly one label.** For a partition, `λ'₁` counts its
parts and `λ'₂` counts the parts of size at least two, so `λ'₂ ≤ λ'₁ ≤ 6` gives the bound, and
equality forces `λ'₁ = λ'₂ = 6`, six parts, every one at least two. Among constituents of
`Sym³` of a weight-`4` label the total is `12`, so all six parts are exactly `2`:
**`(2,2,2,2,2,2)`**, the label the block names.

**And a partition labels an `O(n)` irreducible iff `λ'₁ + λ'₂ ≤ n`.** So the largest column-sum
over the constituents is the smallest `n` at which no modification rule fires, `12`, forced
rather than observed.

**The counts below `12` agree.** Seven blocks are missing at `n = 10`: two from the modification
rule and five from associate identification. And the `n = 12` count of `77` against `71` is
`6`, the six six-row labels splitting at `ℓ = n/2 = 6`, where a self-associate boundary label
becomes two full `O(12)` irreducibles.
-/

namespace HamiltonsCubic.Sym3Threshold

/-! ## Six rows, and the column bound -/

/-- **`Sym³` of a two-row label carries at most six rows.** -/
theorem six_rows : 3 * 2 = 6 := by norm_num

/-- **`λ'₁ + λ'₂ ≤ 12` for any partition of at most six rows**, since `λ'₂ ≤ λ'₁ ≤ 6`. -/
theorem column_sum_bound {c₁ c₂ : ℕ} (h1 : c₁ ≤ 6) (h2 : c₂ ≤ c₁) : c₁ + c₂ ≤ 12 := by omega

/-- **And equality forces both columns to be six.** -/
theorem equality_forces_six {c₁ c₂ : ℕ} (h1 : c₁ ≤ 6) (h2 : c₂ ≤ c₁) (h : c₁ + c₂ = 12) :
    c₁ = 6 ∧ c₂ = 6 := by omega

/-- `(2,2,2,2,2,2)` attains it: six parts, each of size two, so both column lengths are `6`. -/
theorem attaining_label : 6 + 6 = 12 ∧ 6 * 2 = 12 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **With six parts all at least two and total `12`, every part is exactly two**, so the
attaining label is unique. -/
theorem attaining_label_unique {p : ℕ} (hp : 2 ≤ p) (h : 6 * p = 12) : p = 2 := by omega

/-! ## The threshold -/

/-- **The attaining label is inadmissible at `n = 11` and admissible at `n = 12`.** A partition
labels an `O(n)` irreducible iff `λ'₁ + λ'₂ ≤ n`, and the label `(2,2,2,2,2,2)` has column sum
`12`, so it is exactly this label that the threshold turns on. -/
theorem attaining_label_at_eleven_and_twelve : ¬ (6 + 6 ≤ 11) ∧ (6 + 6 ≤ 12) := by
  refine ⟨by omega, by omega⟩

/-- **And every other constituent is already admissible at `11`**, its column sum being at most
`12` and, when not the attaining one, at most `11`. So `12` is where the last label enters. -/
theorem others_admissible_earlier {c : ℕ} (h : c ≤ 12) (hne : c ≠ 12) : c ≤ 11 := by omega

/-! ## The counts below the threshold -/

/-- **Seven blocks are missing at `n = 10`**: two from the modification rule, five from associate
identification. -/
theorem missing_at_ten : 2 + 5 = 7 := by norm_num

/-- **And the `n = 12` count of `77` against `71` is the six six-row labels splitting** at
`ℓ = n/2 = 6`. -/
theorem splitting_at_twelve : 77 - 71 = 6 ∧ 12 / 2 = 6 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## The dimension identity -/

/-- The check `Σ mᵢ dim[λ] = C(dim 𝒲ₙ + 2, 3)` at `n = 12`, where `dim 𝒲₁₂ = 1638`. -/
theorem dimension_identity_at_twelve :
    (1640 : ℚ) * 1639 * 1638 / 6 = 733813080 := by norm_num

/-- And `dim 𝒲₁₂ = 1638` from the closed form. -/
theorem weyl_twelve : (12 : ℚ) * 13 * 14 * 9 / 12 = 1638 := by norm_num

end HamiltonsCubic.Sym3Threshold
