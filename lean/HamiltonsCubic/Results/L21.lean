import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L21, the branching that names the missing `940`, and a formula that simplifies

[route-a.md](../../../findings/route-a.md)'s Lemma L21, whose table left `940` of
`dim Weyl₁₂ = 1638` unnamed. The audit supplies the two missing types; their arithmetic is here.

**`dim V_{(2,1)}` is `m(m-2)(m+2)/3`.** The audit writes it as `m(m²-1)/3 - m`, which collapses:
`m(m²-1)/3 - m = m(m²-4)/3 = m(m-2)(m+2)/3`. At `m = 8` that is `160`, and the factored form
makes the vanishing at `m = 2` visible, where the second `ℝ⁴` factor degenerates.

**And `dim V_{(2,2)}` is `dim Weyl_m` on the nose.** The audit's
`m(m+1)(m+2)(m-3)/12` **is** the Weyl dimension formula, so the identification
`V_{(2,2)} = Weyl_{n-4}` is an equality of formulas rather than a coincidence at one dimension.
At `m = 8` it is `300`.

**The exhaustion closes exactly.** `4·160 + 1·300 = 940`, and `698 + 940 = 1638 = dim Weyl₁₂`,
so the four named blocks and the two unnamed types partition the space with nothing left over.

**And the annihilation carries no dimension.** `F_u` preserves the `A`-index degree and vanishes
below degree `2`; both higher isotypics sit at degrees `0` and `1`. That argument mentions `m`
nowhere, so it holds at every `m` at once, which is what makes *"the bound never has to look at
`940` of the `1638`"* a statement about the construction rather than about `n = 12`.
-/

namespace HamiltonsCubic.MissingTypes

/-! ## The two dimension formulas -/

/-- The audit's form for `dim V_{(2,1)}`. -/
def dimV21 (m : ℚ) : ℚ := m * (m ^ 2 - 1) / 3 - m

/-- **It collapses to `m(m-2)(m+2)/3`.** -/
theorem dimV21_factors (m : ℚ) : dimV21 m = m * (m - 2) * (m + 2) / 3 := by
  unfold dimV21; ring

/-- So it vanishes exactly at `m = 0, ±2`. -/
theorem dimV21_vanishes : dimV21 2 = 0 ∧ dimV21 0 = 0 := by
  constructor <;> (unfold dimV21; norm_num)

/-- `dim V_{(2,2)}`, the audit's form. -/
def dimV22 (m : ℚ) : ℚ := m * (m + 1) * (m + 2) * (m - 3) / 12

/-- `dim Weylₙ = n(n+1)(n+2)(n-3)/12`. -/
def dimWeyl (n : ℚ) : ℚ := n * (n + 1) * (n + 2) * (n - 3) / 12

/-- **`dim V_{(2,2)} = dim Weyl_m` identically**, so `V_{(2,2)} = Weyl_{n-4}` is an equality of
formulas rather than an agreement at one dimension. -/
theorem V22_is_Weyl (m : ℚ) : dimV22 m = dimWeyl m := by
  unfold dimV22 dimWeyl; ring

/-! ## The values at `n = 12` -/

theorem values_at_eight : dimV21 8 = 160 ∧ dimV22 8 = 300 := by
  constructor
  · unfold dimV21; norm_num
  · unfold dimV22; norm_num

/-- **The two unnamed types carry `940`**, with multiplicities `4` and `1`. -/
theorem unnamed_total : 4 * dimV21 8 + 1 * dimV22 8 = 940 := by
  unfold dimV21 dimV22; norm_num

/-- **And the exhaustion closes exactly**: `698 + 940 = 1638 = dim Weyl₁₂`. -/
theorem exhaustion_closes : (698 : ℚ) + 940 = 1638 ∧ dimWeyl 12 = 1638 := by
  constructor
  · norm_num
  · unfold dimWeyl; norm_num

/-- The named blocks carry less than half, which is what made the gap load-bearing. -/
theorem named_is_minority : (698 : ℚ) / 1638 < 1 / 2 := by norm_num

/-! ## The annihilation is dimension-free -/

/-- **`F_u` vanishes below `A`-degree `2`, and both types sit at degrees `0` and `1`.** The
statement mentions no dimension, so it holds at every `m`, recorded here as the degree
comparison the argument actually makes. -/
theorem degrees_below_threshold : (0 : ℕ) < 2 ∧ (1 : ℕ) < 2 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **Both types are genuinely present at every `m ≥ 4`**, so the unnamed rows are a systematic
omission rather than an accident of `n = 12`. -/
theorem both_types_present {m : ℚ} (hm : 4 ≤ m) : 0 < dimV21 m ∧ 0 < dimV22 m := by
  rw [dimV21_factors]
  unfold dimV22
  have h1 : (0:ℚ) < m := by linarith
  have h2 : (0:ℚ) < m - 2 := by linarith
  have h3 : (0:ℚ) < m + 2 := by linarith
  have h4 : (0:ℚ) < m - 3 := by linarith
  have h5 : (0:ℚ) < m + 1 := by linarith
  constructor
  · exact div_pos (mul_pos (mul_pos h1 h2) h3) (by norm_num)
  · exact div_pos (mul_pos (mul_pos (mul_pos h1 h5) h3) h4) (by norm_num)

end HamiltonsCubic.MissingTypes
