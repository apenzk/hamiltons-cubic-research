import Mathlib
import HamiltonsCubic.Results.L3Local

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# The derivative of the `O(n)`-action along a coordinate rotation, at every operator

`U ↦ U · A` on `CurvOp2`, differentiated along the rotation `R_φ` of the `(j, k)`-plane, has derivative `[ad_ξ, A]`, the orbit
tangent `orbitTangent A ξ` with `ξ = φ_jk` the generator, at every operator `A`. Calculus on `Matrix` has no norm to stand on, so
it is done entry by entry:

* `HasMDeriv`, entrywise `HasDerivAt` of a matrix curve, with `.mul`, `.transpose`, `const`, `.linear`;
* `hasMDeriv_Rot`: `φ ↦ Rot j k (cos φ) (sin φ)` has derivative `φ_jk` at `0`;
* **`hasDerivAt_pairing`**: `φ ↦ ⟨R_φ · A, B⟩` has derivative `⟨orbitTangent A ξ, B⟩` at `0`.
-/

namespace HamiltonsCubic.RotDeriv

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.TensorBridge

variable {n : ℕ}

/-- Entrywise derivative of a matrix curve. -/
def HasMDeriv (A : ℝ → Matrix (Fin n) (Fin n) ℝ) (A' : Matrix (Fin n) (Fin n) ℝ) (x : ℝ) : Prop :=
  ∀ a b, HasDerivAt (fun t => A t a b) (A' a b) x

theorem HasMDeriv.mul {A B : ℝ → Matrix (Fin n) (Fin n) ℝ} {A' B' : Matrix (Fin n) (Fin n) ℝ} {x : ℝ}
    (hA : HasMDeriv A A' x) (hB : HasMDeriv B B' x) :
    HasMDeriv (fun t => A t * B t) (A' * B x + A x * B') x := by
  intro a b
  simp only [Matrix.mul_apply, Matrix.add_apply, ← Finset.sum_add_distrib]
  exact HasDerivAt.fun_sum fun c _ => (hA a c).mul (hB c b)

theorem HasMDeriv.transpose {A : ℝ → Matrix (Fin n) (Fin n) ℝ} {A' : Matrix (Fin n) (Fin n) ℝ} {x : ℝ}
    (hA : HasMDeriv A A' x) : HasMDeriv (fun t => (A t)ᵀ) A'ᵀ x := fun a b => hA b a

theorem hasMDeriv_const (C : Matrix (Fin n) (Fin n) ℝ) (x : ℝ) : HasMDeriv (fun _ => C) 0 x := fun a b =>
  hasDerivAt_const x (C a b)

theorem HasMDeriv.linear {A : ℝ → Matrix (Fin n) (Fin n) ℝ} {A' : Matrix (Fin n) (Fin n) ℝ} {x : ℝ}
    (hA : HasMDeriv A A' x) (L : Matrix (Fin n) (Fin n) ℝ →ₗ[ℝ] Matrix (Fin n) (Fin n) ℝ) :
    HasMDeriv (fun t => L (A t)) (L A') x := by
  have hexp : ∀ M : Matrix (Fin n) (Fin n) ℝ, L M = ∑ p, ∑ q, M p q • L (Matrix.single p q 1) := by
    intro M
    conv_lhs => rw [Matrix.matrix_eq_sum_single M]
    simp only [map_sum]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    rw [← map_smul, Matrix.smul_single, smul_eq_mul, mul_one]
  intro a b
  have e1 : (fun t => L (A t) a b) = fun t => ∑ p, ∑ q, A t p q * L (Matrix.single p q 1) a b := by
    funext t
    rw [hexp (A t)]
    simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul]
  have e2 : L A' a b = ∑ p, ∑ q, A' p q * L (Matrix.single p q 1) a b := by
    rw [hexp A']
    simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul]
  rw [e1, e2]
  exact HasDerivAt.fun_sum fun p _ => HasDerivAt.fun_sum fun q _ => (hA p q).mul_const _

theorem hasDerivAt_inner2 {A : ℝ → Matrix (Fin n) (Fin n) ℝ} {A' : Matrix (Fin n) (Fin n) ℝ} {x : ℝ}
    (hA : HasMDeriv A A' x) (C : Matrix (Fin n) (Fin n) ℝ) :
    HasDerivAt (fun t => inner2 (A t) C) (inner2 A' C) x := by
  simp only [inner2_eq_sum]
  exact (HasDerivAt.fun_sum fun a _ => HasDerivAt.fun_sum fun b _ => (hA a b).mul_const _).const_mul _

/-- **The rotation of the `(j, k)`-plane has derivative `φ_jk` at `0`.** -/
theorem hasMDeriv_Rot {j k : Fin n} (hjk : j ≠ k) :
    HasMDeriv (fun φ => HamiltonsCubic.PairSquare.Rot j k (Real.cos φ) (Real.sin φ)) (phi j k) 0 := by
  intro p q
  have hc : HasDerivAt Real.cos 0 0 := by simpa using Real.hasDerivAt_cos 0
  have hs : HasDerivAt Real.sin 1 0 := by simpa using Real.hasDerivAt_sin 0
  have hs' : HasDerivAt (fun φ => -Real.sin φ) (-1) 0 := hs.neg
  simp only [HamiltonsCubic.PairSquare.Rot, Matrix.of_apply, phi, Matrix.sub_apply, Matrix.single_apply]
  by_cases hq : q = j
  · subst hq
    by_cases hp : p = q
    · subst hp; simpa [hjk, Ne.symm hjk] using hc
    · by_cases hpk : p = k
      · subst hpk; simpa [hp, hjk, Ne.symm hjk] using hs
      · simpa [hp, hpk, Ne.symm hp, Ne.symm hpk] using hasDerivAt_const (0 : ℝ) (0 : ℝ)
  · by_cases hqk : q = k
    · subst hqk
      by_cases hp : p = j
      · subst hp; simpa [hq, hjk, Ne.symm hjk] using hs'
      · by_cases hpk : p = q
        · subst hpk; simpa [hq, hp, Ne.symm hq] using hc
        · simpa [hq, hp, hpk, Ne.symm hp, Ne.symm hpk, Ne.symm hq] using hasDerivAt_const (0 : ℝ) (0 : ℝ)
    · by_cases hpq : p = q
      · subst hpq; simpa [hq, hqk, Ne.symm hq, Ne.symm hqk] using hasDerivAt_const (0 : ℝ) (1 : ℝ)
      · simpa [hq, hqk, hpq, Ne.symm hq, Ne.symm hqk] using hasDerivAt_const (0 : ℝ) (0 : ℝ)

/-- The extension of `u` to all matrices, as a linear map. -/
noncomputable def extL (u : CurvOp2 (Fin n)) : Matrix (Fin n) (Fin n) ℝ →ₗ[ℝ] Matrix (Fin n) (Fin n) ℝ where
  toFun := extend u
  map_add' := (isLinOp_extend u).1
  map_smul' := (isLinOp_extend u).2

theorem extL_apply (u : CurvOp2 (Fin n)) (X : skewSub (Fin n)) :
    extL u (X : Matrix (Fin n) (Fin n) ℝ) = ((u X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) := extend_apply u X

/-- **The derivative of `φ ↦ (R_φ · u) X` at `0` is `[ξ, uX] − u[ξ, X]`.** -/
theorem hasMDeriv_rotR (u : CurvOp2 (Fin n)) {j k : Fin n} (hjk : j ≠ k) (X : skewSub (Fin n)) :
    HasMDeriv (fun φ => ((rotR (HamiltonsCubic.PairSquare.Rot j k (Real.cos φ) (Real.sin φ)) u X : skewSub (Fin n)) :
      Matrix (Fin n) (Fin n) ℝ))
      ((HamiltonsCubic.I117S.orbitTangent u ⟨phi j k, phi_mem_skewSub j k⟩ X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) 0 := by
  set R := fun φ : ℝ => HamiltonsCubic.PairSquare.Rot j k (Real.cos φ) (Real.sin φ) with hRdef
  have e : (fun φ => ((rotR (R φ) u X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ))
      = fun φ => R φ * extL u ((R φ)ᵀ * (X : Matrix (Fin n) (Fin n) ℝ) * R φ) * (R φ)ᵀ := by
    funext φ
    rw [rotR_coe, ← cU_coe, extL_apply]
  show HasMDeriv (fun φ => ((rotR (R φ) u X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) _ 0
  rw [e]
  have hR : HasMDeriv R (phi j k) 0 := hasMDeriv_Rot hjk
  have hZ := (hR.transpose.mul (hasMDeriv_const (X : Matrix (Fin n) (Fin n) ℝ) 0)).mul hR
  have hLZ := hZ.linear (extL u)
  have hY := (hR.mul hLZ).mul hR.transpose
  have hR0 : R 0 = 1 := by
    simp only [hRdef, Real.cos_zero, Real.sin_zero]
    exact HamiltonsCubic.L3Local.Rot_zero j k
  rw [hR0] at hY
  simp only [Matrix.transpose_one, Matrix.one_mul, Matrix.mul_one, Matrix.mul_zero, add_zero] at hY
  convert hY using 1
  have hξT : (phi j k)ᵀ = -phi j k := phi_isSkew j k
  rw [hξT]
  show ((HamiltonsCubic.I117S.orbitTangent u ⟨phi j k, phi_mem_skewSub j k⟩ X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = _
  unfold HamiltonsCubic.I117S.orbitTangent
  simp only [_root_.sub_apply, ContinuousLinearMap.comp_apply, Submodule.coe_sub]
  have h1 : ((adS ⟨phi j k, phi_mem_skewSub j k⟩ (u X) : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = br (phi j k) ((u X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) := rfl
  have h2 : ((u (adS ⟨phi j k, phi_mem_skewSub j k⟩ X) : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = extL u (br (phi j k) (X : Matrix (Fin n) (Fin n) ℝ)) := by
    rw [← extL_apply]; rfl
  rw [h1, h2, ← extL_apply u X]
  unfold br
  rw [map_sub, map_add]
  simp only [Matrix.neg_mul, Matrix.mul_neg, map_neg]
  abel

/-- **`φ ↦ ⟨R_φ · u, B⟩` has derivative `⟨orbitTangent u ξ, B⟩` at `0`.** -/
theorem hasDerivAt_pairing (u B : CurvOp2 (Fin n)) {j k : Fin n} (hjk : j ≠ k) :
    HasDerivAt (fun φ => innerOp2 (rotR (HamiltonsCubic.PairSquare.Rot j k (Real.cos φ) (Real.sin φ)) u) B)
      (innerOp2 (HamiltonsCubic.I117S.orbitTangent u ⟨phi j k, phi_mem_skewSub j k⟩) B) 0 := by
  unfold innerOp2
  exact (HasDerivAt.fun_sum fun a _ => HasDerivAt.fun_sum fun b _ =>
    hasDerivAt_inner2 (hasMDeriv_rotR u hjk ⟨phi a b, phi_mem_skewSub a b⟩) _).const_mul _

end HamiltonsCubic.RotDeriv
