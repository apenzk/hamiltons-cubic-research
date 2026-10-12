import HamiltonsCubic.Base.RelationC
import HamiltonsCubic.Base.Spectrum

/-!
# L70's identity at the competitor, the deficiency vanishes

The boxed identity reads, at a critical point and a unit `v ∈ E_min`,

`θ = λ_min + (n-2) λ_max - D(v)/|λ_min|`,  `D(v) ≥ 0`.

**At padded `W_{ℂP²}` the deficiency is zero**, which is what
[post 41](../../../findings/INDEX-traps.md) records as the LP being *exactly
tight* there, *because `dim E_max = 1` makes the row cap bind*.

**In rational form.** On the unnormalised tensor the spectrum is `(2,-1,-1,0,0,0)`
and `‖W‖² = 6`, so `λ_min = -1`, `λ_max = 2` and

`λ_min + (n-2) λ_max = -1 + 2·2 = 3`,

while [relation (C)](../Base/RelationC.lean) gives `Q(W) = 3W`, i.e. `θ‖W‖ = 3`.
The two sides agree at `3`, so `D = 0`, and the identity is checked at a point
without either side being normalised.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L70b

open HamiltonsCubic.Base

/-- The spectrum's extremes, from [B7](../Base/Spectrum.lean)'s complete list. -/
theorem lambda_min : (![2, -1, -1, 0, 0, 0] : Fin 6 → ℚ) 1 = -1 := by
  norm_num [Matrix.cons_val_one, Matrix.vecHead]

theorem lambda_max : (![2, -1, -1, 0, 0, 0] : Fin 6 → ℚ) 0 = 2 := by
  norm_num [Matrix.cons_val_zero]

/-- **The identity's right side, with `n = 4`.** -/
theorem deficiency_free_side : (-1 : ℚ) + (4 - 2) * 2 = 3 := by norm_num

/-- **And it equals the criticality eigenvalue**, so the deficiency vanishes at
the competitor. -/
theorem deficiency_vanishes :
    Qop WCP2 = ((-1 : ℚ) + (4 - 2) * 2) • WCP2 := by
  rw [deficiency_free_side]
  exact WCP2_critical

end HamiltonsCubic.L70b
