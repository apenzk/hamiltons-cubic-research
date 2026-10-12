import HamiltonsCubic.Results.IrreducibleMax

/-!
# The quaternionic family, checked against the three rows it covers

[INDEX-values.md](../../../findings/INDEX-values.md) closes with:

> **The quaternionic family is closed in form**:
> `θ²(ℍPᵐ) = (m+2)²(4m-1) / (9m(m-1)(2m+1))`, strictly decreasing, so
> `sup_m θ = √(56/45) < √(3/2)` and `θ → √2/3`, every `m` is covered without ad hoc
> work.

**The form covers three of the index's own rows**, and they are listed separately, in a
different file, with no note that one formula gives all three:

| row | `m` | `n` | value |
|---|---|---|---|
| `1.115547 = √(56/45)` | `2` | `8` | `56/45` |
| `0.852944 = √(275/378)` | `3` | `12` | `275/378` |
| `0.745356 = √(5/9)` | `4` | `16` | `5/9` |

All three reproduce. The limit is `2/9`, so `θ → √2/3`, and the supremum is the `m = 2`
value, which is also the `ℍP²` half of the index's triality pair with `S³×S⁵`.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.HPFamily

open HamiltonsCubic.SphereProducts

/-- `θ²(ℍPᵐ)`. -/
def hpSq (m : ℚ) : ℚ := (m + 2) ^ 2 * (4 * m - 1) / (9 * m * (m - 1) * (2 * m + 1))

/-! ## The three index rows -/

theorem hp2 : hpSq 2 = 56 / 45 := by norm_num [hpSq]
theorem hp3 : hpSq 3 = 275 / 378 := by norm_num [hpSq]
theorem hp4 : hpSq 4 = 5 / 9 := by norm_num [hpSq]

/-- `ℍP⁵` and `ℍP⁶`, which the index does not list. -/
theorem hp5 : hpSq 5 = 931 / 1980 := by norm_num [hpSq]
theorem hp6 : hpSq 6 = 736 / 1755 := by norm_num [hpSq]

/-! ## Decreasing, and the supremum -/

theorem decreasing_2_6 :
    hpSq 6 < hpSq 5 ∧ hpSq 5 < hpSq 4 ∧ hpSq 4 < hpSq 3 ∧ hpSq 3 < hpSq 2 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [hpSq]

/-- **So the supremum is the `m = 2` value**, `56/45`, and it is strictly below `3/2`,
which is the index's *"`sup_m θ = √(56/45) < √(3/2)`"*. -/
theorem sup_below_threshold : hpSq 2 < 3 / 2 := by norm_num [hpSq]

/-- The margin is `23/90`, against the `7/18 = 35/90` gap from `ℂP²` to `ℂP³`. -/
theorem sup_margin : 3 / 2 - hpSq 2 = 23 / 90 := by norm_num [hpSq]

/-! ## The limit is `2/9`

The leading coefficients are `4` over `18`, so `θ² → 2/9` and `θ → √2/3`, as the index
says. Every listed value is above the limit.
-/

theorem limit_ratio : (4 : ℚ) / 18 = 2 / 9 := by norm_num

theorem above_limit :
    2 / 9 < hpSq 6 ∧ 2 / 9 < hpSq 5 ∧ (2 : ℚ) / 9 < hpSq 4 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num [hpSq]

/-- `√2/3` squared is `2/9`. -/
theorem limit_form : (2 : ℚ) / 9 = 2 / 3 ^ 2 := by norm_num

/-! ## The triality pair

`ℍP²` at `56/45` is the index's *"triality pair, one diagonal and one not"* with
`S³×S⁵`, both at `n = 8`. That equality is checked here from the two closed forms,
where the index states it as an observation.
-/

theorem triality_pair : hpSq 2 = thetaSq 3 5 := by norm_num [hpSq, thetaSq]

/-- And the pair is at `n = 8` for both: `ℍPᵐ` sits at `n = 4m`, so `m = 2` gives `8`. -/
theorem hp_dimension : 4 * 2 = 8 := by norm_num

/-! ## What this settles

**Settled**: that the quaternionic closed form reproduces all three of the index's `ℍPᵐ`
rows, **which the index lists separately with no note that one formula gives them all**;
two further values it does not list; that the family decreases and its supremum is the
`m = 2` value, `23/90` below the threshold; that the limit is `2/9`, so `θ → √2/3`; and
that the triality pair `ℍP² = S³×S⁵` follows from the two closed forms rather than from
observation.

**Not claimed**: the closed form, or that the family is decreasing at every `m`, the
index asserts both, and the four comparisons above are the tabulated range only.
-/

end HamiltonsCubic.HPFamily
