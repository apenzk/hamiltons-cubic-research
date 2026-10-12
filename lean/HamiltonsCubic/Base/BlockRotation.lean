import HamiltonsCubic.Base.Schur

set_option linter.style.longLine false

/-!
# The rotation that block-diagonalises `u + tH` to first order

Milestone 3 of [the build plan for L17's derivative](../../../reviews/2026-09-26-lean-DK-plan.md), with
[Schur.lean](Schur.lean)'s generator `K = rotGen hn hu H` and its identity `[K, u] = H − H_blk`. In the algebra
`E →L[ℝ] E`:

- `rot K t = exp(tK)`, with `rot_mul_rot_neg` and `rot_neg_mul_rot` (`U(t) U(−t) = 1 = U(−t) U(t)`), `star_rot`
  (`U(t)* = U(−t)` when `K* = −K`, so `U(t)` is orthogonal) and `hasDerivAt_rot` (`U′(0) = K`);
- **`hasDerivAt_conjPath`**: `M(t) = U(−t) (u + tH) U(t)` has `M′(0) = H − [K, u]` for every `K`, `u`, `H`;
- the bridge from [Schur.lean](Schur.lean)'s operators in `E →ₗ[ℝ] E`: `star_rotGen` (`K* = −K` for symmetric `H`)
  and **`hasDerivAt_conjPath_blk`** (`M′(0) = H_blk` for `K = rotGen hn hu H`). So `M(t) = u + t H_blk + o(t)`.
-/

namespace HamiltonsCubic.SpectralFn

open Module

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-- **The rotation `U(t) = exp(tK)`.** -/
noncomputable def rot (K : E →L[ℝ] E) (t : ℝ) : E →L[ℝ] E := NormedSpace.exp (t • K)

theorem rot_mul_rot_neg (K : E →L[ℝ] E) (t : ℝ) : rot K t * rot K (-t) = 1 := by
  let : NormedAlgebra ℚ (E →L[ℝ] E) := NormedAlgebra.restrictScalars ℚ ℝ (E →L[ℝ] E)
  rw [rot, rot, ← NormedSpace.exp_add_of_commute (((Commute.refl K).smul_left t).smul_right (-t)), ← add_smul,
    add_neg_cancel, zero_smul, NormedSpace.exp_zero]

theorem rot_neg_mul_rot (K : E →L[ℝ] E) (t : ℝ) : rot K (-t) * rot K t = 1 := by
  simpa using rot_mul_rot_neg K (-t)

/-- **`U(t)` is orthogonal when `K` is skew**: `U(t)* = U(−t)`. -/
theorem star_rot {K : E →L[ℝ] E} (hK : star K = -K) (t : ℝ) : star (rot K t) = rot K (-t) := by
  rw [rot, rot, NormedSpace.star_exp, star_smul, hK, star_trivial, smul_neg, neg_smul]

/-- **`U′(0) = K`.** -/
theorem hasDerivAt_rot (K : E →L[ℝ] E) : HasDerivAt (rot K) K 0 := by
  have := hasDerivAt_exp_smul_const (𝕂 := ℝ) K (0 : ℝ)
  simp only [zero_smul, NormedSpace.exp_zero, one_mul] at this
  exact this

omit [FiniteDimensional ℝ E] in
theorem rot_zero (K : E →L[ℝ] E) : rot K 0 = 1 := by simp [rot]

omit [FiniteDimensional ℝ E] in
theorem rot_neg (K : E →L[ℝ] E) (t : ℝ) : rot K (-t) = rot (-K) t := by
  rw [rot, rot, neg_smul, smul_neg]

/-- **The conjugated path** `M(t) = U(−t) (u + tH) U(t)`, which is `U(t)* (u + tH) U(t)` for skew `K`. -/
noncomputable def conjPath (K u H : E →L[ℝ] E) (t : ℝ) : E →L[ℝ] E := rot K (-t) * (u + t • H) * rot K t

/-- **`M′(0) = H − [K, u]`**, where `[K, u] = K u − u K`. -/
theorem hasDerivAt_conjPath (K u H : E →L[ℝ] E) :
    HasDerivAt (conjPath K u H) (H - (K * u - u * K)) 0 := by
  have h1 : HasDerivAt (fun t => rot K (-t)) (-K) 0 := by
    simp_rw [rot_neg]; exact hasDerivAt_rot (-K)
  have h2 : HasDerivAt (fun t : ℝ => u + t • H) H 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).smul_const H).const_add u
  have h3 := hasDerivAt_rot K
  have := (h1.mul h2).mul h3
  have hval : (-K * (u + (0 : ℝ) • H) + rot K (-0) * H) * rot K 0 + ((fun t => rot K (-t)) * fun t : ℝ => u + t • H) 0 * K =
      H - (K * u - u * K) := by
    simp only [Pi.mul_apply, neg_zero, rot_zero, zero_smul, add_zero, one_mul, mul_one]
    noncomm_ring
  rw [hval] at this
  exact this

/-! ## The bridge from the eigenbasis operators of [Schur.lean](Schur.lean) -/

section Bridge
variable {n : ℕ} (hn : finrank ℝ E = n) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric)

/-- **`K* = −K`** for the generator of [Schur.lean](Schur.lean), read in `E →L[ℝ] E`. -/
theorem star_rotGen {H : E →ₗ[ℝ] E} (hH : H.IsSymmetric) :
    star (LinearMap.toContinuousLinearMap (rotGen hn hu H)) = -LinearMap.toContinuousLinearMap (rotGen hn hu H) := by
  rw [ContinuousLinearMap.star_eq_adjoint, eq_comm, ContinuousLinearMap.eq_adjoint_iff]
  intro x y
  simp only [neg_apply, LinearMap.coe_toContinuousLinearMap', inner_neg_left]
  rw [rotGen_isSkew hn hu hH, neg_neg]

/-- **`M′(0) = H_blk`** for the generator of [Schur.lean](Schur.lean), read in `E →L[ℝ] E`. -/
theorem hasDerivAt_conjPath_blk (H : E →ₗ[ℝ] E) :
    HasDerivAt (conjPath (LinearMap.toContinuousLinearMap (rotGen hn hu H)) (LinearMap.toContinuousLinearMap u)
      (LinearMap.toContinuousLinearMap H)) (LinearMap.toContinuousLinearMap (blkPart hn hu H)) 0 := by
  have h := hasDerivAt_conjPath (LinearMap.toContinuousLinearMap (rotGen hn hu H)) (LinearMap.toContinuousLinearMap u)
    (LinearMap.toContinuousLinearMap H)
  have hc := rotGen_commutator hn hu H
  have hval : LinearMap.toContinuousLinearMap H - (LinearMap.toContinuousLinearMap (rotGen hn hu H) *
      LinearMap.toContinuousLinearMap u - LinearMap.toContinuousLinearMap u * LinearMap.toContinuousLinearMap (rotGen hn hu H)) =
      LinearMap.toContinuousLinearMap (blkPart hn hu H) := by
    ext x
    have := LinearMap.congr_fun hc x
    simp only [LinearMap.sub_apply, LinearMap.comp_apply] at this
    simp only [sub_apply, mul_apply_eq_comp, LinearMap.coe_toContinuousLinearMap']
    rw [this]; abel
  rw [hval] at h
  exact h

end Bridge

end HamiltonsCubic.SpectralFn
