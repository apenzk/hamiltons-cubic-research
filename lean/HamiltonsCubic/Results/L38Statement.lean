import Mathlib

/-!
# L38, two families in closed form, strictly decreasing, meeting at `W_{ℂP²}`, STATED

From [ungraded-slack.md](../../../findings/ungraded-slack.md), the block headed *"Lemma L38, two
families in closed form, strictly decreasing, meeting at `W_{ℂP²}`"*, quoted verbatim so the Lean
below can be diffed against it:

> **Statement.** For $m\ge2$, the unit Weyl tensor of the $\mathbb{CP}^m$ family has
> $$\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)},$$
> and the two-eigenvalue point of the symmetric pair $(\mathfrak{su}(m),\mathfrak{so}(m))$ inside
> $\mathfrak{so}(2m)$, with $p=\dim\mathfrak k=\binom m2$ and $q=\dim\mathfrak m=\binom{m+1}2-1$,
> has
> $$\theta^2=\frac{m(m+1)}{(m-1)(m+2)}=\frac X{X-2},\qquad X=m(m+1).$$
> **Both are strictly decreasing on $m\ge2$**, with common maximum $\theta^2=\tfrac32$ at their
> shared $m=2$ member, which is $W_{\mathbb{CP}^2}$. *The second is immediate, being
> $1+\tfrac2{X-2}$ in $X=m(m+1)$; the first needs its derivative, whose numerator
> $-3(3m^2-2m+1)$ has discriminant $-8$ and is therefore negative-definite.* *The range matters and
> was once stated for neither: $m=1$ is a pole of both, and on $(1,2)$ both exceed $\tfrac32$, so
> monotonicity alone gives no maximum.* **The two families meet at $m=2$ and nowhere else**, the
> difference vanishing exactly on $m^2-3m+2=0$ whose other root $m=1$ is the shared singularity.

together with the block's own correction of the word *capped*:

> **"CAPPED" IS TRUE ONLY AS "CAPPED AT $\sqrt{3/2}$, ATTAINED", IT DOES NOT MEAN "BELOW THE
> TARGET".** For $\mathbb{CP}^m$,
> $\theta^2-\theta_0(2m)^2=\frac{-(2m-1)^2(m-3)}{3m^2(m-1)}$: **above at $m=2$ by $\tfrac34$,
> exactly equal at $m=3$, below only from $m\ge4$.** For the Kähler family the difference is
> $\tfrac34$ at $m=2$ and $\tfrac4{45}$ at $m=3$, turning negative at $m=4$, **above at both small
> members.**

`θ₀(n)² = 2(n-1)(n-2)/n²` is [conventions.md](../../../findings/conventions.md)'s closed form, read
here at `n = 2m`.

## What is typed here

Every claim the lemma makes **about the two closed forms**: their values at `m = 2`, strict
decrease, the `X/(X-2)` rewriting, the exact difference between the families and hence that they
meet at `m = 2` alone, and both comparisons with `θ₀(2m)` in the exact form the block states them.
All are over real `m` with `2 ≤ m`, which is wider than the integers the families are indexed by and
is therefore the safe direction. **No `sorry`.**

## What is NOT typed here

**That these two closed forms are the `θ²` of those two families.** The `ℂPᵐ` value comes from Fox's
norm identity with the `4×` Fox-to-Frobenius conversion, and the Kähler value from
[L39](../../../findings/target.md)'s symmetric-pair formula at `p = C(m,2)`, `q = C(m+1,2) - 1`;
neither derivation is in this Lean layer, and neither is the block's *"Owed: that the Kähler
family's members are Weyl tensors at all"*, which the record discharges separately as
[L166](../../../findings/ungraded-slack.md). **So this file states the arithmetic half of L38 and
not its value half**, and the row for it should be written that way.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L38Statement

/-! ## The two closed forms -/

/-- `θ²` on the `ℂPᵐ` family. -/
noncomputable def thetaSqCP (m : ℝ) : ℝ := (m + 1) * (2 * m - 1) / (3 * m * (m - 1))

/-- `θ²` at the two-eigenvalue point of `(𝔰𝔲(m), 𝔰𝔬(m))` inside `𝔰𝔬(2m)`. -/
noncomputable def thetaSqK (m : ℝ) : ℝ := m * (m + 1) / ((m - 1) * (m + 2))

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`, [conventions.md](../../../findings/conventions.md)'s closed form. -/
noncomputable def thetaZeroSq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

theorem denCP_pos {m : ℝ} (hm : 2 ≤ m) : 0 < 3 * m * (m - 1) := by nlinarith

theorem denK_pos {m : ℝ} (hm : 2 ≤ m) : 0 < (m - 1) * (m + 2) := by nlinarith

/-! ## The shared `m = 2` member -/

/-- **Both families read `3/2` at `m = 2`.** -/
theorem thetaSqCP_two : thetaSqCP 2 = 3 / 2 := by norm_num [thetaSqCP]

theorem thetaSqK_two : thetaSqK 2 = 3 / 2 := by norm_num [thetaSqK]

/-! ## The `X/(X-2)` rewriting, and strict decrease -/

/-- **The second family is `X/(X-2)` with `X = m(m+1)`**, the record's reason its monotonicity is
immediate. -/
theorem thetaSqK_eq_X (m : ℝ) :
    thetaSqK m = m * (m + 1) / (m * (m + 1) - 2) := by
  have h : (m - 1) * (m + 2) = m * (m + 1) - 2 := by ring
  rw [thetaSqK, h]

/-- **The second family is `1 + 2/(X-2)`.** -/
theorem thetaSqK_eq_one_add {m : ℝ} (hm : 2 ≤ m) :
    thetaSqK m = 1 + 2 / (m * (m + 1) - 2) := by
  have h2 : m * (m + 1) - 2 ≠ 0 := by nlinarith
  rw [thetaSqK_eq_X m]
  field_simp
  ring

/-- **The `ℂPᵐ` family is strictly decreasing on `m ≥ 2`.** -/
theorem thetaSqCP_strict_anti {a b : ℝ} (ha : 2 ≤ a) (hab : a < b) : thetaSqCP b < thetaSqCP a := by
  have hb : (2:ℝ) ≤ b := le_of_lt (lt_of_le_of_lt ha hab)
  have hda : 0 < 3 * a * (a - 1) := denCP_pos ha
  have hdb : 0 < 3 * b * (b - 1) := denCP_pos hb
  rw [thetaSqCP, thetaSqCP, div_lt_div_iff₀ hdb hda]
  nlinarith [mul_pos (sub_pos.mpr hab) (show (0:ℝ) < 3 * a * b - a - b + 1 by nlinarith)]

/-- **The Kähler family is strictly decreasing on `m ≥ 2`.** -/
theorem thetaSqK_strict_anti {a b : ℝ} (ha : 2 ≤ a) (hab : a < b) : thetaSqK b < thetaSqK a := by
  have hb : (2:ℝ) ≤ b := le_of_lt (lt_of_le_of_lt ha hab)
  have hda : 0 < (a - 1) * (a + 2) := denK_pos ha
  have hdb : 0 < (b - 1) * (b + 2) := denK_pos hb
  rw [thetaSqK, thetaSqK, div_lt_div_iff₀ hdb hda]
  nlinarith [mul_pos (sub_pos.mpr hab) (show (0:ℝ) < a * b + a + b - 2 by nlinarith)]

/-! ## `3/2` is the common maximum, attained at `m = 2` -/

/-- **`θ² ≤ 3/2` on the `ℂPᵐ` family**, with equality exactly at `m = 2`. -/
theorem thetaSqCP_le {m : ℝ} (hm : 2 ≤ m) : thetaSqCP m ≤ 3 / 2 := by
  rcases eq_or_lt_of_le hm with h | h
  · rw [← h, thetaSqCP_two]
  · exact le_of_lt (thetaSqCP_two ▸ thetaSqCP_strict_anti le_rfl h)

/-- **`θ² ≤ 3/2` on the Kähler family**, with equality exactly at `m = 2`. -/
theorem thetaSqK_le {m : ℝ} (hm : 2 ≤ m) : thetaSqK m ≤ 3 / 2 := by
  rcases eq_or_lt_of_le hm with h | h
  · rw [← h, thetaSqK_two]
  · exact le_of_lt (thetaSqK_two ▸ thetaSqK_strict_anti le_rfl h)

/-- **Neither family exceeds `√(3/2)` anywhere on `m ≥ 2`**, which is the lemma's closing clause
read on `θ` rather than on `θ²`: `θ² ≤ 3/2` is `|θ| ≤ √(3/2)`. -/
theorem thetaCP_le_sqrt {m : ℝ} (hm : 2 ≤ m) :
    Real.sqrt (thetaSqCP m) ≤ Real.sqrt (3 / 2) :=
  Real.sqrt_le_sqrt (thetaSqCP_le hm)

theorem thetaK_le_sqrt {m : ℝ} (hm : 2 ≤ m) :
    Real.sqrt (thetaSqK m) ≤ Real.sqrt (3 / 2) :=
  Real.sqrt_le_sqrt (thetaSqK_le hm)

/-! ## The two families meet at `m = 2` and nowhere else -/

/-- **The exact difference between the two families.** *The record's numerator `m² - 3m + 2` is
this one before the shared pole `m = 1` cancels.* -/
theorem thetaSq_diff {m : ℝ} (hm : 2 ≤ m) :
    thetaSqCP m - thetaSqK m = -((m + 1) * (m - 2)) / (3 * m * (m + 2)) := by
  have h0 : m ≠ 0 := by intro h; rw [h] at hm; linarith
  have h1 : m - 1 ≠ 0 := by intro h; nlinarith
  have h2 : m + 2 ≠ 0 := by intro h; nlinarith
  rw [thetaSqCP, thetaSqK]
  field_simp
  ring

/-- **They meet at `m = 2` and nowhere else on `m ≥ 2`.** -/
theorem meet_iff {m : ℝ} (hm : 2 ≤ m) : thetaSqCP m = thetaSqK m ↔ m = 2 := by
  constructor
  · intro h
    have hd : thetaSqCP m - thetaSqK m = 0 := by rw [h]; ring
    rw [thetaSq_diff hm] at hd
    have hden : (0:ℝ) < 3 * m * (m + 2) := by nlinarith
    have : -((m + 1) * (m - 2)) = 0 := by
      field_simp at hd
      linarith [hd]
    nlinarith [this]
  · rintro rfl
    rw [thetaSqCP_two, thetaSqK_two]

/-- **Past `m = 2` the `ℂPᵐ` value is the smaller of the two.** -/
theorem thetaSqCP_lt_thetaSqK {m : ℝ} (hm : 2 < m) : thetaSqCP m < thetaSqK m := by
  have h := thetaSq_diff (le_of_lt hm)
  have hden : (0:ℝ) < 3 * m * (m + 2) := by nlinarith
  have hnum : -((m + 1) * (m - 2)) < 0 := by nlinarith
  have : thetaSqCP m - thetaSqK m < 0 := by
    rw [h]; exact div_neg_of_neg_of_pos hnum hden
  linarith

/-! ## The comparison with `θ₀(2m)`, which is what "capped" concealed -/

/-- **The `ℂPᵐ` family against `θ₀(2m)`, in the block's exact form.** -/
theorem cp_vs_theta0 {m : ℝ} (hm : 2 ≤ m) :
    thetaSqCP m - thetaZeroSq (2 * m) = -((2 * m - 1) ^ 2 * (m - 3)) / (3 * m ^ 2 * (m - 1)) := by
  have h0 : m ≠ 0 := by intro h; rw [h] at hm; linarith
  have h1 : m - 1 ≠ 0 := by intro h; nlinarith
  rw [thetaSqCP, thetaZeroSq]
  field_simp
  ring

/-- **Above `θ₀` at `m = 2`, by `3/4`.** -/
theorem cp_above_at_two : thetaSqCP 2 - thetaZeroSq 4 = 3 / 4 := by
  norm_num [thetaSqCP, thetaZeroSq]

/-- **Exactly equal at `m = 3`**, the sharp statement the word "capped" concealed. -/
theorem cp_equal_at_three : thetaSqCP 3 = thetaZeroSq 6 := by
  norm_num [thetaSqCP, thetaZeroSq]

/-- **Below `θ₀` only from `m ≥ 4`.** -/
theorem cp_below_from_four {m : ℝ} (hm : 3 < m) : thetaSqCP m < thetaZeroSq (2 * m) := by
  have hm2 : (2:ℝ) ≤ m := by linarith
  have h := cp_vs_theta0 hm2
  have hden : (0:ℝ) < 3 * m ^ 2 * (m - 1) := by nlinarith
  have hnum : -((2 * m - 1) ^ 2 * (m - 3)) < 0 := by nlinarith [sq_nonneg (2 * m - 1)]
  have : thetaSqCP m - thetaZeroSq (2 * m) < 0 := by
    rw [h]; exact div_neg_of_neg_of_pos hnum hden
  linarith

/-- **The Kähler family is above `θ₀(2m)` at `m = 2`, by `3/4`.** -/
theorem kahler_above_at_two : thetaSqK 2 - thetaZeroSq 4 = 3 / 4 := by
  norm_num [thetaSqK, thetaZeroSq]

/-- **And above at `m = 3` too, by `4/45`**, the block's *"above at both small members"*. -/
theorem kahler_above_at_three : thetaSqK 3 - thetaZeroSq 6 = 4 / 45 := by
  norm_num [thetaSqK, thetaZeroSq]

/-- **Turning negative at `m = 4`.** -/
theorem kahler_below_at_four : thetaSqK 4 < thetaZeroSq 8 := by
  norm_num [thetaSqK, thetaZeroSq]

/-! ## The range is part of the statement -/

/-- **`m = 1` is a pole of both**, which is why `m ≥ 2` is stated rather than assumed: at `m = 1`
both denominators vanish. -/
theorem pole_at_one : (3:ℝ) * 1 * (1 - 1) = 0 ∧ ((1:ℝ) - 1) * (1 + 2) = 0 := by norm_num

/-- **On `(1,2)` both exceed `3/2`, so monotonicity alone gives no maximum**, the record's reason
the range is load-bearing. Read at `m = 3/2`. -/
theorem above_on_open_interval :
    3 / 2 < thetaSqCP (3 / 2) ∧ 3 / 2 < thetaSqK (3 / 2) := by
  constructor <;> norm_num [thetaSqCP, thetaSqK]

end HamiltonsCubic.L38Statement
