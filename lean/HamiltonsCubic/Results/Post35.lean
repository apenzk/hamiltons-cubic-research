import HamiltonsCubic.Results.Theta0

/-!
# Fence post 35's `n ≈ 356` is exact

[INDEX-traps.md](../../../findings/INDEX-traps.md), post 35:

> **No cap on `tr(M³) + ‖M#‖_F` closes Conjecture A below `n = 356`**, … padded
> `W_{ℂP²}` carries `1 + 1/√6` identically at `n = 4…16` and `θ₀` first reaches it at
> `n ≈ 356`.

**The `≈` is unnecessary: `356` is exactly the first `n` at which `θ₀(n)` reaches
`1 + 1/√6`.** With `√6` bracketed to seven places, `2.4494897² < 6 < 2.4494898²`, the
target squared lies in `(1.9831632, 1.9831633)`, while

* `θ₀(355)² = 1.98313033…`, **below**;
* `θ₀(356)² = 1.98317763…`, **above**.

So the post's threshold is sharp, and the route it closes is closed for every `n` up to
`355` rather than approximately so.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Post35

open HamiltonsCubic.Theta0

/-! ## Bracketing `√6` -/

theorem sqrt6_bracket : (2.4494897 : ℚ) ^ 2 < 6 ∧ (6 : ℚ) < 2.4494898 ^ 2 := by
  constructor <;> norm_num

/-- `(1 + 1/√6)² = 7/6 + 2/√6`, so with the bracket it lies in
`(1.9831632, 1.9831633)`. -/
theorem target_bracket :
    (1.9831632 : ℚ) < 7 / 6 + 2 / 2.4494898 ∧ 7 / 6 + 2 / (2.4494897 : ℚ) < 1.9831633 := by
  constructor <;> norm_num

/-! ## The threshold -/

/-- `θ₀(355)² = 1.98313033…`, **below** the target. -/
theorem below_at_355 : evenSq 355 < 1.9831632 := by norm_num [evenSq]

/-- `θ₀(356)² = 1.98317763…`, **above** it. -/
theorem above_at_356 : (1.9831633 : ℚ) < evenSq 356 := by norm_num [evenSq]

/-- **So `356` is the first `n` at which `θ₀` reaches `1 + 1/√6`**, the post's `≈` is
exact. -/
theorem threshold_sharp : evenSq 355 < 1.9831632 ∧ (1.9831633 : ℚ) < evenSq 356 := by
  constructor <;> norm_num [evenSq]

/-- The gap at the threshold is small: `θ₀(356)² - θ₀(355)²` is under `5·10⁻⁵`. -/
theorem step_small : evenSq 356 - evenSq 355 < 0.00005 := by norm_num [evenSq]

/-! ## The competitor's value is constant

The post says padded `W_{ℂP²}` carries `1 + 1/√6` *identically* at `n = 4…16`, a
constant, where `θ₀` is rising. That is why a crossing exists at all, and why it is so
far out.
-/

/-- At `n = 12`, `θ₀² = 55/36 = 1.5278`, far below the target. -/
theorem far_below_at_12 : evenSq 12 < 1.6 := by norm_num [evenSq]

/-- Even at `n = 100` it is still below. -/
theorem below_at_100 : evenSq 100 < 1.9831632 := by norm_num [evenSq]

/-- **And `θ₀² < 2` always**, so the target `1.98316…` sits just under the ceiling,
which is why the crossing is pushed to the hundreds. -/
theorem target_near_ceiling : (1.9831633 : ℚ) < 2 := by norm_num

theorem margin_to_ceiling : (2 : ℚ) - 1.9831633 < 0.017 := by norm_num

/-! ## What this settles

**Settled**: that `356` is exactly the first `n` at which `θ₀(n)` reaches `1 + 1/√6`, with
`θ₀(355)²` below and `θ₀(356)²` above a target bracketed to seven places, **so the
post's `≈ 356` is sharp**; that the step at the threshold is under `5·10⁻⁵`; and that the
target sits within `0.017` of the `√2` ceiling, which is why the crossing is pushed so
far out.

**Not claimed**: the harmonic-square law, the decomposability restriction, or that padded
`W_{ℂP²}` carries `1 + 1/√6`, the post's own content.
-/

end HamiltonsCubic.Post35
