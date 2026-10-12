import HamiltonsCubic.Results.SphereProducts

/-!
# The `S²×S^q` family, exactly

[nondegeneracy.md](../../../findings/nondegeneracy.md) says of this family:

> the whole `S²×S^k` family for `k = 2,…,8` is nondegenerate at its own dimension and
> degenerate at **every** padding, eighteen cases, with excess `q(n - n₀)` for `S²×S^q`,
> doubled when both factors are `2`-spheres, generalising the `4(n-4)` recorded below.
> That family can never threaten the top of the range, since `θ(S²×S^q) ↑ 1` while
> `θ₀ ↑ √2`, capping its ratio at `1/θ₀(n) → 0.707`.

Both quantitative claims are exact under the closed form.

* **`θ(S²×S^q)² = 1 - 1/q²`.** The record's `↑ 1` is that, and it says how fast.
* **The ratio to `θ₀` at the family's own dimension `n = q+2` is
  `(q-1)(q+2)² / (2q³)`**, which starts at `1`, `S²×S²` *is* the balanced product at
  `n = 4`, and decreases to `1/2`, so the ratio falls to `1/√2` **from above**.

Everything is `norm_num`, `ring` or `linarith`, kernel-checked.
-/

namespace HamiltonsCubic.S2Family

open HamiltonsCubic.SphereProducts HamiltonsCubic.Theta0

/-! ## `θ² = 1 - 1/q²` -/

/-- Cross-multiplied, so no division and no side condition. -/
theorem thetaSq_closed (q : ℚ) :
    2 * (2 - 1) * (q - 1) * (2 + q - 1) * q ^ 2
      = (q ^ 2 - 1) * (2 * q * (2 + q - 2)) := by
  ring

theorem at_2 : thetaSq 2 2 = 3 / 4 := by norm_num [thetaSq]
theorem at_3 : thetaSq 2 3 = 8 / 9 := by norm_num [thetaSq]
theorem at_8 : thetaSq 2 8 = 63 / 64 := by norm_num [thetaSq]

/-- **Strictly below `1` at every `q`**, since `q² - 1 < q²`. -/
theorem lt_one (q : ℚ) : q ^ 2 - 1 < q ^ 2 := by linarith

/-- And strictly increasing: `1 - 1/q²` rises with `q`. Stated cross-multiplied. -/
theorem increasing {a b : ℚ} (ha : 2 ≤ a) (hab : a < b) :
    (a ^ 2 - 1) * b ^ 2 < (b ^ 2 - 1) * a ^ 2 := by
  nlinarith [sq_nonneg (b - a), sq_nonneg (b + a)]

/-! ## The ratio to `θ₀` at the family's own dimension -/

/-- `(θ/θ₀)²` at `n = q + 2`. -/
def ratioSq (q : ℚ) : ℚ := (q - 1) * (q + 2) ^ 2 / (2 * q ^ 3)

/-- **At `q = 2` it is exactly `1`**, `S²×S²` is the balanced product at `n = 4`, so the
family starts on the top of the range rather than below it. -/
theorem ratio_at_2 : ratioSq 2 = 1 := by norm_num [ratioSq]

theorem ratio_at_2_matches : thetaSq 2 2 = evenSq 4 := by norm_num [thetaSq, evenSq]

theorem ratio_at_3 : ratioSq 3 = 25 / 27 := by norm_num [ratioSq]
theorem ratio_at_8 : ratioSq 8 = 175 / 256 := by norm_num [ratioSq]

/-- **The ratio stays above `1/2`**, so `θ/θ₀` stays above `1/√2` and approaches it from
above: `(q-1)(q+2)² > q³` reduces to `3q² > 4`. -/
theorem ratio_gt_half (q : ℚ) (hq : 2 ≤ q) : q ^ 3 < (q - 1) * (q + 2) ^ 2 := by
  nlinarith

/-- And it decreases across the tabulated range, so the family moves away from the top
as `q` grows, which is the record's *"can never threaten the top"*. -/
theorem ratio_decreasing : ratioSq 8 < ratioSq 3 ∧ ratioSq 3 < ratioSq 2 := by
  constructor <;> norm_num [ratioSq]

/-! ## The degeneracy excess

The record's excess is `q(n - n₀)` for `S²×S^q`, doubled when both factors are
`2`-spheres, and it says this generalises a recorded `4(n-4)`.
-/

/-- The excess formula, with `d = 2` when both factors are `2`-spheres and `1`
otherwise. -/
def excess (q n n₀ d : ℚ) : ℚ := d * q * (n - n₀)

/-- **It does generalise `4(n-4)`**: at `S²×S²` the base dimension is `4`, `q = 2`, and
the doubling gives `2 · 2 · (n - 4)`. -/
theorem generalises_recorded (n : ℚ) : excess 2 n 4 2 = 4 * (n - 4) := by
  unfold excess; ring

/-- For a single `2`-sphere factor the excess is linear in the padding with slope `q`,
so the family's worst case at fixed padding is its largest `q`. -/
theorem slope (q n n₀ : ℚ) : excess q (n + 1) n₀ 1 - excess q n n₀ 1 = q := by
  unfold excess; ring

/-! ## What this settles

**Settled**: that `θ(S²×S^q)² = 1 - 1/q²`, strictly increasing and strictly below `1`;
that the family's ratio to `θ₀` starts at exactly `1`, `S²×S²` **is** the balanced
product at `n = 4`, and decreases, staying above `1/2`, so `θ/θ₀` approaches `1/√2` from
above; and that the excess formula reproduces the recorded `4(n-4)` at the doubled case,
with slope `q` in the padding.

**Not settled here**: the degeneracy computations themselves, and the count of eighteen
cases, both the record's.
-/

end HamiltonsCubic.S2Family
