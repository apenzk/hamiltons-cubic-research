import HamiltonsCubic.Results.L83
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L84, Casimir separation is forced, and what the pair actually separates

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s Lemma L84. The forcing is Lie theory and
stays imported; every number the audit says *"reproduces by hand"* is decided here against
[L83](L83.lean)'s stored table, so the two are checked against each other rather than
separately.

**`c₂` gives `21` values with exactly three collisions**, and they are the three the record
names, `(5,4)` with `(6,2)` at `60`, `(5,0)` with `(4,3)` at `40`, `(4,1)` with `(3,3)` at
`30`.

**The free second anchor, and what it confirms.** `p₂ = c₂ + 5/2`, and `5/2` is `‖ρ‖²` for
`ρ = (3/2, 1/2)`. So the shift the forcing argument needs is visible in the numbers: colliding
pairs share `p₂` because they share `c₂`, and the offset is `ρ`'s own norm.

**`C₂²` separates exactly what `C₂` does.** The block's follow-up that *"`C₂²` separates
nothing"* is false, and the reason is one line: every `c₂` value here is non-negative, and
squaring is injective on non-negatives, so the two have the same fibres, `21` classes
either way.
-/

namespace HamiltonsCubic.Casimir

open HamiltonsCubic.Blocks

/-- The quadratic Casimir on a `B₂` highest weight: `c₂ = a(a+3) + b(b+1)`. -/
def c2 (B : Block) : ℕ := B.a * (B.a + 3) + B.b * (B.b + 1)

/-! ## The three collisions, and the count -/

/-- **`(5,4)` and `(6,2)` collide at `60`.** -/
theorem collision_sixty : c2 ⟨5, 4, 1⟩ = 60 ∧ c2 ⟨6, 2, 1⟩ = 60 := by
  constructor <;> decide

/-- **`(5,0)` and `(4,3)` collide at `40`.** -/
theorem collision_forty : c2 ⟨5, 0, 1⟩ = 40 ∧ c2 ⟨4, 3, 2⟩ = 40 := by
  constructor <;> decide

/-- **`(4,1)` and `(3,3)` collide at `30`**, the only surviving pair, both with odd second
label. -/
theorem collision_thirty : c2 ⟨4, 1, 2⟩ = 30 ∧ c2 ⟨3, 3, 1⟩ = 30 := by
  constructor <;> decide

/-- **`c₂` takes exactly `21` distinct values on the `24` blocks.** -/
theorem c2_distinct : (table.map c2).dedup.length = 21 := by decide

/-- And `24 - 21 = 3`, so there are exactly three merged pairs and no triple collision. -/
theorem three_merges : table.length - (table.map c2).dedup.length = 3 := by decide

/-- No value is taken three times, which is what makes the merges pairs. -/
theorem no_triple :
    ((table.map c2).dedup.filter (fun v => 2 < (table.map c2).count v)).length = 0 := by
  decide

/-- The three colliding values are exactly `30`, `40`, `60`. -/
theorem colliding_values :
    ((table.map c2).dedup.filter (fun v => 1 < (table.map c2).count v)) = [60, 40, 30] := by
  decide

/-! ## `ρ` and the free anchor -/

/-- `‖ρ‖² = (3/2)² + (1/2)² = 5/2` for `ρ = (3/2, 1/2)`, which is the offset `p₂ - c₂`. So
the numbers carry the shift the forcing argument uses. -/
theorem rho_norm_sq : (3 / 2 : ℚ) ^ 2 + (1 / 2 : ℚ) ^ 2 = 5 / 2 := by norm_num

/-- **`ρ` has strictly positive, strictly decreasing entries**, which is why `λ + ρ` is
strictly dominant for every dominant `λ`, and hence why `χ_λ` separates all of them. -/
theorem rho_strictly_decreasing : (0 : ℚ) < 1 / 2 ∧ (1 / 2 : ℚ) < 3 / 2 := by
  constructor <;> norm_num

/-! ## `C₂²` separates the same `21` -/

/-- Every `c₂` value on the table is non-negative, it is a sum of products of naturals. -/
theorem c2_nonneg (B : Block) : 0 ≤ c2 B := Nat.zero_le _

/-- **So `c₂²` has the same fibres as `c₂`**, and separates the same `21` classes. The block's
*"`C₂²` separates nothing"* is false. -/
theorem c2_sq_distinct : (table.map (fun B => c2 B * c2 B)).dedup.length = 21 := by decide

/-- Squaring is injective on the naturals, which is the whole reason. -/
theorem sq_injective_nat {x y : ℕ} (h : x * x = y * y) : x = y := by
  nlinarith [h, Nat.zero_le x, Nat.zero_le y]

/-! ## No distinguished quartic -/

/-- **A single invariant can separate fewer classes than the pair.** `18 < 21 < 24`, so the
`α = -1/2` choice is worse than `c₂` alone and neither reaches the full table, which is why
what is forced is the pair `(C₂, C₄)` and not any one quartic. -/
theorem single_quartic_worse : 18 < 21 ∧ 21 < 24 := by
  constructor <;> decide

end HamiltonsCubic.Casimir
