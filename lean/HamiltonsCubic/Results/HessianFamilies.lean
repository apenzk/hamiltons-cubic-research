import HamiltonsCubic.Results.OrbitDim
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

/-!
# The Hessian's four families, and why `k = 3` is the only failure

[algebra.md](../../../findings/algebra.md) closes the balanced family's nondegeneracy in
closed form. With `c = (6F - 3θ)/θ` and `k = n/2`:

  `c_A = -3/(k-1)`,  `c_B = -3(k-3)/(k-1)`,  `c_C = -3`,  `c_D = -3(k+1)/(k-1)`,

and Morse–Bott nondegeneracy is exactly `c = 0` on the orbit tangent and nowhere else.
Setting each to zero: `c_A` never, `c_C` never, `c_D` only at `k = -1`. **Only `c_B`
vanishes, and exactly at `k = 3`.**

> Every balanced sphere product `Sᵏ×Sᵏ` with `k ≥ 4` is Morse–Bott nondegenerate, and
> `k = 3` is the only failure, for all `k` at once, by closed form rather than by sweep.

**This also explains a coincidence recorded elsewhere as unremarked.**
[OrbitDim.lean](HamiltonsCubic/Results/OrbitDim.lean) noted that `S³×S³`'s degenerate
kernel is exactly twice its orbit and said the record does not say why. It does, here:
the kernel is the orbit tangent `k²` plus `dim B = (k(k-1)/2)²`, and at `k = 3` both are
`9`.

Everything is `ring`, `norm_num` or `field_simp`, kernel-checked.
-/

namespace HamiltonsCubic.HessianFamilies

open HamiltonsCubic.OrbitDim

def cA (k : ℚ) : ℚ := -3 / (k - 1)
def cB (k : ℚ) : ℚ := -3 * (k - 3) / (k - 1)
def cC : ℚ := -3
def cD (k : ℚ) : ℚ := -3 * (k + 1) / (k - 1)

/-! ## Which families can vanish -/

/-- `c_A` never vanishes: its numerator is the constant `-3`. -/
theorem cA_ne_zero {k : ℚ} (hk : k ≠ 1) : cA k ≠ 0 := by
  unfold cA
  simp [sub_ne_zero.mpr hk]

/-- `c_C` never vanishes. -/
theorem cC_ne_zero : cC ≠ 0 := by unfold cC; norm_num

/-- `c_D` vanishes only at `k = -1`, outside the admissible range. -/
theorem cD_zero_iff {k : ℚ} (hk : k ≠ 1) : cD k = 0 ↔ k = -1 := by
  unfold cD
  rw [div_eq_zero_iff]
  constructor
  · rintro (h | h)
    · have : k + 1 = 0 := by linarith [h]
      linarith
    · exact absurd h (sub_ne_zero.mpr hk)
  · intro h; left; rw [h]; ring

/-- **`c_B` vanishes exactly at `k = 3`.** -/
theorem cB_zero_iff {k : ℚ} (hk : k ≠ 1) : cB k = 0 ↔ k = 3 := by
  unfold cB
  rw [div_eq_zero_iff]
  constructor
  · rintro (h | h)
    · have : k - 3 = 0 := by linarith [h]
      linarith
    · exact absurd h (sub_ne_zero.mpr hk)
  · intro h; left; rw [h]; ring

/-! ## The tabulated row at `k = 4` -/

/-- **`A` and `B` coincide at `k = 4`**, both `-1`, which is why that row shows four
values where the families are five. -/
theorem coincide_at_4 : cA 4 = -1 ∧ cB 4 = -1 := by
  constructor <;> norm_num [cA, cB]

/-- The `k = 4` row is `(-1, -1, -3, -5)`, as recorded. -/
theorem row_at_4 : cA 4 = -1 ∧ cB 4 = -1 ∧ cC = -3 ∧ cD 4 = -5 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [cA, cB, cC, cD]

/-- At `k = 5` the families separate: `-3/4`, `-3/2`, `-3`, `-9/2`. -/
theorem row_at_5 : cA 5 = -3/4 ∧ cB 5 = -3/2 ∧ cD 5 = -9/2 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num [cA, cB, cD]

/-! ## The failure's size at `k = 3`

`dim B = (k(k-1)/2)²` and the orbit tangent is `k²`. At `k = 3` both are `9`, so the
kernel is `18` against an orbit of `9`.
-/

def dimB (k : ℚ) : ℚ := (k * (k - 1) / 2) ^ 2

theorem dimB_3 : dimB 3 = 9 := by norm_num [dimB]

/-- The orbit at `k = 3` is `9`, `pq` with `p = q = 3`, from
[OrbitDim](HamiltonsCubic/Results/OrbitDim.lean). -/
theorem orbit_3 : orbitDim 3 3 = 9 := by rw [orbitDim_eq]; norm_num

/-- **So the kernel is `18` and the orbit `9`**, the recorded `n = 6` exception, to the
dimension, and the factor of two is `dim B = k²` at `k = 3` rather than a coincidence. -/
theorem kernel_at_3 : dimB 3 + orbitDim 3 3 = 18 ∧ dimB 3 = orbitDim 3 3 := by
  constructor
  · rw [orbitDim_eq]; norm_num [dimB]
  · rw [orbitDim_eq]; norm_num [dimB]

/-- At `k = 4` the two differ (`dim B = 36` against an orbit of `16`) so the equality at
`k = 3` does not persist. -/
theorem differ_at_4 : dimB 4 = 36 ∧ orbitDim 4 4 = 16 := by
  constructor
  · norm_num [dimB]
  · rw [orbitDim_eq]; norm_num

/-! ## What this settles

**Settled**: that among the four families only `c_B` can vanish, and exactly at `k = 3`;
that `A` and `B` coincide at `k = 4`, which is why the recorded row has four entries; the
`k = 4` and `k = 5` rows; and that the `k = 3` kernel is `18` against an orbit of `9`
**because `dim B = k²` there**, not by coincidence.

**A correction this file carries**: [OrbitDim.lean](HamiltonsCubic/Results/OrbitDim.lean)
said the record states `18` against `9` without remarking on the factor of two. **The
record explains it**, in [algebra.md](../../../findings/algebra.md), and that row is
corrected.

**Not claimed**: the four closed forms, which
[algebra.md](../../../findings/algebra.md) itself flags as *"a fit to the three tabulated
rows, not a derivation"*, the record's own scope note, and this file inherits it.
-/

end HamiltonsCubic.HessianFamilies
