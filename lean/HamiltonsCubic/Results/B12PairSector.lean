import HamiltonsCubic.Results.B12PairTrace
import HamiltonsCubic.Results.L120PairSign

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 4c: each pair sector contributes `∑_{m,i∈S} Lb_{mi}² − ¼ w_jk²` to `tr(L_e²)`

The pair analogue of [B12FourSector.lean](B12FourSector.lean). [B12Pair.lean](B12Pair.lean)'s `Lop_pairMap` gives `L_e` on
[L120PairDim.lean](L120PairDim.lean)'s coordinates as `Bmap`, and [B12PairTrace.lean](B12PairTrace.lean)'s `trace_B2_cut`
computes `tr(B²)` on the Ricci cut, realised as `range Pcut`. This file joins them at a pair `t = {j, k}`:

* `setChar_pair`: the character of `t` is `ε_j ε_k`;
* **`mem_range_projS_pair`**: `range P_t` is exactly `pairMap` of the Ricci cut, by
  [L120PairSign.lean](L120PairSign.lean)'s `pairSummand_mem_signMat` and `proj_of_char`;
* `pairMap_inj_cut`, **`pairEquiv`**: `pairMap` is an isomorphism `range Pcut ≃ range P_t`, reading `c_y` off the coordinate
  `⟨R φ_jy, φ_ky⟩` as `pairSummand_finrank` does;
* **`trace_pair_sector`**: at every weight `w`, `tr(L_{diagW w}² ∘ P_t) = ∑_{m,i∈S} Lb_{mi}² − ¼ w_jk²`.
-/

namespace HamiltonsCubic.B12PairSector

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.B12Sphere
  HamiltonsCubic.B12Sectors HamiltonsCubic.B12Restrict HamiltonsCubic.B12Pair HamiltonsCubic.B12PairTrace
  HamiltonsCubic.L120Decomp HamiltonsCubic.L120HessPair HamiltonsCubic.L121Block HamiltonsCubic.L122Statement

variable {n : ℕ} {j k : Fin n}

/-- The Ricci cut of the pair span. -/
abbrev cut (j k : Fin n) : Submodule ℝ (Fin n → ℝ) :=
  LinearMap.ker (blockSums1 (univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i)))

theorem setChar_pair (hjk : j ≠ k) (ε : Fin n → ℝ) :
    HamiltonsCubic.L120Blocks.setChar ({j, k} : Finset (Fin n)) ε = ε j * ε k := by
  unfold HamiltonsCubic.L120Blocks.setChar
  rw [Finset.prod_insert (by simp [hjk]), Finset.prod_singleton]

/-- **The pair sector is `pairMap` of the Ricci cut.** -/
theorem mem_range_projS_pair (hjk : j ≠ k) (Y : weylModuleS (Fin n)) :
    Y ∈ LinearMap.range (projS ({j, k} : Finset (Fin n))) ↔ (Y : CurvLin (Fin n)) ∈ (cut j k).map (pairMap j k) := by
  rw [pairSummand_mem_signMat hjk]
  constructor
  · rintro ⟨Z, rfl⟩
    refine ⟨(projS _ Z).2, fun ε hε => ?_⟩
    rw [projS_coe, proj_signMat _ _ ε hε, setChar_pair hjk]
  · rintro ⟨_, hch⟩
    refine ⟨Y, Subtype.ext ?_⟩
    rw [projS_coe]
    have h := HamiltonsCubic.CompChar.proj_of_char (u := ({j, k} : Finset (Fin n))) (B := (Y : CurvLin (Fin n)))
      (fun ε hε => by rw [hch ε hε, setChar_pair hjk]) {j, k}
    rw [if_pos rfl] at h
    exact h

theorem pairMap_inj_cut (hjk : j ≠ k) {c d : Fin n → ℝ} (hc : c ∈ cut j k) (hd : d ∈ cut j k)
    (h : pairMap j k c = pairMap j k d) : c = d := by
  have hc' := (mem_ker_blockSums1 _ c).mp hc
  have hd' := (mem_ker_blockSums1 _ d).mp hd
  funext y
  by_cases hy : y ∈ univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i)
  · obtain ⟨hjy, hky⟩ := (Finset.mem_filter.mp hy).2
    have e := congrArg (fun F : CurvLin (Fin n) => coord F j y k y) h
    change coord (pairLin j k c ∘ₗ _) j y k y = coord (pairLin j k d ∘ₗ _) j y k y at e
    rwa [coord_pairS_diag hjk _ (Ne.symm hjy) (Ne.symm hky), coord_pairS_diag hjk _ (Ne.symm hjy) (Ne.symm hky)] at e
  · rw [hc'.1 y hy, hd'.1 y hy]

theorem cut_of_Pcut (hS : (Sset j k).Nonempty) (v : LinearMap.range (Pcut j k)) : (v : Fin n → ℝ) ∈ cut j k :=
  (mem_range_Pcut hS v).mp v.2

/-- `pairMap` from the cut into the sector. -/
noncomputable def pairSec (hjk : j ≠ k) (hS : (Sset j k).Nonempty) :
    LinearMap.range (Pcut j k) →ₗ[ℝ] LinearMap.range (projS ({j, k} : Finset (Fin n))) where
  toFun v := ⟨⟨pairMap j k v, pairMap_mem hjk (cut_of_Pcut hS v)⟩,
    (mem_range_projS_pair hjk _).mpr ⟨v, cut_of_Pcut hS v, rfl⟩⟩
  map_add' v u := by apply Subtype.ext; apply Subtype.ext; simp only [Submodule.coe_add, map_add]
  map_smul' c v := by apply Subtype.ext; apply Subtype.ext; simp only [Submodule.coe_smul, map_smul]; rfl

/-- **`range Pcut ≃ range P_t`** through `pairMap`. -/
noncomputable def pairEquiv (hjk : j ≠ k) (hS : (Sset j k).Nonempty) :
    LinearMap.range (Pcut j k) ≃ₗ[ℝ] LinearMap.range (projS ({j, k} : Finset (Fin n))) :=
  LinearEquiv.ofBijective (pairSec hjk hS)
    ⟨fun v u h => Subtype.ext (pairMap_inj_cut hjk (cut_of_Pcut hS v) (cut_of_Pcut hS u)
        (congrArg (fun y : LinearMap.range (projS ({j, k} : Finset (Fin n))) => ((y : weylModuleS (Fin n)) : CurvLin (Fin n))) h)),
      fun y => by
        obtain ⟨c, hc, hcy⟩ := (mem_range_projS_pair hjk (y : weylModuleS (Fin n))).mp y.2
        exact ⟨⟨c, (mem_range_Pcut hS c).mpr hc⟩, Subtype.ext (Subtype.ext hcy)⟩⟩

/-- **A pair sector contributes `∑_{m,i∈S} Lb_{mi}² − ¼ w_jk²` to `tr(L_e²)`** at `e = diagW w`. -/
theorem trace_pair_sector {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (hjk : j ≠ k) (hS : (Sset j k).Nonempty) :
    LinearMap.trace ℝ (weylModuleS (Fin n))
        ((Lop ⟨diagW w, diagW_mem hw⟩ ∘ₗ Lop ⟨diagW w, diagW_mem hw⟩) ∘ₗ projS ({j, k} : Finset (Fin n)))
      = ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb w j k m i ^ 2 - w j k ^ 2 / 4 := by
  set e : weylModuleS (Fin n) := ⟨diagW w, diagW_mem hw⟩ with he_def
  have he : ∀ u : Finset (Fin n), act (diagSet u) (e : CurvLin (Fin n)) = e := fun u => diagW_diagSet hw u
  rw [trace_sector_restrict e he, ← trace_B2_cut hw hjk hS]
  set ψ := pairEquiv hjk hS
  have step : ∀ (c : Fin n → ℝ) (hc : c ∈ cut j k), Lop e ⟨pairMap j k c, pairMap_mem hjk hc⟩
      = ⟨pairMap j k (Bmap w j k c), pairMap_mem hjk (Bmap_mem hw hjk hc)⟩ :=
    fun c hc => Subtype.ext (Lop_pairMap hw hjk hc)
  have hkey : ∀ v : LinearMap.range (Pcut j k),
      (Lop e ∘ₗ Lop e).restrict (fun x hx => mapsTo_range (V := weylModuleS (Fin n)) (A := Lop e ∘ₗ Lop e)
        (P := projS ({j, k} : Finset (Fin n))) (sq_comm e he _) hx) (ψ v)
      = ψ ((Bmap w j k ∘ₗ Bmap w j k).restrict (fun x hx => mapsTo_range (V := Fin n → ℝ)
          (A := Bmap w j k ∘ₗ Bmap w j k) (P := Pcut j k) (B2_Pcut hw hjk) hx) v) := by
    intro v
    apply Subtype.ext
    show (Lop e ∘ₗ Lop e) ⟨pairMap j k v, pairMap_mem hjk (cut_of_Pcut hS v)⟩
      = ⟨pairMap j k (Bmap w j k (Bmap w j k v)), _⟩
    rw [LinearMap.comp_apply, step _ (cut_of_Pcut hS v), step _ (Bmap_mem hw hjk (cut_of_Pcut hS v))]
  rw [LinearMap.trace_eq_matrix_trace ℝ ((Module.finBasis ℝ (LinearMap.range (Pcut j k))).map ψ),
    LinearMap.trace_eq_matrix_trace ℝ (Module.finBasis ℝ (LinearMap.range (Pcut j k)))]
  congr 1
  ext a b
  rw [LinearMap.toMatrix_apply, LinearMap.toMatrix_apply, Module.Basis.map_apply, hkey, Module.Basis.map_repr,
    LinearEquiv.trans_apply, LinearEquiv.symm_apply_apply]

end HamiltonsCubic.B12PairSector
