import Mathlib

/-!
# Isserlis' fourth moment for two quadratic forms, stated

For a standard Gaussian vector `v` on `ℝ^d` and symmetric `A`, `B`,
`E[(vᵀAv)(vᵀBv)] = tr A · tr B + 2 tr(AB)`.

[L238](../../../findings/second-order.md) uses it to write a seven-frame's bracket total as
`E[(tr G)² − ‖G‖²] − 168` and, through it, the rank refinement at `d ≤ 7`. **At `r = 7` it is no
longer needed**: `frame_identity` in [FrameGaussianBound.lean](FrameGaussianBound.lean) evaluates
the Gaussian identity as an exact trace identity. What still rests on this moment is the rank
refinement `rank G(v) ≤ d − 1 < 7`, the `hM` of `isotropic_frame_bound`.

**Proved** from the product structure of `Measure.pi` and the moments `1, 0, 1, 0, 3` of
`gaussianReal 0 1`, which are the derivatives of its moment generating function `exp (t²/2)` at `0`
(`iteratedDeriv_mgf_zero`). A monomial `v i v j v k v l` factors as `∏ₘ vₘ^{cₘ}`, so
`integral_fintype_prod_eq_prod` gives the four-point moment `δᵢⱼδₖₗ + δᵢₖδⱼₗ + δᵢₗδⱼₖ` (`E4`).
-/

namespace HamiltonsCubic.Results.Isserlis

open MeasureTheory ProbabilityTheory Real

/-- The Gaussian moments are the derivatives of `exp (t²/2)` at `0`. -/
theorem moment_eq_deriv (n : ℕ) :
    ∫ x, x ^ n ∂(gaussianReal 0 1) = iteratedDeriv n (fun t => Real.exp (t ^ 2 / 2)) 0 := by
  have h := iteratedDeriv_mgf_zero (X := id) (μ := gaussianReal 0 1)
    (by rw [integrableExpSet_id_gaussianReal]; simp) n
  rw [mgf_id_gaussianReal] at h
  simp only [zero_mul, zero_add, NNReal.coe_one, one_mul] at h
  rw [h]; rfl

theorem d1 : deriv (fun t : ℝ => Real.exp (t ^ 2 / 2)) = fun t => t * Real.exp (t ^ 2 / 2) := by
  funext t
  have := ((hasDerivAt_pow 2 t).div_const 2).exp
  rw [this.deriv]; ring

theorem d2 : deriv (fun t : ℝ => t * Real.exp (t ^ 2 / 2)) = fun t => (1 + t ^ 2) * Real.exp (t ^ 2 / 2) := by
  funext t
  have : HasDerivAt (fun t : ℝ => t * Real.exp (t ^ 2 / 2)) _ t :=
    (hasDerivAt_id t).mul ((hasDerivAt_pow 2 t).div_const 2).exp
  rw [this.deriv]; simp; ring

theorem d3 : deriv (fun t : ℝ => (1 + t ^ 2) * Real.exp (t ^ 2 / 2))
    = fun t => (3 * t + t ^ 3) * Real.exp (t ^ 2 / 2) := by
  funext t
  have : HasDerivAt (fun t : ℝ => (1 + t ^ 2) * Real.exp (t ^ 2 / 2)) _ t :=
    ((hasDerivAt_pow 2 t).const_add 1).mul ((hasDerivAt_pow 2 t).div_const 2).exp
  rw [this.deriv]; simp; ring

theorem d4 : deriv (fun t : ℝ => (3 * t + t ^ 3) * Real.exp (t ^ 2 / 2))
    = fun t => (3 + 6 * t ^ 2 + t ^ 4) * Real.exp (t ^ 2 / 2) := by
  funext t
  have : HasDerivAt (fun t : ℝ => (3 * t + t ^ 3) * Real.exp (t ^ 2 / 2)) _ t :=
    (((hasDerivAt_id t).const_mul 3).add (hasDerivAt_pow 3 t)).mul ((hasDerivAt_pow 2 t).div_const 2).exp
  rw [this.deriv]; simp; ring

theorem it1 : iteratedDeriv 1 (fun t : ℝ => Real.exp (t ^ 2 / 2)) = fun t => t * Real.exp (t ^ 2 / 2) := by
  rw [iteratedDeriv_one, d1]
theorem it2 : iteratedDeriv 2 (fun t : ℝ => Real.exp (t ^ 2 / 2)) = fun t => (1 + t ^ 2) * Real.exp (t ^ 2 / 2) := by
  rw [iteratedDeriv_succ, it1, d2]
theorem it3 : iteratedDeriv 3 (fun t : ℝ => Real.exp (t ^ 2 / 2)) = fun t => (3 * t + t ^ 3) * Real.exp (t ^ 2 / 2) := by
  rw [iteratedDeriv_succ, it2, d3]
theorem it4 : iteratedDeriv 4 (fun t : ℝ => Real.exp (t ^ 2 / 2))
    = fun t => (3 + 6 * t ^ 2 + t ^ 4) * Real.exp (t ^ 2 / 2) := by
  rw [iteratedDeriv_succ, it3, d4]

/-- **The Gaussian moment table.** -/
theorem m0 : ∫ x, x ^ 0 ∂(gaussianReal 0 1) = 1 := by simp
theorem m1 : ∫ x, x ^ 1 ∂(gaussianReal 0 1) = 0 := by rw [moment_eq_deriv, it1]; simp
theorem m2 : ∫ x, x ^ 2 ∂(gaussianReal 0 1) = 1 := by rw [moment_eq_deriv, it2]; simp
theorem m3 : ∫ x, x ^ 3 ∂(gaussianReal 0 1) = 0 := by rw [moment_eq_deriv, it3]; simp
theorem m4 : ∫ x, x ^ 4 ∂(gaussianReal 0 1) = 3 := by rw [moment_eq_deriv, it4]; simp

theorem integrable_pow_gauss (n : ℕ) : Integrable (fun x : ℝ => x ^ n) (gaussianReal 0 1) := by
  refine ((memLp_id_gaussianReal (n : NNReal)).integrable_norm_pow').mono'
    (by fun_prop) (Filter.Eventually.of_forall fun x => ?_)
  simp [norm_pow]

variable {d : ℕ}

/-- The exponent of coordinate `m` in `v i v j v k v l`. -/
def cnt (i j k l m : Fin d) : ℕ :=
  (if m = i then 1 else 0) + (if m = j then 1 else 0) + (if m = k then 1 else 0) + (if m = l then 1 else 0)

theorem prod_single (v : Fin d → ℝ) (i : Fin d) : ∏ m, v m ^ (if m = i then 1 else 0) = v i := by
  rw [Finset.prod_eq_single i (fun b _ hb => by simp [hb]) (by simp)]; simp

theorem monomial_eq (v : Fin d → ℝ) (i j k l : Fin d) :
    v i * v j * v k * v l = ∏ m, v m ^ cnt i j k l m := by
  simp only [cnt, pow_add, Finset.prod_mul_distrib, prod_single]

theorem mtab (n : ℕ) (hn : n ≤ 4) :
    ∫ x, x ^ n ∂(gaussianReal 0 1) = if n = 0 then 1 else if n = 2 then 1 else if n = 4 then 3 else 0 := by
  interval_cases n
  · simp
  · rw [m1]; simp
  · rw [m2]; simp
  · rw [m3]; simp
  · rw [m4]; simp

/-- **The four-point moment.** -/
theorem E4 (i j k l : Fin d) :
    ∫ v, v i * v j * v k * v l ∂(Measure.pi fun _ : Fin d => gaussianReal 0 1)
      = (if i = j ∧ k = l then 1 else 0) + (if i = k ∧ j = l then 1 else 0)
        + (if i = l ∧ j = k then 1 else 0) := by
  simp_rw [monomial_eq _ i j k l]
  rw [integral_fintype_prod_eq_prod (fun m x => x ^ cnt i j k l m)]
  have hle : ∀ m, cnt i j k l m ≤ 4 := fun m => by unfold cnt; split_ifs <;> omega
  simp only [fun m => mtab (cnt i j k l m) (hle m)]
  have h0 : ∀ m, m ≠ i → m ≠ j → m ≠ k → m ≠ l → cnt i j k l m = 0 := by
    intro m h1 h2 h3 h4; simp [cnt, h1, h2, h3, h4]
  rw [← Finset.prod_subset (Finset.subset_univ {i, j, k, l}) (fun m _ hm => by
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hm
    rw [h0 m hm.1 hm.2.1 hm.2.2.1 hm.2.2.2]; simp)]
  by_cases hij : i = j <;> by_cases hik : i = k <;> by_cases hil : i = l <;> by_cases hjk : j = k <;>
    by_cases hjl : j = l <;> by_cases hkl : k = l <;> subst_vars <;>
    simp_all [cnt, Finset.prod_insert, eq_comm] <;> norm_num

theorem integrable_mono (i j k l : Fin d) :
    Integrable (fun v : Fin d → ℝ => v i * v j * v k * v l) (Measure.pi fun _ : Fin d => gaussianReal 0 1) := by
  simp_rw [monomial_eq _ i j k l]
  exact Integrable.fintype_prod (f := fun m x => x ^ cnt i j k l m) fun m => integrable_pow_gauss _

theorem isserlis (A B : Matrix (Fin d) (Fin d) ℝ) (hA : A.IsSymm) (hB : B.IsSymm) :
    ∫ v, (v ⬝ᵥ A.mulVec v) * (v ⬝ᵥ B.mulVec v) ∂(Measure.pi fun _ : Fin d => gaussianReal 0 1) =
      A.trace * B.trace + 2 * (A * B).trace := by
  set μ := Measure.pi fun _ : Fin d => gaussianReal 0 1
  have hexp : ∀ v : Fin d → ℝ, (v ⬝ᵥ A.mulVec v) * (v ⬝ᵥ B.mulVec v)
      = ∑ i, ∑ j, ∑ k, ∑ l, A i j * B k l * (v i * v j * v k * v l) := by
    intro v
    have q : ∀ C : Matrix (Fin d) (Fin d) ℝ, v ⬝ᵥ C.mulVec v = ∑ i, ∑ j, C i j * (v i * v j) := by
      intro C
      simp only [dotProduct, Matrix.mulVec, Finset.mul_sum]
      exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
    rw [q A, q B, Finset.sum_mul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by ring
  simp_rw [hexp]
  have hI : ∀ i j k l, Integrable (fun v : Fin d → ℝ => A i j * B k l * (v i * v j * v k * v l)) μ :=
    fun i j k l => (integrable_mono i j k l).const_mul _
  rw [integral_finset_sum _ fun i _ => integrable_finset_sum _ fun j _ => integrable_finset_sum _
    fun k _ => integrable_finset_sum _ fun l _ => hI i j k l]
  have inner : ∀ i j, ∫ a, ∑ k, ∑ l, A i j * B k l * (a i * a j * a k * a l) ∂μ
      = ∑ k, ∑ l, A i j * B k l * ((if i = j ∧ k = l then 1 else 0) + (if i = k ∧ j = l then 1 else 0)
          + (if i = l ∧ j = k then 1 else 0)) := by
    intro i j
    rw [integral_finset_sum _ fun k _ => integrable_finset_sum _ fun l _ => hI i j k l]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [integral_finset_sum _ fun l _ => hI i j k l]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [integral_const_mul, E4]
  rw [Finset.sum_congr rfl fun i _ => (integral_finset_sum _ fun j _ => integrable_finset_sum _
    fun k _ => integrable_finset_sum _ fun l _ => hI i j k l)]
  simp only [inner]
  simp only [mul_add, Finset.sum_add_distrib, mul_ite, mul_one, mul_zero, ite_and,
    Finset.sum_ite_eq, Finset.mem_univ, if_true, Finset.sum_ite_irrel,
    Finset.sum_const_zero]
  have hb : ∀ i j, B j i = B i j := fun i j => hB.apply i j
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Finset.sum_mul_sum, hb]
  ring

end HamiltonsCubic.Results.Isserlis

namespace HamiltonsCubic.Results

open MeasureTheory ProbabilityTheory

/-- **Isserlis' fourth moment for two quadratic forms.** -/
theorem integral_quadForm_mul_quadForm {d : ℕ} (A B : Matrix (Fin d) (Fin d) ℝ)
    (hA : A.IsSymm) (hB : B.IsSymm) :
    ∫ v, (v ⬝ᵥ A.mulVec v) * (v ⬝ᵥ B.mulVec v) ∂(Measure.pi fun _ : Fin d => gaussianReal 0 1) =
      A.trace * B.trace + 2 * (A * B).trace :=
  Isserlis.isserlis A B hA hB

end HamiltonsCubic.Results
