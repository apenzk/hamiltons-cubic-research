import HamiltonsCubic.Results.L70Unit
import HamiltonsCubic.Results.L70Symmetric

set_option linter.style.longLine false

/-!
# L70's dimension theorem at a saturating critical point, in one frame

[findings/bounds.md](../../../findings/bounds.md), Lemma L70: *saturation forces `dim E_min ≥ n/2` and
`dim E_max ≥ (n−2)/2`.* [L70Unit.lean](L70Unit.lean)'s `L70_equality_support` turns saturation into the
support condition, and [L70Dims.lean](L70Dims.lean)'s `saturation_dims` turns the support condition into the
two dimension bounds. **This file composes them in the eigenframe of Mathlib's spectral theorem**
([EigenFrameExist.lean](EigenFrameExist.lean)), with the unit `λ_min`-eigenvector taken to be a frame vector:

- `support_of_saturation`: at `θ = λ_min + (n − 2)λ_max` the frame's structure constants at `v_{γ₀}` are
  supported on `E_min × E_max` and its mirror;
- `L70_saturation_dims`: **`n − 2 ≤ 2 dim E_max` and `n ≤ 2 dim E_min`** at a saturating critical point,
  and `L70_saturation_dims_unit` the same on `θ(W)` at unit norm;
- `saturation_iff_support`: the converse too, so saturation IS the frame support condition, and
  `L70_saturation_iff_mm`: **on L23's family (a two-valued spectral frame with `E_max` spanning a
  bracket-closed `𝔥`), saturation at `v_{γ₀} ∈ 𝔪` holds iff `[𝔪, 𝔪] ⊥ v_{γ₀}`**.
-/

namespace HamiltonsCubic.EigenFrameExist

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SecondKind HamiltonsCubic.L41Statement
  HamiltonsCubic.L41Statement.Frame

variable {n : ℕ}

/-- **Saturation puts `ad(v_{γ₀})` on `E_min × E_max`**, in the spectral-theorem eigenframe. -/
theorem support_of_saturation (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax) :
    ∀ a b, cst (frameVec W hW.1 hW.2.1 hW.2.2.1) γ₀ a b ≠ 0 →
      ((Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmin ∧
          (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues b = lmax) ∨
        ((Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmax ∧
          (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues b = lmin) := by
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  set e := Fintype.equivFin (Pairs n)
  set ψ : Fin (Fintype.card (Pairs n)) → Matrix (Fin n) (Fin n) ℝ := fun k => frameVec W hW.1 hW.2.1 hW.2.2.1 (e.symm k)
  set lam : Fin (Fintype.card (Pairs n)) → ℝ := fun k => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues (e.symm k)
  have hψS : ∀ k, IsSkew (ψ k) := fun k => hf.skew _
  have hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k := fun Y hY => by
    conv_lhs => rw [hf.complete Y hY]
    rw [← e.symm.sum_comp]
    exact Finset.sum_congr rfl fun k _ => by rw [inner2_comm]
  have hWP := HamiltonsCubic.L70Weyl.hWP_of_eigenbasis W hW ψ lam hψ (fun k => hf.eigen _)
  have hunit : inner2 (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) = 1 := by rw [hf.orthonormal, if_pos rfl]
  have hxe : W (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) = lmin • frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀ := by have h := hf.eigen γ₀; rw [hγ] at h; exact h
  have hsupp := (HamiltonsCubic.L70Unit.L70_equality_support W hW θ hc ψ hψS hψ id lam hWP (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀)
    (hf.skew γ₀) hunit lmin lmax hxe hneg hpos (fun i => hlo _) (fun i => hhi _)).mp hsat
  intro a b hab
  have hb : HamiltonsCubic.L244RowA.bAB ψ id (e a) (e b) (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) ≠ 0 := by
    rw [HamiltonsCubic.L70Weyl.bAB_id]
    simp only [ψ, Equiv.symm_apply_apply]
    have : inner2 (br (frameVec W hW.1 hW.2.1 hW.2.2.1 a) (frameVec W hW.1 hW.2.1 hW.2.2.1 b)) (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) = cst (frameVec W hW.1 hW.2.1 hW.2.2.1) γ₀ a b := by rw [cst_cyclic hf]; rfl
    rw [this]; positivity
  have := hsupp (e a) (e b) hb
  simpa [lam, Equiv.symm_apply_apply] using this

/-- **L70's dimension theorem at a saturating critical point**: `n − 2 ≤ 2 dim E_max` and
`n ≤ 2 dim E_min`, the dimensions counted in the spectral-theorem eigenframe. -/
theorem L70_saturation_dims (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax) :
    (n : ℝ) - 2 ≤ 2 * ((univ.filter fun a => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmax).card : ℝ) ∧
      (n : ℝ) ≤ 2 * ((univ.filter fun a => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmin).card : ℝ) := by
  have h := saturation_dims hW.2 (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1) γ₀ lmin lmax
    (by linarith) hγ (support_of_saturation W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat)
  simpa [Fintype.card_fin] using h

/-- The same on `θ(W)` at a unit-norm critical point. -/
theorem L70_saturation_dims_unit (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (hn : normSq W = 1) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : theta W = lmin + ((n : ℝ) - 2) * lmax) :
    (n : ℝ) - 2 ≤ 2 * ((univ.filter fun a => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmax).card : ℝ) ∧
      (n : ℝ) ≤ 2 * ((univ.filter fun a => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmin).card : ℝ) := by
  rw [HamiltonsCubic.L74Statement.theta_of_critical_unit hc hn] at hsat
  exact L70_saturation_dims W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat

/-- **Saturation is equivalent to the frame support condition**, in the spectral-theorem eigenframe. -/
theorem saturation_iff_support (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax) :
    θ = lmin + ((n : ℝ) - 2) * lmax ↔
      ∀ a b, cst (frameVec W hW.1 hW.2.1 hW.2.2.1) γ₀ a b ≠ 0 →
        ((Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmin ∧
            (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues b = lmax) ∨
          ((Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmax ∧
            (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues b = lmin) := by
  refine ⟨support_of_saturation W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi, fun hs => ?_⟩
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  set e := Fintype.equivFin (Pairs n)
  set ψ : Fin (Fintype.card (Pairs n)) → Matrix (Fin n) (Fin n) ℝ :=
    fun k => frameVec W hW.1 hW.2.1 hW.2.2.1 (e.symm k)
  set lam : Fin (Fintype.card (Pairs n)) → ℝ :=
    fun k => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues (e.symm k)
  have hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k := fun Y hY => by
    conv_lhs => rw [hf.complete Y hY]
    rw [← e.symm.sum_comp]
    exact Finset.sum_congr rfl fun k _ => by rw [inner2_comm]
  have hWP := HamiltonsCubic.L70Weyl.hWP_of_eigenbasis W hW ψ lam hψ (fun k => hf.eigen _)
  have hunit : inner2 (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) = 1 := by
    rw [hf.orthonormal, if_pos rfl]
  have hxe : W (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) = lmin • frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀ := by
    have h := hf.eigen γ₀; rw [hγ] at h; exact h
  refine (HamiltonsCubic.L70Unit.L70_equality_support W hW θ hc ψ (fun k => hf.skew _) hψ id lam hWP
    (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀) (hf.skew γ₀) hunit lmin lmax hxe hneg hpos (fun i => hlo _)
    (fun i => hhi _)).mpr fun a b hb => ?_
  rw [HamiltonsCubic.L70Weyl.bAB_id] at hb
  have hc0 : cst (frameVec W hW.1 hW.2.1 hW.2.2.1) γ₀ (e.symm a) (e.symm b) ≠ 0 := by
    intro h0; apply hb
    have : inner2 (br (ψ a) (ψ b)) (frameVec W hW.1 hW.2.1 hW.2.2.1 γ₀)
        = cst (frameVec W hW.1 hW.2.1 hW.2.2.1) γ₀ (e.symm a) (e.symm b) := by rw [cst_cyclic hf]; rfl
    rw [this, h0]; ring
  exact hs _ _ hc0

/-- **L70 on L23's family, at a critical Weyl point**: when the spectral frame is two-valued, `λ_max` on the
frame vectors spanning a bracket-closed `𝔥` and `λ_min < 0` off them, **saturation at `v_{γ₀} ∈ 𝔪` holds iff
`[𝔪, 𝔪] ⊥ v_{γ₀}`**. -/
theorem L70_saturation_iff_mm (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (H : Set (Pairs n)) [DecidablePred (· ∈ H)]
    (hclosed : ∀ a b, a ∈ H → b ∈ H →
      br (frameVec W hW.1 hW.2.1 hW.2.2.1 a) (frameVec W hW.1 hW.2.1 hW.2.2.1 b)
        ∈ Submodule.span ℝ (frameVec W hW.1 hW.2.1 hW.2.2.1 '' H))
    (lmin lmax : ℝ) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlam : ∀ a, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = if a ∈ H then lmax else lmin)
    (γ₀ : Pairs n) (hg : γ₀ ∉ H) :
    θ = lmin + ((n : ℝ) - 2) * lmax ↔
      ∀ a b, a ∉ H → b ∉ H → cst (frameVec W hW.1 hW.2.1 hW.2.2.1) a b γ₀ = 0 := by
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  have hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin := by rw [hlam, if_neg hg]
  have hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j := fun j => by
    rw [hlam]; split_ifs <;> linarith
  have hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax := fun j => by
    rw [hlam]; split_ifs <;> linarith
  rw [saturation_iff_support W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi]
  exact L70_support_iff_mm hf H (cst_closed_of_span hf H hclosed) lmin lmax (by linarith) hlam γ₀ hg

end HamiltonsCubic.EigenFrameExist
