import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Data.Nat.Choose.Basic

/-!
# L78, the residual floor for the 3-form mass

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L78. The floor
`α ≥ (2d/n)(4d - n²)` is geometry and stays imported; the two numbers the block pairs are
arithmetic, and they are not the same kind of number.

**`8.4` is attained and `16.6` is not, by a margin the record rounds.** At `n = 5, d = 7` the
floor is `42/5` exactly, and the extremiser is the orthocomplement of the principal
`𝔰𝔬(3) ⊂ 𝔰𝔬(5)`, `dim = C(5,2) - 3 = 7`, so the dimension the floor is evaluated at is the
one the extremiser has. At `n = 6, d = 10` the floor is `40/3 = 13.3̄`, and the companion
`16.6` exceeds it by **exactly `49/200`, which is `24.5%`**, the record prints `24%`, so the
gap is slightly wider than stated.

**And at `n = 6` the floor is structurally unattainable.** A minimiser would need `𝔪^⊥` a
five-dimensional subalgebra, and every such in `𝔰𝔬(6)` gives `α = 24`, which is `1.8` times
the floor, not `1.245`. So `16.6` sits between the floor and the only attainable value, and is
certified by neither.
-/

namespace HamiltonsCubic.ResidualFloor

/-- The floor `(2d/n)(4d - n²)`. -/
def floor (n d : ℚ) : ℚ := (2 * d / n) * (4 * d - n ^ 2)

/-! ## `n = 5`: the floor is attained -/

/-- **`floor(5,7) = 42/5`**, the block's `8.4`, exactly. -/
theorem floor_five : floor 5 7 = 42 / 5 := by unfold floor; norm_num

/-- The extremiser's dimension is `C(5,2) - 3 = 7`, the orthocomplement of the principal
`𝔰𝔬(3)`, so the `d` the floor is evaluated at is the one the extremiser has. -/
theorem extremiser_dim : Nat.choose 5 2 - 3 = 7 := by decide

/-! ## `n = 6`: the floor is `13.3̄` and the companion is not certified -/

/-- **`floor(6,10) = 40/3`**, the block's `13.3̄`. -/
theorem floor_six : floor 6 10 = 40 / 3 := by unfold floor; norm_num

/-- The corresponding `𝔪^⊥` has dimension `C(6,2) - 10 = 5`. -/
theorem complement_dim : Nat.choose 6 2 - 10 = 5 := by decide

/-- **`16.6` exceeds its own floor by exactly `49/200`**, that is `24.5%`, where the record
prints `24%`. -/
theorem excess_exact : ((83 : ℚ) / 5 - 40 / 3) / (40 / 3) = 49 / 200 := by norm_num

theorem excess_is_24_5_percent : (49 : ℚ) / 200 = 245 / 1000 := by norm_num

/-- So the record's `24%` understates it. -/
theorem record_rounds_down : (24 : ℚ) / 100 < 49 / 200 := by norm_num

/-! ## The only attainable value at `n = 6` -/

/-- Every five-dimensional subalgebra of `𝔰𝔬(6)` gives `α = 24`, which is **`1.8` times** the
floor, so `16.6` lies strictly between the floor and the attainable value and is certified by
neither. -/
theorem attainable_exceeds_floor : (40 : ℚ) / 3 < 24 := by norm_num

theorem attainable_ratio : (24 : ℚ) / (40 / 3) = 9 / 5 := by norm_num

theorem companion_strictly_between : (40 : ℚ) / 3 < 83 / 5 ∧ (83 : ℚ) / 5 < 24 := by
  constructor <;> norm_num

/-! ## The floor's shape -/

/-- The floor is **negative** below `d = n²/4`, so it constrains nothing there, which is why
it is a *residual* floor and bites only past the cap. -/
theorem floor_negative_below (n d : ℚ) (hn : 0 < n) (hd : 0 < d) (h : 4 * d < n ^ 2) :
    floor n d < 0 := by
  unfold floor
  have h1 : 0 < 2 * d / n := div_pos (by linarith) hn
  nlinarith [h1, h]

/-- At `n = 5` the cap sits at `d = 25/4`, so `d = 7` is the first integer past it. -/
theorem cap_at_five : (4 : ℚ) * 7 - 25 = 3 ∧ (4 : ℚ) * 6 - 25 < 0 := by
  constructor <;> norm_num

end HamiltonsCubic.ResidualFloor
