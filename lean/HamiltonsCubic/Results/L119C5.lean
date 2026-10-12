import Mathlib

set_option linter.style.longLine false

/-!
# L119's `C₅` figure, derived rather than measured

[findings/bounds-relaxations.md](../../../findings/bounds-relaxations.md), Lemma L119: *"From the recorded entries
`4 : -2 : +1` with blocks `(2,2,2,2,2)`, the row sum and `180c² = 1` give `c = 1/(6√5)`, and Lemma L68's closed form gives
`g = 0/1.2/0.6` …, reproducing `Δ = 12`, `M = 24`, `Σ g = 36 = 4(n-1)`, and `0.894427 → 0.670820 = θ` exactly."* The
`C₅` blow-up at `n = 10`: five blocks of two, in a cycle, the weight `4c` within a block, `-2c` between adjacent blocks
and `+c` between non-adjacent ones.

* **`c5_rowSum`**: each row sums to zero, `4c - 8c + 4c = 0` (one within-block partner, four adjacent, four non-adjacent);
* **`c5_normSq`**: the squared norm over the `45` pairs is `180c²` (`5·16c² + 20·4c² + 20·c²`), so unit norm is
  `c = 1/(6√5)`;
* **`c5_bounds`**: with `|λ_min| = 2c`, `λ^min_𝔭 = c`, `M = 24` and `Δ = 12`, the unsharpened bound `|λ_min| M/4 = 12c`
  is `2/√5 = 0.894427…` and the sharpened `[|λ_min| M - λ^min_𝔭 Δ]/4 = 9c` is `3/(2√5) = 0.670820…`, the recorded `θ`;
* **`c5_gsum`**: `M = 24`, `Δ = 12` and `Σ g = 36 = 4(n - 1)` from `g = 0, 6/5, 3/5` on the `5`, `20`, `20` pairs of each
  kind.

The `g` values are L68's closed form, taken as recorded; `θ = 3/(2√5)` at this point is the record's value, which the
sharpened bound meets.
-/

namespace HamiltonsCubic.L119C5

theorem c5_rowSum (c : ℝ) : 1 * (4 * c) + 4 * (-2 * c) + 4 * c = 0 := by ring

theorem c5_normSq (c : ℝ) : 5 * (4 * c) ^ 2 + 20 * (-2 * c) ^ 2 + 20 * c ^ 2 = 180 * c ^ 2 := by ring

/-- The unit-norm constant `c = 1/(6√5)`. -/
noncomputable def c5 : ℝ := 1 / (6 * Real.sqrt 5)

theorem c5_unit : 180 * c5 ^ 2 = 1 := by
  rw [c5, div_pow, mul_pow, Real.sq_sqrt (by norm_num)]; norm_num

theorem c5_bounds :
    (2 * c5) * 24 / 4 = 2 / Real.sqrt 5 ∧ ((2 * c5) * 24 - c5 * 12) / 4 = 3 / (2 * Real.sqrt 5) := by
  have h5 : Real.sqrt 5 ≠ 0 := by positivity
  constructor <;> (rw [c5]; field_simp; ring)

theorem c5_bound_values :
    (0.894427 : ℝ) < 2 / Real.sqrt 5 ∧ 2 / Real.sqrt 5 < 0.894428 ∧
      (0.670820 : ℝ) < 3 / (2 * Real.sqrt 5) ∧ 3 / (2 * Real.sqrt 5) < 0.670821 := by
  have hs : (2.2360679 : ℝ) < Real.sqrt 5 := by
    rw [Real.lt_sqrt (by norm_num)]; norm_num
  have hs' : Real.sqrt 5 < (2.2360680 : ℝ) := by
    rw [Real.sqrt_lt' (by norm_num)]; norm_num
  have hp : 0 < Real.sqrt 5 := by positivity
  refine ⟨?_, ?_, ?_, ?_⟩ <;> [rw [lt_div_iff₀ hp]; rw [div_lt_iff₀ hp]; rw [lt_div_iff₀ (by positivity)];
    rw [div_lt_iff₀ (by positivity)]] <;> nlinarith

/-- `M = Σ_{λ<0} g = 20 · 6/5 = 24` on the adjacent pairs, `Δ = Σ_{λ>0} g = 5 · 0 + 20 · 3/5 = 12` on the within-block
and non-adjacent pairs, and `Σ g = 36 = 4(n - 1)`. -/
theorem c5_gsum : (20 : ℝ) * (6 / 5) = 24 ∧ 5 * (0 : ℝ) + 20 * (3 / 5) = 12 ∧
    5 * (0 : ℝ) + 20 * (6 / 5) + 20 * (3 / 5) = 36 ∧ (36 : ℝ) = 4 * (10 - 1) := by norm_num

end HamiltonsCubic.L119C5
