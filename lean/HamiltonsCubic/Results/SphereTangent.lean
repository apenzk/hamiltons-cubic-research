import HamiltonsCubic.Results.SphereCurve

/-!
# The scalar limit behind the tangent cone

`mem_tangentConeAt_of_seq` wants `c n • (γ(1/n) - a) → y`. With the closed-form normalisation
`r(t) = (1 + t²k)^(-1/2)` and `k = normSq2 y`, the curve satisfies

`γ(t) - a = (r(t) - 1) • a + t·r(t) • y`,

so `n • (γ(1/n) - a) = n(r(1/n) - 1) • a + r(1/n) • y`. **The second term tends to `y` because
`r` is continuous at `0` with `r(0) = 1`, so EVERYTHING rests on the first scalar tending to `0`.**

*`r(t) - 1` is of order `t²`, so `n(r(1/n) - 1)` is of order `1/n`*, and the statement below is
that estimate made exact by a two-sided bound.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open Real Filter Topology
open scoped NNReal Matrix.Norms.Frobenius OperatorNorm

/-- **The elementary bound: `1 - u/2 ≤ (1+u)^{-1/2}` for every `u ≥ 0`.**

*The case split is doing real work rather than tidying.* For `u > 2` the left side is negative and
the right side positive, so the inequality is free. For `0 ≤ u ≤ 2` both sides are nonnegative and
squaring is valid, where it becomes `u²(u - 3) ≤ 0`. **The polynomial route needs `u ≤ 3` and so
CANNOT be applied on all of `u ≥ 0`**, which is why the split comes first. -/
theorem one_sub_half_le_inv_sqrt {u : ℝ} (hu : 0 ≤ u) :
    1 - u / 2 ≤ (Real.sqrt (1 + u))⁻¹ := by
  have h1 : (0:ℝ) < 1 + u := by linarith
  have hs : 0 < Real.sqrt (1 + u) := Real.sqrt_pos.mpr h1
  rcases le_or_gt (1 - u / 2) 0 with h | h
  · exact h.trans (inv_pos.mpr hs).le
  · have hsq : Real.sqrt (1 + u) ^ 2 = 1 + u := Real.sq_sqrt h1.le
    have hmul : (1 - u / 2) * Real.sqrt (1 + u) ≤ 1 := by
      nlinarith [hsq, hs.le, sq_nonneg (Real.sqrt (1 + u) - 1), sq_nonneg u, hu]
    calc 1 - u / 2 = (1 - u / 2) * Real.sqrt (1 + u) / Real.sqrt (1 + u) := by
          field_simp
      _ ≤ 1 / Real.sqrt (1 + u) := by
          exact div_le_div_of_nonneg_right hmul hs.le |>.trans_eq rfl
      _ = (Real.sqrt (1 + u))⁻¹ := one_div _

/-- **And the other side, `(1+u)^{-1/2} ≤ 1`**, which is monotonicity of the square root. -/
theorem inv_sqrt_le_one {u : ℝ} (hu : 0 ≤ u) : (Real.sqrt (1 + u))⁻¹ ≤ 1 := by
  have h1 : (1:ℝ) ≤ Real.sqrt (1 + u) := by
    nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 1 + u by linarith), Real.sqrt_nonneg (1 + u), hu]
  have hpos : (0:ℝ) < Real.sqrt (1 + u) := lt_of_lt_of_le one_pos h1
  have hmul := mul_le_mul_of_nonneg_left h1 (inv_pos.mpr hpos).le
  rw [inv_mul_cancel₀ (ne_of_gt hpos), mul_one] at hmul
  exact hmul

/-! ## The squeeze

*The two bounds put `n(r(1/n) - 1)` between `-k/2n` and `0`*, and both ends tend to `0`.
-/

/-- **`n · (r(1/n) - 1) → 0`, WHICH IS THE WHOLE OF THE TANGENT CONE'S SCALAR CONTENT.**

*`r(t) - 1` is of order `t²` and `n` is of order `t⁻¹`, so the product is of order `t`.* The bound
above makes that exact: `-k/2n ≤ n(r(1/n) - 1) ≤ 0`, and a squeeze finishes it. -/
theorem tendsto_n_mul_rad_sub_one (k : ℝ) (hk : 0 ≤ k) :
    Tendsto (fun n : ℕ => (n : ℝ) * ((Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * k))⁻¹ - 1))
      atTop (nhds 0) := by
  have hlow : ∀ᶠ n : ℕ in atTop,
      -(k / (2 * n)) ≤ (n : ℝ) * ((Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * k))⁻¹ - 1) := by
    filter_upwards [eventually_gt_atTop 0] with n hn
    have hn' : (0 : ℝ) < n := by exact_mod_cast hn
    set u : ℝ := ((1 : ℝ) / n) ^ 2 * k with hu_def
    have hu : 0 ≤ u := mul_nonneg (sq_nonneg _) hk
    have hb := one_sub_half_le_inv_sqrt hu
    have hun : u = k / n ^ 2 := by rw [hu_def]; field_simp
    have key : -(k / (2 * n)) = (n : ℝ) * (1 - u / 2 - 1) := by
      rw [hun]; field_simp; ring
    rw [key]
    exact mul_le_mul_of_nonneg_left (by linarith) hn'.le
  have hhigh : ∀ᶠ n : ℕ in atTop,
      (n : ℝ) * ((Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * k))⁻¹ - 1) ≤ 0 := by
    filter_upwards [eventually_gt_atTop 0] with n hn
    have hn' : (0 : ℝ) < n := by exact_mod_cast hn
    have hu : 0 ≤ ((1 : ℝ) / n) ^ 2 * k := mul_nonneg (sq_nonneg _) hk
    have := inv_sqrt_le_one hu
    nlinarith [hn'.le]
  have hleft : Tendsto (fun n : ℕ => -(k / (2 * n))) atTop (nhds 0) := by
    simpa [div_div] using (tendsto_const_div_atTop_nhds_zero_nat (k / 2)).neg
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le' hleft tendsto_const_nhds hlow hhigh

/-- **`r(1/n) → 1`**, the other limit the assembly needs, from the SAME two-sided bound.

*Stated with the bound in the form `one_sub_half_le_inv_sqrt` already gives*, so no conversion
between `k/n²` and `(1/n)²·k` is needed: that conversion is what made the first attempt fail, since
the two agree at every `n` and are not the same term. -/
theorem tendsto_rad (k : ℝ) (hk : 0 ≤ k) :
    Tendsto (fun n : ℕ => (Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * k))⁻¹) atTop (nhds 1) := by
  have hlow : ∀ n : ℕ,
      1 - ((1 : ℝ) / n) ^ 2 * k / 2 ≤ (Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * k))⁻¹ := by
    intro n
    have h := one_sub_half_le_inv_sqrt (mul_nonneg (sq_nonneg ((1 : ℝ) / n)) hk)
    linarith
  have hhigh : ∀ n : ℕ, (Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * k))⁻¹ ≤ 1 :=
    fun _ => inv_sqrt_le_one (mul_nonneg (sq_nonneg _) hk)
  have hleft : Tendsto (fun n : ℕ => 1 - ((1 : ℝ) / n) ^ 2 * k / 2) atTop (nhds 1) := by
    have h1 : Tendsto (fun n : ℕ => (1 : ℝ) / n) atTop (nhds 0) :=
      tendsto_one_div_atTop_nhds_zero_nat
    simpa using tendsto_const_nhds.sub (((h1.pow 2).mul_const k).div_const 2)
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le' hleft tendsto_const_nhds
    (Eventually.of_forall hlow) (Eventually.of_forall hhigh)

/-! ## The decomposition the assembly runs on

*Pure algebra, no limits*: the displacement splits into a scalar multiple of `a` and a scalar
multiple of `y`, and the two scalars are exactly the ones bounded above.
-/

/-- **`γ(t) - a = (r(t) - 1) • a + (t · r(t)) • y`.**

*This is what makes the tangent cone computable in closed form*: the displacement never leaves the
plane spanned by `a` and `y`, so the limit is decided by two scalars rather than by a geometry. -/
theorem sphereCurve_sub {ι : Type*} [Fintype ι] [DecidableEq ι] (a y : CurvOp2 ι) (t : ℝ) :
    sphereCurve a y t - a
      = ((Real.sqrt (1 + t ^ 2 * normSq2 y))⁻¹ - 1) • a
        + (t * (Real.sqrt (1 + t ^ 2 * normSq2 y))⁻¹) • y := by
  unfold sphereCurve
  module

/-! ## The assembly

`posTangentConeAt s x` IS `tangentConeAt ℝ≥0 s x`, and `NNReal.smul_def` turns its scalar action
into the real one, so `mem_tangentConeAt_of_seq` applies with `c n = n` and
`d n = γ(1/n) - a`. **Its three obligations are the two limits above plus `sphereCurve_mem`.**
-/

/-- **THE TANGENT CONE MEMBERSHIP**, r1016's third piece: every `y` orthogonal to a unit `a` lies
in the positive tangent cone of the unit sphere at `a`.

*The witness is the normalised curve rather than a segment*, since `a + t • y` leaves the sphere
and no segment through `a` stays on it. -/
theorem mem_posTangentConeAt_sphere {ι : Type*} [Fintype ι] [DecidableEq ι]
    {a y : CurvOp2 ι} (ha : normSq2 a = 1) (hy : innerOp2 a y = 0) :
    y ∈ posTangentConeAt {R : CurvOp2 ι | normSq2 R = 1} a := by
  haveI : ContinuousAdd (CurvOp2 ι) :=
    (inferInstance : IsTopologicalAddGroup (CurvOp2 ι)).toContinuousAdd
  have hk : 0 ≤ normSq2 y := normSq2_nonneg y
  refine mem_tangentConeAt_of_seq atTop (fun n : ℕ => (n : ℝ≥0))
    (fun n : ℕ => sphereCurve a y (1 / n) - a) ?_ ?_ ?_
  · -- `d n → 0`
    have h1 : Tendsto (fun n : ℕ => (1 : ℝ) / n) atTop (nhds 0) :=
      tendsto_one_div_atTop_nhds_zero_nat
    have hr := tendsto_rad (normSq2 y) hk
    have : Tendsto (fun n : ℕ => sphereCurve a y (1 / n) - a) atTop (nhds (0 : CurvOp2 ι)) := by
      simp only [sphereCurve_sub]
      have ha' : Tendsto
          (fun n : ℕ => ((Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * normSq2 y))⁻¹ - 1) • a)
          atTop (nhds (((1 : ℝ) - 1) • a)) := (hr.sub_const 1).smul_const a
      have hy' : Tendsto
          (fun n : ℕ => ((1 : ℝ) / n * (Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * normSq2 y))⁻¹) • y)
          atTop (nhds (((0 : ℝ) * 1) • y)) := (h1.mul hr).smul_const y
      have h := ha'.add hy'
      have hz : ((1:ℝ) - 1) • a + ((0:ℝ) * 1) • y = (0 : CurvOp2 ι) := by module
      rw [hz] at h
      exact h
    exact this
  · -- `a + d n` is on the sphere
    filter_upwards with n
    have hcancel : a + (sphereCurve a y (1 / n) - a) = sphereCurve a y (1 / n) := by abel
    show normSq2 (a + (sphereCurve a y (1 / n) - a)) = 1
    rw [hcancel]
    exact sphereCurve_mem ha hy _
  · -- `n • d n → y`
    have hr := tendsto_rad (normSq2 y) hk
    have hzero := tendsto_n_mul_rad_sub_one (normSq2 y) hk
    -- the identity is pure module algebra once the scalar is left unsimplified
    have key : ∀ n : ℕ, ((n : ℝ≥0)) • (sphereCurve a y (1 / n) - a)
        = ((n : ℝ) * ((Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * normSq2 y))⁻¹ - 1)) • a
          + ((n : ℝ) * ((1 : ℝ) / n) * (Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * normSq2 y))⁻¹) • y := by
      intro n
      rw [NNReal.smul_def, sphereCurve_sub]
      module
    simp only [key]
    have h1 : Tendsto
        (fun n : ℕ => ((n : ℝ) * ((Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * normSq2 y))⁻¹ - 1)) • a)
        atTop (nhds ((0 : ℝ) • a)) := hzero.smul_const a
    have hscal : Tendsto
        (fun n : ℕ => (n : ℝ) * ((1 : ℝ) / n)
          * (Real.sqrt (1 + ((1 : ℝ) / n) ^ 2 * normSq2 y))⁻¹) atTop (nhds ((1 : ℝ) * 1)) := by
      refine Tendsto.mul ?_ hr
      refine Tendsto.congr' ?_ tendsto_const_nhds
      filter_upwards [eventually_gt_atTop 0] with n hn
      have : (n : ℝ) ≠ 0 := by positivity
      field_simp
    have h2 := hscal.smul_const y
    have h := h1.add h2
    have hz : (0 : ℝ) • a + ((1:ℝ) * 1) • y = y := by module
    rw [hz] at h
    exact h

end HamiltonsCubic.RealLayer
