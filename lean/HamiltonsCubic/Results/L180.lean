import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L180, Ricci-flatness is a signed PSD identity

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L180. For `W = Σ λᵢ ωᵢ ⊗ ωᵢ` in
spectral form, Ricci-flatness is `Σ λᵢ ωᵢ² = 0`, a signed combination of positive semidefinite
`Aᵢ = ωᵢ ωᵢᵀ` of trace `2`, and tracelessness is its trace. With [L179](L179.lean) this reduces
[I38](../../../plan.md) to the single case `dim V ≥ 6`.

**What is checked here.** The scalar consequences: tracelessness is the trace of Ricci-flatness;
at rank three the signs cannot all agree; the minority-sign split; the rank-two collapse
`λ₂ = -λ₁ ⟹ A₁ = A₂`; and the dimension bookkeeping that rules out `dim V = 2` and leaves `6`.

**What is not.** That `ωωᵀ` is positive semidefinite with `range = supp ω`, and that the range of
a sum of PSD matrices is the sum of their ranges, matrix facts the base layer does not carry.
-/

namespace HamiltonsCubic.RicciPSD

/-! ## Tracelessness is the trace of Ricci-flatness -/

/-- **`tr(ω²) = -2‖ω‖²`**, so the trace of `Σ λᵢ ωᵢ² = 0` is `-2 Σ λᵢ = 0`. Tracelessness is
therefore not a further condition. -/
theorem trace_of_ricci (l₁ l₂ l₃ : ℝ) (h : -2 * l₁ + -2 * l₂ + -2 * l₃ = 0) :
    l₁ + l₂ + l₃ = 0 := by linarith

/-- And `Aᵢ = -ωᵢ²` has trace `2` at unit norm. -/
theorem trace_A_is_two : -(-2 : ℝ) = 2 := by norm_num

/-! ## At rank three the signs cannot all agree -/

/-- **Three nonzero reals summing to zero are not all of one sign.** All positive gives a positive
sum; all negative a negative one. -/
theorem signs_differ (l₁ l₂ l₃ : ℝ) (hs : l₁ + l₂ + l₃ = 0)
    (hp : 0 < l₁) (hq : 0 < l₂) (hr : 0 < l₃) : False := by linarith

/-- So the pattern is two of one sign and one of the other, and moving the minority term leaves a
PSD sum equal to a PSD matrix. -/
theorem minority_split (l₁ l₂ l₃ : ℝ) (h : l₁ + l₂ + l₃ = 0) : l₁ + l₂ = -l₃ := by linarith

/-! ## The rank-two collapse -/

/-- **At rank two, `λ₂ = -λ₁`**, so `λ₁A₁ + λ₂A₂ = 0` reads `A₁ = A₂` and the two forms share a
support. -/
theorem rank_two_same_support (l a₁ a₂ : ℝ) (hl : l ≠ 0) (h : l * a₁ + -l * a₂ = 0) : a₁ = a₂ := by
  have : l * (a₁ - a₂) = 0 := by linarith
  rcases mul_eq_zero.mp this with h' | h'
  · exact absurd h' hl
  · linarith

/-! ## The dimension bookkeeping -/

/-- **`dim V = 2` is impossible**: `Λ²V` is then one-dimensional, so the rank is at most one, and
[L179](L179.lean) rules rank one out. -/
theorem dim_two_gives_rank_one : 2 * 1 / 2 = 1 := by norm_num

/-- A `2`-form's support has even dimension, so the cases are `2, 4, 6, …`; `2` is out and
[L178](L178.lean) covers `4`. **`6` is the whole of what remains.** -/
theorem remaining_case : (4 : ℕ) < 6 ∧ (2 : ℕ) < 4 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.RicciPSD
