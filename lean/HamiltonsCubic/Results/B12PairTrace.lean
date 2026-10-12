import HamiltonsCubic.Results.B12Pair

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 4b: the pair block's square has trace `∑ Lb² − ¼ w_jk²` on the Ricci cut

[B12Pair.lean](B12Pair.lean) gives `L_e` on a pair sector as `Bmap`, the pair block `Lb` on `S = Sset j k`. The sector is the
Ricci cut, the vectors supported on `S` with zero sum, and the constant vector `𝟏_S` is the one direction of `ℝ^S` it
leaves out. `Lb` is symmetric with every column summing to `−½ w_jk`, so `B 𝟏_S = −½ w_jk 𝟏_S`, and the trace on the cut is
the trace on `ℝ^S` less that one eigenvalue squared:

* **`Pcut`**, `c ↦ c − c̄_S 𝟏_S` on `S` and `0` off it, and **`mem_range_Pcut`**: its range is the Ricci cut;
* `Pcut_idem`, **`Bmap_Pcut`**: it is idempotent and commutes with `Bmap`;
* **`trace_B2_Pcut`**: `tr(B² ∘ Pcut) = ∑_{m,i∈S} Lb_{mi}² − ¼ w_jk²`, in the standard basis of `Fin n → ℝ`;
* **`trace_B2_cut`**: so the trace of `B²` on the Ricci cut is that value, by
  [B12Restrict.lean](B12Restrict.lean)'s `trace_comp_idem`.
-/

namespace HamiltonsCubic.B12PairTrace

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.B12Pair
  HamiltonsCubic.L122Statement HamiltonsCubic.L121Block HamiltonsCubic.B12Restrict

variable {n : ℕ}

/-- The indicator of `S`. -/
def oneS (j k : Fin n) : Fin n → ℝ := fun x => if x ∈ Sset j k then 1 else 0

/-- **The projection onto the Ricci cut.** -/
noncomputable def Pcut (j k : Fin n) : (Fin n → ℝ) →ₗ[ℝ] (Fin n → ℝ) where
  toFun c x := if x ∈ Sset j k then c x - (∑ i ∈ Sset j k, c i) / (Sset j k).card else 0
  map_add' c d := by
    funext x; simp only [Pi.add_apply]
    split_ifs
    · rw [Finset.sum_add_distrib]; ring
    · ring
  map_smul' r c := by
    funext x; simp only [Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    split_ifs
    · rw [← Finset.mul_sum]; ring
    · ring

theorem Pcut_apply (j k : Fin n) (c : Fin n → ℝ) (x : Fin n) :
    Pcut j k c x = if x ∈ Sset j k then c x - (∑ i ∈ Sset j k, c i) / (Sset j k).card else 0 := rfl

theorem Bmap_apply (w : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) (c : Fin n → ℝ) (x : Fin n) :
    Bmap w j k c x = if x ∈ Sset j k then ∑ i ∈ Sset j k, Lb w j k x i * c i else 0 := rfl

theorem card_ne {j k : Fin n} (hS : (Sset j k).Nonempty) : ((Sset j k).card : ℝ) ≠ 0 := by
  exact_mod_cast (Finset.card_pos.mpr hS).ne'

/-- **The range of `Pcut` is the Ricci cut.** -/
theorem mem_range_Pcut {j k : Fin n} (hS : (Sset j k).Nonempty) (c : Fin n → ℝ) :
    c ∈ LinearMap.range (Pcut j k) ↔ c ∈ LinearMap.ker (blockSums1 (univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i))) := by
  rw [mem_ker_blockSums1, filter_eq]
  have hs := card_ne hS
  constructor
  · rintro ⟨d, rfl⟩
    refine ⟨fun x hx => by rw [Pcut_apply, if_neg hx], ?_⟩
    rw [Finset.sum_congr rfl fun x hx => by rw [Pcut_apply, if_pos hx], Finset.sum_sub_distrib, Finset.sum_const,
      nsmul_eq_mul]
    field_simp
    ring
  · rintro ⟨h0, hsum⟩
    refine ⟨c, funext fun x => ?_⟩
    rw [Pcut_apply, hsum, zero_div, sub_zero]
    split_ifs with hx
    · rfl
    · exact (h0 x hx).symm

theorem Pcut_idem {j k : Fin n} (hS : (Sset j k).Nonempty) : Pcut j k ∘ₗ Pcut j k = Pcut j k := by
  apply LinearMap.ext; intro c
  obtain ⟨h0, hsum⟩ := (mem_ker_blockSums1 _ _).mp ((mem_range_Pcut hS _).mp ⟨c, rfl⟩)
  rw [filter_eq] at h0 hsum
  funext x
  rw [LinearMap.comp_apply, Pcut_apply, hsum, zero_div, sub_zero]
  split_ifs with hx
  · rfl
  · exact (h0 x hx).symm

theorem Lb_symm {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (j k m i : Fin n) : Lb w j k m i = Lb w j k i m := by
  unfold Lb
  by_cases h : m = i
  · subst h; rfl
  · rw [if_neg h, if_neg (Ne.symm h), hw.symm]

/-- Every row of `Lb` over `S` sums to `−½ w_jk` too. -/
theorem rowSum_Lb {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k) {m : Fin n}
    (hm : m ∈ Sset j k) : ∑ i ∈ Sset j k, Lb w j k m i = -(1 / 2) * w j k := by
  rw [Finset.sum_congr rfl fun i _ => Lb_symm hw j k m i]
  exact colSum_Lb hw hjk hm

/-- **`Pcut` commutes with `Bmap`.** -/
theorem Bmap_Pcut {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k) :
    Bmap w j k ∘ₗ Pcut j k = Pcut j k ∘ₗ Bmap w j k := by
  apply LinearMap.ext; intro c
  funext x
  simp only [LinearMap.comp_apply, Bmap_apply, Pcut_apply]
  split_ifs with hx
  · have e1 : ∑ i ∈ Sset j k, Lb w j k x i * (c i - (∑ i ∈ Sset j k, c i) / ((Sset j k).card : ℝ))
        = ∑ i ∈ Sset j k, Lb w j k x i * c i
          - (∑ i ∈ Sset j k, Lb w j k x i) * ((∑ i ∈ Sset j k, c i) / ((Sset j k).card : ℝ)) := by
      rw [Finset.sum_mul, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => by ring
    have e2 : ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb w j k m i * c i = -(1 / 2) * w j k * ∑ i ∈ Sset j k, c i := by
      rw [Finset.sum_comm]
      simp only [← Finset.sum_mul]
      rw [Finset.sum_congr rfl fun i hi => by rw [colSum_Lb hw hjk hi], Finset.mul_sum]
    have hrow := rowSum_Lb hw hjk hx
    linear_combination e1 + (1 / ((Sset j k).card : ℝ)) * e2
      - ((∑ i ∈ Sset j k, c i) / ((Sset j k).card : ℝ)) * hrow
  · rfl

theorem B2_Pcut {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k) :
    (Bmap w j k ∘ₗ Bmap w j k) ∘ₗ Pcut j k = Pcut j k ∘ₗ (Bmap w j k ∘ₗ Bmap w j k) := by
  rw [LinearMap.comp_assoc, Bmap_Pcut hw hjk, ← LinearMap.comp_assoc, Bmap_Pcut hw hjk, LinearMap.comp_assoc]

/-- The trace on `Fin n → ℝ` in the standard basis. -/
theorem trace_pi (f : (Fin n → ℝ) →ₗ[ℝ] (Fin n → ℝ)) :
    LinearMap.trace ℝ (Fin n → ℝ) f = ∑ m, f (Pi.single m 1) m := by
  rw [LinearMap.trace_eq_matrix_trace ℝ (Pi.basisFun ℝ (Fin n)), Matrix.trace]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Matrix.diag_apply, LinearMap.toMatrix_apply, Pi.basisFun_apply, Pi.basisFun_repr]

theorem Bmap_oneS {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k) :
    Bmap w j k (oneS j k) = (-(1 / 2) * w j k) • oneS j k := by
  funext x
  rw [Bmap_apply, Pi.smul_apply, smul_eq_mul, oneS]
  split_ifs with hx
  · rw [Finset.sum_congr rfl fun i hi => by rw [oneS, if_pos hi, mul_one], rowSum_Lb hw hjk hx, mul_one]
  · rw [mul_zero]

theorem Pcut_single {j k : Fin n} (m : Fin n) :
    Pcut j k (Pi.single m 1) = if m ∈ Sset j k then Pi.single m 1 - (1 / ((Sset j k).card : ℝ)) • oneS j k else 0 := by
  funext x
  rw [Pcut_apply]
  have hsum : ∑ i ∈ Sset j k, (Pi.single m (1 : ℝ) : Fin n → ℝ) i = if m ∈ Sset j k then 1 else 0 := by
    simp [Pi.single_apply, Finset.sum_ite_eq']
  rw [hsum]
  by_cases hm : m ∈ Sset j k
  · rw [if_pos hm, if_pos hm, Pi.sub_apply, Pi.smul_apply, smul_eq_mul, oneS]
    split_ifs with hx
    · ring
    · have hxm : x ≠ m := fun h => hx (h ▸ hm)
      simp [hxm]
  · rw [if_neg hm, if_neg hm, zero_div, sub_zero, Pi.zero_apply]
    split_ifs with hx
    · have hxm : x ≠ m := fun h => hm (h ▸ hx)
      simp [hxm]
    · rfl

theorem B_single {w : Matrix (Fin n) (Fin n) ℝ} {j k m : Fin n} (hm : m ∈ Sset j k) (x : Fin n) :
    Bmap w j k (Pi.single m 1) x = if x ∈ Sset j k then Lb w j k x m else 0 := by
  rw [Bmap_apply]
  split_ifs
  · rw [Finset.sum_eq_single m (fun i _ hi => by simp [hi]) (fun h => absurd hm h)]
    simp
  · rfl

/-- **`tr(B² ∘ Pcut) = ∑_{m,i∈S} Lb_{mi}² − ¼ w_jk²`.** -/
theorem trace_B2_Pcut {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k)
    (hS : (Sset j k).Nonempty) :
    LinearMap.trace ℝ (Fin n → ℝ) ((Bmap w j k ∘ₗ Bmap w j k) ∘ₗ Pcut j k)
      = ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb w j k m i ^ 2 - w j k ^ 2 / 4 := by
  have hs := card_ne hS
  rw [trace_pi]
  have hterm : ∀ m, ((Bmap w j k ∘ₗ Bmap w j k) ∘ₗ Pcut j k) (Pi.single m 1) m
      = if m ∈ Sset j k then ∑ i ∈ Sset j k, Lb w j k m i ^ 2 - (1 / ((Sset j k).card : ℝ)) * (w j k ^ 2 / 4) else 0 := by
    intro m
    rw [LinearMap.comp_apply, Pcut_single]
    by_cases hm : m ∈ Sset j k
    · rw [if_pos hm, if_pos hm, map_sub, map_smul, LinearMap.comp_apply, LinearMap.comp_apply, Bmap_oneS hw hjk,
        map_smul, Bmap_oneS hw hjk, Pi.sub_apply, Pi.smul_apply, Pi.smul_apply, Pi.smul_apply, smul_eq_mul,
        smul_eq_mul, smul_eq_mul, oneS, if_pos hm, Bmap_apply, if_pos hm]
      rw [Finset.sum_congr rfl fun i hi => by rw [B_single hm i, if_pos hi, Lb_symm hw j k i m]]
      simp only [sq]
      ring
    · rw [if_neg hm, if_neg hm, map_zero, Pi.zero_apply]
  rw [Finset.sum_congr rfl fun m _ => hterm m, Finset.sum_ite_mem, Finset.univ_inter, Finset.sum_sub_distrib,
    Finset.sum_const, nsmul_eq_mul]
  field_simp

/-- **The trace of `B²` on the Ricci cut.** -/
theorem trace_B2_cut {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {j k : Fin n} (hjk : j ≠ k)
    (hS : (Sset j k).Nonempty) :
    LinearMap.trace ℝ (LinearMap.range (Pcut j k))
        ((Bmap w j k ∘ₗ Bmap w j k).restrict (fun x hx => mapsTo_range (V := Fin n → ℝ) (A := Bmap w j k ∘ₗ Bmap w j k)
          (P := Pcut j k) (B2_Pcut hw hjk) hx))
      = ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb w j k m i ^ 2 - w j k ^ 2 / 4 := by
  rw [← trace_comp_idem _ _ (Pcut_idem hS) (B2_Pcut hw hjk), trace_B2_Pcut hw hjk hS]

end HamiltonsCubic.B12PairTrace
