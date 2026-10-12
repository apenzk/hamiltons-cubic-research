import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-!
# The tube radius, as an algebraic number

[L20](../../../findings/problem.md)'s proof runs: with `φ` the distance to the
competitor's orbit, the cubic expansion gives `m ≤ cos φ + m sin³ φ`, hence
`m ≤ ψ(φ) ≤ 1`, and the contradiction needs `φ ≤ 0.5748`. That number is quoted
fifteen times in the record, always as four decimals, and it is **the radius of the
excluded tube**, the whole quantitative content of the lemma.

It is not a measurement. `ψ(φ) = cos φ / (1 - sin³ φ)` reaches `1` exactly when
`cos φ + sin³ φ = 1`; writing `s = sin φ` and squaring gives `s⁴ - 2s + 1 = 0`, which
factors as `(s - 1)(s³ + s² + s - 1)`. **So the radius is `arcsin s*` with `s*` the
real root of `s³ + s² + s - 1`**, an algebraic number of degree three.

This file does the part that lives in `ℚ`: the factorisation, that the cubic has one
root in `(0,1)` and where it is. The step from `s*` to `φ` is
[L20Arcsin.lean](L20Arcsin.lean)'s, over `ℝ`.

Everything is `ring`, `norm_num` or `linarith`, kernel-checked.
-/

namespace HamiltonsCubic.TubeRadius

/-- The quartic that squaring produces. -/
def quartic (s : ℚ) : ℚ := s ^ 4 - 2 * s + 1

/-- The cubic that carries the root. -/
def cubic (s : ℚ) : ℚ := s ^ 3 + s ^ 2 + s - 1

/-- **The factorisation.** `s = 1` is the spurious root introduced by squaring,
`φ = π/2`, and the radius is the other one. -/
theorem quartic_factors (s : ℚ) : quartic s = (s - 1) * cubic s := by
  unfold quartic cubic; ring

/-! ## The cubic has exactly one root in `(0,1)` -/

/-- It is strictly increasing on `s ≥ 0`: the difference of values factors with a
positive second factor. -/
theorem cubic_strict_mono {a b : ℚ} (ha : 0 ≤ a) (hab : a < b) : cubic a < cubic b := by
  have key : cubic b - cubic a
      = (b - a) * (b ^ 2 + a * b + a ^ 2 + (b + a) + 1) := by
    unfold cubic; ring
  have h1 : 0 < b - a := by linarith
  have hb : 0 ≤ b := by linarith
  have h2 : 0 < b ^ 2 + a * b + a ^ 2 + (b + a) + 1 := by positivity
  nlinarith [mul_pos h1 h2]

theorem cubic_neg_at_zero : cubic 0 < 0 := by norm_num [cubic]
theorem cubic_pos_at_one : 0 < cubic 1 := by norm_num [cubic]

/-! ## Where the root is

Bracketing to four places, which is the precision the record prints for `φ`.
-/

theorem bracket_lower : cubic (5436 / 10000) < 0 := by norm_num [cubic]
theorem bracket_upper : 0 < cubic (5437 / 10000) := by norm_num [cubic]

/-- **So `0.5436 < s* < 0.5437`**, and by monotonicity the root is unique there. -/
theorem root_bracket :
    cubic (5436 / 10000) < 0 ∧ 0 < cubic (5437 / 10000) := ⟨bracket_lower, bracket_upper⟩

/-- A tighter bracket, to seven places. -/
theorem bracket_tight :
    cubic (5436890 / 10000000) < 0 ∧ 0 < cubic (5436891 / 10000000) := by
  constructor <;> norm_num [cubic]

/-! ## The radius is irrational

`s³ + s² + s - 1` has no rational root, so `s*` is irrational and the recorded
`0.5748` cannot be exact in any base. By the rational root theorem a rational root
would be `±1`, and neither is one.
-/

theorem no_rational_root_one : cubic 1 ≠ 0 := by norm_num [cubic]
theorem no_rational_root_neg_one : cubic (-1) ≠ 0 := by norm_num [cubic]

/-- The only candidates the rational root theorem allows are `±1`, and the cubic
takes the values `2` and `-2` there. -/
theorem candidates_fail : cubic 1 = 2 ∧ cubic (-1) = -2 := by
  constructor <;> norm_num [cubic]

/-! ## What this settles

**Settled**: that the quartic from squaring factors as `(s-1)(s³+s²+s-1)`; that the
cubic is strictly increasing on `s ≥ 0` and changes sign in `(0,1)`, so it has exactly
one root there; that the root lies in `(0.5436890, 0.5436891)`; and that it is
irrational, since the only rational candidates are `±1`.

**Settled in [L20Arcsin.lean](L20Arcsin.lean)**: that `φ = arcsin s*` (`radius_eq_sStar`, with the real root
built there, since over `ℚ` this cubic has none), and the cubic expansion `m ≤ cos φ + m sin³ φ`
(`expansion_step`).

**What this changes about the record**: `0.5748` is a rounding of an algebraic number
of degree three, not a chosen or fitted constant. **A reader cannot tell that from four
decimals**, and the lemma's *"more than double the largest published `γₙ`"*
compares an algebraic number to a published one.
-/

end HamiltonsCubic.TubeRadius
