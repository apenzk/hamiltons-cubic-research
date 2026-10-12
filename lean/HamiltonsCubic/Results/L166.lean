import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

/-!
# L166, for the Kähler family, Ricci-flatness and first Bianchi are one condition

[ungraded-slack.md](../../../findings/ungraded-slack.md)'s Lemma L166. For
`W_{a,b} = a·Π_𝔨 + b·Π_𝔪` inside `𝔰𝔲(m) ⊂ 𝔰𝔬(2m)`, both conditions reduce to
`am + b(m+2) = 0`, so [L38](../../../findings/ungraded-slack.md)'s second family lies in
`Weyl_{2m}` at every `m ≥ 2`.

**What is checked here.** The dimension count `p + q = m² - 1`; the Casimir values
`C_𝔨 = p/m` and `C_𝔪 = q/m`; that Ricci-flatness `ap + bq = 0` factors as
`((m-1)/2)·[am + b(m+2)]`; that the Bianchi equation `a/2 + b(1/2 + 1/m) = 0` is the same
line at `(1/2m)`; and that `m = 1` is the one falsifier of the second half of the statement.

**What is not.** That `Ω_𝔨` and `Ω_𝔪` take the tabled values at `(e₁,e₂,f₁,f₂)`, and that
they vanish on the four outer summands of `Λ⁴(A ⊕ B)`, those are the bivector computations,
and the base layer has no `Λ⁴` type to state them over.
-/

namespace HamiltonsCubic.KahlerFamily

/-! ## Dimensions -/

/-- `p = m(m-1)/2` and `q = (m+2)(m-1)/2` sum to `dim 𝔰𝔲(m) = m² - 1`. -/
theorem dims_sum (m : ℚ) :
    m * (m - 1) / 2 + (m + 2) * (m - 1) / 2 = m ^ 2 - 1 := by ring

/-! ## The Casimirs, each scalar and each one trace -/

/-- `C_𝔨 = -Σ v² = (m-1)/2`, computed directly, each index lying in `m - 1` pairs. **This is
what survives at `m = 2`**, where `ℝ²` is `𝔰𝔬(2)`-irreducible over `ℝ` but not absolutely so,
its real endomorphism algebra being `ℂ`, so real Schur returns a two-parameter family. -/
theorem casimir_k (m : ℚ) (hm : m ≠ 0) : m * (m - 1) / 2 / m = (m - 1) / 2 := by
  field_simp

/-- `C_𝔪 = q/m = (m-1)(m+2)/(2m)`. -/
theorem casimir_m (m : ℚ) (hm : m ≠ 0) :
    (m + 2) * (m - 1) / 2 / m = (m - 1) * (m + 2) / (2 * m) := by
  field_simp

/-- The two add to `C_𝔰𝔲(m) = (p+q)/m = (m²-1)/m`, the cross-check both audits ran. -/
theorem casimir_sum (m : ℚ) (hm : m ≠ 0) :
    (m - 1) / 2 + (m - 1) * (m + 2) / (2 * m) = (m ^ 2 - 1) / m := by
  field_simp
  ring

/-! ## The two conditions are one line -/

/-- **Ricci-flatness.** `ap + bq = ((m-1)/2)·[am + b(m+2)]`, the factor is `(m-1)/2`,
not `(m-1)`, which an earlier version of the findings block printed. -/
theorem ricci_factors (a b m : ℚ) :
    a * (m * (m - 1) / 2) + b * ((m + 2) * (m - 1) / 2)
      = (m - 1) / 2 * (a * m + b * (m + 2)) := by ring

/-- **First Bianchi.** `a·(1/2) + b·(1/2 + 1/m) = (1/(2m))·[am + b(m+2)]`. -/
theorem bianchi_factors (a b m : ℚ) (hm : m ≠ 0) :
    a * (1 / 2) + b * (1 / 2 + 1 / m) = 1 / (2 * m) * (a * m + b * (m + 2)) := by
  field_simp

/-- **So the two cut the same line at every `m ≥ 2`**, both prefactors being nonzero there. -/
theorem conditions_agree (a b m : ℚ) (hm : 2 ≤ m) :
    (a * (m * (m - 1) / 2) + b * ((m + 2) * (m - 1) / 2) = 0)
      ↔ (a * m + b * (m + 2) = 0) := by
  have hf : (m - 1) / 2 ≠ 0 := by
    intro h; linarith
  rw [ricci_factors]
  constructor
  · intro h
    rcases mul_eq_zero.mp h with h1 | h2
    · exact absurd h1 hf
    · exact h2
  · intro h; rw [h, mul_zero]

/-- The solution line is `(a, b) ∝ (m+2, -m)`. -/
theorem solution_line (m : ℚ) : (m + 2) * m + (-m) * (m + 2) = 0 := by ring

/-! ## `m = 1` is the one falsifier, and `m ≥ 2` excludes it -/

/-- At `m = 1` both projections vanish, so every `(a,b)` gives `W = 0 ∈ Weyl₂`, while
`am + b(m+2) = a + 3b` does not vanish identically. **The hypothesis `m ≥ 2` protects the
"and nowhere else on the line" half**, and nothing else. -/
theorem m_one_falsifies : (1 : ℚ) * (1 - 1) / 2 = 0 ∧ (1 + 2) * (1 - 1) / 2 = 0
    ∧ (1 : ℚ) * 1 + 1 * (1 + 2) ≠ 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The `m = 2` edge, where the family is `W_{ℂP²}` -/

/-- At `m = 2` the equation is `2a + 4b = 0`, which is `ap + bq = 0` at `(p,q) = (1,2)`,
tracelessness and nothing more, matching `Weyl₄ = S²₀(Λ⁺) ⊕ S²₀(Λ⁻)`. **The traceless
qualifier is load-bearing**: `Π_{Λ⁺}` itself has `Ω = 3/2`, so Bianchi is automatic on
`S²₀(Λ^±)` and fails on `S²(Λ^±)`. -/
theorem m_two_is_tracelessness (a b : ℚ) :
    (a * 2 + b * (2 + 2) = 0) ↔ (a * 1 + b * 2 = 0) := by
  constructor <;> intro h <;> linarith

end HamiltonsCubic.KahlerFamily
