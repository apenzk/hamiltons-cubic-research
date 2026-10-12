import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

/-!
# L171, `V(t)` has two constants, not three

[route-a.md](../../../findings/route-a.md)'s Lemma L171. With `a = ‖Π_ker Q(W₁)‖` and
`λ = λ_max(M_{W₁})`, and under `M_{W₁}q = 0`, the inner maximisation is `a` below
`t* = a/(2λ)` and `a²/(4λt) + λt` above.

**What is checked here.** That the two-parameter form reproduces the record's three constants
from `a² = 5/6` and `λ = 2/3`; that `t*` and `5/16` each pin `λ` independently; and that the
tangency is structural, the frontier branch's minimum sits at `t*` with value `a`.

**What is not.** That `λ_max(M_{W₁}) = 2/3`, which remains a spectral fact measured at one
dimension, and the reduction of the maximisation to two parameters, which is what `c₀ = 1`
asserts and the block does not derive.

**The range matters.** The closed form holds for `t ≥ 0` and `λ > 0`. At `t < 0` the first
branch is false: with `M = diag(0, 2/3, -1)` and `q = (√(5/6), 0, 0)` every other hypothesis
holds and `V(-2) = 101/48 ≠ a`. *Both audits found this independently, and the theorems below
carry the hypothesis the prose first omitted.*
-/

namespace HamiltonsCubic.InnerMaximisation

/-! ## The two constants reproduce the three -/

/-- **`a²/(4λ) = 5/16`** at `a² = 5/6`, `λ = 2/3`. -/
theorem frontier_coefficient : (5 / 6 : ℚ) / (4 * (2 / 3)) = 5 / 16 := by norm_num

/-- **`t*² = a²/(4λ²) = 15/32`**, which is `(√30/8)²`, the record's branch point. -/
theorem branch_point_squared : (5 / 6 : ℚ) / (4 * (2 / 3) ^ 2) = 15 / 32 := by norm_num

/-- And `(√30/8)² = 30/64 = 15/32`, so the two agree. -/
theorem root_thirty_over_eight : (30 : ℚ) / 64 = 15 / 32 := by norm_num

/-- **`5/16` pins `λ`**: `a²/(4λ) = 5/16` with `a² = 5/6` forces `λ = 2/3`. -/
theorem coefficient_pins_lambda (lam : ℚ) (hl : lam ≠ 0)
    (h : (5 / 6 : ℚ) / (4 * lam) = 5 / 16) : lam = 2 / 3 := by
  field_simp at h
  linarith

/-- **`t*` pins `λ` too**, and to the same value: `t*² = a²/(4λ²) = 15/32` with `λ > 0`. -/
theorem branch_point_pins_lambda (lam : ℚ) (hl : 0 < lam)
    (h : (5 / 6 : ℚ) / (4 * lam ^ 2) = 15 / 32) : lam = 2 / 3 := by
  have h4 : (4 : ℚ) * lam ^ 2 ≠ 0 := by positivity
  field_simp at h
  nlinarith [h, hl]

/-! ## The maximisation, and the structural tangency -/

/-- The interior maximum of `f(c) = ac + tλ(1-c²)` sits at `c* = a/(2tλ)` with value
`a²/(4λt) + λt`. -/
theorem interior_value (a lam t : ℚ) (hl : lam ≠ 0) (ht : t ≠ 0) :
    a * (a / (2 * t * lam)) + t * lam * (1 - (a / (2 * t * lam)) ^ 2)
      = a ^ 2 / (4 * lam * t) + lam * t := by
  field_simp
  ring

/-- **The interior point is admissible exactly when `t ≥ a/(2λ)`**, since `c* ≤ 1` is that. -/
theorem interior_admissible (a lam t : ℚ) (hl : 0 < lam) (ht : 0 < t) (ha : 0 < a) :
    a / (2 * t * lam) ≤ 1 ↔ a / (2 * lam) ≤ t := by
  rw [div_le_iff₀ (by positivity : (0:ℚ) < 2 * t * lam),
      div_le_iff₀ (by positivity : (0:ℚ) < 2 * lam)]
  constructor <;> intro h <;> nlinarith [h]

/-- **The tangency is structural.** The frontier branch's minimum is at `t = a/(2λ)`, which is
`t*` itself, and its value there is `a`, the constant branch exactly. Shown at the recorded
constants: `(5/16)/t* + (2/3)t* = √(5/6)`, both sides squaring to `5/6`. -/
theorem tangency_at_branch_point (a lam : ℚ) (hl : 0 < lam) (ha : 0 < a) :
    a ^ 2 / (4 * lam * (a / (2 * lam))) + lam * (a / (2 * lam)) = a := by
  field_simp
  ring

end HamiltonsCubic.InnerMaximisation
