import HamiltonsCubic.Results.L120PairDim

set_option linter.style.longLine false

/-!
# L120's pair summand at the full sign group

[L120Pair.lean](L120Pair.lean) proves the pair summand's identification with flip isotypy, and its forward direction
from isotypy under the whole diagonal sign group `Γ = {diag(ε) : ε_i = ±1}`. This file gives the converse at `Γ`, so
the summand is characterised by L120's own hypothesis in both directions:

* **`rot_sign`**, **`coord_sign`**: `diag(ε)` rescales `φ_{ab}` by `ε_a ε_b`, so it rescales the coordinate `R_{abcd}`
  by `ε_a ε_b ε_c ε_d`;
* **`pairForm_parity_sign`**: a `PairForm` position carries `ε_j ε_k`;
* **`pairS_iso_signMat`**: the pair-span operator on the Ricci cut is `Γ`-isotypic with character `ε_j ε_k`;
* **`pairSummand_mem_signMat`**: the image of the Ricci-cut coefficient space is exactly the members of `weylModuleS`
  that are `Γ`-isotypic with character `ε_j ε_k`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `diag(ε)` rescales `φ_{ij}` by `ε_i ε_j`. -/
theorem rot_sign (ε : ι → ℝ) (i j : ι) : (signMat ε).transpose * phi i j * signMat ε = (ε i * ε j) • phi i j := by
  rw [rot_phi]
  rw [Finset.sum_eq_single i]
  · rw [Finset.sum_eq_single j]
    · simp [signMat, Matrix.diagonal_apply]
    · intro b _ hb; simp [signMat, Matrix.diagonal_apply, Ne.symm hb]
    · simp
  · intro a _ ha
    apply Finset.sum_eq_zero; intro b _
    simp [signMat, Matrix.diagonal_apply, Ne.symm ha]
  · simp

/-- **The coordinate law at a sign matrix.** -/
theorem coord_sign (ε : ι → ℝ) (R : CurvLin ι) (i j k l : ι) :
    coord (act (signMat ε) R) i j k l = ε i * ε j * ε k * ε l * coord R i j k l := by
  unfold coord
  rw [act_apply, inner2_conj, rot_sign, rot_sign, map_smul, inner2_smul_left'', inner2_smul_right'']
  ring

omit [Fintype ι] [DecidableEq ι] in
/-- **A `PairForm` position carries the character `ε_j ε_k`**, at `ε_y² = 1`. -/
theorem pairForm_parity_sign (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) {j k a b c d : ι} (h : PairForm j k a b c d) :
    ε a * ε b * ε c * ε d = ε j * ε k := by
  obtain ⟨y, _, _, h⟩ := h
  have hy := hε y
  rcases h with ⟨hab, hcd⟩ | ⟨hab, hcd⟩ <;>
    rcases hab with ⟨ha, hb⟩ | ⟨ha, hb⟩ <;> rcases hcd with ⟨hc, hd⟩ | ⟨hc, hd⟩ <;> rw [ha, hb, hc, hd] <;>
    linear_combination (ε j * ε k) * hy

variable {n : ℕ}

/-- **The pair-span operator on the Ricci cut is `Γ`-isotypic** with character `ε_j ε_k`. -/
theorem pairS_iso_signMat {j k : Fin n} (hjk : j ≠ k) (c : Fin n → ℝ)
    (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) (ε : Fin n → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    act (signMat ε) (pairMap j k c) = (ε j * ε k) • pairMap j k c := by
  have hS := pairS_mem hjk c hsum
  refine eq_of_coord _ _ (act_mem _ (signMat_orth ε hε).1 _ hS) (Submodule.smul_mem _ _ hS) fun a b p q => ?_
  rw [coord_sign, coord_smul]
  by_cases h0 : coord (pairMap j k c) a b p q = 0
  · rw [h0, mul_zero, mul_zero]
  · congr 1
    apply pairForm_parity_sign ε hε
    have h1 := iso_coord_form _ hS hjk (pairS_iso hjk c hsum) h0
    exact h1

/-- **The pair summand at L120's own hypothesis**: the image of the Ricci-cut coefficient space is exactly the members of
`weylModuleS` that are `Γ`-isotypic with character `ε_j ε_k`. -/
theorem pairSummand_mem_signMat {j k : Fin n} (hjk : j ≠ k) (R : CurvLin (Fin n)) :
    R ∈ (LinearMap.ker (blockSums1 (univ.filter (fun i => j ≠ i ∧ k ≠ i)))).map (pairMap j k)
      ↔ R ∈ weylModuleS (Fin n)
        ∧ ∀ ε : Fin n → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) R = (ε j * ε k) • R := by
  constructor
  · intro hR
    obtain ⟨c, hc, rfl⟩ := Submodule.mem_map.mp hR
    rw [mem_ker_blockSums1] at hc
    exact ⟨pairS_mem hjk c hc.2, fun ε hε => pairS_iso_signMat hjk c hc.2 ε hε⟩
  · rintro ⟨hR, hiso⟩
    exact (pairSummand_mem hjk R).mpr ⟨hR, fun m => hiso (sgn m) (sgn_mul_self m)⟩

end HamiltonsCubic.Results
