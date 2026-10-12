import Mathlib

/-!
# The product foothold for (MG), the arithmetic core

[reviews/2026-09-28-LIT-step8-sweep.md](../../../reviews/2026-09-28-LIT-step8-sweep.md), route R53,
phase 3a.

**The source's statement.** "At a global maximiser `ρ = Θ_n ≥ d`, so **either `b = 0` (`W` is
diagonal) or `t ≤ c_*/(d - c_*)`**, and (MG) holds whenever `t ≥ c_*/(d - c_*)`." Here `W = A + B`
in a frame maximising the diagonal mass, `t = ‖A‖`, `b = ‖B‖`, `A = t e` with `e` the unit Weyl
tensor of a sphere product, `Q(e) = d e`, and `a = ⟪L_A B, B⟫`.

**What is typed.** The inference from four scalar facts to the dichotomy and to (MG):
* `t ^ 2 + b ^ 2 = 1`, the unit norm split.
* `d * t ^ 3 = ρ * t ^ 2 - a`, L214's first relation with `P(A) = d t³`.
* `a ≤ t * c * b ^ 2`, the coupling bound the character table gives.
* `d ≤ ρ`, global maximality against the product.

**Not typed**: the coupling bound itself, which rests on the character table of `L_e` at a sphere
product and on the maximal frame's first-order condition, one-plane bound and double rotation.
That is the structural half, argued in the note.
-/

namespace HamiltonsCubic.ProductFoothold

/-- **(MG) AS A COUPLING BOUND.** Above `√(3/2)`, (MG) `ρ ≤ max {√(3/2), P(A)/t³}` is
`a ≤ ρ t² (1 - t)`, through L214's relation `P(A) = ρ t² - a`. -/
theorem mg_iff_coupling (ρ PA t a : ℝ) (ht : 0 < t) (hρ : Real.sqrt (3 / 2) < ρ)
    (hrel : PA = ρ * t ^ 2 - a) :
    ρ ≤ max (Real.sqrt (3 / 2)) (PA / t ^ 3) ↔ a ≤ ρ * t ^ 2 * (1 - t) := by
  have ht3 : 0 < t ^ 3 := pow_pos ht 3
  rw [le_max_iff, le_div_iff₀ ht3, hrel]
  constructor
  · rintro (h | h)
    · exact absurd h (not_le.mpr hρ)
    · nlinarith
  · intro h; right; nlinarith

/-- **THE KNAPSACK FORM.** With `a = t S`, `S = ∑ λᵢ yᵢ` and `b² = ∑ yᵢ = 1 - t²`, the coupling
bound `a ≤ ρ t² (1 - t)` is `S - (ρ t/(1 + t)) b² ≤ 0`, i.e. `∑ (λᵢ - ρ t/(1 + t)) yᵢ ≤ 0`. -/
theorem coupling_iff_knapsack (ρ t b a S : ℝ) (ht : 0 < t) (hb : b ^ 2 = 1 - t ^ 2)
    (ha : a = t * S) :
    a ≤ ρ * t ^ 2 * (1 - t) ↔ S - ρ * t / (1 + t) * b ^ 2 ≤ 0 := by
  have h1 : 0 < 1 + t := by linarith
  have hk : ρ * t / (1 + t) * b ^ 2 = ρ * t * (1 - t) := by
    rw [hb]; field_simp; ring
  rw [hk, ha]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/-- **THE VALUE BOUND.** `ρ t ≤ d t² + c (1 - t²)`, i.e. `ρ ≤ d t + c (1 - t²)/t`. -/
theorem value_bound (ρ d c t b a : ℝ) (ht : 0 < t) (hunit : t ^ 2 + b ^ 2 = 1)
    (hrel : d * t ^ 3 = ρ * t ^ 2 - a) (hcoup : a ≤ t * c * b ^ 2) :
    ρ * t ≤ d * t ^ 2 + c * (1 - t ^ 2) := by
  have hb2 : b ^ 2 = 1 - t ^ 2 := by linarith
  have h : t * (ρ * t) ≤ t * (d * t ^ 2 + c * (1 - t ^ 2)) := by
    rw [hb2] at hcoup; nlinarith
  exact le_of_mul_le_mul_left h ht

/-- **THE DICHOTOMY.** Either `B = 0`, or `t` is at most the threshold `c/(d - c)`. -/
theorem dichotomy (ρ d c t b a : ℝ) (ht : 0 < t) (hb : 0 ≤ b) (hunit : t ^ 2 + b ^ 2 = 1)
    (hrel : d * t ^ 3 = ρ * t ^ 2 - a) (hcoup : a ≤ t * c * b ^ 2) (hρ : d ≤ ρ)
    (hcd : c < d) : b = 0 ∨ t ≤ c / (d - c) := by
  rcases eq_or_lt_of_le hb with h0 | hpos
  · exact Or.inl h0.symm
  right
  have hv := value_bound ρ d c t b a ht hunit hrel hcoup
  have ht1 : t < 1 := by nlinarith [mul_pos hpos hpos]
  have hdc : 0 < d - c := by linarith
  rw [le_div_iff₀ hdc]
  -- d t ≤ ρ t ≤ d t² + c (1 - t²), and dividing by 1 - t > 0 gives d t ≤ c (1 + t)
  have h1 : (1 - t) * (d * t) ≤ (1 - t) * (c * (1 + t)) := by
    nlinarith [mul_le_mul_of_nonneg_right hρ ht.le]
  have h2 : d * t ≤ c * (1 + t) := le_of_mul_le_mul_left h1 (by linarith)
  linarith

/-- **(MG) ABOVE THE THRESHOLD.** When `c ≤ t (d - c)`, the value is at most `d = P(A)/‖A‖³`. -/
theorem mg_of_threshold (ρ d c t b a : ℝ) (ht : 0 < t) (hunit : t ^ 2 + b ^ 2 = 1)
    (hrel : d * t ^ 3 = ρ * t ^ 2 - a) (hcoup : a ≤ t * c * b ^ 2)
    (hth : c ≤ t * (d - c)) : ρ ≤ d := by
  have hv := value_bound ρ d c t b a ht hunit hrel hcoup
  have ht1 : t ≤ 1 := by nlinarith [sq_nonneg b]
  have h1 : c * (1 - t ^ 2) ≤ d * t * (1 - t) := by
    nlinarith [mul_nonneg (sub_nonneg.2 ht1) (by linarith : (0:ℝ) ≤ t * (d - c) - c)]
  have h2 : ρ * t ≤ d * t := by nlinarith [hv, h1]
  exact le_of_mul_le_mul_right h2 ht

/-- The balanced threshold: at `c = d/(m-1)` the threshold `c/(d - c)` is `1/(m-2)`. -/
theorem balanced_threshold (d m : ℝ) (hd : 0 < d) (hm : 2 < m) :
    (d / (m - 1)) / (d - d / (m - 1)) = 1 / (m - 2) := by
  have h1 : m - 1 ≠ 0 := by linarith
  have h2 : m - 2 ≠ 0 := by linarith
  have h3 : d - d / (m - 1) = d * (m - 2) / (m - 1) := by field_simp; ring
  rw [h3, div_div_div_cancel_right₀ h1, div_eq_div_iff (mul_ne_zero hd.ne' h2) h2]
  ring

/-- **THE AVERAGING COROLLARY'S ARITHMETIC.** At `n ≥ 30` the `O(n)`-average diagonal mass
`6/((n+1)(n+2))` strictly exceeds the squared balanced threshold `(1/(m-2))² = 4/(n-4)²`. -/
theorem average_beats_threshold (n : ℝ) (hn : 30 ≤ n) :
    4 / (n - 4) ^ 2 < 6 / ((n + 1) * (n + 2)) := by
  have h1 : 0 < (n - 4) ^ 2 := pow_pos (by linarith) 2
  have h2 : 0 < (n + 1) * (n + 2) := by positivity
  rw [div_lt_div_iff₀ h1 h2]
  nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ n - 30) (by linarith : (0:ℝ) ≤ n)]

/-- One object satisfying the hypotheses, so `dichotomy` is not vacuous: `W = A` diagonal. -/
example : (1 : ℝ) ^ 2 + (0 : ℝ) ^ 2 = 1 ∧ (1 : ℝ) * 1 ^ 3 = 1 * 1 ^ 2 - 0 ∧
    (0 : ℝ) ≤ 1 * (1 / 2) * 0 ^ 2 := by norm_num

end HamiltonsCubic.ProductFoothold
