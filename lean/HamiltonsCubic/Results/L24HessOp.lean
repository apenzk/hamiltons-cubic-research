import HamiltonsCubic.Results.L24Hess
import HamiltonsCubic.Results.L24Restrict

set_option linter.style.longLine false

/-!
# L24's Riemannian Hessian as an operator on `T_aS`: `Hess(P|_S)_a = 6θ(L_e − ½ Id)`

[findings/second-order.md](../../../findings/second-order.md), Lemma L24. On the round unit sphere the geodesic
through `a` with unit velocity `u ⊥ a` is `t ↦ cos t · a + sin t · u`, and the Riemannian Hessian of a function `f`
at `a` has quadratic form `Hess f(v, v) = ‖v‖² (f ∘ γ_{v/‖v‖})''(0)`, which is what `hessQ` is. A symmetric bilinear
form is its quadratic form polarised, so this pins the Hessian as a bilinear form on `T_aS`.

- `hessQ_eq`: at a critical Weyl `a` and a Weyl `v ⊥ a`, `hessQ a v = 6(⟨a, Q(v)⟩ − ½ P(a) ‖v‖²)`;
- `hessOp`: the operator `6θ(L_e − ½ Id)` on `W^⊥` (`weylPerpR a`, the tangent space of the unit Weyl sphere at `a`);
- **`hessQ_op`** and **`hessB_op`**: the quadratic form and its polarisation are those of `hessOp`, which is L24's
  `Hess(P|_S)_a = 6θ(L_e − ½ Id)` as an operator.
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.TensorBridge

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The Riemannian Hessian's quadratic form on the round sphere**: `‖v‖²` times the second derivative at `0` of
`f` along the unit-speed great circle through `a` in direction `v/‖v‖`. -/
noncomputable def hessQ (a v : CurvOp2 ι) : ℝ :=
  innerOp2 v v * deriv (deriv (fun t => Pcubic2 (Real.cos t • a + Real.sin t • ((Real.sqrt (innerOp2 v v))⁻¹ • v)))) 0

theorem innerOp2_Qop2_zero (a : CurvOp2 ι) : innerOp2 a (Qop2 0) = 0 := by
  have e : (2 : ℝ) • (0 : CurvOp2 ι) = 0 := by ext; simp
  have hq := Qop2_smul 2 (0 : CurvOp2 ι)
  rw [e] at hq
  have h := congrArg (innerOp2 a) hq
  rw [innerOp2_smul_right] at h
  linarith

theorem innerOp2_sub_left' (A B C : CurvOp2 ι) : innerOp2 (A - B) C = innerOp2 A C - innerOp2 B C := by
  have h := innerOp2_add_left (A - B) B C
  have e : A - B + B = A := by ext; simp
  rw [e] at h
  linarith

/-- A tangent vector as an operator. -/
def tanV {a : CurvOp2 ι} (v : weylPerpR a) : CurvOp2 ι := ((v : RecCurv ι) : CurvOp2 ι)

theorem tanV_add {a : CurvOp2 ι} (v w : weylPerpR a) : tanV (v + w) = tanV v + tanV w := rfl

/-- **The Hessian quadratic form at a critical point**: `hessQ a v = 6(⟨a, Q(v)⟩ − ½ P(a) ‖v‖²)`. -/
theorem hessQ_eq {a v : CurvOp2 ι} {lam : ℝ} (hWa : IsWeyl2 a) (hWv : IsWeyl2 v)
    (hcrit : Qop2 a = lam • a) (hperp : innerOp2 a v = 0) :
    hessQ a v = 6 * (innerOp2 a (Qop2 v) - (1 / 2) * Pcubic2 a * innerOp2 v v) := by
  by_cases h0 : innerOp2 v v = 0
  · have hv : v = 0 := normSq2_eq_zero h0
    subst hv
    simp [hessQ, h0, innerOp2_Qop2_zero]
  · have hpos : 0 < innerOp2 v v := lt_of_le_of_ne (innerOp2_self_nonneg v) (Ne.symm h0)
    set r := Real.sqrt (innerOp2 v v) with hr
    have hr0 : 0 < r := Real.sqrt_pos.mpr hpos
    have hr2 : r ^ 2 = innerOp2 v v := Real.sq_sqrt hpos.le
    have hperp' : innerOp2 a (r⁻¹ • v) = 0 := by rw [innerOp2_smul_right, hperp, mul_zero]
    have h := L24_hessian hWa (isWeyl2_smul r⁻¹ hWv) hcrit hperp'
    unfold hessQ
    rw [← hr, h, Qop2_smul, innerOp2_smul_right, ← hr2]
    field_simp

/-- **`Hess(P|_S)_a = 6θ(L_e − ½ Id)`**, as an endomorphism of `W^⊥`. -/
noncomputable def hessOp {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) : Module.End ℝ (weylPerpR a) :=
  (6 * Pcubic2 a) • (LeRestr ha hWa hcrit hθ - (1 / 2 : ℝ) • LinearMap.id)

theorem hessOp_apply {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (v : weylPerpR a) :
    tanV (hessOp ha hWa hcrit hθ v) = (6 * Pcubic2 a) • (LeLin a (tanV v) - (1 / 2 : ℝ) • tanV v) := rfl

/-- **THE HESSIAN'S QUADRATIC FORM IS `hessOp`'s**: `hessQ a v = ⟨6θ(L_e − ½)v, v⟩` for every `v ∈ W^⊥`. -/
theorem hessQ_op {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (v : weylPerpR a) :
    hessQ a (tanV v) = innerOp2 (tanV (hessOp ha hWa hcrit hθ v)) (tanV v) := by
  have hv : IsWeyl2 (tanV v) := v.2.1
  rw [hessQ_eq hWa hv hcrit v.2.2, hessOp_apply]
  have hLe : innerOp2 (LeLin a (tanV v)) (tanV v) = (Pcubic2 a)⁻¹ * innerOp2 a (Qop2 (tanV v)) := by
    show innerOp2 (foxProd2 ((Pcubic2 a)⁻¹ • a) _) _ = _
    rw [foxProd2_smul_left, innerOp2_smul_left, innerOp2_foxProd2_self hWa.isSelfAdjoint2 hv.isSelfAdjoint2]
  rw [innerOp2_smul_left, innerOp2_sub_left', innerOp2_smul_left, hLe]
  field_simp
  try ring

/-- **THE HESSIAN AS A BILINEAR FORM IS `hessOp`'s**: the polarisation of `hessQ` is `⟨6θ(L_e − ½)v, w⟩`. -/
theorem hessB_op {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (v w : weylPerpR a) :
    (hessQ a (tanV (v + w)) - hessQ a (tanV v) - hessQ a (tanV w)) / 2
      = innerOp2 (tanV (hessOp ha hWa hcrit hθ v)) (tanV w) := by
  rw [hessQ_op ha hWa hcrit hθ, hessQ_op ha hWa hcrit hθ, hessQ_op ha hWa hcrit hθ, map_add, tanV_add, tanV_add]
  have hS : innerOp2 (LeLin a (tanV v)) (tanV w) = innerOp2 (tanV v) (LeLin a (tanV w)) :=
    LeRestr_isSymmetric ha hWa hcrit hθ v w
  have hsym : innerOp2 (tanV (hessOp ha hWa hcrit hθ w)) (tanV v)
      = innerOp2 (tanV (hessOp ha hWa hcrit hθ v)) (tanV w) := by
    rw [hessOp_apply, hessOp_apply, innerOp2_smul_left, innerOp2_smul_left, innerOp2_sub_left',
      innerOp2_sub_left', innerOp2_smul_left, innerOp2_smul_left, innerOp2_comm (tanV w) (tanV v),
      innerOp2_comm (LeLin a (tanV w)) (tanV v), hS]
  rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, hsym]
  ring

end HamiltonsCubic.RealLayer
