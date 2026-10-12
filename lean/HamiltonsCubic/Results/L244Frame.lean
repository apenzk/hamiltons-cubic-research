import Mathlib
import HamiltonsCubic.Results.L244RowA
import HamiltonsCubic.Results.L244RowBMass
import HamiltonsCubic.Results.EigenFrameExist
import HamiltonsCubic.Results.CriticalBridge

set_option linter.style.longLine false

/-!
# L244's rows at `W`'s own eigenbasis

The L244 row proves rows (A), (B) and (C) in class masses for any complete skew family `ψ` split into
classes (`hA_of_basis`, `rowMass_total_any` in [L244RowA.lean](L244RowA.lean); `rowB_mass`, `rowC_mass` in
[L244RowBMass.lean](L244RowBMass.lean)), with the resolutions `hId` (the class projections sum to the
identity on bivectors) and `hWP` (`W = ∑_b λ_b P_b` there) as hypotheses, and owes *"the construction of
ψ, φ, cls from W's eigenspaces"*, *"what the layer does not build is ψ from W's eigenspaces"*. This file
builds it from [EigenFrameExist.lean](EigenFrameExist.lean)'s spectral frame:

* `ψf`, `evf`: the spectral eigenframe of a linear Weyl `W`, reindexed by `Fin r`, `r = |Pairs n|`;
* `ψf_skew`, `ψf_complete`, `ψf_eigen`: skew, complete in the form L244 uses, eigenvectors;
* `hId_frame`, `hWP_frame`: for any labelling `cls` of the frame by classes with values `λ`, the evaluation
  `evf k = λ (cls k)` gives both resolutions on bivectors;
* `rowA_frame`, `rowB_frame`, `rowC_frame`: rows (A), (B), (C) at `W`'s eigenbasis, for every such labelling.
-/

namespace HamiltonsCubic.L244Frame

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.EigenFrameExist
  HamiltonsCubic.SecondKind HamiltonsCubic.L244RowBMass

variable {n K : ℕ} (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)

/-- The frame's index. -/
noncomputable abbrev eF (n : ℕ) : Pairs n ≃ Fin (Fintype.card (Pairs n)) := Fintype.equivFin (Pairs n)

/-- **The spectral eigenframe**, reindexed. -/
noncomputable def ψf : Fin (Fintype.card (Pairs n)) → Matrix (Fin n) (Fin n) ℝ :=
  fun k => frameVec W hW.1 hW.2.1 hW.2.2.1 ((eF n).symm k)

/-- Its eigenvalues. -/
noncomputable def evf : Fin (Fintype.card (Pairs n)) → ℝ :=
  fun k => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues ((eF n).symm k)

theorem ψf_skew (k : Fin (Fintype.card (Pairs n))) : IsSkew (ψf W hW k) :=
  (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1).skew _

theorem ψf_eigen (k : Fin (Fintype.card (Pairs n))) : W (ψf W hW k) = evf W hW k • ψf W hW k :=
  (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1).eigen _

/-- **Complete**, in the form L244 uses: `Y = ∑_k ⟨ψ_k, Y⟩ ψ_k` on bivectors. -/
theorem ψf_complete (Y : Matrix (Fin n) (Fin n) ℝ) (hY : IsSkew Y) :
    Y = ∑ k, inner2 (ψf W hW k) Y • ψf W hW k := by
  have h := (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1).complete Y hY
  conv_lhs => rw [h]
  rw [← Equiv.sum_comp (eF n).symm]
  refine Finset.sum_congr rfl fun k _ => ?_
  simp only [ψf, inner2_comm Y]

variable {W hW}

/-- **The class projections resolve the identity on bivectors.** -/
theorem hId_frame (cls : Fin (Fintype.card (Pairs n)) → Fin K) (X : Matrix (Fin n) (Fin n) ℝ)
    (hX : IsSkew X) : X = ∑ a, Pc (ψf W hW) cls a X := by
  unfold Pc
  rw [Finset.sum_fiberwise_of_maps_to (g := cls) (fun _ _ => Finset.mem_univ _)]
  exact ψf_complete W hW X hX

/-- **`W = ∑_b λ_b P_b` on bivectors**, when each frame eigenvalue is its class's value. -/
theorem hWP_frame (cls : Fin (Fintype.card (Pairs n)) → Fin K) (lam : Fin K → ℝ)
    (hcls : ∀ k, evf W hW k = lam (cls k)) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    W X = ∑ b, lam b • Pc (ψf W hW) cls b X := by
  have hexp := ψf_complete W hW X hX
  have hWX : W X = ∑ k, inner2 (ψf W hW k) X • (lam (cls k) • ψf W hW k) := by
    conv_lhs => rw [hexp]
    show CriticalBridge.linOf hW.1 _ = _
    simp only [map_sum, map_smul]
    refine Finset.sum_congr rfl fun k _ => ?_
    show inner2 (ψf W hW k) X • W (ψf W hW k) = _
    rw [ψf_eigen W hW k, hcls k]
  rw [hWX]
  unfold Pc
  simp only [Finset.smul_sum]
  rw [← Finset.sum_fiberwise_of_maps_to (g := cls) (fun _ _ => Finset.mem_univ _)]
  refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun k hk => ?_
  rw [(Finset.mem_filter.mp hk).2, smul_comm]

/-- **Row (A) at `W`'s eigenbasis**: `∑_{a,b} b_ab(x) = (n - 2)⟨x, x⟩`. -/
theorem rowA_frame (cls : Fin (Fintype.card (Pairs n)) → Fin K) (x : Matrix (Fin n) (Fin n) ℝ)
    (hx : IsSkew x) :
    ∑ a, ∑ b, HamiltonsCubic.L244RowA.bAB (ψf W hW) cls a b x = ((n : ℝ) - 2) * inner2 x x := by
  rw [← HamiltonsCubic.L244RowA.rowMass_eq_sum_bAB]
  exact HamiltonsCubic.L244RowA.rowMass_total_any (ψf W hW) (ψf_skew W hW) (ψf_complete W hW)
    (ψf W hW) (ψf_complete W hW) x hx

/-- **Row (B) at `W`'s eigenbasis**: `∑_{a,b} λ_b b_ab(η) = -⟨Wη, η⟩`. -/
theorem rowB_frame (cls : Fin (Fintype.card (Pairs n)) → Fin K) (lam : Fin K → ℝ)
    (hcls : ∀ k, evf W hW k = lam (cls k)) (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) :
    ∑ a, ∑ b, lam b * HamiltonsCubic.L244RowA.bAB (ψf W hW) cls a b η = -inner2 (W η) η :=
  rowB_mass W hW (ψf W hW) (ψf_skew W hW) cls lam (hId_frame cls) (hWP_frame cls lam hcls) η hη

/-- **Row (C) at `W`'s eigenbasis**: `∑_{a,b} λ_a λ_b b_ab(η) = ⟨W^# η, η⟩`. -/
theorem rowC_frame (cls : Fin (Fintype.card (Pairs n)) → Fin K) (lam : Fin K → ℝ)
    (hcls : ∀ k, evf W hW k = lam (cls k)) (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) :
    ∑ a, ∑ b, lam a * lam b * HamiltonsCubic.L244RowA.bAB (ψf W hW) cls a b η = sharpQF W η :=
  rowC_mass W hW (ψf W hW) (ψf_skew W hW) cls lam (hWP_frame cls lam hcls) η hη

end HamiltonsCubic.L244Frame
