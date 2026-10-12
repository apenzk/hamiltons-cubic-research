import Mathlib

set_option linter.style.longLine false

/-!
# L138, the two parts that stand of a withdrawn lemma

## The record's block, quoted verbatim from [route-a.md](../../../findings/route-a.md)

> #### Lemma L138, WITHDRAWN: absorbed into the corrected Lemma L136
>
> Its numerical conclusion consumed [Lemma L137] and falls with it. **Two of its parts stand and
> one does not.** *Stand*: the Daleckii–Krein multiplier at $u$ takes only the values
> $\{0,\tfrac13,1\}$ in magnitude (the signs being negative in the operative convention), and on
> the cone $g_1$ carries no content from the competitor's own four indices, $\Lambda^4\mathbb R^4$
> is one-dimensional, $\star$ is block-diagonal across $E\oplus A$, and $B_{11}=0$,
> $B_{33}=-B_{22}$ there. *Does not stand*: **its displayed $\lVert g_1\rVert^2$ inequality was
> itself defective**, applying $\mathrm{Alt}$ to one summand and not the other when the two share
> $4$-sets. […] **The defect has an exact size and a fixed direction.** $\mathrm{Alt}$ being an
> orthogonal projection,
> $\lVert\mathrm{Alt}(x)+y\rVert^2=\lVert\mathrm{Alt}(x+y)\rVert^2+\lVert y-\mathrm{Alt}(y)\rVert^2$
> with the cross term vanishing, so the discrepancy is exactly the omitted summand's
> non-alternating part and the two agree iff that part is zero, the $4$-set condition, made
> quantitative. Since the gap is a square the defective expression is the **larger**, so a bound
> proved for it would have transferred; what fails is a value computed from it.

## What is typed here

**L138 is withdrawn, so there is no L138 conclusion to state.** What this file types is the record's
two surviving parts, each in full.

* `alt_split`, `alt_split_ge` and `alt_split_eq_iff`, the exact-size statement. For an orthogonal
  projection `P` on a real inner product space, `‖P x + y‖² = ‖P (x+y)‖² + ‖y - P y‖²`, hence the
  defective expression is the larger and the two agree **iff** `y` is in the range of `P`.
* `dd_mem_Icc`, every divided difference of `f(x) = ½(|x| - x)` lies in `[-1, 0]`, so every
  Daleckii–Krein multiplier does.
* `mult_*`, the record's table at `u`'s spectrum `(2,-1,-1)/√6` on `E` and `0` on `K`, entry by
  entry: `0`, `-1/3`, `-1`, `0`, `-1`, whose magnitudes are exactly `{0, 1/3, 1}`.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**The withdrawn conclusion is not restated**, in any form: it consumed [Lemma L137], which is itself
withdrawn. **And the second surviving part is not typed**, that on the cone `g₁` carries no content
from the competitor's own four indices. Its statement needs `Λ⁴ℝ⁴`, the Hodge `⋆` and the `E ⊕ A`
block decomposition, which is the curvature layer this record has not built in Lean; its arithmetic
content, `B₁₁ = 0` and `B₃₃ = -B₂₂`, is a fact about that decomposition rather than a numerical
identity.
-/

namespace HamiltonsCubic.L138Statement

open scoped RealInnerProductSpace

/-! ## The exact size of the `Alt` defect

*The record's displayed identity, with `P` standing for `Alt`: an idempotent, self-adjoint linear
map, which is what "orthogonal projection" means here.* -/

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-- **The record's identity.** With `P` an orthogonal projection,
`‖P x + y‖² = ‖P (x + y)‖² + ‖y - P y‖²`, the cross term vanishing because `P (y - P y) = 0`. -/
theorem alt_split (P : V →ₗ[ℝ] V) (hidem : ∀ v, P (P v) = P v)
    (hsa : ∀ v w, (inner ℝ (P v) w : ℝ) = inner ℝ v (P w)) (x y : V) :
    ‖P x + y‖ ^ 2 = ‖P (x + y)‖ ^ 2 + ‖y - P y‖ ^ 2 := by
  have hdecomp : P x + y = P (x + y) + (y - P y) := by
    rw [map_add]; abel
  have hcross : (inner ℝ (P (x + y)) (y - P y) : ℝ) = 0 := by
    rw [hsa]
    have : P (y - P y) = 0 := by
      rw [map_sub, hidem]; abel
    rw [this, inner_zero_right]
  rw [hdecomp, norm_add_sq_real, hcross]
  ring

/-- **The defective expression is the larger**, the gap being a square. So a bound proved for
`‖Alt(x) + y‖²` transfers to `‖Alt(x + y)‖²`; what fails is a value computed from it. -/
theorem alt_split_ge (P : V →ₗ[ℝ] V) (hidem : ∀ v, P (P v) = P v)
    (hsa : ∀ v w, (inner ℝ (P v) w : ℝ) = inner ℝ v (P w)) (x y : V) :
    ‖P (x + y)‖ ^ 2 ≤ ‖P x + y‖ ^ 2 := by
  have h := alt_split P hidem hsa x y
  nlinarith [sq_nonneg ‖y - P y‖]

/-- **The two agree exactly when the omitted summand's non-alternating part is zero**, the record's
`4`-set condition, made quantitative. -/
theorem alt_split_eq_iff (P : V →ₗ[ℝ] V) (hidem : ∀ v, P (P v) = P v)
    (hsa : ∀ v w, (inner ℝ (P v) w : ℝ) = inner ℝ v (P w)) (x y : V) :
    ‖P x + y‖ ^ 2 = ‖P (x + y)‖ ^ 2 ↔ y = P y := by
  have h := alt_split P hidem hsa x y
  constructor
  · intro heq
    have hzero : ‖y - P y‖ ^ 2 = 0 := by linarith
    have hn : ‖y - P y‖ = 0 := by
      have := sq_eq_zero_iff.mp hzero
      exact this
    exact sub_eq_zero.mp (norm_eq_zero.mp hn)
  · intro hy
    have hz : y - P y = 0 := sub_eq_zero.mpr hy
    rw [h, hz, norm_zero]
    ring

/-! ## The multiplier table at `u`

*`f(x) = ½(|x| - x)` is the map whose Daleckii–Krein derivative the record forms;
`dd a b = (f a - f b)/(a - b)` is the divided difference, which is the multiplier at a pair of
distinct eigenvalues. `u`'s spectrum is `(2,-1,-1)/√6` on `E` and `0` on `K`.* -/

/-- The negative part of a real number, `f(x) = ½(|x| - x)`. -/
noncomputable def f (x : ℝ) : ℝ := (|x| - x) / 2

/-- The divided difference of `f`, which is the Daleckii–Krein multiplier at a pair of distinct
eigenvalues. -/
noncomputable def dd (a b : ℝ) : ℝ := (f a - f b) / (a - b)

/-- **`f` is nonincreasing and `1`-Lipschitz** on any pair with `a ≤ b`: `0 ≤ f a - f b ≤ b - a`.
This is the whole content of the multiplier range. -/
theorem f_diff {a b : ℝ} (hab : a ≤ b) : 0 ≤ f a - f b ∧ f a - f b ≤ b - a := by
  have habs : |(|b| - |a|)| ≤ |b - a| := abs_abs_sub_abs_le_abs_sub b a
  rw [abs_of_nonneg (by linarith : (0:ℝ) ≤ b - a)] at habs
  obtain ⟨h1, h2⟩ := abs_le.mp habs
  have hf : f a - f b = ((|a| - |b|) - (a - b)) / 2 := by unfold f; ring
  constructor <;> rw [hf] <;> linarith

/-- A ratio with numerator in `[0, -d]` and negative denominator `d` lies in `[-1, 0]`. -/
private lemma ratio_neg_den {n d : ℝ} (hd : d < 0) (hn0 : 0 ≤ n) (hn : n ≤ -d) :
    n / d ∈ Set.Icc (-1 : ℝ) 0 := by
  refine ⟨?_, div_nonpos_iff.mpr (Or.inl ⟨hn0, hd.le⟩)⟩
  rw [le_div_iff_of_neg hd]
  linarith

/-- **Every multiplier lies in `[-1, 0]`.** `f` is nonincreasing and `1`-Lipschitz, so every
divided difference does, which is the general fact behind the record's table, and is what makes
the centring `|m + ½| ≤ ½` available. -/
theorem dd_mem_Icc {a b : ℝ} (hab : a ≠ b) : dd a b ∈ Set.Icc (-1 : ℝ) 0 := by
  rcases lt_or_gt_of_ne hab with h | h
  · obtain ⟨hn0, hn⟩ := f_diff h.le
    exact ratio_neg_den (by linarith) hn0 (by linarith)
  · obtain ⟨hn0, hn⟩ := f_diff h.le
    have hrw : dd a b = (f b - f a) / (b - a) := by
      rw [dd]
      rw [show a - b = -(b - a) by ring, show f a - f b = -(f b - f a) by ring]
      rw [neg_div_neg_eq]
    rw [hrw]
    exact ratio_neg_den (by linarith) hn0 (by linarith)

/-- **The centring the record's proof runs on**: every multiplier being in `[-1,0]`,
`|m + ½| ≤ ½`. -/
theorem centred {m : ℝ} (hm : m ∈ Set.Icc (-1 : ℝ) 0) : |m + 1 / 2| ≤ 1 / 2 := by
  obtain ⟨h1, h2⟩ := hm
  rw [abs_le]; constructor <;> linarith

/-! ### The five entries -/

private lemma sqrt6_pos : (0 : ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)

/-- `f` at `u`'s large eigenvalue `2/√6`, which is positive: `f = 0`. -/
theorem f_top : f (2 / Real.sqrt 6) = 0 := by
  have h : (0 : ℝ) ≤ 2 / Real.sqrt 6 := by positivity
  unfold f; rw [abs_of_nonneg h]; ring

/-- `f` at `u`'s double eigenvalue `-1/√6`, which is negative: `f = 1/√6`. -/
theorem f_low : f (-(1 / Real.sqrt 6)) = 1 / Real.sqrt 6 := by
  have hs := sqrt6_pos
  have hpos : (0 : ℝ) < 1 / Real.sqrt 6 := by positivity
  have h : -(1 / Real.sqrt 6) ≤ 0 := by linarith
  unfold f
  rw [abs_of_nonpos h]
  ring

/-- `f` at the kernel eigenvalue `0`. -/
theorem f_zero : f 0 = 0 := by unfold f; norm_num

/-- **Entry `(ω̂₁, ω̂₂)`: the multiplier is `-1/3`.** -/
theorem mult_top_low : dd (2 / Real.sqrt 6) (-(1 / Real.sqrt 6)) = -(1 / 3) := by
  have hs := sqrt6_pos
  have hne : (2 / Real.sqrt 6) - (-(1 / Real.sqrt 6)) = 3 / Real.sqrt 6 := by field_simp; ring
  rw [dd, f_top, f_low, hne]
  field_simp
  ring

/-- **Entry `(ω̂₁, K)`: the multiplier is `0`.** -/
theorem mult_top_kernel : dd (2 / Real.sqrt 6) 0 = 0 := by
  rw [dd, f_top, f_zero]; norm_num

/-- **Entry `(ω̂₂, K)`: the multiplier is `-1`.** -/
theorem mult_low_kernel : dd (-(1 / Real.sqrt 6)) 0 = -1 := by
  have hs := sqrt6_pos
  have hne : Real.sqrt 6 ≠ 0 := ne_of_gt hs
  rw [dd, f_low, f_zero]
  field_simp
  ring

/-- **Entry `(ω̂₁, ω̂₁)`: the multiplier is `f'(2/√6) = 0`**, `f` being locally constant on the
positive axis. -/
theorem mult_top_top : HasDerivAt f 0 (2 / Real.sqrt 6) := by
  have hs := sqrt6_pos
  have hpos : (0 : ℝ) < 2 / Real.sqrt 6 := by positivity
  have hev : f =ᶠ[nhds (2 / Real.sqrt 6)] fun _ => (0 : ℝ) := by
    filter_upwards [eventually_gt_nhds hpos] with x hx
    unfold f; rw [abs_of_pos hx]; ring
  exact (hasDerivAt_const _ (0 : ℝ)).congr_of_eventuallyEq hev

/-- **Entry among `ω̂₂, ω̂₃`: the multiplier is `f'(-1/√6) = -1`**, `f(x) = -x` on the negative
axis, the case the record marks as the degenerate pair, where the divided difference is a
derivative. -/
theorem mult_low_low : HasDerivAt f (-1) (-(1 / Real.sqrt 6)) := by
  have hs := sqrt6_pos
  have hneg : -(1 / Real.sqrt 6) < 0 := by
    have : (0 : ℝ) < 1 / Real.sqrt 6 := by positivity
    linarith
  have hev : f =ᶠ[nhds (-(1 / Real.sqrt 6))] fun x => -x := by
    filter_upwards [eventually_lt_nhds hneg] with x hx
    unfold f; rw [abs_of_neg hx]; ring
  exact (hasDerivAt_neg (-(1 / Real.sqrt 6))).congr_of_eventuallyEq hev

/-- **The table's magnitudes are exactly `{0, 1/3, 1}`**, as the record states, with every sign
negative. -/
theorem table_magnitudes :
    |dd (2 / Real.sqrt 6) 0| = 0 ∧
    |dd (2 / Real.sqrt 6) (-(1 / Real.sqrt 6))| = 1 / 3 ∧
    |dd (-(1 / Real.sqrt 6)) 0| = 1 := by
  refine ⟨by rw [mult_top_kernel]; norm_num, ?_, by rw [mult_low_kernel]; norm_num⟩
  rw [mult_top_low]; norm_num

end HamiltonsCubic.L138Statement
