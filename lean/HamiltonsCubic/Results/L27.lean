import Mathlib
import HamiltonsCubic.Results.L26Statement

set_option linter.style.longLine false

/-!
# L27, sphere products are Morse–Bott nondegenerate: the arithmetic

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L27: for `p, q ≥ 3`,
`(p,q) ≠ (3,3)`, `λ_max(L_e|_{W^⊥}) = ½` at `W_{p,q}`, attained exactly on the orbit tangent.

**The argument has two halves.** The representation theory (the ten summands are irreducible and
pairwise non-isomorphic under `O(p) × O(q)`, Nienhaus Proposition 4.6, so the equivariant `L_e`
acts on each by a scalar) is imported and **not typed**: Mathlib carries no representation theory
of the orthogonal groups. **The arithmetic the argument then runs on is proved here**, over `ℚ`:

- `dim_sum`: the ten dimensions sum to `dim Weyl_n = n(n+1)(n+2)(n−3)/12` identically in `p, q`;
- `overcount_two` and `overcount_one`: at `q = 2` and `q = 1` the formula-dimensions over-count the
  true ones by `2` and by `1 + p`, since `dim Weyl_2` reads `−2`, and `dim Weyl_1` and `dim X_1`
  read `−1`, so the decomposition itself fails for `q ≤ 2`;
- `half_minus_lam`: `½ − λ_m = 1/(2(m−1)) > 0`;
- `half_minus_mu_pos` and `half_minus_mu_three`: `(p−2)(q−2) − 1 > 0` for integers `p, q ≥ 3`
  off `(3,3)`, and `= 0` at `(3,3)`, the sign of `½ − μ = ((p−2)(q−2)−1)/(2(p−1)(q−1))`;
- `mu_diag`: that display gives `μ = 1/(m−1)` at `p = q = m`, the value
  [second-order.md](../../../findings/second-order.md) records;
- `collision_three`: at `(3,3)`, `dim E(½) = pq + dim(Λ²⊗Λ²) = 9 + 9 = 18`;
- `mu_eq_L26`: this `μ` is [L26Statement.lean](L26Statement.lean)'s `(p+q−2)/(2(p−1)(q−1))`;
- `trace_identity`: `1 + pq/2 + λ_p dim S²₀(ℝᵖ) + λ_q dim S²₀(ℝ^q) + μ(dim Λ²⊗Λ² − dim S²₀⊗S²₀) = 0`,
  the trace of `L_e` over `Weyl_n` summand by summand, which is what puts `−μ` on `S²₀ ⊗ S²₀`.
-/

namespace HamiltonsCubic.L27

/-- `dim Weyl_n = n(n+1)(n+2)(n−3)/12`, as a formula. -/
def dimW (n : ℚ) : ℚ := n * (n + 1) * (n + 2) * (n - 3) / 12

/-- `dim X_m = m(m² − 4)/3`, the `[2,1]` irreducible, as a formula. -/
def dimX (m : ℚ) : ℚ := m * (m ^ 2 - 4) / 3

/-- `dim S²₀(ℝᵐ)`. -/
def dimS (m : ℚ) : ℚ := m * (m + 1) / 2 - 1

/-- `dim Λ²(ℝᵐ)`. -/
def dimL (m : ℚ) : ℚ := m * (m - 1) / 2

/-- The ten summands' formula-dimensions. -/
def tenSum (p q : ℚ) : ℚ :=
  1 + dimW p + dimW q + p * q + dimS p + dimS q + dimS p * dimS q + dimL p * dimL q
    + dimX p * q + dimX q * p

/-- **The ten dimensions sum to `dim Weyl_{p+q}` identically.** -/
theorem dim_sum (p q : ℚ) : tenSum p q = dimW (p + q) := by
  unfold tenSum dimW dimX dimS dimL; ring

/-- The true dimensions at `q = 2`: `Weyl_2 = 0` and `X_2 = 0`. -/
def tenSumTrue2 (p : ℚ) : ℚ :=
  1 + dimW p + 0 + p * 2 + dimS p + dimS 2 + dimS p * dimS 2 + dimL p * dimL 2 + dimX p * 2 + 0 * p

/-- **At `q = 2` the formula over-counts by `2`**: `dim Weyl_2` reads `−2`. -/
theorem overcount_two (p : ℚ) : tenSumTrue2 p - dimW (p + 2) = 2 := by
  have h := dim_sum p 2
  unfold tenSumTrue2
  unfold tenSum at h
  have hW2 : dimW 2 = -2 := by unfold dimW; norm_num
  have hX2 : dimX 2 = 0 := by unfold dimX; norm_num
  rw [hW2, hX2] at h
  linarith

/-- The true dimensions at `q = 1`: `Weyl_1 = 0`, `X_1 = 0`. -/
def tenSumTrue1 (p : ℚ) : ℚ :=
  1 + dimW p + 0 + p * 1 + dimS p + dimS 1 + dimS p * dimS 1 + dimL p * dimL 1 + dimX p * 1 + 0 * p

/-- **At `q = 1` the formula over-counts by `1 + p`**: `dim Weyl_1` and `dim X_1` read `−1`. -/
theorem overcount_one (p : ℚ) : tenSumTrue1 p - dimW (p + 1) = 1 + p := by
  have h := dim_sum p 1
  unfold tenSumTrue1
  unfold tenSum at h
  have hW1 : dimW 1 = -1 := by unfold dimW; norm_num
  have hX1 : dimX 1 = -1 := by unfold dimX; norm_num
  rw [hW1, hX1] at h
  linarith

/-- `λ_m = (m−2)/(2(m−1))`. -/
def lam (m : ℚ) : ℚ := (m - 2) / (2 * (m - 1))

/-- **`½ − λ_m = 1/(2(m−1))`, positive for `m > 1`.** -/
theorem half_minus_lam (m : ℚ) (hm : 1 < m) : 1 / 2 - lam m = 1 / (2 * (m - 1)) ∧ 0 < 1 / 2 - lam m := by
  have hm1 : m - 1 ≠ 0 := by linarith
  have e : 1 / 2 - lam m = 1 / (2 * (m - 1)) := by unfold lam; field_simp; ring
  refine ⟨e, ?_⟩
  rw [e]; apply div_pos one_pos; linarith

/-- `μ` from the record's display `½ − μ = ((p−2)(q−2)−1)/(2(p−1)(q−1))`. -/
def mu (p q : ℚ) : ℚ := 1 / 2 - ((p - 2) * (q - 2) - 1) / (2 * (p - 1) * (q - 1))

/-- **At `p = q = m`, `μ = 1/(m−1)`**, the value [second-order.md] records. -/
theorem mu_diag (m : ℚ) (hm : 1 < m) : mu m m = 1 / (m - 1) := by
  have hm1 : m - 1 ≠ 0 := by linarith
  unfold mu; field_simp; ring

/-- **The strict sign off `(3,3)`**: for integers `p, q ≥ 3` with `(p,q) ≠ (3,3)`,
`(p−2)(q−2) − 1 > 0`. -/
theorem half_minus_mu_pos (p q : ℕ) (hp : 3 ≤ p) (hq : 3 ≤ q) (hne : (p, q) ≠ (3, 3)) :
    0 < ((p : ℚ) - 2) * ((q : ℚ) - 2) - 1 := by
  have hp' : (3 : ℚ) ≤ p := by exact_mod_cast hp
  have hq' : (3 : ℚ) ≤ q := by exact_mod_cast hq
  rcases Nat.lt_or_ge 3 p with h | h
  · have : (4 : ℚ) ≤ p := by exact_mod_cast h
    nlinarith
  · have hp3 : p = 3 := le_antisymm h hp
    subst hp3
    have hq4 : 4 ≤ q := by
      rcases Nat.lt_or_ge 3 q with h' | h'
      · exact h'
      · exact absurd (by rw [le_antisymm h' hq]) hne
    have : (4 : ℚ) ≤ q := by exact_mod_cast hq4
    push_cast; nlinarith

/-- **So `½ − μ > 0` there**, the denominator `2(p−1)(q−1)` being positive. -/
theorem half_minus_mu_gt (p q : ℕ) (hp : 3 ≤ p) (hq : 3 ≤ q) (hne : (p, q) ≠ (3, 3)) :
    mu p q < 1 / 2 := by
  have h := half_minus_mu_pos p q hp hq hne
  have hp' : (3 : ℚ) ≤ p := by exact_mod_cast hp
  have hq' : (3 : ℚ) ≤ q := by exact_mod_cast hq
  have hden : 0 < 2 * ((p : ℚ) - 1) * ((q : ℚ) - 1) := by nlinarith
  unfold mu
  have := div_pos h hden
  linarith

/-- **At `(3,3)` the two scalars collide**: `μ = ½`. -/
theorem half_minus_mu_three : mu 3 3 = 1 / 2 := by unfold mu; norm_num

/-- **The collision at `(3,3)`**: `dim E(½) = pq + dim(Λ²⊗Λ²) = 18` against an orbit of `9`. -/
theorem collision_three : (3 : ℚ) * 3 + dimL 3 * dimL 3 = 18 ∧ (3 : ℚ) * 3 = 9 := by
  unfold dimL; norm_num

/-- **This `μ` is L26's.** -/
theorem mu_eq_L26 (p q : ℚ) (hp : p - 1 ≠ 0) (hq : q - 1 ≠ 0) :
    mu p q = HamiltonsCubic.L26Statement.mu p q := by
  unfold mu HamiltonsCubic.L26Statement.mu
  field_simp; ring

/-- **The trace identity that puts `−μ` on `S²₀ ⊗ S²₀`**: the values `1`, `½`, `λ_p`, `λ_q`, `μ`,
`−μ`, `0` weighted by the summands' dimensions sum to zero. -/
theorem trace_identity (p q : ℚ) (hp : p - 1 ≠ 0) (hq : q - 1 ≠ 0) :
    1 + p * q / 2 + lam p * dimS p + lam q * dimS q
      + mu p q * (dimL p * dimL q - dimS p * dimS q) = 0 := by
  unfold lam mu dimS dimL
  field_simp; ring

end HamiltonsCubic.L27
