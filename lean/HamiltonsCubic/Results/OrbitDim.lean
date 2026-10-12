import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# The orbit dimensions, in closed form

[nondegeneracy.md](../../../findings/nondegeneracy.md) tabulates, for each sphere
product, four columns of the same integer, `16, 16, 16, 16` at `S⁴×S⁴`, `25` four times
at `S⁵×S⁵`, `36` at `S⁶×S⁶`, `35` at `S⁵×S⁷`. **The repetition is the content**: the
Hessian kernel equals the orbit tangent exactly, which is Morse–Bott nondegeneracy.

The integers themselves are printed and never named. They are `pq`:

  `dim(orbit of Sᵖ×S^q) = C(n,2) - C(p,2) - C(q,2) = pq`,  `n = p + q`,

the standard identity, so `16 = 4·4`, `25 = 5·5`, `36 = 6·6` and `35 = 5·7`. **A column
of `35`s next to three columns of squares reads as four unrelated measurements; `pq`
covers all four rows at once.**

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.OrbitDim

/-- The orbit dimension of `Sᵖ×S^q` inside `𝒲_{p+q}`: the ambient `𝔰𝔬(n)` less the
isotropy `𝔰𝔬(p) ⊕ 𝔰𝔬(q)`. -/
def orbitDim (p q : ℚ) : ℚ :=
  (p + q) * (p + q - 1) / 2 - p * (p - 1) / 2 - q * (q - 1) / 2

/-- **The identity: it is `pq`.** -/
theorem orbitDim_eq (p q : ℚ) : orbitDim p q = p * q := by
  unfold orbitDim; ring

/-! ## The four tabulated rows -/

theorem s4_s4 : orbitDim 4 4 = 16 := by rw [orbitDim_eq]; norm_num
theorem s5_s5 : orbitDim 5 5 = 25 := by rw [orbitDim_eq]; norm_num
theorem s6_s6 : orbitDim 6 6 = 36 := by rw [orbitDim_eq]; norm_num
theorem s5_s7 : orbitDim 5 7 = 35 := by rw [orbitDim_eq]; norm_num

/-- The balanced case is `(n/2)²`, which is why three of the four rows are squares and
the unbalanced one is not. -/
theorem balanced_is_square (m : ℚ) : orbitDim m m = m ^ 2 := by
  rw [orbitDim_eq]; ring

/-- **And the unbalanced row is strictly smaller at the same dimension**: `35 < 36` at
`n = 12`, since `pq` is maximised at `p = q`. -/
theorem unbalanced_smaller : orbitDim 5 7 < orbitDim 6 6 := by
  rw [orbitDim_eq, orbitDim_eq]; norm_num

/-- In general, splitting a fixed `n` unevenly costs exactly the square of the
imbalance: `m² - (m-k)(m+k) = k²`. -/
theorem imbalance_cost (m k : ℚ) : orbitDim m m - orbitDim (m - k) (m + k) = k ^ 2 := by
  rw [orbitDim_eq, orbitDim_eq]; ring

/-! ## The degenerate exception

`S³×S³` at `n = 6` has orbit `9` and Hessian kernel `18`, the one sphere product the
record records as genuinely degenerate. The excess is exactly the orbit dimension again.
-/

theorem s3_s3_orbit : orbitDim 3 3 = 9 := by rw [orbitDim_eq]; norm_num

/-- **The excess is `9`, equal to the orbit itself**, the kernel is exactly twice the
orbit there, which the record states as `18` against `9` and does not remark on. -/
theorem s3_s3_excess : (18 : ℚ) - orbitDim 3 3 = orbitDim 3 3 := by
  rw [orbitDim_eq]; norm_num

/-! ## The padded competitor

The record gives `dim T(orbit of padded W_{ℂP²}) = 4n - 14`, and tabulates `10` at
`n = 6` and `18` at `n = 8`.
-/

def cpOrbitDim (n : ℚ) : ℚ := 4 * n - 14

theorem cp_at_6 : cpOrbitDim 6 = 10 := by norm_num [cpOrbitDim]
theorem cp_at_8 : cpOrbitDim 8 = 18 := by norm_num [cpOrbitDim]
theorem cp_at_10 : cpOrbitDim 10 = 26 := by norm_num [cpOrbitDim]

/-- At `n = 4`, where `ℂP²` is unpadded, the formula gives `2`, the orbit of a point
with `U(2)` isotropy in `SO(4)`, `6 - 4 = 2`. **So the closed form extends below the
padded range it was written for**, which the record does not claim. -/
theorem cp_at_4 : cpOrbitDim 4 = 2 := by norm_num [cpOrbitDim]

/-- **The two orbits cross between `n = 10` and `n = 12`.** The competitor's is larger at
`n = 6, 8, 10` (`10 > 9`, `18 > 16`, `26 > 25`) and smaller at `n = 12`, `34 < 36`,
since `4n - 14` is linear and `(n/2)²` is quadratic. -/
theorem cp_vs_balanced_6 : orbitDim 3 3 < cpOrbitDim 6 := by
  rw [orbitDim_eq]; norm_num [cpOrbitDim]

theorem cp_vs_balanced_12 : cpOrbitDim 12 < orbitDim 6 6 := by
  rw [orbitDim_eq]; norm_num [cpOrbitDim]

/-! ## What this settles

**Settled**: that the tabulated orbit dimensions are `pq`, one formula covering three
squares and one non-square, where the table shows four unrelated integers; that
imbalance costs exactly `k²`; that `S³×S³`'s degenerate kernel is exactly twice its
orbit; and that the competitor's `4n - 14` still gives the right answer at `n = 4`,
outside the padded range it was written for.

**Not settled here**: that the Hessian kernel equals the orbit, that is the record's
computation, and the four equal columns are its statement.
-/

end HamiltonsCubic.OrbitDim
