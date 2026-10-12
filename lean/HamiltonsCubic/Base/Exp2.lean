import HamiltonsCubic.Base.SecondOrder
import HamiltonsCubic.Base.BlockRotation

set_option linter.style.longLine false

/-!
# One-sided second-order expansions

`Exp2 f a b c` says `f t = a + t b + t² c + o(t²)` as `t → 0⁺`, for `f : ℝ → 𝔸` in a normed algebra. It is closed
under sums, scalar multiples and products (`Exp2.add`, `Exp2.smul`, `Exp2.mul`). The rotation `exp(tK)` has
`Exp2 (rot K) 1 K (K²/2)` (`exp2_rot`), `exp(t²K)` has `Exp2 _ 1 0 K` (`exp2_rot_sq`), and **`exp2_conj`** expands the
rotated path `R(t)⁻¹ W(t) R(t)` with `t²` coefficient `M2 − [K₂, u]`.
-/

namespace HamiltonsCubic.SpectralFn

open Asymptotics Filter Topology

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸]

/-- **`f t = a + t b + t² c + o(t²)` as `t → 0⁺`.** -/
def Exp2 (f : ℝ → 𝔸) (a b c : 𝔸) : Prop :=
  (fun t => f t - (a + t • b + t ^ 2 • c)) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2

theorem cube_isLittleO : (fun t : ℝ => t ^ 3) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2 :=
  (isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 2 < 3)).mono nhdsWithin_le_nhds

theorem poly_isBigO_one (a b c : 𝔸) : (fun t : ℝ => a + t • b + t ^ 2 • c) =O[𝓝[Set.Ici 0] 0] fun _ => (1 : ℝ) := by
  refine (Filter.Tendsto.isBigO_one ℝ (c := a + (0 : ℝ) • b + (0 : ℝ) ^ 2 • c) ?_)
  exact ((continuous_const.add (continuous_id.smul continuous_const)).add
    ((continuous_id.pow 2).smul continuous_const)).continuousAt.tendsto.mono_left nhdsWithin_le_nhds

theorem Exp2.isBigO_one {f : ℝ → 𝔸} {a b c : 𝔸} (h : Exp2 f a b c) : f =O[𝓝[Set.Ici 0] 0] fun _ => (1 : ℝ) := by
  have h1 : (fun t : ℝ => t ^ 2) =O[𝓝[Set.Ici 0] 0] fun _ => (1 : ℝ) :=
    (Filter.Tendsto.isBigO_one ℝ (c := (0 : ℝ) ^ 2)
      ((continuous_id.pow 2).continuousAt.tendsto.mono_left nhdsWithin_le_nhds))
  have := (h.isBigO.trans h1).add (poly_isBigO_one a b c)
  simpa using this

theorem Exp2.add {f g : ℝ → 𝔸} {a b c a' b' c' : 𝔸} (hf : Exp2 f a b c) (hg : Exp2 g a' b' c') :
    Exp2 (fun t => f t + g t) (a + a') (b + b') (c + c') := by
  refine (IsLittleO.add hf hg).congr_left fun t => ?_
  simp only [smul_add]; abel

theorem Exp2.sub {f g : ℝ → 𝔸} {a b c a' b' c' : 𝔸} (hf : Exp2 f a b c) (hg : Exp2 g a' b' c') :
    Exp2 (fun t => f t - g t) (a - a') (b - b') (c - c') := by
  refine (IsLittleO.sub hf hg).congr_left fun t => ?_
  simp only [smul_sub]; abel

theorem Exp2.smul {f : ℝ → 𝔸} {a b c : 𝔸} (hf : Exp2 f a b c) (r : ℝ) :
    Exp2 (fun t => r • f t) (r • a) (r • b) (r • c) := by
  refine (IsLittleO.const_smul_left hf r).congr_left fun t => ?_
  simp only [Pi.smul_apply, smul_sub, smul_add, smul_comm r t, smul_comm r (t ^ 2)]

/-- **Products**: `(a + tb + t²c)(a' + tb' + t²c') = aa' + t(ab' + ba') + t²(ac' + bb' + ca') + O(t³)`. -/
theorem Exp2.mul {f g : ℝ → 𝔸} {a b c a' b' c' : 𝔸} (hf : Exp2 f a b c) (hg : Exp2 g a' b' c') :
    Exp2 (fun t => f t * g t) (a * a') (a * b' + b * a') (a * c' + b * b' + c * a') := by
  -- f g − P = (f − p)(g) + p (g − q) + (p q − P), each o(t²)
  set p : ℝ → 𝔸 := fun t => a + t • b + t ^ 2 • c
  set q : ℝ → 𝔸 := fun t => a' + t • b' + t ^ 2 • c'
  have h1 : (fun t => (f t - p t) * g t) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2 * 1 :=
    IsLittleO.mul_isBigO hf (Exp2.isBigO_one hg)
  have h2 : (fun t => p t * (g t - q t)) =o[𝓝[Set.Ici 0] 0] fun t => 1 * t ^ 2 :=
    IsBigO.mul_isLittleO (poly_isBigO_one a b c) hg
  have hv : (fun t : ℝ => b * c' + c * b' + t • (c * c')) =O[𝓝[Set.Ici 0] 0] fun _ => (1 : ℝ) :=
    Filter.Tendsto.isBigO_one ℝ (c := b * c' + c * b' + (0 : ℝ) • (c * c'))
      ((continuous_const.add (continuous_id.smul continuous_const)).continuousAt.tendsto.mono_left nhdsWithin_le_nhds)
  have h3 : (fun t : ℝ => t ^ 3 • (b * c' + c * b' + t • (c * c'))) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2 • (1 : ℝ) :=
    IsLittleO.smul_isBigO cube_isLittleO hv
  have hsum := ((h1.congr_right fun t => mul_one _).add (h2.congr_right fun t => one_mul _)).add
    (h3.congr_right fun t => by rw [smul_eq_mul, mul_one])
  refine hsum.congr_left fun t => ?_
  simp only [p, q, sub_mul, mul_sub, add_mul, mul_add, smul_mul_assoc, mul_smul_comm, smul_add, smul_smul]
  module

theorem Exp2.const (a : 𝔸) : Exp2 (fun _ => a) a 0 0 := by
  unfold Exp2; simp only [smul_zero, add_zero, sub_self]; exact isLittleO_zero _ _

theorem Exp2.congr {f g : ℝ → 𝔸} {a b c : 𝔸} (h : Exp2 f a b c) (hfg : ∀ t, f t = g t) : Exp2 g a b c := by
  unfold Exp2 at *; simpa only [hfg] using h

/-! ## The rotation -/

section Rot
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

omit [FiniteDimensional ℝ E] in
/-- `t³ ‖K‖³ = o(t²)`: a cubic remainder is second-order small. -/
theorem cube_norm_isLittleO (K : E →L[ℝ] E) :
    (fun t : ℝ => ‖t • K‖ ^ 3) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2 := by
  have : (fun t : ℝ => ‖t • K‖ ^ 3) = fun t => ‖K‖ ^ 3 * |t| ^ 3 := by
    funext t; rw [norm_smul, Real.norm_eq_abs, mul_pow, mul_comm]
  rw [this]
  refine IsLittleO.const_mul_left ?_ _
  have h := (isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 2 < 3)).mono (nhdsWithin_le_nhds (s := Set.Ici 0))
  exact h.norm_left.congr_left fun t => by rw [norm_pow, Real.norm_eq_abs]

/-- **`exp(tK) = 1 + tK + t²K²/2 + o(t²)`.** -/
theorem exp2_rot (K : E →L[ℝ] E) : Exp2 (rot K) 1 K ((1 / 2 : ℝ) • (K * K)) := by
  have h := (exp_sub_quadratic_isBigO (E := E)).comp_tendsto
    (show Tendsto (fun t : ℝ => t • K) (𝓝[Set.Ici 0] 0) (𝓝 0) by
      have : Tendsto (fun t : ℝ => t • K) (𝓝 0) (𝓝 ((0 : ℝ) • K)) :=
        (continuous_id.smul continuous_const).continuousAt.tendsto
      rw [zero_smul] at this; exact this.mono_left nhdsWithin_le_nhds)
  refine (h.trans_isLittleO (cube_norm_isLittleO K)).congr_left fun t => ?_
  simp only [Function.comp, rot, smul_mul_smul_comm, smul_smul]
  congr 2; ring_nf

/-- **`exp(t²K) = 1 + t²K + o(t²)`.** -/
theorem exp2_rot_sq (K : E →L[ℝ] E) : Exp2 (fun t => rot K (t ^ 2)) 1 0 K := by
  have h := (exp_sub_quadratic_isBigO (E := E)).comp_tendsto
    (show Tendsto (fun t : ℝ => t ^ 2 • K) (𝓝[Set.Ici 0] 0) (𝓝 0) by
      have : Tendsto (fun t : ℝ => t ^ 2 • K) (𝓝 0) (𝓝 ((0 : ℝ) ^ 2 • K)) :=
        ((continuous_id.pow 2).smul continuous_const).continuousAt.tendsto
      rw [zero_pow two_ne_zero, zero_smul] at this; exact this.mono_left nhdsWithin_le_nhds)
  -- `exp y − 1 − y = y²/2 + O(‖y‖³)`, and at `y = t²K` both are `o(t²)`
  have hq : (fun t : ℝ => (1 / 2 : ℝ) • ((t ^ 2 • K) * (t ^ 2 • K))) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2 := by
    have : (fun t : ℝ => (1 / 2 : ℝ) • ((t ^ 2 • K) * (t ^ 2 • K))) = fun t => t ^ 4 • ((1 / 2 : ℝ) • (K * K)) := by
      funext t; rw [smul_mul_smul_comm, smul_comm, ← pow_add]
    rw [this]
    have h4 := (isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 2 < 4)).mono (nhdsWithin_le_nhds (s := Set.Ici 0))
    exact (IsLittleO.smul_isBigO h4 (isBigO_const_const ((1 / 2 : ℝ) • (K * K)) one_ne_zero _)).congr_right
      fun t => by rw [smul_eq_mul, mul_one]
  have hc : (fun t : ℝ => ‖t ^ 2 • K‖ ^ 3) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2 := by
    have : (fun t : ℝ => ‖t ^ 2 • K‖ ^ 3) = fun t => ‖K‖ ^ 3 * |t| ^ 6 := by
      funext t; rw [norm_smul, Real.norm_eq_abs, mul_pow, abs_pow, ← pow_mul, mul_comm]
    rw [this]
    refine IsLittleO.const_mul_left ?_ _
    have h6 := (isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 2 < 6)).mono (nhdsWithin_le_nhds (s := Set.Ici 0))
    exact h6.norm_left.congr_left fun t => by rw [norm_pow, Real.norm_eq_abs]
  refine ((h.trans_isLittleO hc).add hq).congr_left fun t => ?_
  simp only [Function.comp, rot, smul_zero, add_zero]
  abel

/-- **The `t²` coefficient of `exp(−tK) W(t) exp(tK)`** for `W(t) = u + tH + t²G + o(t²)`. -/
noncomputable def M2 (K u H G : E →L[ℝ] E) : E →L[ℝ] E :=
  G - (K * H - H * K) + ((1 / 2 : ℝ) • (K * K * u) + (1 / 2 : ℝ) • (u * (K * K)) - K * u * K)

/-- **The rotated path to second order**: with `R(t) = exp(tK) exp(t²K₂)` and `R(t)⁻¹ = exp(−t²K₂) exp(−tK)`,
`R(t)* W(t) R(t) = u + t (H − [K, u]) + t² (M₂ − [K₂, u]) + o(t²)`. -/
theorem exp2_conj (K K₂ : E →L[ℝ] E) {W : ℝ → E →L[ℝ] E} {u H G : E →L[ℝ] E} (hW : Exp2 W u H G) :
    Exp2 (fun t => (rot (-K₂) (t ^ 2) * rot (-K) t) * W t * (rot K t * rot K₂ (t ^ 2)))
      u (H - (K * u - u * K)) (M2 K u H G - (K₂ * u - u * K₂)) := by
  have hR := (exp2_rot K).mul (exp2_rot_sq K₂)
  have hRs := (exp2_rot_sq (-K₂)).mul (exp2_rot (-K))
  have h := (hRs.mul hW).mul hR
  unfold Exp2 at h ⊢
  refine h.congr_left fun t => ?_
  unfold M2
  congr 1
  simp only [smul_add, smul_sub, smul_neg, neg_mul, mul_neg, one_mul, mul_one, zero_mul, mul_zero, add_zero, zero_add,
    smul_mul_assoc, mul_smul_comm, mul_add, add_mul]
  module

end Rot

end HamiltonsCubic.SpectralFn
