import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-!
# L173, the pinned class cannot bound `θ` once a kernel is allowed

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L173. At `n = 12` the
spectrum with values `(-a, 4a/3, 0)` and multiplicities `(4, 3, 59)`, `a = √(3/28)`, admits a
hollow `T ≥ 0` meeting relations (A), (B), (C) at every row and the pair cap at every pair,
with `θ = 7a = √21/2 > θ₀(12)`.

**Everything is stated over `ℚ`.** Writing `ν = a·(-1, 4/3, 0)` makes (B) rational and (C)
rational in `θ/a`, so `a` never appears as a variable and the squares are compared instead of
the roots.

**An earlier version of this file carried two vacuous theorems**, `unit_norm` and
`theta_closed_form`, each hypothesising `a^2 = 3/28` for a rational `a`, which has no solution,
so both were empty. It also mislabelled row 3's cancellation as (B₂), leaving (B₂) and (C₃)
checked nowhere, and its docstring claimed a nonnegativity check the file did not contain.
Both Gate 2 reviewers found all three.

**What is not checked here.** That the ten value-type variables suffice, the direction this
lemma uses is an elementary lift of a `G`-invariant `T` back to the full tensor, not
[L104](../../../findings/bounds-relaxations.md)'s reduction, which runs the other way.
-/

namespace HamiltonsCubic.PinnedKernel

/-! ## The forced parameters, over `ℚ` throughout -/

/-- Multiplicities sum to `C(12,2) = 66`. -/
theorem multiplicities : 4 + 3 + 59 = 12 * 11 / 2 := by norm_num

/-- Tracelessness `-4a + 3b = 0` gives `b = 4a/3`, for every `a`. -/
theorem traceless (a : ℚ) : -4 * a + 3 * (4 * a / 3) = 0 := by ring

/-- Unit norm: `4 + 3·(4/3)² = 28/3`, so `a² = 3/28` is what `‖W‖ = 1` forces. -/
theorem unit_norm : 4 + 3 * (4 / 3 : ℚ) ^ 2 = 28 / 3 := by norm_num

/-! ## The nine relations, in `ν = a·(-1, 4/3, 0)` coordinates with `θ/a = 7` -/

theorem row1_A : 18 * (2 / 3 : ℚ) + 3422 * (4 / 1711) = 20 := by norm_num

theorem row1_B : 3 * (2 / 3 : ℚ) = 2 := by norm_num

/-- (C₁): `-18·(4/3)·t₁₁₂ = -2(θ/a) - 2` at `θ/a = 7`. -/
theorem row1_C : -18 * (4 / 3 : ℚ) * (2 / 3) = -2 * 7 - 2 := by norm_num

theorem row2_A : 12 * (2 / 3 : ℚ) + 2 * 2 + 3422 * (4 / 1711) = 20 := by norm_num

/-- **(B₂), which the earlier file omitted.** `-12·t₁₁₂ + 2·(4/3)·t₂₂₂ = -2·(4/3)`, since
`t₂₂₃ = 0` kills the only other term. -/
theorem row2_B : -12 * (2 / 3 : ℚ) + 2 * (4 / 3) * 2 = -2 * (4 / 3) := by norm_num

theorem row2_C : 12 * (2 / 3 : ℚ) + 2 * (4 / 3) ^ 2 * 2 = 2 * (4 / 3) * 7 - 2 * (4 / 3) ^ 2 := by
  norm_num

theorem row3_A : 2 * (232 * (4 / 1711 : ℚ) + 174 * (4 / 1711)) + 3306 * (178 / 32509) = 20 := by
  norm_num

/-- (B₃) reads `0 = 0` because `232·(-1) + 174·(4/3) = 0`. -/
theorem row3_B : (232 : ℚ) * (-1) + 174 * (4 / 3) = 0 := by norm_num

/-- **(C₃), which the earlier file omitted.** Every type it touches, `t₁₂₃`, `t₁₁₃`, `t₂₂₃`,
is zero at this witness, so it reads `0 = 0` with no cancellation needed. -/
theorem row3_C : 2 * (12 * (-1 : ℚ) * (4 / 3) * 0) + (12 * 1 * 0 + 6 * (4 / 3) ^ 2 * 0) = 0 := by
  norm_num

/-! ## The pair caps -/

/-- `(1,1)`, `(1,2)` and `(2,2)` are all exactly `2`. -/
theorem caps_tight :
    2 * (0 : ℚ) + 3 * (2 / 3) + 59 * 0 = 2 ∧
    3 * (2 / 3 : ℚ) + 2 * 0 + 59 * 0 = 2 ∧
    4 * (0 : ℚ) + 1 * 2 + 59 * 0 = 2 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- `(1,3)` and `(2,3)` read `8/59`, and `(3,3)` reads `562/1711`; all below `2`. -/
theorem caps_slack :
    58 * (4 / 1711 : ℚ) = 8 / 59 ∧ (8 : ℚ) / 59 < 2 ∧
    4 * (4 / 1711 : ℚ) + 3 * (4 / 1711) + 57 * (178 / 32509) = 562 / 1711 ∧
    (562 : ℚ) / 1711 < 2 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-! ## Nonnegativity, which the earlier docstring claimed and the file omitted -/

/-- **`T ≥ 0` at all ten value types.** The six unlisted are zero. -/
theorem witness_nonneg :
    (0 : ℚ) ≤ 2 / 3 ∧ (0 : ℚ) ≤ 2 ∧ (0 : ℚ) ≤ 4 / 1711 ∧ (0 : ℚ) ≤ 178 / 32509
      ∧ (0 : ℚ) ≤ 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num, le_refl 0⟩

/-! ## The conclusion, as a comparison of squares -/

/-- **`θ² = 49a² = 49·(3/28) = 21/4`**, so `θ = √21/2`. -/
theorem theta_squared : 49 * (3 / 28 : ℚ) = 21 / 4 := by norm_num

/-- **And `θ₀(12)² = 220/144 < 21/4`**, so the witness exceeds the threshold. -/
theorem exceeds_threshold : (220 : ℚ) / 144 < 21 / 4 := by norm_num

/-- The ratio, squared: `(21/4)/(220/144) = 189/55`. -/
theorem ratio_squared : (21 / 4 : ℚ) / (220 / 144) = 189 / 55 := by norm_num

end HamiltonsCubic.PinnedKernel
