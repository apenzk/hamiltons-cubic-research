import HamiltonsCubic.Results.B12FourSector
import HamiltonsCubic.Results.L120PairDim
import HamiltonsCubic.Results.L122Cap
import HamiltonsCubic.Results.L122

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 4a: `L_e` on a pair sector is the pair block `Lb` on the Ricci cut

At a diagonal Weyl operator `diagW w` and a pair `j ≠ k`, [L122Cap.lean](L122Cap.lean)'s `foxProd_pairVec` gives the Fox product
on the pair span `∑_i c_i f_i` as the matrix `Lb = ½[diag(w_ji + w_ki) − w_jk Id + w^{(jk)}]` on the coefficients, indices in
`S = Sset j k`. On [L120PairDim.lean](L120PairDim.lean)'s coordinates, the Ricci cut `V` (supported on `S`, summing to zero):

* **`Bmap w j k`**: `Lb` on `S`, zero off it;
* **`colSum_Lb`**: every column of `Lb` over `S` sums to `−½ w_jk`, from Ricci-flatness ([L122.lean](L122.lean)'s
  `deleted_row_sum`), so `Bmap` preserves `V` (**`Bmap_mem`**);
* **`Lop_pairMap`**: `L_{diagW w}` sends `pairMap c` to `pairMap (Bmap c)` for every `c ∈ V`, through `Lop_spec`,
  `foxProd_congr_on_skew` and `foxProd_pairVec`.
-/

namespace HamiltonsCubic.B12Pair

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.B12Sphere
  HamiltonsCubic.B12Four HamiltonsCubic.WeylModuleSNonzero HamiltonsCubic.L126Assembly HamiltonsCubic.L122Statement HamiltonsCubic.L121Block

variable {n : ℕ}

/-- **The pair block on `S`**, zero off `S`. -/
noncomputable def Bmap (w : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) : (Fin n → ℝ) →ₗ[ℝ] (Fin n → ℝ) where
  toFun c m := if m ∈ Sset j k then ∑ i ∈ Sset j k, Lb w j k m i * c i else 0
  map_add' c d := by
    funext m; simp only [Pi.add_apply]
    split_ifs
    · rw [← Finset.sum_add_distrib]; exact Finset.sum_congr rfl fun i _ => by ring
    · ring
  map_smul' r c := by
    funext m; simp only [Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    split_ifs
    · rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun i _ => by ring
    · ring

theorem Lb_split (w : Matrix (Fin n) (Fin n) ℝ) (hh : ∀ a, w a a = 0) (j k m i : Fin n) :
    Lb w j k m i = (1 / 2) * w m i + (if m = i then (1 / 2) * (w j i + w k i - w j k) else 0) := by
  unfold Lb
  split_ifs with h
  · subst h; rw [hh]; ring
  · ring

/-- **Every column of `Lb` over `S` sums to `−½ w_jk`.** -/
theorem colSum_Lb {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k) {i : Fin n}
    (hi : i ∈ Sset j k) : ∑ m ∈ Sset j k, Lb w j k m i = -(1 / 2) * w j k := by
  simp only [Lb_split w hw.hollow, Finset.sum_add_distrib, Finset.sum_ite_eq', if_pos hi, ← Finset.mul_sum]
  have hd := HamiltonsCubic.PairBlock.deleted_row_sum (M := fun a b => w a b) hw.rowSum j k i hjk
  have e : ∑ m ∈ Sset j k, w m i = ∑ m ∈ univ \ ({j, k} : Finset (Fin n)), w i m :=
    Finset.sum_congr rfl fun m _ => hw.symm m i
  rw [e, hd, hw.symm i j, hw.symm i k]
  ring

theorem filter_eq (j k : Fin n) : univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i) = Sset j k :=
  filter_eq_Sset j k

/-- **`Bmap` preserves the Ricci cut.** -/
theorem Bmap_mem {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k) {c : Fin n → ℝ}
    (hc : c ∈ LinearMap.ker (blockSums1 (univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i)))) :
    Bmap w j k c ∈ LinearMap.ker (blockSums1 (univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i))) := by
  rw [mem_ker_blockSums1, filter_eq] at hc ⊢
  refine ⟨fun m hm => ?_, ?_⟩
  · show (if m ∈ Sset j k then _ else _) = _
    rw [if_neg hm]
  · show ∑ m ∈ Sset j k, (if m ∈ Sset j k then ∑ i ∈ Sset j k, Lb w j k m i * c i else 0) = 0
    rw [Finset.sum_congr rfl fun m hm => if_pos hm, Finset.sum_comm]
    simp only [← Finset.sum_mul]
    rw [Finset.sum_congr rfl fun i hi => by rw [colSum_Lb hw hjk hi], ← Finset.mul_sum, hc.2, mul_zero]

theorem pairMap_mem {j k : Fin n} (hjk : j ≠ k) {c : Fin n → ℝ}
    (hc : c ∈ LinearMap.ker (blockSums1 (univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i)))) :
    pairMap j k c ∈ weylModuleS (Fin n) :=
  ((pairSummand_mem hjk _).mp ⟨c, hc, rfl⟩).1

theorem pairMap_apply_skew (j k : Fin n) (c : Fin n → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    pairMap j k c X = pairVec j k c X := by
  show pairLin j k c (skewProj (Fin n) X) = _
  rw [skewProj_skew X hX]; rfl

theorem pairVec_congr (j k : Fin n) {c d : Fin n → ℝ} (h : ∀ i ∈ Sset j k, c i = d i) :
    pairVec j k c = pairVec j k d := by
  funext Y
  unfold pairVec
  rw [filter_eq]
  exact Finset.sum_congr rfl fun i hi => by rw [h i hi]

/-- **`L_{diagW w}` on the pair sector is `Bmap`.** -/
theorem Lop_pairMap {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k) {c : Fin n → ℝ}
    (hc : c ∈ LinearMap.ker (blockSums1 (univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i)))) :
    (Lop ⟨diagW w, diagW_mem hw⟩ ⟨pairMap j k c, pairMap_mem hjk hc⟩ : CurvLin (Fin n))
      = pairMap j k (Bmap w j k c) := by
  apply eq_of_coord _ _ (Submodule.coe_mem _) (pairMap_mem hjk (Bmap_mem hw hjk hc))
  intro a b p q
  unfold coord
  congr 1
  have hZ := phi_isSkew a b
  rw [Lop_spec, pairMap_apply_skew _ _ _ _ hZ]
  have hcong := HamiltonsCubic.TensorBridge.foxProd_congr_on_skew
    (X := fun A => diagW w A) (Y := fun A => pairMap j k c A)
    (X' := diagOp w) (Y' := pairVec j k c)
    (fun Z hZ' => by rw [diagW_apply_skew w Z hZ']; exact diagOp_skew w hw.symm Z hZ')
    (fun Z hZ' => by rw [pairMap_apply_skew j k c Z hZ']; exact pairVec_skew j k c Z)
    (fun Z hZ' => diagW_apply_skew w Z hZ') (fun Z hZ' => pairMap_apply_skew j k c Z hZ') (phi a b) hZ
  have hB : pairVec j k (fun m => ∑ i ∈ Sset j k, Lb w j k m i * c i) = pairVec j k (Bmap w j k c) :=
    pairVec_congr j k fun m hm => by
      show _ = (if m ∈ Sset j k then _ else _)
      rw [if_pos hm]
  rw [hcong, foxProd_pairVec hw.symm hw.hollow hjk c hZ, hB]

end HamiltonsCubic.B12Pair
