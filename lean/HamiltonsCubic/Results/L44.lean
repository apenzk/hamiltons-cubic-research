import HamiltonsCubic.Results.L2
import HamiltonsCubic.Base.RelationC

/-!
# L44, `n ≥ 12` is necessary, not merely sufficient

The padded `W_{ℂP²}` keeps `θ = √(3/2)` at every `n`, and the invariance
criterion fails at the boundary point it furnishes exactly when
`θ₀(n)² < 3/2`, i.e. `n² - 12n + 8 < 0`, i.e. `4 ≤ n ≤ 11` over the integers.

**This file composes two results already proved rather than restating either.**

* the value `θ² = 3/2`, at `n = 4`, from `Q`, [Base/CP2.lean](../Base/CP2.lean);
* the range `4 ≤ n ≤ 11`, from [L2](L2.lean)'s `threshold_neg` and
  `threshold_pos`, which give the sign of `n² - 12n + 8` in both directions.

**What is owed** is the padding: that `θ` is unchanged when `W_{ℂP²}` is padded
into `𝒲ₙ` for `n > 4`. The record gets it from `Λ²U = 𝔰𝔬(U)` being a subalgebra,
so `W#` stays inside `Λ⁺`. The padding map is not built, so the value is
formalised at `n = 4` alone.
-/

namespace HamiltonsCubic.L44

open HamiltonsCubic.L2 Matrix

/-- **The criterion fails exactly on `4 ≤ n ≤ 11`**, and holds from `12` on.
`θ₀(n)² - 3/2` has the sign of `n² - 12n + 8`, by [L2](L2.lean)'s identity. -/
theorem criterion_fails_iff {n : ℤ} (h4 : 4 ≤ n) :
    n ^ 2 - 12 * n + 8 < 0 ↔ n ≤ 11 := by
  constructor
  · intro h
    by_contra hc
    exact absurd h (not_lt.mpr (le_of_lt (threshold_pos (by omega))))
  · intro h
    exact threshold_neg h4 h

/-- And the value the competitor supplies at `n = 4` is `3/2`, from the
definition of `Q`, see `Base.WCP2_theta_sq`. The two together are L44's
statement at `n = 4`; the padding to general `n` is owed. -/
theorem competitor_value_four :
    HamiltonsCubic.Base.Pcubic HamiltonsCubic.Base.WCP2 ^ 2 * 2
      = 3 * ((HamiltonsCubic.Base.WCP2ᵀ * HamiltonsCubic.Base.WCP2).trace) ^ 3 :=
  HamiltonsCubic.Base.WCP2_theta_sq

end HamiltonsCubic.L44
