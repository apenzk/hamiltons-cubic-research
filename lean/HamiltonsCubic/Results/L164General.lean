import HamiltonsCubic.Results.L30Exists

set_option linter.style.longLine false

/-!
# L164 at a general subspace `U`

[findings/stratum-two-negative.md](../../../findings/stratum-two-negative.md), Lemma L164: a nonzero
`W ∈ 𝒲_n` that **annihilates `u ∧ u^⊥` for every `u ⊥ U`** is supported on `Λ²U`, its restriction
`W'` lies in `𝒲_{dim U}`, and `‖W'‖ = ‖W‖`, `θ(W') = θ(W)`.
[L30Statement.lean](L30Statement.lean)'s `L30_padding` proves this at `U` the negative support of an
eigenframe. **This file proves it at every `U`, from the record's own hypothesis**:

- `kill_of_support`: the hypothesis makes every eigenvector `v_α` with `λ_α ≠ 0` annihilate each
  `u ⊥ U`, since `λ_α ⟨u ∧ w, v_α⟩ = ⟨W(u ∧ w), v_α⟩ = 0` and `⟨u ∧ w, v_α⟩ = w · v_α u`;
- `L164_general`: **the padding, the Weyl conditions on `W'`, the norm, `P` and `θ` at every `U`**, the
  eigenframe supplied by [L30Exists.lean](L30Exists.lean)'s `eigenframe30_exists` and the rest by
  L30Statement's padding section, which takes `U` and this killing property as parameters.
-/

namespace HamiltonsCubic.L164General

open HamiltonsCubic.RealLayer HamiltonsCubic.L30Statement HamiltonsCubic.L30Exists
  HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind Matrix

variable {n : ℕ}

/-- **The support hypothesis kills the frame off the kernel.** -/
theorem kill_of_support {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl W)
    {κ : Type*} [DecidableEq κ] {v : κ → Matrix (Fin n) (Fin n) ℝ} {lam : κ → ℝ}
    (hf : Eigenframe W v lam) (U : Submodule ℝ (Fin n → ℝ))
    (hsupp : ∀ u : Fin n → ℝ, (∀ x ∈ U, dotProduct u x = 0) → ∀ w, W (wedgeVec u w) = 0)
    (u : Fin n → ℝ) (hu : ∀ x ∈ U, dotProduct u x = 0) (a : κ) (ha : lam a ≠ 0) :
    v a *ᵥ u = 0 := by
  have hw : ∀ w : Fin n → ℝ, dotProduct w (v a *ᵥ u) = 0 := by
    intro w
    have h1 := hW.2.1 (wedgeVec u w) (v a) (wedgeVec_isSkew u w) (hf.skew a)
    rw [hsupp u hu w, hf.eigen a] at h1
    have h0 : inner2 (0 : Matrix (Fin n) (Fin n) ℝ) (v a) = 0 := by unfold inner2; simp
    have hs : inner2 (wedgeVec u w) (lam a • v a) = lam a * inner2 (wedgeVec u w) (v a) := by
      unfold inner2; simp [Matrix.trace_smul, mul_left_comm]
    rw [h0, hs] at h1
    have h2 : inner2 (wedgeVec u w) (v a) = 0 :=
      (mul_eq_zero.mp h1.symm).resolve_left ha
    rwa [inner2_wedge u w (hf.skew a)] at h2
  exact dotProduct_self_eq_zero.mp (hw _)

/-- **L164 AT EVERY `U`.** -/
theorem L164_general (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (U : Submodule ℝ (Fin n → ℝ))
    (hsupp : ∀ u : Fin n → ℝ, (∀ x ∈ U, dotProduct u x = 0) → ∀ w, W (wedgeVec u w) = 0) :
    ∃ (E : Matrix (Fin n) (Fin (Module.finrank ℝ U)) ℝ)
      (W' : Matrix (Fin (Module.finrank ℝ U)) (Fin (Module.finrank ℝ U)) ℝ →
            Matrix (Fin (Module.finrank ℝ U)) (Fin (Module.finrank ℝ U)) ℝ),
      Eᵀ * E = 1 ∧ LinearMap.range (Matrix.mulVecLin E) = U ∧ IsWeyl W' ∧
      (∀ X, IsSkew X → W (E * X * Eᵀ) = E * W' X * Eᵀ) ∧
      HamiltonsCubic.RealLayer.norm W' = HamiltonsCubic.RealLayer.norm W ∧
      Pcubic W' = Pcubic W ∧ theta W' = theta W := by
  have hframe := eigenframe30_exists W hW
  obtain ⟨E, hE, hR⟩ := exists_isometry U
  have hkill := fun u hu a ha => kill_of_support hW.2 hframe U hsupp u hu a ha
  obtain ⟨hn, hP⟩ := invariants hW.2 hframe hE hR hkill
  have hnorm : HamiltonsCubic.RealLayer.norm (Wp W E) = HamiltonsCubic.RealLayer.norm W := by
    unfold HamiltonsCubic.RealLayer.norm; rw [hn]
  refine ⟨E, Wp W E, hE, hR, Wp_weyl hW.2 hframe hE hR hkill,
    fun X hX => conj_eq hW.2 hframe hE hR hkill X hX, hnorm, hP, ?_⟩
  unfold theta; rw [hP, hnorm]

end HamiltonsCubic.L164General
