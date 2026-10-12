import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L113, the moment pair that attains Lemma L107, and where the row cap bites

[bounds.md](../../../findings/bounds.md)'s Lemma L113, audited in
[ROUND_L113](../../../verification/ROUND_L113.md). With `m₀, m₁, m₂` the first three moments of a
nonnegative `g` on a spectrum in `[a, b]`, two inequalities hold for every such `g`:
Cauchy–Schwarz `m₁² ≤ m₀ m₂` and the support bound `m₂ ≤ (a + b) m₁ - a b m₀`, the second from
`Σ gₖ (λₖ - a)(b - λₖ) ≥ 0`. **Eliminating `m₂` between them gives `(m₁ - a m₀)(m₁ - b m₀) ≤ 0`,**
the two-moment feasibility condition itself, which at the pinned `m₀ = 4(n-1)` and `m₁ = -4θ` is
Lemma L107. The characterisation that every such conclusion follows from that condition is
`feasible_iff` in [L113Statement](L113Statement.lean).

**The row cap is a further constraint.** At unit norm `a² + b² ≤ 1`, so `(b - a)² ≤ 2`, and
[Lemma L109](../../../findings/bounds-relaxations.md)'s cap `g_γ ≤ 2(n-2)(b - a)²` is at most
`4(n-2) < 4(n-1) = m₀`. A two-atom `g` with all its mass on a simple `λ_min` is therefore excluded.
-/

namespace HamiltonsCubic.MomentAnalysis

/-- **ELIMINATING `m₂` BETWEEN CAUCHY–SCHWARZ AND THE SUPPORT BOUND GIVES THE TWO-MOMENT
CONDITION.** -/
theorem pair_eliminates {a b m₀ m₁ m₂ : ℝ} (hm₀ : 0 ≤ m₀) (hcs : m₁ ^ 2 ≤ m₀ * m₂)
    (hsup : m₂ ≤ (a + b) * m₁ - a * b * m₀) :
    (m₁ - a * m₀) * (m₁ - b * m₀) ≤ 0 := by
  have h := mul_le_mul_of_nonneg_left hsup hm₀
  nlinarith [h, hcs]

/-- **At unit norm the spectral gap squared is at most `2`**: `a² + b² ≤ 1` gives
`(b - a)² ≤ 2`. -/
theorem gap_sq_le_two {a b : ℝ} (h : a ^ 2 + b ^ 2 ≤ 1) : (b - a) ^ 2 ≤ 2 := by
  nlinarith [sq_nonneg (a + b)]

/-- **So the row cap sits below the total mass**: `2(n-2)(b - a)² ≤ 4(n-2) < 4(n-1)` for
`n ≥ 2`. -/
theorem cap_below_mass {a b : ℝ} {n : ℕ} (hn : 2 ≤ n) (h : a ^ 2 + b ^ 2 ≤ 1) :
    2 * ((n : ℝ) - 2) * (b - a) ^ 2 < 4 * ((n : ℝ) - 1) := by
  have hn' : (2 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hg := gap_sq_le_two h
  have hnn : 0 ≤ (n : ℝ) - 2 := by linarith
  have : 2 * ((n : ℝ) - 2) * (b - a) ^ 2 ≤ 2 * ((n : ℝ) - 2) * 2 :=
    mul_le_mul_of_nonneg_left hg (by linarith)
  linarith

end HamiltonsCubic.MomentAnalysis
