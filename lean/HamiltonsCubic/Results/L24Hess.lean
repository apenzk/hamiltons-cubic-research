import HamiltonsCubic.Results.L24Sharp

set_option linter.style.longLine false

/-!
# L24's Riemannian Hessian, `Hess(P|_S)_a = 6θ(L_e − ½ Id)`, as a quadratic form along great circles

[findings/second-order.md](../../../findings/second-order.md), Lemma L24, and
[findings/route-a.md](../../../findings/route-a.md), Lemma L134(a): at a critical point the Hessian of `P`
restricted to the unit sphere is `6θ(L_e − ½ Id)` on `a^⊥`. [L24Weyl.lean](L24Weyl.lean) has the expansion
along the straight line `a + sv`. **This file has it along the sphere's geodesics**:

- `Pcubic2_circle`: `P(c a + s v) = c³P(a) + 3cs²⟨a, Q(v)⟩ + s³P(v)` when `⟨v, Q(a)⟩ = 0`;
- `circle_deriv2`: the second derivative at `0` of `cos³t·A + 3 cos t sin²t·B + sin³t·C` is `−3A + 6B`;
- **`L24_hessian`**: `(d²/dt²) P(cos t·a + sin t·v)|₀ = 6(⟨a, Q(v)⟩ − ½P(a))` at a critical Weyl `a` and a
  Weyl `v ⊥ a`;
- **`L24_hessian_Le`**: the same as `3θ(⟨L_e v, v⟩ − ½)` after halving, with `θ = P(a) ≠ 0`, which is L134(a)'s
  first equality.
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.TensorBridge

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`P` along a great circle through a critical point**: for `⟨v, Q(a)⟩ = 0`,
`P(c a + s v) = c³P(a) + 3 c s² ⟨a, Q(v)⟩ + s³ P(v)`. -/
theorem Pcubic2_circle {a v : CurvOp2 ι} (ha : IsSelfAdjoint2 a) (hv : IsSelfAdjoint2 v)
    (hQ : innerOp2 v (Qop2 a) = 0) (c s : ℝ) :
    Pcubic2 (c • a + s • v) = c ^ 3 * Pcubic2 a + 3 * c * s ^ 2 * innerOp2 a (Qop2 v) + s ^ 3 * Pcubic2 v := by
  by_cases hc : c = 0
  · subst hc
    rw [show (0 : ℝ) • a + s • v = s • v by ext X; simp, Pcubic2_smul]; ring
  · have e : c • a + s • v = c • (a + (s / c) • v) := by
      ext X; simp [smul_smul, mul_div_cancel₀ s hc]
    rw [e, Pcubic2_smul, Pcubic2_line ha hv hQ]
    field_simp

/-- The first derivative of the great-circle cubic. -/
theorem circle_hasDerivAt (A B C t : ℝ) :
    HasDerivAt (fun t => Real.cos t ^ 3 * A + 3 * Real.cos t * Real.sin t ^ 2 * B + Real.sin t ^ 3 * C)
      (-3 * Real.cos t ^ 2 * Real.sin t * A
        + 3 * (-Real.sin t * Real.sin t ^ 2 + Real.cos t * (2 * Real.sin t * Real.cos t)) * B
        + 3 * Real.sin t ^ 2 * Real.cos t * C) t := by
  have hc := Real.hasDerivAt_cos t
  have hs := Real.hasDerivAt_sin t
  have h := (((hc.pow 3).mul_const A).add ((((hc.const_mul 3).mul (hs.pow 2))).mul_const B)).add
    ((hs.pow 3).mul_const C)
  refine h.congr_deriv ?_
  simp only [Pi.pow_apply, show (3 : ℕ) - 1 = 2 from rfl, show (2 : ℕ) - 1 = 1 from rfl, pow_one]
  push_cast
  ring

/-- The second derivative at `0`: `f''(0) = −3A + 6B`. -/
theorem circle_deriv2 (A B C : ℝ) :
    deriv (deriv (fun t => Real.cos t ^ 3 * A + 3 * Real.cos t * Real.sin t ^ 2 * B
      + Real.sin t ^ 3 * C)) 0 = -3 * A + 6 * B := by
  have hd : deriv (fun t => Real.cos t ^ 3 * A + 3 * Real.cos t * Real.sin t ^ 2 * B
      + Real.sin t ^ 3 * C) = fun t => -3 * Real.cos t ^ 2 * Real.sin t * A
        + 3 * (-Real.sin t * Real.sin t ^ 2 + Real.cos t * (2 * Real.sin t * Real.cos t)) * B
        + 3 * Real.sin t ^ 2 * Real.cos t * C :=
    funext fun t => (circle_hasDerivAt A B C t).deriv
  rw [hd]
  have hc := Real.hasDerivAt_cos 0
  have hs := Real.hasDerivAt_sin 0
  have h := ((((hc.pow 2).const_mul (-3)).mul hs).mul_const A).add
    (((((hs.neg).mul (hs.pow 2)).add (hc.mul ((hs.const_mul 2).mul hc))).const_mul 3).mul_const B) |>.add
    ((((hs.pow 2).const_mul 3).mul hc).mul_const C)
  have h' : HasDerivAt (fun t => -3 * Real.cos t ^ 2 * Real.sin t * A
        + 3 * (-Real.sin t * Real.sin t ^ 2 + Real.cos t * (2 * Real.sin t * Real.cos t)) * B
        + 3 * Real.sin t ^ 2 * Real.cos t * C) (-3 * A + 6 * B) 0 := by
    refine h.congr_deriv ?_
    simp only [Pi.pow_apply, Real.sin_zero, Real.cos_zero]
    norm_num
  exact h'.deriv

/-- **L24's RIEMANNIAN HESSIAN, along every great circle**: at a critical Weyl `a` (`Q(a) = λa`) and a
Weyl `v ⊥ a`, the second derivative at `0` of `t ↦ P(cos t · a + sin t · v)` is `6(⟨a, Q(v)⟩ − ½ P(a))`. -/
theorem L24_hessian {a v : CurvOp2 ι} {lam : ℝ} (hWa : IsWeyl2 a) (hWv : IsWeyl2 v)
    (hcrit : Qop2 a = lam • a) (hperp : innerOp2 a v = 0) :
    deriv (deriv (fun t => Pcubic2 (Real.cos t • a + Real.sin t • v))) 0
      = 6 * (innerOp2 a (Qop2 v) - (1 / 2) * Pcubic2 a) := by
  have hQ : innerOp2 v (Qop2 a) = 0 := by rw [hcrit, innerOp2_smul_right, innerOp2_comm, hperp, mul_zero]
  have hf : (fun t => Pcubic2 (Real.cos t • a + Real.sin t • v)) = fun t => Real.cos t ^ 3 * Pcubic2 a
      + 3 * Real.cos t * Real.sin t ^ 2 * innerOp2 a (Qop2 v) + Real.sin t ^ 3 * Pcubic2 v :=
    funext fun t => Pcubic2_circle hWa.isSelfAdjoint2 hWv.isSelfAdjoint2 hQ _ _
  rw [hf, circle_deriv2]; ring

/-- **`Hess(P|_S)_a = 6θ(L_e − ½ Id)` as a quadratic form**: at a critical Weyl `a` with `θ = P(a) ≠ 0` and a
Weyl `v ⊥ a`, `½ (d²/dt²) P(cos t · a + sin t · v)|₀ = 3θ(⟨L_e v, v⟩ − ½)`. At unit `a` and `v` the curve is the
unit sphere's geodesic in direction `v` and `θ = P(a)` is the record's, so this is L24's Hessian and L134(a)'s first
equality; the identity itself needs neither norm. -/
theorem L24_hessian_Le {a v : CurvOp2 ι} {lam : ℝ} (hWa : IsWeyl2 a) (hWv : IsWeyl2 v)
    (hcrit : Qop2 a = lam • a) (hperp : innerOp2 a v = 0) (hθ : Pcubic2 a ≠ 0) :
    (1 / 2) * deriv (deriv (fun t => Pcubic2 (Real.cos t • a + Real.sin t • v))) 0
      = 3 * Pcubic2 a * (innerOp2 (LeLin a v) v - 1 / 2) := by
  rw [L24_hessian hWa hWv hcrit hperp]
  have hLe : innerOp2 (LeLin a v) v = (Pcubic2 a)⁻¹ * innerOp2 a (Qop2 v) := by
    show innerOp2 (foxProd2 ((Pcubic2 a)⁻¹ • a) v) v = _
    rw [foxProd2_smul_left, innerOp2_smul_left, innerOp2_foxProd2_self hWa.isSelfAdjoint2 hWv.isSelfAdjoint2]
  rw [hLe]
  field_simp
  ring

end HamiltonsCubic.RealLayer
