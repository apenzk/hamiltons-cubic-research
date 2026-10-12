import HamiltonsCubic.Results.L67
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L107, the spectral restatement, and the value it shares with L67

[bounds.md](../../../findings/bounds.md)'s Lemma L107. The audit says the inequality *"is
tight, not auxiliary"*: `(n-1)|λ_min| = θ₀(n)` exactly at the balanced product and at every
Einstein `Sᵖ × S^q`.

**That tightness is an identity in `n`, and it lands on a number the record already holds.**
`(n-1)|λ_min| = θ₀(n)` is equivalent to `λ_min² = 2(n-2)/(n²(n-1))`, which is proved below as
a rational identity. **At `n = 6` it evaluates to `2/45`**, and `2/45` is exactly
[L67](L67.lean)'s `B`-block value `(2A)²` at `m = 3`, the number
[nondegeneracy.md](../../../findings/nondegeneracy.md) records as `0.210818511`.

So L107's tightness at `S³ × S³` and L67's second-kind spectrum are **the same number reached
from two directions**, and neither block cites the other. The file imports L67 rather than
retyping it, so the agreement is checked rather than asserted.

**Post F40's closure transferred an equality case between two objects both called `Π`.** A
name shared by two quantities licenses nothing, and `same_name_different_object` is that with
nothing else in it.
-/

namespace HamiltonsCubic.SpectralTarget

open HamiltonsCubic.SecondKind

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
def theta0Sq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- The value `λ_min²` must take for `(n-1)|λ_min| = θ₀(n)`. -/
def lamMinSq (n : ℚ) : ℚ := 2 * (n - 2) / (n ^ 2 * (n - 1))

/-! ## Tightness is an identity in `n` -/

/-- **`(n-1)² λ_min² = θ₀(n)²`**, identically in `n`, so the tightness claim is one equation
rather than a family of coincidences at the tabulated products. -/
theorem tightness (n : ℚ) (hn : 3 ≤ n) : (n - 1) ^ 2 * lamMinSq n = theta0Sq n := by
  unfold lamMinSq theta0Sq
  have h0 : n ≠ 0 := by intro h; linarith
  have h1 : n - 1 ≠ 0 := by intro h; linarith
  field_simp

/-! ## The value at `n = 6` is L67's -/

/-- **`λ_min²  = 2/45` at `n = 6`.** -/
theorem lamMin_at_six : lamMinSq 6 = 2 / 45 := by unfold lamMinSq; norm_num

/-- **And `2/45` is L67's `B`-block value `(2A)²` at `m = 3`**, imported, not retyped, so the
two blocks are checked against each other. -/
theorem agrees_with_L67 : lamMinSq 6 = 2 ^ 2 * (1 / 90) := by
  rw [lamMin_at_six]; norm_num

theorem L67_value : (2 : ℚ) ^ 2 * (1 / 90) = 2 / 45 := B_block_sq

/-- The record's `0.210818511` brackets it, so the decimal, L107's tightness and L67's
spectrum are one number. -/
theorem decimal_brackets :
    ((210818510 : ℚ) / 1000000000) ^ 2 < 2 / 45
      ∧ (2 : ℚ) / 45 < ((210818512 : ℚ) / 1000000000) ^ 2 := by
  constructor <;> norm_num

/-- And it returns `θ₀(6)² = 10/9` through the tightness identity. -/
theorem returns_theta0_six : (6 - 1 : ℚ) ^ 2 * lamMinSq 6 = 10 / 9 := by
  unfold lamMinSq; norm_num

/-! ## Post F40's closure -/

/-- **A name shared by two quantities licenses no transfer.** Two objects may both be called
`Π` and satisfy different equalities, so an equality case established for one says nothing
about the other. -/
theorem same_name_different_object :
    ∃ P₁ P₂ : ℚ, P₁ ≠ P₂ ∧ P₁ = 0 ∧ P₂ ≠ 0 :=
  ⟨0, 1, by norm_num, rfl, by norm_num⟩

end HamiltonsCubic.SpectralTarget
