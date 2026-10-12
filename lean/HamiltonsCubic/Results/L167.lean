import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-!
# L167, the competitor's stabiliser and the orbit dimension

[route-a.md](../../../findings/route-a.md)'s Lemma L167. For `u = W_{ℂP²}` padded from `ℝ⁴`
into `ℝⁿ`, the stabiliser meets the mixed block trivially, so `stab(u) = 𝔲(2) ⊕ 𝔰𝔬(m)` and the
orbit has dimension `4n - 14`.

**What is checked here.** The dimension arithmetic, and the constant in the invertibility step.

**Elsewhere.** The parity argument splitting `stab(u)` across the blocks is
[L167Statement.lean](L167Statement.lean)'s `parity_splits`, and the first display, the mixed block meeting
`stab(u)` trivially, is [L167Mixed.lean](L167Mixed.lean)'s `stab_mixed_trivial`. The second display is
[L167Stab.lean](L167Stab.lean)'s `stab_so4` on `𝔰𝔬(4)` and [L167Full.lean](L167Full.lean)'s `stab_full` at every `n`.
-/

namespace HamiltonsCubic.CompetitorStabiliser

/-! ## The orbit dimension -/

/-- **`C(n,2) - C(n-4,2) - 4 = 4n - 14`**, the figure [L21](../../../findings/route-a.md)
asserts. The `4` is `dim 𝔲(2)`: three from the summand of `𝔰𝔬(4)` complementary to `u`'s
support, which commutes with it, and one from `𝔰𝔬(2)`, the stabiliser of `diag(2,-1,-1)`
under `𝔰𝔬(3)`. -/
theorem orbit_dimension (n : ℚ) :
    n * (n - 1) / 2 - (n - 4) * (n - 5) / 2 - 4 = 4 * n - 14 := by ring

/-- The stabiliser's `𝔰𝔬(4)`-part is `3 + 1 = 4 = dim 𝔲(2)`, and the algebra is
`Λ^∓ ⊕ ℝJ ≅ 𝔰𝔲(2) ⊕ 𝔲(1)` rather than merely four-dimensional, a dimension coincidence was
all the block originally offered. -/
theorem stabiliser_four : (3 : ℚ) + 1 = 4 := by norm_num

/-- The edges `m = 0, 1, 2` give `2, 6, 10`, matching `4n - 14` at `n = 4, 5, 6`. -/
theorem edges : (4 : ℚ) * 4 - 14 = 2 ∧ (4 : ℚ) * 5 - 14 = 6 ∧ (4 : ℚ) * 6 - 14 = 10 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The invertibility constant, corrected at audit -/

/-- **A nonzero `ω ∈ Λ^±` satisfies `ω² = -(1/2)‖ω‖²·Id`, not `-‖ω‖²·Id`.** At
`ω = e₁₂ + e₃₄` the square is `-Id` while `‖ω‖² = 2` under the half-trace pairing. *The block
carried the factor-free form, which is true under the operator norm; only invertibility is
read, so nothing downstream moved.* -/
theorem omega_square_constant : (2 : ℚ) * (1 / 2) = 1 := by norm_num

/-- And that is what makes such an `ω` invertible: `ω² = -(1/2)‖ω‖²·Id` with `‖ω‖ ≠ 0`. -/
theorem omega_invertible (nrm : ℚ) (h : nrm ≠ 0) : -(1 / 2) * nrm ^ 2 ≠ 0 := by
  intro hc
  apply h
  have : nrm ^ 2 = 0 := by linarith
  exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this

end HamiltonsCubic.CompetitorStabiliser
