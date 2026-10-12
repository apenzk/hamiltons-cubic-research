import Mathlib

/-!
# L38, two families capped, in closed form and strictly decreasing

`θ²(ℂPᵐ) = (m+1)(2m-1) / (3m(m-1))` and, on the Kähler family of
`(𝔰𝔲(m), 𝔰𝔬(m))` inside `𝔰𝔬(2m)`, `θ² = m(m+1) / ((m-1)(m+2))`.

**The split.** The two closed forms are values of `θ` on named objects and stay
imported. Everything the block does with them is here: both are strictly
decreasing, both are `3/2` at `m = 2`, and they agree at `m = 2` and nowhere
else on `m ≥ 2`.

Two things the block's reviewers record are also proved:

* the `ℂPᵐ` form reproduces `θ₀(6)² = 10/9` at `m = 3`, an anchor it was not
  built from;
* **both forms are undefined at `m = 1`**, which the record excludes silently
  rather than by hypothesis. Here `2 ≤ m` is a hypothesis on every statement.
-/

namespace HamiltonsCubic.L38

/-- `θ²` on the `ℂPᵐ` family. -/
noncomputable def cpSq (m : ℝ) : ℝ := (m + 1) * (2 * m - 1) / (3 * m * (m - 1))

/-- `θ²` on the Kähler family. -/
noncomputable def kahlerSq (m : ℝ) : ℝ := m * (m + 1) / ((m - 1) * (m + 2))

/-- `θ₀(n)²`, quoted from [L2](L2.lean) so the anchor is not restated. -/
noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

theorem cpSq_two : cpSq 2 = 3 / 2 := by unfold cpSq; norm_num

theorem kahlerSq_two : kahlerSq 2 = 3 / 2 := by unfold kahlerSq; norm_num

/-- **The anchor the family was not built from**: at `m = 3` the `ℂPᵐ` value is
`θ₀(6)²`. -/
theorem cpSq_three : cpSq 3 = theta0Sq 6 := by unfold cpSq theta0Sq; norm_num

theorem kahlerSq_three : kahlerSq 3 = 6 / 5 := by unfold kahlerSq; norm_num

/- The reviewers note that the Kähler form equals `1 + 2/(m² + m - 2)`, which is
where they read its monotonicity from. That reformulation is a remark rather
than a step: `kahlerSq_strictAnti` below is proved from the definition, so
nothing here depends on it and it is not stated as a theorem. -/

theorem kahlerSq_strictAnti {x y : ℝ} (hx : 2 ≤ x) (hxy : x < y) :
    kahlerSq y < kahlerSq x := by
  have hx1 : (0:ℝ) < x - 1 := by linarith
  have hx2 : (0:ℝ) < x + 2 := by linarith
  have hy1 : (0:ℝ) < y - 1 := by linarith
  have hy2 : (0:ℝ) < y + 2 := by linarith
  unfold kahlerSq
  rw [div_lt_div_iff₀ (by positivity) (by positivity)]
  nlinarith [sq_nonneg (x - y), sq_nonneg (x + y)]

theorem cpSq_strictAnti {x y : ℝ} (hx : 2 ≤ x) (hxy : x < y) :
    cpSq y < cpSq x := by
  have hy : (2:ℝ) ≤ y := le_of_lt (lt_of_le_of_lt hx hxy)
  have hx1 : (0:ℝ) < x - 1 := by linarith
  have hy1 : (0:ℝ) < y - 1 := by linarith
  have hx0 : (0:ℝ) < x := by linarith
  have hy0 : (0:ℝ) < y := by linarith
  -- the difference factors as `3 (y - x) (3xy - x - y + 1)`, both factors positive
  have key : (0:ℝ) < 3 * x * y - x - y + 1 := by nlinarith
  have hdiff : (0:ℝ) < y - x := by linarith
  unfold cpSq
  rw [div_lt_div_iff₀ (by positivity) (by positivity)]
  nlinarith [mul_pos hdiff key]

/-- **The two families meet at `m = 2` and nowhere else** on `m ≥ 2`: equality
reduces to `m² - 3m + 2 = 0`, whose roots are `1` and `2`, and `1` is outside
the range where either form is defined. -/
theorem meet_iff {m : ℝ} (h : 2 ≤ m) : cpSq m = kahlerSq m ↔ m = 2 := by
  have h1 : m - 1 ≠ 0 := ne_of_gt (by nlinarith)
  have h2 : m + 2 ≠ 0 := ne_of_gt (by nlinarith)
  have h0 : m ≠ 0 := ne_of_gt (by nlinarith)
  constructor
  · intro he
    unfold cpSq kahlerSq at he
    have : m ^ 2 - 3 * m + 2 = 0 := by field_simp at he; nlinarith [he]
    nlinarith [this]
  · rintro rfl
    rw [cpSq_two, kahlerSq_two]

/-! ## A third object at `10/9`

`cpSq 3 = theta0Sq 6` above puts two objects at `10/9`. **The Kähler family reaches it too, at
`m = 4`**, so the value carries three distinct objects, and two of them sit at different `m`.
That is a collision to note rather than a connection: the families are proved to meet only at
`m = 2` by `meet_iff`, so agreeing in value at `m = 3` and `m = 4` respectively is exactly what
sharing a number without sharing a point looks like. -/

theorem kahlerSq_four : kahlerSq 4 = 10 / 9 := by unfold kahlerSq; norm_num

theorem theta0Sq_six : theta0Sq 6 = 10 / 9 := by unfold theta0Sq; norm_num

/-- **Three objects at one value, at two different parameters.** -/
theorem three_at_ten_ninths :
    cpSq 3 = theta0Sq 6 ∧ kahlerSq 4 = theta0Sq 6 ∧ cpSq 4 ≠ kahlerSq 4 := by
  refine ⟨cpSq_three, ?_, ?_⟩
  · rw [kahlerSq_four, theta0Sq_six]
  · unfold cpSq kahlerSq; norm_num

end HamiltonsCubic.L38
