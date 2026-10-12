import HamiltonsCubic.Results.L126Kernel

set_option linter.style.longLine false

/-!
# L125 on the operator: `⟨L_e Y, Y⟩ ≤ ½‖Y‖² + ½⟨W, Y⟩²` at a maximiser

[findings/second-order.md](../../../findings/second-order.md), Lemma L125. [L125.lean](L125.lean) proves the
collapse to L24 as scalar algebra. **This file proves the display itself** at a unit Weyl maximiser:

- `L24_perp`: `⟨a, Q(Z)⟩ ≤ (P(a)/2)‖Z‖²` for every Weyl `Z ⊥ a`, L24 at any norm;
- **`L125_weyl`**: `⟨L_e Y, Y⟩ ≤ ½‖Y‖² + ½⟨a, Y⟩²` for every Weyl `Y`, by `Y = ⟨a, Y⟩a + Z`, the cross term
  vanishing through `Q(a) = λa`;
- `L125_fourSet`: the four-set application as a scalar step, `Σ ≤ θ²(1 + c²)²` once the block's top Rayleigh
  value is `√Σ/(2θ)`, which is L121's identification and enters as a hypothesis.
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.TensorBridge

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **L24's Rayleigh bound on `W^⊥`, at any norm**: `⟨a, Q(Z)⟩ ≤ (P(a)/2)‖Z‖²` for every Weyl `Z ⊥ a`. -/
theorem L24_perp {a Z : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a) (hWZ : IsWeyl2 Z) (hZ : innerOp2 a Z = 0) :
    innerOp2 a (Qop2 Z) ≤ Pcubic2 a / 2 * normSq2 Z := by
  by_cases h0 : Z = 0
  · subst h0
    have h00 : ∀ X : CurvOp2 ι, (0 : ℝ) • X = 0 := fun X => ContinuousLinearMap.ext fun Y => by simp
    have hq : Qop2 (0 : CurvOp2 ι) = 0 := by
      have := Qop2_smul 0 (0 : CurvOp2 ι); rw [h00, zero_pow two_ne_zero, h00] at this; exact this
    have hn : normSq2 (0 : CurvOp2 ι) = 0 := by
      have := innerOp2_smul_left 0 (0 : CurvOp2 ι) 0; rw [h00, zero_mul] at this; exact this
    rw [hq, hn]
    have := innerOp2_smul_right 0 a (0 : CurvOp2 ι); rw [h00, zero_mul] at this
    rw [this]; linarith
  · set s := normSq2 Z
    have hs : 0 < s := lt_of_le_of_ne (normSq2_nonneg Z) (fun h => h0 (normSq2_eq_zero h.symm))
    set r := Real.sqrt s
    have hr : 0 < r := Real.sqrt_pos.mpr hs
    have hrr : r * r = s := Real.mul_self_sqrt hs.le
    have hv1 : normSq2 (r⁻¹ • Z) = 1 := by
      show innerOp2 (r⁻¹ • Z) (r⁻¹ • Z) = 1
      rw [innerOp2_smul_left, innerOp2_smul_right]
      show r⁻¹ * (r⁻¹ * s) = 1
      field_simp; linarith
    have hv : innerOp2 a (r⁻¹ • Z) = 0 := by rw [innerOp2_smul_right, hZ, mul_zero]
    have h := L24_weyl ha hWa hcrit hmax hθ (isWeyl2_smul _ hWZ) hv hv1
    rw [Qop2_smul, innerOp2_smul_right] at h
    have hq : innerOp2 a (Qop2 Z) = r ^ 2 * ((r⁻¹) ^ 2 * innerOp2 a (Qop2 Z)) := by
      field_simp
    rw [hq, ← hrr]
    nlinarith [sq_nonneg r]

/-- **L125 ON THE OPERATOR**: at a unit Weyl maximiser `a` with `P(a) > 0`, for every Weyl `Y`,
`⟨L_e Y, Y⟩ ≤ ½‖Y‖² + ½⟨a, Y⟩²`. -/
theorem L125_weyl {a Y : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a) (hWY : IsWeyl2 Y) :
    innerOp2 (LeLin a Y) Y ≤ (1 / 2) * normSq2 Y + (1 / 2) * innerOp2 a Y ^ 2 := by
  have hlam : Pcubic2 a = lam := by
    rw [Pcubic2_eq_innerOp2, hcrit, innerOp2_smul_right, ← normSq2, ha, mul_one]
  set c := innerOp2 a Y
  set Z := Y + (-c) • a
  have hY : Y = Z + c • a := by
    ext X; simp [Z]
  have hWZ : IsWeyl2 Z := isWeyl2_add hWY (isWeyl2_smul _ hWa)
  have haa : innerOp2 a a = 1 := ha
  have hZ : innerOp2 a Z = 0 := by
    rw [innerOp2_add_right, innerOp2_smul_right, haa]; ring
  have hZa : innerOp2 Z a = 0 := by rw [innerOp2_comm, hZ]
  have hkey := L24_perp ha hWa hcrit hmax hθ hWZ hZ
  have hcY : innerOp2 a Y = c := rfl
  clear_value Z c
  -- the left side
  have hL : innerOp2 (LeLin a Y) Y = (Pcubic2 a)⁻¹ * innerOp2 a (Qop2 Y) := by
    show innerOp2 (foxProd2 ((Pcubic2 a)⁻¹ • a) Y) Y = _
    rw [foxProd2_smul_left, innerOp2_smul_left, innerOp2_foxProd2_self hWa.isSelfAdjoint2 hWY.isSelfAdjoint2]
  have hcross : innerOp2 a (foxProd2 Z a) = 0 := by
    rw [foxProd2_comm, innerOp2_comm]
    change foxTri2 a Z a = 0
    rw [foxTri2_symm_right a Z a hWZ.isSelfAdjoint2 hWa.isSelfAdjoint2]
    show innerOp2 (foxProd2 a a) Z = 0
    rw [foxProd2_self, hcrit, innerOp2_smul_left, hZ, mul_zero]
  have hQa : innerOp2 a (Qop2 a) = Pcubic2 a := by
    rw [hcrit, innerOp2_smul_right, haa, mul_one, hlam]
  have hQY : innerOp2 a (Qop2 Y) = innerOp2 a (Qop2 Z) + c ^ 2 * Pcubic2 a := by
    rw [hY, Qop2_line, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_right, innerOp2_smul_right,
      hcross, hQa]; ring
  have hN : normSq2 Y = normSq2 Z + c ^ 2 := by
    show innerOp2 Y Y = innerOp2 Z Z + c ^ 2
    rw [hY, innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
      innerOp2_smul_right, innerOp2_smul_right, hZa, hZ, haa]; ring
  rw [hL, hQY, hN]
  have hP := hθ
  have h1 : (Pcubic2 a)⁻¹ * innerOp2 a (Qop2 Z) ≤ (1 / 2) * normSq2 Z := by
    rw [inv_mul_le_iff₀ hP]; linarith
  have h2 : (Pcubic2 a)⁻¹ * (innerOp2 a (Qop2 Z) + c ^ 2 * Pcubic2 a)
      = (Pcubic2 a)⁻¹ * innerOp2 a (Qop2 Z) + c ^ 2 := by
    field_simp
  rw [h2]; nlinarith [sq_nonneg c]

/-- **The four-set application, as the scalar step**: if the block's top Rayleigh value `⟨L_e X̂, X̂⟩` at a unit
Weyl `X̂` is `√Σ/(2θ)` (L121's identification, a hypothesis here), then `√Σ ≤ θ(1 + c²)`, `c = ⟨a, X̂⟩`, hence
`Σ ≤ θ²(1 + c²)²`, DERIVE-mx1's projection-corrected bound. -/
theorem L125_fourSet {a X : CurvOp2 ι} {lam σ : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a) (hWX : IsWeyl2 X) (hX : normSq2 X = 1) (hσ : 0 ≤ σ)
    (hblock : innerOp2 (LeLin a X) X = σ / (2 * Pcubic2 a)) :
    σ ^ 2 ≤ Pcubic2 a ^ 2 * (1 + innerOp2 a X ^ 2) ^ 2 := by
  have h := L125_weyl ha hWa hcrit hmax hθ hWX
  rw [hblock, hX] at h
  have hs : σ ≤ Pcubic2 a * (1 + innerOp2 a X ^ 2) := by
    rw [div_le_iff₀ (by positivity)] at h; nlinarith
  have := mul_self_le_mul_self hσ hs
  nlinarith

end HamiltonsCubic.RealLayer
