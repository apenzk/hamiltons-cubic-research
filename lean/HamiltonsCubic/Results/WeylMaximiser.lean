import HamiltonsCubic.Results.L66Positive
import HamiltonsCubic.Results.L24Weyl
import HamiltonsCubic.Results.L24Restrict
import HamiltonsCubic.Results.SphereTangent
import HamiltonsCubic.Results.Frechet

set_option linter.style.longLine false

/-!
# A maximiser of `P` on the unit Weyl sphere exists, is critical, and satisfies L24

[L24Weyl.lean](L24Weyl.lean)'s `L24_weyl` takes a unit Weyl `a` that is critical, `Q(a) = λa`,
locally maximises `P` on the unit Weyl sphere and has `P(a) > 0`. [SphereFermat.lean](SphereFermat.lean)
derives criticality only from maximality on the FULL sphere of `End(Λ²)`, the stronger hypothesis.
**This file supplies every hypothesis at every `n ≥ 4`**:

- `mem_posTangentConeAt_of_curve`: a `y ⊥ a` lies in the tangent cone of any set carrying the
  sphere curve `sphereCurve a y`, [SphereTangent.lean](SphereTangent.lean)'s argument with the set
  left free;
- `innerOp2_Qop2_eq_zero_weyl` and `Qop2_eq_smul_weyl`: **a local maximiser of `P` on the unit
  Weyl sphere has `Q(a) = P(a)·a`**, the Lagrange condition on the sphere the record maximises on,
  `Q(a)` being Weyl since `Q(a) = a ∘ a` (`foxProd2_self`, `isWeyl2_foxProd2`);
- `exists_weyl_maximiser`: at `n ≥ 4` the unit Weyl sphere is compact (a sphere in the
  finite-dimensional `weylR`), nonempty (`Wc n`), and `P` is continuous on it, so `P` attains its
  maximum there;
- `L24_nonvacuous`: **that maximiser is a unit Weyl `a` with `Q(a) = P(a)·a`, `P(a) ≥ √(3/2)`, and
  `⟪a, Q(v)⟫ ≤ P(a)/2` at every unit Weyl `v ⊥ a`**, so `L24_weyl`'s hypotheses are met by an
  object and its conclusion holds there;
- `L0_critical_reduction`: **[L0](L0.lean)'s reduction**, `P ≤ Θ` on the unit Weyl sphere iff
  `P ≤ Θ` at every critical point `Q(R) = P(R)·R`, with the compactness and the Lagrange condition
  both proved here rather than imported.
-/

namespace HamiltonsCubic.RealLayer

open Filter Topology HamiltonsCubic.CP2Real HamiltonsCubic.L66Statement
open scoped NNReal Matrix.Norms.Frobenius OperatorNorm

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The tangent cone of any set carrying the sphere curve** contains every `y ⊥ a`. -/
theorem mem_posTangentConeAt_of_curve {s : Set (CurvOp2 ι)} {a y : CurvOp2 ι}
    (hs : ∀ t, sphereCurve a y t ∈ s) :
    y ∈ posTangentConeAt s a := by
  have : ContinuousAdd (CurvOp2 ι) :=
    (inferInstance : IsTopologicalAddGroup (CurvOp2 ι)).toContinuousAdd
  have hk : 0 ≤ normSq2 y := normSq2_nonneg y
  refine mem_tangentConeAt_of_seq atTop (fun n : ℕ => (n : ℝ≥0))
    (fun n : ℕ => sphereCurve a y (1 / n) - a) ?_ ?_ ?_
  · have h1 : Tendsto (fun n : ℕ => (1 : ℝ) / n) atTop (nhds 0) :=
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
  · filter_upwards with n
    have hcancel : a + (sphereCurve a y (1 / n) - a) = sphereCurve a y (1 / n) := by abel
    show a + (sphereCurve a y (1 / n) - a) ∈ s
    rw [hcancel]
    exact hs _
  · have hr := tendsto_rad (normSq2 y) hk
    have hzero := tendsto_n_mul_rad_sub_one (normSq2 y) hk
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

/-- The unit Weyl sphere. -/
def weylSphereSet (ι : Type*) [Fintype ι] [DecidableEq ι] : Set (CurvOp2 ι) :=
  {R | normSq2 R = 1 ∧ IsWeyl2 R}

/-- **FERMAT ON THE UNIT WEYL SPHERE**: a local maximiser `a` has `⟪y, Q(a)⟫ = 0` at every Weyl
`y ⊥ a`. -/
theorem innerOp2_Qop2_eq_zero_weyl {a : CurvOp2 ι} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hmax : IsLocalMaxOn Pcubic2 (weylSphereSet ι) a)
    {y : CurvOp2 ι} (hWy : IsWeyl2 y) (hy : innerOp2 a y = 0) :
    innerOp2 y (Qop2 a) = 0 := by
  have hd : HasFDerivWithinAt Pcubic2 (PcubicDiffS a) (weylSphereSet ι) a :=
    (hasFDerivAt_Pcubic2 hWa.isSelfAdjoint2).hasFDerivWithinAt
  have hneg : (-y : CurvOp2 ι) = (-1 : ℝ) • y := by module
  have hyneg : innerOp2 a (-y) = 0 := by
    rw [hneg, innerOp2_smul_right, hy, mul_zero]
  have hWyneg : IsWeyl2 (-y) := by rw [hneg]; exact isWeyl2_smul _ hWy
  have hcurve : ∀ z : CurvOp2 ι, IsWeyl2 z → innerOp2 a z = 0 → ∀ t,
      sphereCurve a z t ∈ weylSphereSet ι := fun z hWz hz t =>
    ⟨sphereCurve_mem ha hz t, isWeyl2_smul _ (isWeyl2_add hWa (isWeyl2_smul t hWz))⟩
  have h1 := hmax.hasFDerivWithinAt_nonpos hd
    (mem_posTangentConeAt_of_curve (hcurve y hWy hy))
  have h2 := hmax.hasFDerivWithinAt_nonpos hd
    (mem_posTangentConeAt_of_curve (hcurve (-y) hWyneg hyneg))
  have h1' : 3 * innerOp2 y (Qop2 a) ≤ 0 := h1
  have h2' : 3 * innerOp2 (-y) (Qop2 a) ≤ 0 := h2
  have hlin : innerOp2 (-y) (Qop2 a) = -innerOp2 y (Qop2 a) := by
    rw [hneg, innerOp2_smul_left]; ring
  rw [hlin] at h2'
  linarith

/-- `Q` preserves the Weyl operators, `Q(a) = a ∘ a`. -/
theorem isWeyl2_Qop2 {a : CurvOp2 ι} (hWa : IsWeyl2 a) : IsWeyl2 (Qop2 a) := by
  rw [← foxProd2_self]; exact isWeyl2_foxProd2 hWa hWa

/-- **CRITICALITY ON THE UNIT WEYL SPHERE**: a local maximiser has `Q(a) = P(a)·a`. -/
theorem Qop2_eq_smul_weyl {a : CurvOp2 ι} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hmax : IsLocalMaxOn Pcubic2 (weylSphereSet ι) a) :
    Qop2 a = Pcubic2 a • a := by
  set lam : ℝ := innerOp2 a (Qop2 a) with hlam
  set z : CurvOp2 ι := Qop2 a - lam • a with hz
  have haa : innerOp2 a a = 1 := ha
  have hza : innerOp2 z a = 0 := by
    rw [hz, innerOp2_sub_left, innerOp2_smul_left, innerOp2_comm (Qop2 a) a, ← hlam, haa]
    ring
  have haz : innerOp2 a z = 0 := by rw [innerOp2_comm]; exact hza
  have hzW : IsWeyl2 z := by
    have e : z = Qop2 a + (-lam) • a := by rw [hz]; module
    rw [e]; exact isWeyl2_add (isWeyl2_Qop2 hWa) (isWeyl2_smul _ hWa)
  have hzq : innerOp2 z (Qop2 a) = 0 := innerOp2_Qop2_eq_zero_weyl ha hWa hmax hzW haz
  have hzz : normSq2 z = 0 := by
    show innerOp2 z z = 0
    nth_rewrite 1 [hz]
    rw [innerOp2_sub_left, innerOp2_smul_left, innerOp2_comm (Qop2 a) z, hzq, haz]
    ring
  have hz0 : z = 0 := normSq2_eq_zero hzz
  rw [hz] at hz0
  rw [Pcubic2_eq_innerOp2, ← hlam]
  exact sub_eq_zero.mp hz0


/-- `‖x‖² = normSq2 x` on `weylR`. -/
theorem weylR_norm_sq {ι : Type*} [Fintype ι] [DecidableEq ι] (x : weylR ι) :
    ‖x‖ ^ 2 = normSq2 (cv x) := by
  have h : ‖x‖ = ‖(x : RecCurv ι)‖ := (Submodule.coe_norm x).symm
  rw [h]
  exact RecCurv.norm_sq_eq (x : RecCurv ι)

/-- **The record's unit Weyl sphere is the norm sphere of `weylR`.** -/
theorem weylSphere_eq_sphere {ι : Type*} [Fintype ι] [DecidableEq ι] :
    weylSphere ι = Metric.sphere (0 : weylR ι) 1 := by
  ext x
  rw [mem_sphere_zero_iff_norm]
  show normSq2 (cv x) = 1 ↔ ‖x‖ = 1
  rw [← weylR_norm_sq]
  constructor
  · intro h1
    have h0 : 0 ≤ ‖x‖ := _root_.norm_nonneg _
    nlinarith
  · intro h1; rw [h1]; norm_num

/-- **`P` is continuous on `weylR`**, a cubic in the coordinates of a basis. -/
theorem continuous_Pcubic2_cv : Continuous (fun x : weylR ι => Pcubic2 (cv x)) := by
  let b := Module.finBasis ℝ (weylR ι)
  have hc : Continuous (fun x : weylR ι => b.equivFun x) :=
    LinearMap.continuous_of_finiteDimensional b.equivFun.toLinearMap
  have hci : ∀ i, Continuous (fun x : weylR ι => b.equivFun x i) := fun i =>
    (continuous_apply i).comp hc
  have e : (fun x : weylR ι => Pcubic2 (cv x)) = fun x =>
      ∑ k, ∑ j, ∑ i, b.equivFun x k * (b.equivFun x j * (b.equivFun x i * foxT (b i) (b j) (b k))) := by
    funext x
    rw [← Pf_foxT]
    unfold Pf
    conv_lhs => rw [← b.sum_equivFun x]
    simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul,
      Finset.mul_sum]
  rw [e]
  fun_prop

variable {n : ℕ}

/-- **A MAXIMISER OF `P` ON THE UNIT WEYL SPHERE EXISTS** at every `n ≥ 4`, with `P ≥ √(3/2)`. -/
theorem exists_weyl_maximiser (hn : 4 ≤ n) :
    ∃ a : CurvOp2 (Fin n), a ∈ weylSphereSet (Fin n) ∧ IsMaxOn Pcubic2 (weylSphereSet (Fin n)) a ∧
      Real.sqrt (3 / 2) ≤ Pcubic2 a := by
  have : ProperSpace (weylR (Fin n)) := FiniteDimensional.proper_real _
  have hK : IsCompact (weylSphere (Fin n)) := by
    rw [weylSphere_eq_sphere]; exact isCompact_sphere 0 1
  have hcont := (continuous_Pcubic2_cv (ι := Fin n)).continuousOn (s := weylSphere (Fin n))
  -- nonempty, from `Wc n`
  set B : weylR (Fin n) := ⟨show RecCurv (Fin n) from restrict (Wc_weyl hn), isWeyl2_restrict _⟩
  have hB1 : normSq2 (cv B) = 1 := by
    show normSq2 (restrict (Wc_weyl hn)) = 1
    rw [normSq2_restrict_Wc hn]; exact (Wc_values hn).1
  have hBP : Pcubic2 (cv B) = Real.sqrt (3 / 2) := by
    show Pcubic2 (restrict (Wc_weyl hn)) = _
    rw [Pcubic2_restrict_Wc hn, Pcubic_Wc hn]
  obtain ⟨x, hx, hxmax⟩ := hK.exists_isMaxOn ⟨B, hB1⟩ hcont
  refine ⟨cv x, ⟨hx, cv_weyl x⟩, fun R hR => ?_, ?_⟩
  · have hRW : RecCurv.equiv R ∈ weylR (Fin n) := hR.2
    have hy : (⟨RecCurv.equiv R, hRW⟩ : weylR (Fin n)) ∈ weylSphere (Fin n) := hR.1
    have h : Pcubic2 (cv ⟨RecCurv.equiv R, hRW⟩) ≤ Pcubic2 (cv x) := hxmax hy
    exact h
  · exact hBP ▸ hxmax (show B ∈ weylSphere (Fin n) from hB1)

/-- **L24 IS NOT VACUOUS**: at every `n ≥ 4` a unit Weyl `a` maximising `P` on the unit Weyl sphere
exists, is critical with `Q(a) = P(a)·a`, has `P(a) ≥ √(3/2) > 0`, and satisfies L24's bound
`⟪a, Q(v)⟫ ≤ P(a)/2` at every unit Weyl `v ⊥ a`. -/
theorem L24_nonvacuous (hn : 4 ≤ n) :
    ∃ a : CurvOp2 (Fin n), normSq2 a = 1 ∧ IsWeyl2 a ∧
      IsMaxOn Pcubic2 (weylSphereSet (Fin n)) a ∧ Qop2 a = Pcubic2 a • a ∧
      Real.sqrt (3 / 2) ≤ Pcubic2 a ∧
      ∀ v : CurvOp2 (Fin n), IsWeyl2 v → innerOp2 a v = 0 → normSq2 v = 1 →
        innerOp2 a (Qop2 v) ≤ Pcubic2 a / 2 := by
  obtain ⟨a, ⟨ha, hWa⟩, hmax, hP⟩ := exists_weyl_maximiser hn
  have hloc : IsLocalMaxOn Pcubic2 (weylSphereSet (Fin n)) a := hmax.localize
  have hcrit := Qop2_eq_smul_weyl ha hWa hloc
  have hθ : 0 < Pcubic2 a := lt_of_lt_of_le (by positivity) hP
  exact ⟨a, ha, hWa, hmax, hcrit, hP, fun v hWv hv hv1 =>
    L24_weyl ha hWa hcrit hloc hθ hWv hv hv1⟩

/-- **L0's REDUCTION, TYPED**: at every `n ≥ 4`, `P ≤ Θ` on the unit Weyl sphere iff `P ≤ Θ` at every
unit Weyl `R` critical in the record's sense, `Q(R) = P(R)·R`. The `⇐` direction is the maximiser of
`exists_weyl_maximiser`, critical by `Qop2_eq_smul_weyl`. -/
theorem L0_critical_reduction (hn : 4 ≤ n) (Θ : ℝ) :
    (∀ R ∈ weylSphereSet (Fin n), Pcubic2 R ≤ Θ) ↔
      (∀ R ∈ weylSphereSet (Fin n), Qop2 R = Pcubic2 R • R → Pcubic2 R ≤ Θ) := by
  constructor
  · exact fun h R hR _ => h R hR
  · intro h R hR
    obtain ⟨a, ⟨ha, hWa⟩, hmax, _⟩ := exists_weyl_maximiser hn
    have hcrit := Qop2_eq_smul_weyl ha hWa hmax.localize
    exact le_trans (hmax hR) (h a ⟨ha, hWa⟩ hcrit)

end HamiltonsCubic.RealLayer
