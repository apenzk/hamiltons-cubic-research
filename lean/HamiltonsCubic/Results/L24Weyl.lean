import HamiltonsCubic.Results.SphereFermat
import HamiltonsCubic.Results.CubicTri
import HamiltonsCubic.Results.SphereCurve
import HamiltonsCubic.Results.L24Abstract

set_option linter.style.longLine false

/-!
# L24 on the operator layer: the second-order bound at a maximiser of `P`

[findings/second-order.md](../../../findings/second-order.md), Lemma L24 (Krasnov–Tkachev,
Proposition 6.6). [L24Abstract.lean](L24Abstract.lean) proves the bound for an abstract symmetric
trilinear form; **this file proves it for the programme's own `P`**, `Pcubic2` on `CurvOp2`: on any
set containing the sphere curve (`L24_of_curve`), on the whole unit sphere (`L24_curvOp`), and on the
unit sphere of the Weyl operators with criticality as a hypothesis (`L24_weyl`), the record's case.

**THE STATEMENT.** For a self-adjoint unit `a` that locally maximises `P` on the unit sphere, with
`θ = P(a) > 0`, every self-adjoint unit `v ⊥ a` has `⟪a, Q(v)⟫ ≤ θ/2`. *`⟪a, Q(v)⟫` is `T(a,v,v)`,
so with `e = a/θ` this is `⟪L_e v, v⟫ ≤ ½`, the record's `λ_max(L_e|W⊥) ≤ ½` read as a quadratic
form.*

**THE HESSIAN IDENTITY NEEDS NO NEW ALGEBRA.** *The quadratic part of `P`'s increment is the
linear part with the roles swapped* (`Pcubic2Quad_eq_Lin_swap`, both being the three arrangements
of `cubicTri`), *and the linear part at a self-adjoint point is `3⟪H, Q(R)⟫`*
(`Pcubic2Lin_selfAdjoint`). So along `a + s v` the cubic is `θ + 3 s² ⟪a, Q v⟫ + s³ P(v)`, the
`s`-term vanishing by criticality (`Qop2_eq_smul_of_isLocalMaxOn`).

**THE CURVE IS `sphereCurve a v`**, which stays on the sphere at every `s`
([SphereCurve.lean](SphereCurve.lean)) and is continuous, so local maximality gives
`P(γ s) ≤ P(a)` for small `s`; the scalar contradiction is `L24Abstract.real_close`.

**Carried elsewhere**: the passage to `λ_max` of the restriction to `W⊥` and the simplicity of the
eigenvalue `1` are [L24Restrict.lean](L24Restrict.lean) and [L24Eigen.lean](L24Eigen.lean); a
maximiser meeting every hypothesis of `L24_weyl` is [WeylMaximiser.lean](WeylMaximiser.lean)'s
`L24_nonvacuous`; the Hessian along great circles is [L24Hess.lean](L24Hess.lean)'s `L24_hessian`, and the
sharpness of `½` along the orbit is [L24Sharp.lean](L24Sharp.lean)'s `L24_sharp` ([r1194](../../../reviews/REVIEW_r1194.md)
asked for both).
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`P` is homogeneous of degree three.** -/
theorem Pcubic2_smul (c : ℝ) (R : CurvOp2 ι) : Pcubic2 (c • R) = c ^ 3 * Pcubic2 R := by
  rw [Pcubic2_eq_cubicTri, Pcubic2_eq_cubicTri, cubicTri_smul_left, cubicTri_smul_mid,
    cubicTri_smul_right]
  ring

/-- **The quadratic part of the increment is the linear part with the roles swapped.** -/
theorem Pcubic2Quad_eq_Lin_swap (R H : CurvOp2 ι) : Pcubic2Quad R H = Pcubic2Lin H R := by
  rw [Pcubic2Quad_eq_cubicTri, Pcubic2Lin_eq_cubicTri]
  ring

/-- **So at a self-adjoint direction the quadratic part is `3⟪R, Q(H)⟫`**, the Hessian identity. -/
theorem Pcubic2Quad_selfAdjoint {H : CurvOp2 ι} (hH : IsSelfAdjoint2 H) (R : CurvOp2 ι) :
    Pcubic2Quad R H = 3 * innerOp2 R (Qop2 H) := by
  rw [Pcubic2Quad_eq_Lin_swap, Pcubic2Lin_selfAdjoint hH]

theorem Pcubic2Quad_smul (c : ℝ) (R H : CurvOp2 ι) :
    Pcubic2Quad R (c • H) = c ^ 2 * Pcubic2Quad R H := by
  rw [Pcubic2Quad_eq_cubicTri, Pcubic2Quad_eq_cubicTri]
  simp only [cubicTri_smul_left, cubicTri_smul_mid, cubicTri_smul_right]
  ring

/-- **The cubic along a line through a self-adjoint point, in a direction `Q(a)` is orthogonal
to.** -/
theorem Pcubic2_line {a v : CurvOp2 ι} (ha : IsSelfAdjoint2 a) (hv : IsSelfAdjoint2 v)
    (hQ : innerOp2 v (Qop2 a) = 0) (s : ℝ) :
    Pcubic2 (a + s • v) = Pcubic2 a + 3 * s ^ 2 * innerOp2 a (Qop2 v) + s ^ 3 * Pcubic2 v := by
  rw [Pcubic2_expand, Pcubic2Lin_selfAdjoint ha, innerOp2_smul_left, hQ, Pcubic2Quad_smul,
    Pcubic2Quad_selfAdjoint hv, Pcubic2_smul]
  ring

/-- The sphere curve is continuous. *`ContinuousAdd` is supplied from the additive-group instance,
as in [SphereTangent.lean](SphereTangent.lean), since it does not synthesize on `CurvOp2`.* -/
theorem continuous_sphereCurve (a y : CurvOp2 ι) : Continuous (sphereCurve a y) := by
  have : ContinuousAdd (CurvOp2 ι) :=
    (inferInstance : IsTopologicalAddGroup (CurvOp2 ι)).toContinuousAdd
  unfold sphereCurve
  have hpos : ∀ t : ℝ, Real.sqrt (1 + t ^ 2 * normSq2 y) ≠ 0 := fun t => by
    have := normSq2_nonneg y
    exact (Real.sqrt_pos.mpr (by nlinarith [sq_nonneg t])).ne'
  have h1 : Continuous fun t : ℝ => (Real.sqrt (1 + t ^ 2 * normSq2 y))⁻¹ :=
    Continuous.inv₀ (by fun_prop) hpos
  have h3 : Continuous fun t : ℝ => t • y :=
    Continuous.smul (f := fun t : ℝ => t) (g := fun _ : ℝ => y) continuous_id continuous_const
  have h2 : Continuous fun t : ℝ => a + t • y :=
    Continuous.add (f := fun _ : ℝ => a) (g := fun t : ℝ => t • y) continuous_const h3
  exact h1.smul h2

set_option maxHeartbeats 1000000 in
/-- **L24 FOR `P`, ON ANY SET CONTAINING THE CURVE.** If `a` locally maximises `P` on a set `S`
that contains the whole sphere curve through `a` in the direction `v`, and `Q(a)` is orthogonal
to `v`, then `⟪a, Q(v)⟫ ≤ P(a)/2`. *Neither a unit `a` nor `v ⊥ a` is a hypothesis: the curve's membership in `S` is what the
argument uses, and the corollaries below discharge it on the unit sphere of `CurvOp2` and on the
unit sphere of the Weyl operators, where those two facts are what put the curve on the sphere.* -/
theorem L24_of_curve {a v : CurvOp2 ι} (hsa : IsSelfAdjoint2 a)
    (hsv : IsSelfAdjoint2 v) (hv1 : normSq2 v = 1)
    {S : Set (CurvOp2 ι)} (hS : ∀ t, sphereCurve a v t ∈ S)
    (hmax : IsLocalMaxOn Pcubic2 S a) (hQ : innerOp2 v (Qop2 a) = 0) (hθ : 0 < Pcubic2 a) :
    innerOp2 a (Qop2 v) ≤ Pcubic2 a / 2 := by
  set θ := Pcubic2 a with hθdef
  set b := innerOp2 a (Qop2 v) with hbdef
  set c := Pcubic2 v with hcdef
  -- local maximality along the sphere curve
  have hγ : Filter.Tendsto (sphereCurve a v) (nhds 0) (nhdsWithin a S) := by
    refine tendsto_nhdsWithin_iff.mpr ⟨?_, Filter.Eventually.of_forall hS⟩
    have := (continuous_sphereCurve a v).tendsto 0
    rwa [sphereCurve_zero] at this
  have hev : ∀ᶠ t in nhds (0 : ℝ), Pcubic2 (sphereCurve a v t) ≤ θ := hγ.eventually hmax
  obtain ⟨ε, hε, hloc⟩ := Metric.eventually_nhds_iff.mp hev
  by_contra hcon
  push Not at hcon
  have hg : 0 < 3 * b - 3 * θ / 2 := by linarith
  obtain ⟨s, hs0, hs1, hsε, hsg⟩ :=
    HamiltonsCubic.L24Abstract.exists_small ε (3 * b - 3 * θ / 2) (2 * (|c| + θ + 1)) hε hg
      (by positivity)
  obtain ⟨r, hrdef⟩ : ∃ r, r = Real.sqrt (1 + s ^ 2) := ⟨_, rfl⟩
  have hrsq : r ^ 2 = 1 + s ^ 2 := by rw [hrdef]; exact Real.sq_sqrt (by positivity)
  have hr1 : 1 ≤ r := by rw [hrdef, Real.one_le_sqrt]; nlinarith
  have hrpos : 0 < r := by linarith
  have hrle : r ≤ 1 + s ^ 2 / 2 := by nlinarith [sq_nonneg (r - 1), sq_nonneg s]
  have hdist : dist s 0 < ε := by rw [Real.dist_eq, sub_zero, abs_of_pos hs0]; exact hsε
  have hle := hloc hdist
  have hcurve : sphereCurve a v s = r⁻¹ • (a + s • v) := by
    unfold sphereCurve; rw [hv1, mul_one, ← hrdef]
  rw [hcurve, Pcubic2_smul, Pcubic2_line hsa hsv hQ s] at hle
  have hr3 : 0 < r ^ 3 := by positivity
  have key : θ + 3 * s ^ 2 * b + s ^ 3 * c ≤ θ * r ^ 3 := by
    have h := mul_le_mul_of_nonneg_left hle hr3.le
    rw [← mul_assoc, show r ^ 3 * r⁻¹ ^ 3 = 1 by rw [← mul_pow, mul_inv_cancel₀ hrpos.ne', one_pow],
      one_mul] at h
    linarith
  exact HamiltonsCubic.L24Abstract.real_close θ b c s r hθ hs0 hs1 hrsq hrpos hrle key hsg hg

/-- **On the whole unit sphere of `CurvOp2`**, where criticality comes from Fermat. -/
theorem L24_curvOp {a v : CurvOp2 ι} (ha : normSq2 a = 1) (hsa : IsSelfAdjoint2 a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1} a) (hθ : 0 < Pcubic2 a)
    (hsv : IsSelfAdjoint2 v) (hv : innerOp2 a v = 0) (hv1 : normSq2 v = 1) :
    innerOp2 a (Qop2 v) ≤ Pcubic2 a / 2 := by
  have hQ : innerOp2 v (Qop2 a) = 0 := by
    rw [Qop2_eq_smul_of_isLocalMaxOn ha hsa hmax, innerOp2_smul_right, innerOp2_comm v a, hv,
      mul_zero]
  exact L24_of_curve hsa hsv hv1 (fun t => sphereCurve_mem ha hv t) hmax hQ hθ

/-- The Weyl operators are closed under addition. -/
theorem isWeyl2_add {R S : CurvOp2 ι} (hR : IsWeyl2 R) (hS : IsWeyl2 S) : IsWeyl2 (R + S) where
  selfAdjoint X Y := by
    have h1 := hR.selfAdjoint X Y
    have h2 := hS.selfAdjoint X Y
    simp only [_root_.add_apply, Submodule.coe_add] at *
    unfold inner2 at *
    simp only [Matrix.transpose_add, Matrix.add_mul, Matrix.mul_add, Matrix.trace_add] at *
    linear_combination h1 + h2
  bianchi i j k l := by
    have h1 := hR.bianchi i j k l
    have h2 := hS.bianchi i j k l
    simp only [applyPhi, _root_.add_apply, Submodule.coe_add] at *
    unfold inner2 at *
    simp only [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add] at *
    linear_combination h1 + h2
  ric a b := by
    have h1 := hR.ric a b
    have h2 := hS.ric a b
    simp only [applyPhi, _root_.add_apply, Submodule.coe_add] at *
    unfold inner2 at *
    simp only [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add, mul_add,
      Finset.sum_add_distrib] at *
    linear_combination h1 + h2

/-- The Weyl operators are closed under scaling. -/
theorem isWeyl2_smul (c : ℝ) {R : CurvOp2 ι} (hR : IsWeyl2 R) : IsWeyl2 (c • R) where
  selfAdjoint X Y := by
    have h1 := hR.selfAdjoint X Y
    simp only [_root_.smul_apply, Submodule.coe_smul] at *
    unfold inner2 at *
    simp only [Matrix.transpose_smul, Matrix.smul_mul, Matrix.mul_smul, Matrix.trace_smul,
      smul_eq_mul] at *
    linear_combination c * h1
  bianchi i j k l := by
    have h1 := hR.bianchi i j k l
    simp only [applyPhi, _root_.smul_apply, Submodule.coe_smul] at *
    unfold inner2 at *
    simp only [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul] at *
    linear_combination c * h1
  ric a b := by
    have h1 := hR.ric a b
    simp only [applyPhi, _root_.smul_apply, Submodule.coe_smul] at *
    unfold inner2 at *
    simp only [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul,
      ← Finset.mul_sum] at *
    linear_combination c * h1

/-- **L24 ON THE WEYL SPHERE, THE RECORD'S STATEMENT.** A Weyl operator `a` that is critical,
`Q(a) = λ a`, and locally maximises `P` on the unit sphere of the Weyl operators, with `P(a) > 0`,
has `⟪a, Q(v)⟫ ≤ P(a)/2` at every unit Weyl `v ⊥ a`; with `e = a/θ` this is `⟪L_e v, v⟫ ≤ ½`. -/
theorem L24_weyl {a v : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a) (hWv : IsWeyl2 v) (hv : innerOp2 a v = 0) (hv1 : normSq2 v = 1) :
    innerOp2 a (Qop2 v) ≤ Pcubic2 a / 2 := by
  have hQ : innerOp2 v (Qop2 a) = 0 := by
    rw [hcrit, innerOp2_smul_right, innerOp2_comm v a, hv, mul_zero]
  refine L24_of_curve hWa.isSelfAdjoint2 hWv.isSelfAdjoint2 hv1 (fun t => ?_) hmax hQ hθ
  refine ⟨sphereCurve_mem ha hv t, ?_⟩
  exact isWeyl2_smul _ (isWeyl2_add hWa (isWeyl2_smul t hWv))

end HamiltonsCubic.RealLayer
