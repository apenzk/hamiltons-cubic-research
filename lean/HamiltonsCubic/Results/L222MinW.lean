import Mathlib
import HamiltonsCubic.Results.L222Min

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L222 item 5 on the rotated tensor itself: the minimising angle stated through `R · W = D' + ν'`

[L222Min.lean](L222Min.lean)'s `L222_min` takes the rotated pair part in its explicit form `2cs ν_y + (c² − s²) ν_x`, the identification
with "the `ν` of the rotated tensor" being L222Rot's computation, read rather than typed ([r1876](../../../reviews/REVIEW_r1876.md) O1, O2).
Here both are typed:

* **`odd_sum_zero`**: at a weight `w`, `Σ_c vy(y)_c = 0` for `y_a = (w_{ja} − w_{ka})/2`;
* **`rot_formula`**: `R · (coordOp w + ν_x) = coordOp w' + (2cs ν_y + (c² − s²) ν_x)` with `w'` a weight;
* **`pair_part_unique`**: two splits of one operator into characters `1` and `ε_j ε_k` have the same pair part;
* **`L222_min_W`**: when at every rotation `R` every split `R · W = D' + ν'` (`D'` of character `1`, `ν'` of character `ε_j ε_k`) has
  `‖ν_x‖² ≤ ‖ν'‖²`, the record's two conclusions hold;
* **`hmin_iff`**: that hypothesis is equivalent to `L222_min`'s explicit one, through `rot_formula` and `pair_part_unique`.

`Sjk_rot` in [L222Rot.lean](L222Rot.lean) repeats `rot_formula`'s derivation and could be proved from it (r1879 O2).
-/

namespace HamiltonsCubic.L222MinW

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FrameOp2 HamiltonsCubic.L224Rot
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L222Op HamiltonsCubic.FamilyLayer

variable {n : ℕ} {j k : Fin n}

/-- **The odd part of a weight sums to zero.** -/
theorem odd_sum_zero (hjk : j ≠ k) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) :
    ∑ c, vy j k (fun a => (w j a - w k a) / 2) c = 0 := by
  rw [HamiltonsCubic.L222Rot.sum_vy hjk]
  have hr := hw.rowSum j
  have hr' := hw.rowSum k
  have hsum : ∑ c, (fun a => (w j a - w k a) / 2) c = (∑ c, w j c - ∑ c, w k c) / 2 := by
    rw [← Finset.sum_sub_distrib, Finset.sum_div]
  rw [hsum, hr, hr']
  simp only [hw.hollow j, hw.hollow k, hw.symm k j]
  ring

/-- **The rotation, explicitly.** -/
theorem rot_formula (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w)
    (x : Fin n → ℝ) (hxv : ∑ c, vy j k x c = 0) :
    ∃ w' : Matrix (Fin n) (Fin n) ℝ, IsWeight w' ∧
      rotR (Rot j k c s) (coordOp w + nuX j k x)
        = coordOp w' + ((2 * c * s) • nuX j k (fun a => (w j a - w k a) / 2) + (c ^ 2 - s ^ 2) • nuX j k x) := by
  set y : Fin n → ℝ := fun a => (w j a - w k a) / 2 with hydef
  have hys := odd_sum_zero hjk hw
  have hDy := HamiltonsCubic.OddPart.Dminus_weight hjk y hys
  have hDx := HamiltonsCubic.OddPart.Dminus_weight hjk x hxv
  set ev : Matrix (Fin n) (Fin n) ℝ := w - Dminus j k y with hev
  have hevT : evᵀ = ev := by
    ext p q
    simp only [hev, Matrix.transpose_apply, Matrix.sub_apply, hw.symm q p, hDy.symm q p]
  have hevs : ∀ a, a ≠ j → a ≠ k → ev j a = ev k a := by
    intro a haj hak
    simp only [hev, Matrix.sub_apply, Dminus, Matrix.add_apply, Matrix.vecMulVec_apply, uj, vy, hydef,
      if_pos rfl, if_neg haj, if_neg hak, Ne.symm hjk, if_neg (Ne.symm hjk), if_pos rfl]
    simp [haj, hak, hjk, Ne.symm hjk]
    ring
  have hsplit : coordOp w = coordOp ev + coordOp (Dminus j k y) := by
    rw [← coordOp_add, hev, sub_add_cancel]
  refine ⟨w + (-1 : ℝ) • Dminus j k y + (c ^ 2 - s ^ 2) • Dminus j k y + (-(2 * c * s)) • Dminus j k x,
    HamiltonsCubic.L57Critical.isWeight_add_smul (HamiltonsCubic.L57Critical.isWeight_add_smul
      (HamiltonsCubic.L57Critical.isWeight_add_smul hw hDy (-1)) hDy _) hDx _, ?_⟩
  rw [map_add, hsplit, map_add, rot_even hjk hcs ev hevT hevs, rot_Dminus hjk hcs y, rot_nuX hjk hcs x]
  rw [coordOp_add, coordOp_add, coordOp_add, coordOp_smul', coordOp_smul', coordOp_smul', hsplit]
  module

/-- **The pair part of a character split is unique.** -/
theorem pair_part_unique (hjk : j ≠ k) {A B A' B' : CurvOp2 (Fin n)} (hA : SignChar (fun _ => 1) A)
    (hB : SignChar (setChar {j, k}) B) (hA' : SignChar (fun _ => 1) A') (hB' : SignChar (setChar {j, k}) B')
    (h : A + B = A' + B') : B = B' := by
  have h0 : (A + (-1 : ℝ) • A') + (B + (-1 : ℝ) • B') = 0 := by
    have e : (A + (-1 : ℝ) • A') + (B + (-1 : ℝ) • B') = (A + B) + (-1 : ℝ) • (A' + B') := by module
    rw [e, h]; module
  have := (char_split_zero hjk (signChar_add hA (signChar_smul hA' _)) (signChar_add hB (signChar_smul hB' _)) h0).2
  have e2 : B = (B + (-1 : ℝ) • B') + B' := by module
  rw [e2, this]; module

/-- **L222 item 5 on the rotated tensor.** -/
theorem L222_min_W (hjk : j ≠ k) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {x : Fin n → ℝ} (hxj : x j = 0)
    (hxk : x k = 0) (hxs : ∑ i, x i = 0)
    (hmin : ∀ c s : ℝ, c ^ 2 + s ^ 2 = 1 → ∀ D' ν' : CurvOp2 (Fin n), SignChar (fun _ => 1) D' →
      SignChar (setChar {j, k}) ν' → rotR (Rot j k c s) (coordOp w + nuX j k x) = D' + ν' →
      normSq2 (nuX j k x) ≤ normSq2 ν') :
    ∑ a, x a * (w j a - w k a) = 0 ∧
      normSq2 (nuX j k x) ≤ 1 / 2 * ∑ a, vy j k (fun a => w k a - w j a) a ^ 2 := by
  have hxv : ∑ c, vy j k x c = 0 := by rw [HamiltonsCubic.PairIdent.vy_of_zero x hxj hxk]; exact hxs
  have hys := odd_sum_zero hjk hw
  set y : Fin n → ℝ := fun a => (w j a - w k a) / 2 with hydef
  have hvj : vy j k y j = 0 := by simp [vy]
  have hvk : vy j k y k = 0 := by simp [vy]
  have hνy : SignChar (setChar {j, k}) (nuX j k y) := by
    have e : nuX j k y = nuX j k (vy j k y) := by unfold nuX; simp only [HamiltonsCubic.L222Min.vy_vy]
    rw [e]; exact HamiltonsCubic.PairConv.nuX_char hjk (vy j k y) hvj hvk hys
  have hνx := HamiltonsCubic.PairConv.nuX_char hjk x hxj hxk hxs
  refine HamiltonsCubic.L222Min.L222_min hjk w hxj hxk hxs hys fun c s hcs => ?_
  obtain ⟨w', hw', hrot⟩ := rot_formula hjk hcs hw x hxv
  have hD' : SignChar (fun _ => 1) (coordOp w') := by
    rw [coordOp_eq_restrict hw']
    exact (HamiltonsCubic.L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw', rfl⟩
  exact hmin c s hcs _ _ hD' (signChar_add (signChar_smul hνy _) (signChar_smul hνx _)) hrot

/-- **"Every split" and "the split" coincide** (r1879 O1): the minimising-angle hypothesis over all character splits of `R · W` is
the explicit one of `L222_min`. -/
theorem hmin_iff (hjk : j ≠ k) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {x : Fin n → ℝ} (hxj : x j = 0)
    (hxk : x k = 0) (hxs : ∑ i, x i = 0) :
    (∀ c s : ℝ, c ^ 2 + s ^ 2 = 1 → ∀ D' ν' : CurvOp2 (Fin n), SignChar (fun _ => 1) D' →
      SignChar (setChar {j, k}) ν' → rotR (Rot j k c s) (coordOp w + nuX j k x) = D' + ν' →
      normSq2 (nuX j k x) ≤ normSq2 ν') ↔
    (∀ c s : ℝ, c ^ 2 + s ^ 2 = 1 →
      normSq2 (nuX j k x) ≤ normSq2 ((2 * c * s) • nuX j k (fun a => (w j a - w k a) / 2) + (c ^ 2 - s ^ 2) • nuX j k x)) := by
  have hxv : ∑ c, vy j k x c = 0 := by rw [HamiltonsCubic.PairIdent.vy_of_zero x hxj hxk]; exact hxs
  have hys := odd_sum_zero hjk hw
  set y : Fin n → ℝ := fun a => (w j a - w k a) / 2 with hydef
  have hvj : vy j k y j = 0 := by simp [vy]
  have hvk : vy j k y k = 0 := by simp [vy]
  have hνy : SignChar (setChar {j, k}) (nuX j k y) := by
    have e : nuX j k y = nuX j k (vy j k y) := by unfold nuX; simp only [HamiltonsCubic.L222Min.vy_vy]
    rw [e]; exact HamiltonsCubic.PairConv.nuX_char hjk (vy j k y) hvj hvk hys
  have hνx := HamiltonsCubic.PairConv.nuX_char hjk x hxj hxk hxs
  have hsplit : ∀ c s : ℝ, c ^ 2 + s ^ 2 = 1 → ∃ w' : Matrix (Fin n) (Fin n) ℝ, SignChar (fun _ => 1) (coordOp w') ∧
      rotR (Rot j k c s) (coordOp w + nuX j k x)
        = coordOp w' + ((2 * c * s) • nuX j k y + (c ^ 2 - s ^ 2) • nuX j k x) := by
    intro c s hcs
    obtain ⟨w', hw', hrot⟩ := rot_formula hjk hcs hw x hxv
    refine ⟨w', ?_, hrot⟩
    rw [coordOp_eq_restrict hw']
    exact (HamiltonsCubic.L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw', rfl⟩
  constructor
  · intro h c s hcs
    obtain ⟨w', hD', hrot⟩ := hsplit c s hcs
    exact h c s hcs _ _ hD' (signChar_add (signChar_smul hνy _) (signChar_smul hνx _)) hrot
  · intro h c s hcs D' ν' hD' hν' hrot'
    obtain ⟨w', hD, hrot⟩ := hsplit c s hcs
    have e := pair_part_unique hjk hD' hν' hD (signChar_add (signChar_smul hνy _) (signChar_smul hνx _))
      (hrot'.symm.trans hrot)
    rw [e]; exact h c s hcs

end HamiltonsCubic.L222MinW
