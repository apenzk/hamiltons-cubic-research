import Mathlib

set_option linter.style.longLine false

/-!
# L78, the residual floor for the 3-form mass, stated and proved

**The record's statement, quoted verbatim from [isotropy-cap.md](../../../findings/isotropy-cap.md):**

> #### Lemma L78, the residual floor $\alpha\ge(2d/n)(4d-n^2)$ for the 3-form mass at dimension $d$
>
> **THE FLOOR IS A THEOREM, AT EVERY $d$-SUBSPACE OF $\mathfrak{so}(n)$, $n\ge4$.** It follows from the hypothesis-free block-form Killing identity $\alpha+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2(n-2)d$, **which is [L36](isotropy-cap.md)'s own boxed identity with $\alpha$ put back**, together with $\mu\ge4d^2/n-2d$. **No isotropy, no genericity.** *Structurally it is twice the failure of L36's sandwich past the cap.*
>
> **THE RANGE IS UNSTATED AND THE FLOOR IS VACUOUS BELOW THE CAP**, being negative when $4d<n^2$, *so three of the four $S=0$ points cited as evidence sit where the floor says nothing.*

## What this file states

The floor is an inequality between real numbers once its three inputs are in hand, and it is
stated and proved here at that level, with no `sorry`. The inputs enter as hypotheses because
each is a separate result of the record: the block-form Killing identity (this is L114 in the
ordered convention), the definition `μ = α + S_mmh` of the `𝔪`-bracket mass, the nonnegativity of
`S_mhh`, and L36's Step 2 bound `μ ≥ 4d²/n - 2d`.

**What is not stated here** is that those inputs hold, that would need `𝔰𝔬(n)`, its bracket
tensor and a `d`-dimensional subspace. `L114Statement.lean` proves the block-form identity from a
row marginal, which is the only one of the four the record derives combinatorially.

`floor_is_twice_sandwich_failure` records the structural reading the block gives: the floor is
exactly twice the amount by which L36's two-sided sandwich on `μ` fails to close.
-/

namespace HamiltonsCubic.L78

/-- The record's floor, `(2d/n)(4d - n²)`. -/
noncomputable def floorVal (n d : ℝ) : ℝ := (2 * d / n) * (4 * d - n ^ 2)

/-! ## The floor -/

/-- **The residual floor.** From the block-form Killing identity `α + 2S_mmh + S_mhh = 2(n-2)d`,
the bracket mass `μ = α + S_mmh`, the nonnegativity of `S_mhh` and L36's `μ ≥ 4d²/n - 2d`, the
3-form mass satisfies `α ≥ (2d/n)(4d - n²)`. -/
theorem residual_floor {n d α Smmh Smhh μ : ℝ} (hn : 0 < n)
    (hid : α + 2 * Smmh + Smhh = 2 * (n - 2) * d)
    (hμ : μ = α + Smmh)
    (hSmhh : 0 ≤ Smhh)
    (hlow : 4 * d ^ 2 / n - 2 * d ≤ μ) :
    floorVal n d ≤ α := by
  have hα : α = 2 * μ + Smhh - 2 * (n - 2) * d := by rw [hμ]; linarith
  have hexp : floorVal n d = 2 * (4 * d ^ 2 / n - 2 * d) - 2 * (n - 2) * d := by
    rw [floorVal]
    field_simp
    ring
  rw [hexp, hα]
  linarith

/-- **The floor is twice the failure of L36's sandwich.** L36 chains
`4d²/n - 2d ≤ μ ≤ (n-2)d`, which closes exactly at `d = n²/4`; the floor is twice the amount by
which the lower end overshoots the upper. -/
theorem floor_is_twice_sandwich_failure {n d : ℝ} (hn : 0 < n) :
    floorVal n d = 2 * ((4 * d ^ 2 / n - 2 * d) - (n - 2) * d) := by
  rw [floorVal]; field_simp; ring

/-! ## L36's cap, the companion the floor is read against -/

/-- **L36's cap `d ≤ n²/4`**, from the same sandwich: the lower bound on `μ` cannot exceed the
upper one. -/
theorem isotropy_cap {n d μ : ℝ} (hn : 0 < n) (hlow : 4 * d ^ 2 / n - 2 * d ≤ μ)
    (hhigh : μ ≤ (n - 2) * d) : d ≤ n ^ 2 / 4 := by
  have h : 4 * d ^ 2 / n - 2 * d ≤ (n - 2) * d := le_trans hlow hhigh
  rw [sub_le_iff_le_add, div_le_iff₀ hn] at h
  nlinarith

/-! ## The range: the floor says nothing below the cap -/

/-- **The floor is negative exactly below the cap**, so it is vacuous there: at `4d < n²` with
`d > 0` it asserts less than `α ≥ 0`. -/
theorem floor_neg_below_cap {n d : ℝ} (hn : 0 < n) (hd : 0 < d) (hcap : 4 * d < n ^ 2) :
    floorVal n d < 0 := by
  rw [floorVal]
  apply mul_neg_of_pos_of_neg
  · positivity
  · linarith

/-- **And it is nonnegative at or past the cap.** -/
theorem floor_nonneg_at_cap {n d : ℝ} (hn : 0 < n) (hd : 0 ≤ d) (hcap : n ^ 2 ≤ 4 * d) :
    0 ≤ floorVal n d := by
  rw [floorVal]
  apply mul_nonneg
  · positivity
  · linarith

/-! ## The two figures the block reports -/

/-- **At `n = 5`, `d = 7` the floor is exactly `42/5 = 8.4`**, the value the record's gradient
search stalled at, which the floor plus a matching point certifies as the global minimum. -/
theorem floor_five_seven : floorVal 5 7 = 42 / 5 := by rw [floorVal]; norm_num

/-- **At `n = 6`, `d = 10` the floor is `40/3 = 13.3̄`.** -/
theorem floor_six_ten : floorVal 6 10 = 40 / 3 := by rw [floorVal]; norm_num

/-- **The companion figure `16.6` exceeds its own floor**, by under a quarter, which is the
block's `24%` and the reason `16.6` is certified by nothing, unlike `8.4`. -/
theorem companion_exceeds_floor : floorVal 6 10 < 16.6 ∧ (16.6 : ℝ) < 1.25 * floorVal 6 10 := by
  rw [floor_six_ten]; constructor <;> norm_num

/-! ## The hypotheses are not empty -/

/-- **A witness for `residual_floor`'s hypotheses**, so the implication is not vacuous: at
`n = 5`, `d = 7`, with `α = 42/5`, `S_mmh = 84/5`, `S_mhh = 0` and `μ = 126/5`, every hypothesis
holds and the floor is attained. -/
example : floorVal 5 7 ≤ 42 / 5 :=
  residual_floor (n := 5) (d := 7) (α := 42 / 5) (Smmh := 84 / 5) (Smhh := 0) (μ := 126 / 5)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
