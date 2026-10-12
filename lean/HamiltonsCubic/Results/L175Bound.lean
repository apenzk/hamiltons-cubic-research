import Mathlib

set_option linter.style.longLine false

/-!
# L175's constructive refutation: a `θ`-bound from (A), (C) and `T ≥ 0`

[bounds-relaxations.md](../../../findings/bounds-relaxations.md), Lemma L175: *"Taking (C) against (A) with the
termwise AM–GM `ν_q ν_r ≤ V`, `V = max_q ν_q²`, gives `θ ≤ ν_i + (n-2)V/ν_i` for each `i` with `ν_i > 0`, the same algebra
bounding `θ` from below at `ν_i < 0`, an explicit `θ`-bound whose only inputs besides (C) are (A) and `T ≥ 0` … At
L173's witness it returns `22√21/21 ≈ 4.80` against that lemma's own `√21/2`."* With `T` a
nonnegative tensor, row `i` of (A) reading `Σ_{q,r} T_{iqr} = 2(n-2)` and of (C)
reading `Σ_{q,r} T_{iqr} ν_q ν_r = 2ν_i(θ - ν_i)`, and `V ≥ ν_q²` for every `q`:

* **`theta_le`**: at `ν_i > 0`, `θ ≤ ν_i + (n-2)V/ν_i`;
* **`theta_ge_of_neg`**: at `ν_i < 0` the same algebra gives the reverse, `θ ≥ ν_i + (n-2)V/ν_i`, the block's lower
  bound;
* **`witness_value`**: at L173's witness (`n = 12`, `ν = a(-1, 4/3, 0)`, `a² = 3/28`, `V = (4a/3)²`, `ν_i = 4a/3`) the
  bound is `22√21/21`, above the witness's `θ = √21/2`, so it is slack there.

The inputs are row `i` of (A) and (C), `T ≥ 0` and `V ≥ ν_q²`: neither (B) nor the symmetry of `T` enters.
-/

namespace HamiltonsCubic.L175Bound

open Finset

variable {ι : Type*} [Fintype ι]

/-- The row inequality: `Σ T ν_q ν_r ≤ V Σ T` for `T ≥ 0` and `ν_q² ≤ V`, pointwise from `ν_q ν_r ≤ V`. -/
theorem row_le (T : ι → ι → ℝ) (hT : ∀ q r, 0 ≤ T q r) (ν : ι → ℝ) {V : ℝ}
    (hV : ∀ q, ν q ^ 2 ≤ V) : ∑ q, ∑ r, T q r * (ν q * ν r) ≤ V * ∑ q, ∑ r, T q r := by
  -- `ν_q ν_r ≤ (ν_q² + ν_r²)/2 ≤ V`
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun q _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun r _ => ?_
  have h1 : ν q * ν r ≤ V := by nlinarith [sq_nonneg (ν q - ν r), hV q, hV r]
  nlinarith [hT q r]

/-- **L175's bound at a positive `ν_i`**: `θ ≤ ν_i + (n-2)V/ν_i`. -/
theorem theta_le (T : ι → ι → ℝ) (hT : ∀ q r, 0 ≤ T q r) (ν : ι → ℝ) {V n θ νi : ℝ}
    (hV : ∀ q, ν q ^ 2 ≤ V) (hA : ∑ q, ∑ r, T q r = 2 * (n - 2))
    (hC : ∑ q, ∑ r, T q r * (ν q * ν r) = 2 * νi * (θ - νi)) (hpos : 0 < νi) :
    θ ≤ νi + (n - 2) * V / νi := by
  have h := row_le T hT ν hV
  rw [hC, hA] at h
  have : θ - νi ≤ (n - 2) * V / νi := by
    rw [le_div_iff₀ hpos]; nlinarith
  linarith

/-- **At a negative `ν_i` the bound reverses**: `θ ≥ ν_i + (n-2)V/ν_i`. -/
theorem theta_ge_of_neg (T : ι → ι → ℝ) (hT : ∀ q r, 0 ≤ T q r) (ν : ι → ℝ)
    {V n θ νi : ℝ} (hV : ∀ q, ν q ^ 2 ≤ V) (hA : ∑ q, ∑ r, T q r = 2 * (n - 2))
    (hC : ∑ q, ∑ r, T q r * (ν q * ν r) = 2 * νi * (θ - νi)) (hneg : νi < 0) :
    νi + (n - 2) * V / νi ≤ θ := by
  have h := row_le T hT ν hV
  rw [hC, hA] at h
  have : (n - 2) * V / νi ≤ θ - νi := by
    rw [div_le_iff_of_neg hneg]; nlinarith
  linarith

/-- **At L173's witness the bound is `22√21/21`**, above `θ = √21/2`. -/
theorem witness_value {a : ℝ} (ha : 0 < a) (ha2 : a ^ 2 = 3 / 28) :
    4 * a / 3 + (12 - 2) * (4 * a / 3) ^ 2 / (4 * a / 3) = 22 * Real.sqrt 21 / 21 ∧
      Real.sqrt 21 / 2 < 22 * Real.sqrt 21 / 21 := by
  have h21 : Real.sqrt 21 = 14 * a := by
    rw [show (21 : ℝ) = (14 * a) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by positivity)
  constructor
  · rw [h21]; field_simp; ring
  · have : 0 < Real.sqrt 21 := by positivity
    linarith

end HamiltonsCubic.L175Bound
