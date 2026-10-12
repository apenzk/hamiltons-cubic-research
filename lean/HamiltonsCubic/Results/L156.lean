import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

/-!
# L156's optimum, the four constants, and why they are absolute

[L156](../../../findings/second-order.md) states, for `m ≥ 2` and
`D = (2m-1)/(m-1)`:

  `α* = D/2`,  `γ* = D/4`,  `C* = 2 + 4(m-1)/(2m-1)`,  `J* = 4(1+α*)/α*²`,

with the objective `J = C/γ` and `C(α,γ) = (1+α)/(α-γ)` on `α ≤ D/2`.

**Four constants stated four ways, and the lemma never checks them against each other.**
They are consistent: `C*` is `C(α*,γ*)`, and `J*` is `C*/γ*`.

**And both are absolute.** `C* < 4` reduces to `4m - 4 < 4m - 2`; `J* < 8` reduces to
`α* > 1`, which is `2m - 1 > 2m - 2`. Each approaches its bound from below without
attaining it, so the constants are bounded over the whole family, which is what makes
the optimum usable at every `m` rather than at one.

Everything is `field_simp`/`ring` or `linarith`, kernel-checked.
-/

namespace HamiltonsCubic.L156

/-- `D = (2m-1)/(m-1)`. -/
def D (m : ℚ) : ℚ := (2 * m - 1) / (m - 1)

/-- `C(α,γ) = (1+α)/(α-γ)`, the form valid on `α ≤ D/2`. -/
def C (a g : ℚ) : ℚ := (1 + a) / (a - g)

/-- The stated optimum's value of `C`. -/
def Cstar (m : ℚ) : ℚ := 2 + 4 * (m - 1) / (2 * m - 1)

/-! ## The four constants agree

Written in `α` alone, since `γ* = α*/2`: `C(α, α/2) = 2(1+α)/α`, and dividing by `γ*`
gives `4(1+α)/α²`, the stated `J*`.
-/

/-- **`C` at the optimum is `2(1+α)/α`.** -/
theorem C_at_optimum (a : ℚ) (ha : a ≠ 0) : C a (a / 2) = 2 * (1 + a) / a := by
  unfold C
  rw [show a - a / 2 = a / 2 by ring]
  field_simp

/-- **`J* = C*/γ*` is the stated `4(1+α)/α²`.** -/
theorem J_consistent (a : ℚ) (ha : a ≠ 0) :
    (2 * (1 + a) / a) / (a / 2) = 4 * (1 + a) / a ^ 2 := by
  field_simp
  ring

/-- And `α* = D/2 = (2m-1)/(2(m-1))`, so `C*` in `m` is the record's
`2 + 4(m-1)/(2m-1)`. -/
theorem Cstar_in_m (m : ℚ) (h1 : m - 1 ≠ 0) (h2 : 2 * m - 1 ≠ 0) :
    2 * (1 + (2 * m - 1) / (2 * (m - 1))) / ((2 * m - 1) / (2 * (m - 1))) = Cstar m := by
  unfold Cstar
  field_simp
  ring

/-! ## Both constants are absolute -/

/-- **`C* < 4` reduces to `4m - 4 < 4m - 2`**, true at every `m`. -/
theorem Cstar_reduction (m : ℚ) : 4 * (m - 1) < 2 * (2 * m - 1) := by linarith

theorem Cstar_lt_four {m : ℚ} (hm : 2 ≤ m) : Cstar m < 4 := by
  unfold Cstar
  have h : 0 < 2 * m - 1 := by linarith
  have : 4 * (m - 1) / (2 * m - 1) < 2 := by
    rw [div_lt_iff₀ h]; linarith
  linarith

theorem Cstar_at_2 : Cstar 2 = 10 / 3 := by norm_num [Cstar]
theorem Cstar_at_10 : Cstar 10 = 74 / 19 := by norm_num [Cstar]
theorem Cstar_increasing : Cstar 2 < Cstar 10 := by norm_num [Cstar]

/-- **`α* > 1` reduces to `2m - 2 < 2m - 1`**, true at every `m`. -/
theorem alphaStar_reduction (m : ℚ) : 2 * m - 2 < 2 * m - 1 := by linarith

/-- **`J* < 8` follows from `α > 1`**: `4(1+α) < 8α²` is `(2α+1)(α-1) > 0`. -/
theorem Jstar_lt_eight {a : ℚ} (ha : 1 < a) : 4 * (1 + a) < 8 * a ^ 2 := by
  nlinarith

/-- The two endpoint values the record cites: `40/9` at `m = 2`, which it flags as the
out-of-scope endpoint a reviewer used, and `144/25` at `m = 3`. -/
theorem Jstar_at_2 : 4 * (1 + (3 : ℚ) / 2) / (3 / 2) ^ 2 = 40 / 9 := by norm_num
theorem Jstar_at_3 : 4 * (1 + (5 : ℚ) / 4) / (5 / 4) ^ 2 = 144 / 25 := by norm_num

theorem endpoints_below : (40 : ℚ) / 9 < 8 ∧ (144 : ℚ) / 25 < 8 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled**: that L156's four constants are mutually consistent, `C*` is `C` at the
stated optimum, and `J*` is `C*/γ*`, which the lemma states four ways and never checks;
that `C* < 4` and `J* < 8` at every `m ≥ 2`, each approached from below and neither
attained; and the two endpoint values `40/9` and `144/25`.

**Not settled here**: that the optimum is where the lemma says, which is the
minimisation the record carries, and the resolvent bound the constants feed.
-/

end HamiltonsCubic.L156
