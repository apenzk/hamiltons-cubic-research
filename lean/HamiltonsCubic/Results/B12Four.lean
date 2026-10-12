import HamiltonsCubic.Results.B12Sphere
import HamiltonsCubic.Results.L120Four
import HamiltonsCubic.Results.L121Block
import HamiltonsCubic.Results.FoxBridge

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 3a: `L_e` on a four-set sector is a `2 × 2` matrix whose square has trace `sig/2`

At a diagonal Weyl operator `diagW w` and four distinct indices, [L121Block.lean](L121Block.lean)'s `fourSet_span` gives the Fox
product on the four-set span `x a + y b + z c` as `½ G (x, y, z)`, with `G` the circulant of the opposite-pair sums
`A = w_ij + w_kl`, `B = w_ik + w_jl`, `C = w_il + w_jk`. On [L120Four.lean](L120Four.lean)'s coordinates `(x, y)`, `z = -x - y`,
that is the matrix `½ [[A − B, C − B], [C − A, B − A]]`:

* **`Kmap w`**, the matrix as a linear map on `ℝ × ℝ`;
* **`Lop_fourMap`**: `L_{diagW w}` sends `fourMap (x, y)` to `fourMap (Kmap w (x, y))`, through `Lop_spec`,
  [FoxBridge.lean](FoxBridge.lean)'s `foxProd_congr_on_skew` and `fourSet_span`;
* **`trace_Kmap_sq`**: `tr(K²) = ½(A² + B² + C² − AB − BC − CA)`, which is `sig(A, B, C)/2` in
  [L27Four.lean](L27Four.lean)'s notation.
-/

namespace HamiltonsCubic.B12Four

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.B12Sphere
  HamiltonsCubic.WeylModuleSNonzero HamiltonsCubic.L126Assembly

variable {n : ℕ}

/-- The opposite-pair sums. -/
def sA (w : Matrix (Fin n) (Fin n) ℝ) (i j k l : Fin n) : ℝ := w i j + w k l
def sB (w : Matrix (Fin n) (Fin n) ℝ) (i j k l : Fin n) : ℝ := w i k + w j l
def sC (w : Matrix (Fin n) (Fin n) ℝ) (i j k l : Fin n) : ℝ := w i l + w j k

/-- **`L_e` on the four-set coordinates**, `½ [[A − B, C − B], [C − A, B − A]]`. -/
noncomputable def Kmap (A B C : ℝ) : (ℝ × ℝ) →ₗ[ℝ] (ℝ × ℝ) where
  toFun v := ((1 / 2 : ℝ) * ((A - B) * v.1 + (C - B) * v.2), (1 / 2 : ℝ) * ((C - A) * v.1 + (B - A) * v.2))
  map_add' v u := by ext <;> simp <;> ring
  map_smul' c v := by ext <;> simp <;> ring

theorem fourMap_mem {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (v : ℝ × ℝ) : fourMap i j k l v ∈ weylModuleS (Fin n) :=
  ((fourSummand_mem hij hik hil hjk hjl hkl _).mp ⟨v, rfl⟩).1

theorem fourMap_apply_skew (i j k l : Fin n) (v : ℝ × ℝ) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    fourMap i j k l v X = spanVec i j k l v.1 v.2 (-v.1 - v.2) X := by
  show fourLin i j k l v.1 v.2 (-v.1 - v.2) (skewProj (Fin n) X) = _
  rw [skewProj_skew X hX]; rfl

theorem diagW_apply_skew (w : Matrix (Fin n) (Fin n) ℝ) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    diagW w X = diagOp w X := by
  show diagOp w (skewProj (Fin n) X) = _
  rw [skewProj_skew X hX]

/-- **`L_{diagW w}` on the four-set sector is `Kmap`.** -/
theorem Lop_fourMap {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k)
    (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) (v : ℝ × ℝ) :
    (Lop ⟨diagW w, diagW_mem hw⟩ ⟨fourMap i j k l v, fourMap_mem hij hik hil hjk hjl hkl v⟩ : CurvLin (Fin n))
      = fourMap i j k l (Kmap (sA w i j k l) (sB w i j k l) (sC w i j k l) v) := by
  apply eq_of_coord _ _ (Submodule.coe_mem _) (fourMap_mem hij hik hil hjk hjl hkl _)
  intro a b c d
  unfold coord
  congr 1
  have hZ := phi_isSkew a b
  rw [Lop_spec, fourMap_apply_skew _ _ _ _ _ _ hZ]
  have hcong := HamiltonsCubic.TensorBridge.foxProd_congr_on_skew
    (X := fun A => diagW w A) (Y := fun A => fourMap i j k l v A)
    (X' := diagOp w) (Y' := spanVec i j k l v.1 v.2 (-v.1 - v.2))
    (fun Z hZ' => by rw [diagW_apply_skew w Z hZ']; exact diagOp_skew w hw.symm Z hZ')
    (fun Z hZ' => by rw [fourMap_apply_skew i j k l v Z hZ']; exact spanVec_skew i j k l _ _ _ Z)
    (fun Z hZ' => diagW_apply_skew w Z hZ') (fun Z hZ' => fourMap_apply_skew i j k l v Z hZ') (phi a b) hZ
  rw [hcong]
  unfold spanVec
  rw [HamiltonsCubic.L121Block.fourSet_span w hw.symm hij hik hil hjk hjl hkl hZ v.1 v.2 (-v.1 - v.2)]
  simp only [Kmap, LinearMap.coe_mk, AddHom.coe_mk, sA, sB, sC]
  module

/-- **The trace of `K²` is `sig/2`.** -/
theorem trace_Kmap_sq (A B C : ℝ) :
    LinearMap.trace ℝ (ℝ × ℝ) (Kmap A B C ∘ₗ Kmap A B C) = (A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A) / 2 := by
  rw [LinearMap.trace_eq_matrix_trace ℝ (Module.Basis.finTwoProd ℝ), Matrix.trace_fin_two]
  simp only [LinearMap.toMatrix_apply, Module.Basis.finTwoProd_zero, Module.Basis.finTwoProd_one, LinearMap.comp_apply, Kmap,
    LinearMap.coe_mk, AddHom.coe_mk, Module.Basis.coe_finTwoProd_repr]
  norm_num
  ring

end HamiltonsCubic.B12Four
