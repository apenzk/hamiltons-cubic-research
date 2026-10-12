import Mathlib
import HamiltonsCubic.Results.L224Rot
import HamiltonsCubic.Results.OddPart
import HamiltonsCubic.Results.PairConv
import HamiltonsCubic.Results.L57Diagonal
import HamiltonsCubic.Results.L222Op

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L222 item 1's rotation invariance: `𝒮_{jk} = 𝒟ₙ ⊕ V_{jk}` is preserved by rotations in the `(j, k)`-plane

[findings/second-order.md](../../../findings/second-order.md), Lemma L222, item 1: *$\mathcal S_{jk}$ is a subalgebra, preserved by
rotations in the $(j,k)$-plane.* The subalgebra clause is `Sjk_mul` in [L222Op.lean](L222Op.lean). The rotation clause, from
[L224Rot.lean](L224Rot.lean)'s finite action:

* `sum_vy`: `Σ_c vy f c = Σ f − f j − f k`;
* **`Sjk_rot`**: for `R = Rot_{jk}(c, s)`, `c² + s² = 1`, and `W = D + ν` with `D` Weyl of character `1` and `ν` Weyl of
  character `ε_j ε_k`, `R · W = D' + ν'` with `D'` Weyl of character `1` and `ν'` Weyl of character `ε_j ε_k`. The weight of `D`
  splits as its swap-even part, fixed by `rot_even`, plus `D⁻_y` with `y_a = (w_{ja} − w_{ka})/2`, which `rot_Dminus` turns into
  `D⁻_y` and `ν_y`; `ν = ν_x` turns into `ν_x` and `D⁻_x` by `rot_nuX`.

"Preserved" is read as mapped into. Onto follows from the inverse rotation `Rot_{jk}(c, −s)`.
-/

namespace HamiltonsCubic.L222Rot

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FrameOp2 HamiltonsCubic.L224Rot
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L222Op HamiltonsCubic.FamilyLayer

variable {n : ℕ} {j k : Fin n}

theorem sum_vy (hjk : j ≠ k) (f : Fin n → ℝ) : ∑ c, vy j k f c = ∑ c, f c - f j - f k := by
  have e : ∀ c, vy j k f c = f c - (if c = j then f j else 0) - (if c = k then f k else 0) := fun c => by
    unfold vy
    by_cases h1 : c = j
    · subst h1; simp [hjk]
    · by_cases h2 : c = k
      · subst h2; simp [Ne.symm hjk]
      · simp [h1, h2]
  simp only [e, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]

/-- **L222 item 1's rotation invariance.** -/
theorem Sjk_rot (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D)
    (hD : SignChar (fun _ => 1) D) (hνW : IsWeyl2 ν) (hν : SignChar (setChar {j, k}) ν) :
    ∃ D' ν' : CurvOp2 (Fin n), IsWeyl2 D' ∧ SignChar (fun _ => 1) D' ∧ IsWeyl2 ν' ∧ SignChar (setChar {j, k}) ν' ∧
      rotR (Rot j k c s) (D + ν) = D' + ν' := by
  obtain ⟨w, hw, rfl⟩ := (HamiltonsCubic.L120Ident.trivial_block_iff D hDW).mp hD
  rw [← coordOp_eq_restrict hw]
  obtain ⟨x, hxj, hxk, hxs, rfl⟩ := HamiltonsCubic.PairIdent.pair_eq_nuX hjk hνW hν
  set y : Fin n → ℝ := fun a => (w j a - w k a) / 2 with hydef
  -- the odd part is a weight
  have hys : ∑ c, vy j k y c = 0 := by
    rw [sum_vy hjk]
    have hr := hw.rowSum j
    have hr' := hw.rowSum k
    have hsum : ∑ c, y c = (∑ c, w j c - ∑ c, w k c) / 2 := by
      rw [hydef, ← Finset.sum_sub_distrib, Finset.sum_div]
    rw [hsum, hr, hr']
    simp only [hydef, hw.hollow j, hw.hollow k, hw.symm k j]
    ring
  have hxv : ∑ c, vy j k x c = 0 := by
    rw [HamiltonsCubic.PairIdent.vy_of_zero x hxj hxk]; exact hxs
  have hDy := HamiltonsCubic.OddPart.Dminus_weight hjk y hys
  have hDx := HamiltonsCubic.OddPart.Dminus_weight hjk x hxv
  -- the swap-even part
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
  -- the rotation
  have hrot : rotR (Rot j k c s) (coordOp w + nuX j k x)
      = (coordOp ev + (c ^ 2 - s ^ 2) • coordOp (Dminus j k y) + (-(2 * c * s)) • coordOp (Dminus j k x))
        + ((2 * c * s) • nuX j k y + (c ^ 2 - s ^ 2) • nuX j k x) := by
    rw [map_add, hsplit, map_add, rot_even hjk hcs ev hevT hevs, rot_Dminus hjk hcs y, rot_nuX hjk hcs x]
    abel
  -- `D'`: a weight
  have hw' : IsWeight (w + (-1 : ℝ) • Dminus j k y + (c ^ 2 - s ^ 2) • Dminus j k y + (-(2 * c * s)) • Dminus j k x) :=
    HamiltonsCubic.L57Critical.isWeight_add_smul (HamiltonsCubic.L57Critical.isWeight_add_smul
      (HamiltonsCubic.L57Critical.isWeight_add_smul hw hDy (-1)) hDy _) hDx _
  have hD'eq : coordOp ev + (c ^ 2 - s ^ 2) • coordOp (Dminus j k y) + (-(2 * c * s)) • coordOp (Dminus j k x)
      = coordOp (w + (-1 : ℝ) • Dminus j k y + (c ^ 2 - s ^ 2) • Dminus j k y + (-(2 * c * s)) • Dminus j k x) := by
    rw [coordOp_add, coordOp_add, coordOp_add, coordOp_smul', coordOp_smul', coordOp_smul', hev, sub_eq_add_neg,
      coordOp_add, ← neg_one_smul ℝ (Dminus j k y), coordOp_smul']
  -- `ν'`: in `V_{jk}`
  have hvv' : vy j k (vy j k y) = vy j k y := by
    funext i; unfold vy; split_ifs <;> rfl
  have hyy : nuX j k y = nuX j k (vy j k y) := by
    unfold nuX
    simp only [hvv']
  have hvj : vy j k y j = 0 := by simp [vy]
  have hvk : vy j k y k = 0 := by simp [vy]
  have hvs : ∑ i, vy j k y i = 0 := hys
  have hνy := HamiltonsCubic.PairConv.nuX_char hjk (vy j k y) hvj hvk hvs
  have hνyW : IsWeyl2 (nuX j k (vy j k y)) := by
    have hvv : ∑ c, vy j k (vy j k y) c = 0 := by
      rw [HamiltonsCubic.PairIdent.vy_of_zero _ hvj hvk]; exact hvs
    exact HamiltonsCubic.PairConv.nuX_weyl hjk _ hvv
  have hνx := HamiltonsCubic.PairConv.nuX_char hjk x hxj hxk hxs
  refine ⟨coordOp (w + (-1 : ℝ) • Dminus j k y + (c ^ 2 - s ^ 2) • Dminus j k y + (-(2 * c * s)) • Dminus j k x),
    (2 * c * s) • nuX j k y + (c ^ 2 - s ^ 2) • nuX j k x, ?_, ?_, ?_, ?_, by rw [hrot, hD'eq]⟩
  · rw [coordOp_eq_restrict hw']; exact isWeyl2_restrict _
  · rw [coordOp_eq_restrict hw']
    exact (HamiltonsCubic.L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw', rfl⟩
  · rw [hyy]; exact isWeyl2_add (isWeyl2_smul _ hνyW) (isWeyl2_smul _ hνW)
  · rw [hyy]; exact signChar_add (signChar_smul hνy _) (signChar_smul hνx _)

end HamiltonsCubic.L222Rot
