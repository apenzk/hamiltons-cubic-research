import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

/-!
# L115, the caps on the coordinate-diagonal locus, as arithmetic

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L115, audited in
[ROUND_L115](../../../verification/ROUND_L115.md). On the coordinate-diagonal operators the
Rayleigh quotient of `M` splits into a Weyl part and a non-Weyl part `{u_i + u_j}` with no cross
term, and the non-Weyl part is capped by `½ λ_max(Λ)`, with `Λ` the hollow matrix of `W`'s
entries. Three pieces of arithmetic carry the lemma's second part:

* **the non-Weyl cap squared is below `1/2`.** `Λ` is traceless with `‖Λ‖_F² = 2` and `Λ 𝟙 = 0`,
  so `λ_max(Λ)² ≤ 2(n-2)/(n-1)`, and `¼ · 2(n-2)/(n-1) < 1/2`.
* **at `S^m × S^m` the cap squared is below `θ²`.** The cap is `√((m-1)/(2m-1))` and
  `θ² = (m-1)(2m-1)/m²`, and `(m-1)/(2m-1) < (m-1)(2m-1)/m²` for every `m ≥ 2`.
* **the chain `√(3/2) ≤ θ` fails at `S⁴×S⁴` and `S⁵×S⁵`**, where `θ² = 21/16` and `36/25`, while
  `θ² ≥ 1/2` holds at every `m ≥ 2`, which is all the argument uses.
-/

namespace HamiltonsCubic.OutsideItsSpace

/-- **The non-Weyl cap squared, `¼ · 2(n-2)/(n-1)`, is below `1/2` at every `n ≥ 3`.** -/
theorem nonWeyl_cap_sq_lt_half {n : ℕ} (hn : 3 ≤ n) :
    (1 / 4 : ℚ) * (2 * ((n : ℚ) - 2) / ((n : ℚ) - 1)) < 1 / 2 := by
  have hn' : (3 : ℚ) ≤ (n : ℚ) := by exact_mod_cast hn
  have hpos : (0 : ℚ) < (n : ℚ) - 1 := by linarith
  have h : 2 * ((n : ℚ) - 2) / ((n : ℚ) - 1) < 2 := by
    rw [div_lt_iff₀ hpos]
    linarith
  linarith

/-- **At `S^m × S^m` the non-Weyl cap squared is below `θ²`**:
`(m-1)/(2m-1) < (m-1)(2m-1)/m²` for every `m ≥ 2`. -/
theorem sphere_product_cap_below_theta {m : ℕ} (hm : 2 ≤ m) :
    ((m : ℚ) - 1) / (2 * (m : ℚ) - 1) < ((m : ℚ) - 1) * (2 * (m : ℚ) - 1) / (m : ℚ) ^ 2 := by
  have hm' : (2 : ℚ) ≤ (m : ℚ) := by exact_mod_cast hm
  have h1 : (0 : ℚ) < 2 * (m : ℚ) - 1 := by linarith
  have h2 : (0 : ℚ) < (m : ℚ) ^ 2 := by positivity
  have h3 : (0 : ℚ) < (m : ℚ) - 1 := by linarith
  rw [div_lt_div_iff₀ h1 h2]
  have : (m : ℚ) ^ 2 < (2 * (m : ℚ) - 1) ^ 2 := by nlinarith
  nlinarith [this, h3]

/-- **`θ² = 21/16` and `36/25` at `S⁴×S⁴` and `S⁵×S⁵` are below `3/2`**, so the chain
`√(3/2) ≤ θ` is false there. -/
theorem chain_fails_at_four_and_five :
    (4 - 1 : ℚ) * (2 * 4 - 1) / 4 ^ 2 = 21 / 16 ∧ (21 : ℚ) / 16 < 3 / 2 ∧
    (5 - 1 : ℚ) * (2 * 5 - 1) / 5 ^ 2 = 36 / 25 ∧ (36 : ℚ) / 25 < 3 / 2 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- **But `θ² ≥ 1/2` at every `m ≥ 2`**, which is all the non-Weyl step needs. -/
theorem theta_sq_ge_half {m : ℕ} (hm : 2 ≤ m) :
    (1 / 2 : ℚ) ≤ ((m : ℚ) - 1) * (2 * (m : ℚ) - 1) / (m : ℚ) ^ 2 := by
  have hm' : (2 : ℚ) ≤ (m : ℚ) := by exact_mod_cast hm
  have h2 : (0 : ℚ) < (m : ℚ) ^ 2 := by positivity
  rw [le_div_iff₀ h2]
  nlinarith

end HamiltonsCubic.OutsideItsSpace
