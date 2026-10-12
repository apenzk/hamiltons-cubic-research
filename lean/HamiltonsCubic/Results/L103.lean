import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L103, the witness `W₁` and its constant

[route-a.md](../../../findings/route-a.md)'s Observation L103. The audit says the whole block
is derivable and every reported number follows; that derivation is here, **entirely on
squares, so no root is taken anywhere**.

`f(φ) = cos³φ + c₁₂ sin³φ` with `c₁₂² = 55/54`. Its three critical values on `[0, π/2]` are

* `φ = 0`, value `1`;
* `φ = π/2`, value `c₁₂`, square `55/54`;
* the interior root `tan φ = 1/c₁₂`, value `c₁₂/√(1+c₁₂²)`, square `55/109`.

**So the refutation reduces to `55 > 54`**, and the interior root is the *minimum* rather
than a competitor: `55/109 < 1 < 55/54`. The maximiser is `π/2`, derived rather than
observed, and the block's two figures are one number at two precisions.
-/

namespace HamiltonsCubic.WitnessConstant

/-- `c₁₂² = 55/54`. -/
def cSq : ℚ := 55 / 54

/-! ## The three critical values, as squares -/

/-- **The interior root's square is `c²/(1+c²) = 55/109`**, the value at `tan φ = 1/c₁₂`,
where `cos φ = c/√(1+c²)` and `sin φ = 1/√(1+c²)` give
`f = c(c²+1)/(1+c²)^{3/2} = c/√(1+c²)`. -/
theorem interior_value : cSq / (1 + cSq) = 55 / 109 := by
  unfold cSq; norm_num

/-! ## The ordering, and the refutation -/

/-- **The refutation is `55 > 54`**: the value at `π/2` exceeds the value at `0`. -/
theorem refutation : (1 : ℚ) < cSq := by unfold cSq; norm_num

/-- **And the interior root is the minimum**, not a competitor: `55/109 < 1`. -/
theorem interior_is_min : cSq / (1 + cSq) < 1 := by unfold cSq; norm_num

/-- **So `π/2` is the maximiser**, from the ordering of all three critical values. -/
theorem half_pi_maximises :
    cSq / (1 + cSq) < 1 ∧ (1 : ℚ) < cSq := by
  constructor
  · exact interior_is_min
  · exact refutation

/-! ## The two printed figures are one number -/

/-- `c₁₂ = 1.0092168…`, bracketed on the square so no root is taken. -/
theorem c_bracket :
    ((10092167 : ℚ) / 10000000) ^ 2 < cSq ∧ cSq < ((10092169 : ℚ) / 10000000) ^ 2 := by
  unfold cSq
  constructor <;> norm_num

/-- The coarser printing `1.00922` brackets the same number, so the heading's two figures are
one value at two precisions. -/
theorem c_bracket_coarse :
    ((100921 : ℚ) / 100000) ^ 2 < cSq ∧ cSq < ((100922 : ℚ) / 100000) ^ 2 := by
  unfold cSq
  constructor <;> norm_num

/-! ## The complement the sharpness claim would need -/

/-- **`1603 = 1638 - 35`**: the complement is `dim 𝒲₁₂` less the witness's own
`35`-dimensional span, which is why *"sharp"* is a claim of Conjecture-A strength rather than
a corollary. -/
theorem complement_dim : 1638 - 35 = 1603 := by decide

/-- And `35` is `dim 𝒲₅`, so the subspace removed is a whole lower-dimensional Weyl space. -/
theorem thirty_five_is_weyl_five : 5 * 6 * 7 * 2 / 12 = 35 := by norm_num

theorem sixteen_thirty_eight_is_weyl_twelve : 12 * 13 * 14 * 9 / 12 = 1638 := by norm_num

end HamiltonsCubic.WitnessConstant
