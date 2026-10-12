import HamiltonsCubic.Results.L24Hess

set_option linter.style.longLine false

/-!
# L126's kernel claim: `DF(M) = θ(2L_e − Id)` on the tangent space

[findings/second-order.md](../../../findings/second-order.md), Lemma L126: *"On the tangent space the criticality
map `F(W) = Q(W) − P(W)W` has `DF(M) = θ(2L_e − Id)`, so `ker DF(M)` is the `½`-eigenspace of `L_e`."* **This
file proves it** on `CurvOp2`:

- `Qop2_line`: `Q(M + sH) = Q(M) + 2s M∘H + s²Q(H)`, from bilinearity of `∘` and `v∘v = Q(v)`;
- `critMap_line`: `F(M + sH)` as a quartic in `s` when `⟨H, Q(M)⟩ = 0`, through `Pcubic2_line`;
- **`critMap_hasDerivAt`**: at `Q(M) = λM` and a self-adjoint `H ⊥ M`, the derivative of `F` along `M + sH` at
  `0` is `2 M∘H − P(M) H`, read against every test operator `Z`, `CurvOp2` carrying no norm;
- **`critMap_kernel_iff`**: `2 M∘H − θH = 0` iff `L_e H = ½ H`, at `θ = P(M) ≠ 0`.
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.TensorBridge

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The criticality map `F(W) = Q(W) − P(W) W`. -/
noncomputable def critMap (W : CurvOp2 ι) : CurvOp2 ι := Qop2 W - Pcubic2 W • W

/-- `Q` along a line: `Q(M + sH) = Q(M) + 2s M∘H + s² Q(H)`. -/
theorem Qop2_line (M H : CurvOp2 ι) (s : ℝ) :
    Qop2 (M + s • H) = Qop2 M + (2 * s) • foxProd2 M H + s ^ 2 • Qop2 H := by
  have addL : ∀ X Y Z : CurvOp2 ι, foxProd2 (X + Y) Z = foxProd2 X Z + foxProd2 Y Z := fun X Y Z => by
    rw [foxProd2_comm, foxProd2_add_right, foxProd2_comm Z X, foxProd2_comm Z Y]
  rw [← foxProd2_self]
  simp only [foxProd2_add_right, addL, foxProd2_smul_right, foxProd2_smul_left, smul_smul]
  rw [foxProd2_comm H M, foxProd2_self, foxProd2_self]
  module

/-- `F` along a line through a critical point, as a polynomial in `s`. -/
theorem critMap_line {M H : CurvOp2 ι} (hM : IsSelfAdjoint2 M) (hH : IsSelfAdjoint2 H)
    (hQ : innerOp2 H (Qop2 M) = 0) (s : ℝ) :
    critMap (M + s • H) = (Qop2 M - Pcubic2 M • M) + s • ((2 : ℝ) • foxProd2 M H - Pcubic2 M • H)
      + s ^ 2 • (Qop2 H - (3 * innerOp2 M (Qop2 H)) • M)
      + s ^ 3 • (-(3 * innerOp2 M (Qop2 H)) • H - Pcubic2 H • M) + s ^ 4 • (-(Pcubic2 H) • H) := by
  unfold critMap
  rw [Qop2_line, Pcubic2_line hM hH hQ]
  module

/-- **`DF(M) = θ(2L_e − Id)` on the tangent space**, as the derivative of `F` along the line `M + sH`, read
against every test operator `Z` (`CurvOp2` carries no norm, and in finite dimension the weak derivative is the
derivative): at `M` with `Q(M) = λM` and a self-adjoint `H` with `⟨H, M⟩ = 0`, it is `2 M∘H − P(M) H`. -/
theorem critMap_hasDerivAt {M H : CurvOp2 ι} {lam : ℝ} (hM : IsSelfAdjoint2 M) (hH : IsSelfAdjoint2 H)
    (hcrit : Qop2 M = lam • M) (hperp : innerOp2 M H = 0) (Z : CurvOp2 ι) :
    HasDerivAt (fun s : ℝ => innerOp2 Z (critMap (M + s • H)))
      (innerOp2 Z ((2 : ℝ) • foxProd2 M H - Pcubic2 M • H)) 0 := by
  have hQ : innerOp2 H (Qop2 M) = 0 := by rw [hcrit, innerOp2_smul_right, innerOp2_comm, hperp, mul_zero]
  set A0 := innerOp2 Z (Qop2 M - Pcubic2 M • M)
  set A1 := innerOp2 Z ((2 : ℝ) • foxProd2 M H - Pcubic2 M • H)
  set A2 := innerOp2 Z (Qop2 H - (3 * innerOp2 M (Qop2 H)) • M)
  set A3 := innerOp2 Z (-(3 * innerOp2 M (Qop2 H)) • H - Pcubic2 H • M)
  set A4 := innerOp2 Z (-(Pcubic2 H) • H)
  have hf : (fun s : ℝ => innerOp2 Z (critMap (M + s • H))) =
      fun s => A0 + s * A1 + s ^ 2 * A2 + s ^ 3 * A3 + s ^ 4 * A4 := by
    funext s
    rw [critMap_line hM hH hQ s]
    simp only [innerOp2_add_right, innerOp2_smul_right, A0, A1, A2, A3, A4]
  rw [hf]
  have h := ((((hasDerivAt_const (0 : ℝ) A0).add ((hasDerivAt_id (0 : ℝ)).mul_const A1)).add
    ((hasDerivAt_pow 2 (0 : ℝ)).mul_const A2)).add ((hasDerivAt_pow 3 (0 : ℝ)).mul_const A3)).add
    ((hasDerivAt_pow 4 (0 : ℝ)).mul_const A4)
  refine h.congr_deriv ?_
  simp

/-- **The kernel of `DF(M)` on the tangent space is the `½`-eigenspace of `L_e`**, `e = M/θ`, `θ = P(M) ≠ 0`:
`2 M∘H − θH = 0` iff `L_e H = ½ H`. -/
theorem critMap_kernel_iff {M H : CurvOp2 ι} (hθ : Pcubic2 M ≠ 0) :
    (2 : ℝ) • foxProd2 M H - Pcubic2 M • H = 0 ↔ LeLin M H = (1 / 2 : ℝ) • H := by
  show _ ↔ foxProd2 ((Pcubic2 M)⁻¹ • M) H = _
  rw [foxProd2_smul_left]
  constructor
  · intro h
    have : foxProd2 M H = (Pcubic2 M / 2) • H := by
      have h0 : (2 : ℝ) • foxProd2 M H = Pcubic2 M • H := sub_eq_zero.mp h
      have h' := congrArg (fun X => (1 / 2 : ℝ) • X) h0
      simp only [smul_smul] at h'
      rw [show (1 / 2 : ℝ) * 2 = 1 by norm_num, one_smul] at h'
      rw [h']; congr 1; ring
    rw [this, smul_smul]; congr 1; field_simp
  · intro h
    have h' := congrArg (fun X => (2 * Pcubic2 M) • X) h
    simp only [smul_smul] at h'
    rw [show 2 * Pcubic2 M * (Pcubic2 M)⁻¹ = 2 by field_simp] at h'
    rw [h', show 2 * Pcubic2 M * (1 / 2) = Pcubic2 M by ring]
    exact sub_self (Pcubic2 M • H)

end HamiltonsCubic.RealLayer
