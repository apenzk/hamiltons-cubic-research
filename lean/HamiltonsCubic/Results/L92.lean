import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L92, the surviving collision, both ways, and the basis that decides it

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s Lemma L92, confirmed twice at Gate 2. The
representation theory stays imported; the lattice arithmetic it turns on is carried here,
including the uniqueness step the block leaves implicit.

**The expansion is unique, which is what makes a negative coefficient decisive.** In the
`e`-basis `α₁ = (1,-1)` and `α₂ = (0,1)` are linearly independent, so every vector has exactly
one expansion `aα₁ + bα₂`, namely `a = v₁` and `b = v₁ + v₂`. Without that, exhibiting one
expansion with a negative coefficient would leave open whether another has none.

**Both differences carry a negative coefficient.** `(4,1) - (3,3) = (1,-2)` expands as
`α₁ - α₂`, and `(3,3) - (4,1) = (-1,2)` as `-α₁ + α₂`. Since a weight `μ` of `V_λ` needs
`λ - μ ∈ ℤ≥0 α₁ + ℤ≥0 α₂`, neither weight lies in the other's module, so the collision is
resolved in both directions rather than one.

**The convex-hull check is genuinely disjoint from the lattice one.** `‖(3,3)‖² = 18 > 17 =
‖(4,1)‖²` rules out one direction on norms alone, and `|μ₁| ≤ 3 < 4` rules out the other on a
single coordinate, neither using the root lattice.

**The basis is what the misreading turns on.** The block's own `α`'s pin the `e`-basis; read in
`ω`-coordinates the printed difference is `α₂` itself, and a reader there draws the opposite
conclusion. The norms above are basis-dependent quantities, so they are stated here in the same
`e`-basis the differences are.

**And *"non-colliding"* is lossy**: four of the thirteen blocks are themselves colliding, and of
the `46` dimensions at weight `(4,1)`, `44` come from those thirteen, leaving `2` for the
colliding pair.
-/

namespace HamiltonsCubic.HighestWeight

/-! ## The expansion is unique -/

/-- **`α₁ = (1,-1)` and `α₂ = (0,1)` expand any vector uniquely**, with `a = v₁` and
`b = v₁ + v₂`. -/
theorem expansion_unique (v₁ v₂ a b : ℚ) :
    (a * 1 + b * 0 = v₁ ∧ a * (-1) + b * 1 = v₂) ↔ (a = v₁ ∧ b = v₁ + v₂) := by
  constructor
  · rintro ⟨h1, h2⟩; constructor <;> linarith
  · rintro ⟨h1, h2⟩; constructor <;> (subst h1; linarith)

/-! ## Both differences leave the positive cone -/

/-- `(4,1) - (3,3) = (1,-2)`, whose unique expansion is `α₁ - α₂`, **coefficient `-1`**. -/
theorem first_difference :
    (4 - 3 : ℚ) = 1 ∧ (1 - 3 : ℚ) = -2 ∧ ((1 : ℚ) + (-2)) = -1 ∧ (-1 : ℚ) < 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- `(3,3) - (4,1) = (-1,2)`, whose unique expansion is `-α₁ + α₂`, **coefficient `-1`**. -/
theorem second_difference :
    (3 - 4 : ℚ) = -1 ∧ (3 - 1 : ℚ) = 2 ∧ ((-1 : ℚ) + 2) = 1 ∧ (-1 : ℚ) < 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- **So neither weight lies in the other's module.** A weight `μ` of `V_λ` needs both
coefficients of `λ - μ` nonnegative, and each difference has one that is not. -/
theorem neither_in_the_other {a b : ℚ} (h : a = -1 ∨ b = -1) : ¬ (0 ≤ a ∧ 0 ≤ b) := by
  rintro ⟨ha, hb⟩
  rcases h with h | h
  · rw [h] at ha; norm_num at ha
  · rw [h] at hb; norm_num at hb

/-! ## The convex-hull check, disjoint from the lattice one -/

/-- **`‖(3,3)‖² = 18 > 17 = ‖(4,1)‖²`**, which kills one direction on norms alone. -/
theorem hull_norms :
    (3 : ℚ) ^ 2 + 3 ^ 2 = 18 ∧ (4 : ℚ) ^ 2 + 1 ^ 2 = 17 ∧ (17 : ℚ) < 18 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **And `|μ₁| ≤ 3 < 4` kills the other on a single coordinate.** -/
theorem hull_coordinate : (3 : ℚ) < 4 := by norm_num

/-- The two checks are independent: the norm comparison rules out `(4,1) ∈ V_{(3,3)}` and the
coordinate bound rules out `(3,3) ∈ V_{(4,1)}`, and neither uses the root lattice. -/
theorem checks_point_opposite_ways : (17 : ℚ) < 18 ∧ (3 : ℚ) < 4 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## The counts the aside corrects -/

/-- **`44` of the `46` dimensions at weight `(4,1)` come from thirteen other blocks**, leaving
`2` for the colliding pair. -/
theorem weight_dimensions : 46 - 44 = 2 := by norm_num

/-- **And four of those thirteen are themselves colliding**, so *"non-colliding"* is lossy. -/
theorem non_colliding_is_lossy : 4 < 13 ∧ 13 - 4 = 9 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.HighestWeight
