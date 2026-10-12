import HamiltonsCubic.Results.B12Four
import HamiltonsCubic.Results.B12Restrict

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 3b: each four-set sector contributes `sig/2` to `tr(L_e²)`

[B12Restrict.lean](B12Restrict.lean)'s `trace_sector_restrict` turns the sector term `tr(L_e² ∘ P_t)` into a trace on
`range P_t`, and [B12Four.lean](B12Four.lean)'s `Lop_fourMap` gives `L_e` on [L120Four.lean](L120Four.lean)'s coordinates
`fourMap (x, y)` as the `2 × 2` matrix `Kmap`. This file joins them at a four-set `t = {i, j, k, l}`:

* `setChar_four`: the character of `t` is `ε_i ε_j ε_k ε_l`;
* **`mem_range_projS_iff`**: `range P_t` is exactly `range fourMap`, by `fourSummand_mem` and `proj_of_char`;
* `fourMap_injective`, **`fourEquiv`**: `fourMap` is an isomorphism `ℝ × ℝ ≃ range P_t`, by `fourSummand_finrank`;
* **`trace_four_sector`**: at every weight `w`, `tr(L_{diagW w}² ∘ P_t) = ½(A² + B² + C² − AB − BC − CA)`, `A`, `B`, `C` the
  opposite-pair sums of `w` on `t`.
-/

namespace HamiltonsCubic.B12FourSector

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.B12Sphere
  HamiltonsCubic.B12Sectors HamiltonsCubic.B12Restrict HamiltonsCubic.B12Four HamiltonsCubic.L120Decomp
  HamiltonsCubic.L120HessPair

variable {n : ℕ} {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

theorem setChar_four (ε : Fin n → ℝ) :
    HamiltonsCubic.L120Blocks.setChar ({i, j, k, l} : Finset (Fin n)) ε = ε i * ε j * ε k * ε l := by
  unfold HamiltonsCubic.L120Blocks.setChar
  rw [Finset.prod_insert (by simp [hij, hik, hil]), Finset.prod_insert (by simp [hjk, hjl]),
    Finset.prod_insert (by simp [hkl]), Finset.prod_singleton]
  ring

/-- **The four-set sector is the range of `fourMap`.** -/
theorem mem_range_projS_iff (Y : weylModuleS (Fin n)) :
    Y ∈ LinearMap.range (projS ({i, j, k, l} : Finset (Fin n)))
      ↔ (Y : CurvLin (Fin n)) ∈ LinearMap.range (fourMap i j k l) := by
  rw [fourSummand_mem hij hik hil hjk hjl hkl]
  constructor
  · rintro ⟨Z, rfl⟩
    refine ⟨(projS _ Z).2, fun ε hε => ?_⟩
    rw [projS_coe, proj_signMat _ _ ε hε, setChar_four hij hik hil hjk hjl hkl]
  · rintro ⟨_, hch⟩
    refine ⟨Y, Subtype.ext ?_⟩
    rw [projS_coe]
    have h := HamiltonsCubic.CompChar.proj_of_char (u := ({i, j, k, l} : Finset (Fin n))) (B := (Y : CurvLin (Fin n)))
      (fun ε hε => by rw [hch ε hε, setChar_four hij hik hil hjk hjl hkl]) {i, j, k, l}
    rw [if_pos rfl] at h
    exact h

theorem fourMap_injective : Function.Injective (fourMap i j k l) := by
  have h := LinearMap.finrank_range_add_finrank_ker (fourMap i j k l)
  rw [fourSummand_finrank hij hik hil hjk hjl hkl, Module.finrank_prod, Module.finrank_self] at h
  have hk : Module.finrank ℝ (LinearMap.ker (fourMap i j k l)) = 0 := by omega
  rw [← LinearMap.ker_eq_bot]
  exact Submodule.finrank_eq_zero.mp hk

/-- `fourMap` into the sector. -/
noncomputable def fourSec : (ℝ × ℝ) →ₗ[ℝ] LinearMap.range (projS ({i, j, k, l} : Finset (Fin n))) where
  toFun v := ⟨⟨fourMap i j k l v, fourMap_mem hij hik hil hjk hjl hkl v⟩,
    (mem_range_projS_iff hij hik hil hjk hjl hkl _).mpr ⟨v, rfl⟩⟩
  map_add' v u := by apply Subtype.ext; apply Subtype.ext; simp only [map_add]; rfl
  map_smul' c v := by apply Subtype.ext; apply Subtype.ext; simp only [map_smul]; rfl

/-- **`ℝ × ℝ ≃ range P_t`** through `fourMap`. -/
noncomputable def fourEquiv : (ℝ × ℝ) ≃ₗ[ℝ] LinearMap.range (projS ({i, j, k, l} : Finset (Fin n))) :=
  LinearEquiv.ofBijective (fourSec hij hik hil hjk hjl hkl)
    ⟨fun v u h => fourMap_injective hij hik hil hjk hjl hkl
        (congrArg (fun y : LinearMap.range (projS ({i, j, k, l} : Finset (Fin n))) => ((y : weylModuleS (Fin n)) : CurvLin (Fin n))) h),
      fun y => by
        obtain ⟨v, hv⟩ := (mem_range_projS_iff hij hik hil hjk hjl hkl (y : weylModuleS (Fin n))).mp y.2
        exact ⟨v, Subtype.ext (Subtype.ext hv)⟩⟩

/-- **A four-set sector contributes `½(A² + B² + C² − AB − BC − CA)` to `tr(L_e²)`** at `e = diagW w`. -/
theorem trace_four_sector {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) :
    LinearMap.trace ℝ (weylModuleS (Fin n))
        ((Lop ⟨diagW w, diagW_mem hw⟩ ∘ₗ Lop ⟨diagW w, diagW_mem hw⟩) ∘ₗ projS ({i, j, k, l} : Finset (Fin n)))
      = (sA w i j k l ^ 2 + sB w i j k l ^ 2 + sC w i j k l ^ 2 - sA w i j k l * sB w i j k l
          - sB w i j k l * sC w i j k l - sC w i j k l * sA w i j k l) / 2 := by
  set e : weylModuleS (Fin n) := ⟨diagW w, diagW_mem hw⟩ with he_def
  have he : ∀ u : Finset (Fin n), act (diagSet u) (e : CurvLin (Fin n)) = e := fun u => diagW_diagSet hw u
  rw [trace_sector_restrict e he, ← trace_Kmap_sq]
  set φ := fourEquiv hij hik hil hjk hjl hkl
  have step : ∀ v : ℝ × ℝ, Lop e ⟨fourMap i j k l v, fourMap_mem hij hik hil hjk hjl hkl v⟩
      = ⟨fourMap i j k l (Kmap (sA w i j k l) (sB w i j k l) (sC w i j k l) v),
          fourMap_mem hij hik hil hjk hjl hkl _⟩ :=
    fun v => Subtype.ext (Lop_fourMap hw hij hik hil hjk hjl hkl v)
  have hkey : ∀ v : ℝ × ℝ, (Lop e ∘ₗ Lop e).restrict (fun x hx => mapsTo_range (V := weylModuleS (Fin n)) (A := Lop e ∘ₗ Lop e)
        (P := projS ({i, j, k, l} : Finset (Fin n))) (sq_comm e he _) hx) (φ v)
      = φ ((Kmap (sA w i j k l) (sB w i j k l) (sC w i j k l) ∘ₗ Kmap (sA w i j k l) (sB w i j k l) (sC w i j k l)) v) := by
    intro v
    apply Subtype.ext
    show (Lop e ∘ₗ Lop e) ⟨fourMap i j k l v, fourMap_mem hij hik hil hjk hjl hkl v⟩
      = ⟨fourMap i j k l _, fourMap_mem hij hik hil hjk hjl hkl _⟩
    rw [LinearMap.comp_apply, step, step]
    rfl
  rw [LinearMap.trace_eq_matrix_trace ℝ ((Module.Basis.finTwoProd ℝ).map φ),
    LinearMap.trace_eq_matrix_trace ℝ (Module.Basis.finTwoProd ℝ)]
  congr 1
  ext a b
  rw [LinearMap.toMatrix_apply, LinearMap.toMatrix_apply, Module.Basis.map_apply, hkey, Module.Basis.map_repr,
    LinearEquiv.trans_apply, LinearEquiv.symm_apply_apply]

end HamiltonsCubic.B12FourSector
