import HamiltonsCubic.Results.B12Sectors
import HamiltonsCubic.Results.L120PairSign
import HamiltonsCubic.Results.L120Support

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 2: on `𝒲ₙ` the sectors vanish off `|t| ∈ {0, 2, 4}`

[L120Support.lean](L120Support.lean)'s `block_card` proves it for operators on `CurvOp2`. Here it is carried to the record's
`weylModuleS`, where [B12Sectors.lean](B12Sectors.lean)'s projectors `projS t` act, by the same two flips read on the
coordinates `coord R i j k l = ⟨R φ_ij, φ_kl⟩`:

* `char_coord`: a nonzero coordinate of `proj t Y` forces `∏_{i∈t} ε_i = ε_i ε_j ε_k ε_l` at every sign vector `ε`
  ([L120PairSign.lean](L120PairSign.lean)'s `coord_sign` against [L120Decomp.lean](L120Decomp.lean)'s `proj_signMat`);
* **`projS_card`**: `projS t Y ≠ 0` forces `|t| ∈ {0, 2, 4}`, the global flip making `|t|` even and a single flip off
  `{i, j, k, l}` putting `t` inside it;
* **`projS_eq_zero`**: so `projS t = 0` off `|t| ∈ {0, 2, 4}`, and **`trace_sq_support`** drops those sectors from
  `trace_sq_sectors`.
-/

namespace HamiltonsCubic.B12Support

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.L120Decomp HamiltonsCubic.L120HessPair
  HamiltonsCubic.B12Sectors

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem char_coord (t : Finset ι) (Y : CurvLin ι) {i j k l : ι} (hx : coord (proj t Y) i j k l ≠ 0)
    (ε : ι → ℝ) (hε : ∀ m, ε m * ε m = 1) :
    HamiltonsCubic.L120Blocks.setChar t ε = ε i * ε j * ε k * ε l := by
  have h1 := coord_sign ε (proj t Y) i j k l
  rw [proj_signMat t Y ε hε, coord_smul] at h1
  exact mul_right_cancel₀ hx h1

/-- **A nonzero sector has `|t| ∈ {0, 2, 4}`.** -/
theorem projS_card (t : Finset ι) (Y : weylModuleS ι) (h0 : projS t Y ≠ 0) :
    t.card = 0 ∨ t.card = 2 ∨ t.card = 4 := by
  have hB : proj t (Y : CurvLin ι) ∈ weylModuleS ι := proj_mem t Y.2
  obtain ⟨i, j, k, l, hx⟩ : ∃ i j k l, coord (proj t (Y : CurvLin ι)) i j k l ≠ 0 := by
    by_contra hall
    push_neg at hall
    exact h0 (Subtype.ext (by rw [projS_coe]; exact cd_ext _ hB hall))
  have heven : Even t.card := by
    have h := char_coord t Y hx (fun _ => -1) (fun _ => by norm_num)
    simp only [HamiltonsCubic.L120Blocks.setChar, Finset.prod_const] at h
    norm_num at h
    exact (neg_one_pow_eq_one_iff_even (by norm_num)).mp h
  have hsub : t ⊆ {i, j, k, l} := by
    intro m hm
    by_contra hout
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hout
    obtain ⟨hi, hj, hk, hl⟩ := hout
    have h := char_coord t Y hx (fun a => if a = m then -1 else 1) (fun a => by beta_reduce; split_ifs <;> norm_num)
    simp only [HamiltonsCubic.L120Blocks.setChar, Finset.prod_ite_eq', if_pos hm, if_neg (Ne.symm hi),
      if_neg (Ne.symm hj), if_neg (Ne.symm hk), if_neg (Ne.symm hl)] at h
    norm_num at h
  have hle := (Finset.card_le_card hsub).trans (HamiltonsCubic.L120Support.card_four_le i j k l)
  obtain ⟨r, hr⟩ := heven
  omega

/-- **`projS t = 0` off `|t| ∈ {0, 2, 4}`.** -/
theorem projS_eq_zero (t : Finset ι) (ht : ¬ (t.card = 0 ∨ t.card = 2 ∨ t.card = 4)) : projS t = 0 := by
  apply LinearMap.ext; intro Y
  by_contra h
  exact ht (projS_card t Y h)

/-- **`tr(L_e²)` over the sectors that survive**, `|t| ∈ {0, 2, 4}`. -/
theorem trace_sq_support (e : weylModuleS ι) (he : ∀ u : Finset ι, act (diagSet u) (e : CurvLin ι) = e) :
    LinearMap.trace ℝ (weylModuleS ι) (Lop e ∘ₗ Lop e)
      = ∑ t ∈ Finset.univ.filter (fun t : Finset ι => t.card = 0 ∨ t.card = 2 ∨ t.card = 4),
          LinearMap.trace ℝ (weylModuleS ι) (Lop e ∘ₗ Lop e ∘ₗ projS t) := by
  rw [(trace_sq_sectors e he).1, Finset.sum_filter]
  refine Finset.sum_congr rfl fun t _ => ?_
  split_ifs with ht
  · rfl
  · rw [projS_eq_zero t ht, LinearMap.comp_zero, LinearMap.comp_zero, map_zero]

end HamiltonsCubic.B12Support
