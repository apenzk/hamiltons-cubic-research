import Mathlib
import HamiltonsCubic.Results.L228Item2
import HamiltonsCubic.Results.L57BlockConj

set_option linter.style.longLine false

/-!
# L228 item 3: one block against a common frame

[findings/second-order.md](../../../findings/second-order.md), Lemma L228, item 3: *"If the blocks $X_c$, $c\ne a$,
are simultaneously diagonal in one orthonormal frame of $\mathbb R^J$, then $P(W)\le\Theta_n\lVert W\rVert^3$."*
The proof: item 2 writes $P(W)=6\operatorname{tr}Y_a^3+\operatorname{tr}(Y_a\ell'_a)+c_a$ and
$\lVert W\rVert^2=2\lvert Y_a\rvert^2+n_a$ with $\ell'_a$ diagonal in the frame; alignment replaces $Y_a$ by $Y'$
diagonal in the frame with the same $\operatorname{tr}Y$, $\operatorname{tr}Y^2$, $\operatorname{tr}Y^3$ and no
smaller pairing with $\ell'_a$; the operator $W'$ with $X'_a=Y'-\tfrac12R_a$ has every block diagonal in the frame,
the same norm, no smaller $P$, and is Ricci-flat; L57 bounds it. This file, at the block `a = 0`:

* `DiagIn` and its closure lemmas: a matrix diagonal in the frame `F`;
* `L228_item3_of`: the item for any bound its diagonal tensors obey, through [L228Item2.lean](L228Item2.lean)'s
  `L228_item2`, [L228Statement.lean](L228Statement.lean)'s `align_to_frame` and
  [L57BlockConj.lean](L57BlockConj.lean)'s `L57_block_conj_of`;
* `L228_item3`, `L228_item3_odd`: with `θ₀(n)`, the record's `Θₙ` at even `n`, and with the record's odd `Θₙ` at
  odd `n ≥ 5`.
-/

namespace HamiltonsCubic.L228Item3

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L228Statement
  HamiltonsCubic.L228Item1 HamiltonsCubic.L228Item2 HamiltonsCubic.L57Block HamiltonsCubic.L57BlockConj
  HamiltonsCubic.L226Mixed

variable {m : ℕ}

/-- `A` is diagonal in the frame `F`. -/
def DiagIn (F A : Matrix (Fin 3) (Fin 3) ℝ) : Prop := ∀ x y, x ≠ y → (Fᵀ * A * F) x y = 0

section Diag
variable {F : Matrix (Fin 3) (Fin 3) ℝ}

theorem diagIn_add {A B : Matrix (Fin 3) (Fin 3) ℝ} (hA : DiagIn F A) (hB : DiagIn F B) : DiagIn F (A + B) :=
  fun x y h => by rw [Matrix.mul_add, Matrix.add_mul, Matrix.add_apply, hA x y h, hB x y h, add_zero]

theorem diagIn_sub {A B : Matrix (Fin 3) (Fin 3) ℝ} (hA : DiagIn F A) (hB : DiagIn F B) : DiagIn F (A - B) :=
  fun x y h => by rw [Matrix.mul_sub, Matrix.sub_mul, Matrix.sub_apply, hA x y h, hB x y h, sub_zero]

theorem diagIn_smul (c : ℝ) {A : Matrix (Fin 3) (Fin 3) ℝ} (hA : DiagIn F A) : DiagIn F (c • A) :=
  fun x y h => by rw [Matrix.mul_smul, Matrix.smul_mul, Matrix.smul_apply, hA x y h, smul_zero]

theorem diagIn_sum {ι : Type*} (s : Finset ι) (A : ι → Matrix (Fin 3) (Fin 3) ℝ) (hA : ∀ i, DiagIn F (A i)) :
    DiagIn F (∑ i ∈ s, A i) :=
  fun x y h => by
    rw [Matrix.mul_sum, Matrix.sum_mul, Matrix.sum_apply]
    exact Finset.sum_eq_zero fun i _ => hA i x y h

theorem diagIn_one (hF1 : Fᵀ * F = 1) : DiagIn F 1 :=
  fun x y h => by rw [Matrix.mul_one, hF1, Matrix.one_apply_ne h]

theorem diagIn_mul (hF2 : F * Fᵀ = 1) {A B : Matrix (Fin 3) (Fin 3) ℝ} (hA : DiagIn F A) (hB : DiagIn F B) :
    DiagIn F (A * B) := fun x y h => by
  rw [← conj_mul hF2, Matrix.mul_apply]
  refine Finset.sum_eq_zero fun z _ => ?_
  by_cases hz : z = x
  · subst hz; rw [hB z y h, mul_zero]
  · rw [hA x z (Ne.symm hz), zero_mul]

theorem diagIn_inFrame (hF1 : Fᵀ * F = 1) (y : Fin 3 → ℝ) : DiagIn F (inFrame F y) := fun x z h => by
  unfold inFrame
  rw [show Fᵀ * (F * diagonal y * Fᵀ) * F = (Fᵀ * F) * diagonal y * (Fᵀ * F) by simp only [Matrix.mul_assoc],
    hF1, Matrix.one_mul, Matrix.mul_one, Matrix.diagonal_apply_ne _ h]

/-- A matrix diagonal in `F` is `inFrame F` of its diagonal in that frame. -/
theorem eq_inFrame (hF2 : F * Fᵀ = 1) {A : Matrix (Fin 3) (Fin 3) ℝ} (hA : DiagIn F A) :
    A = inFrame F (fun x => (Fᵀ * A * F) x x) := by
  have hd : Fᵀ * A * F = diagonal (fun x => (Fᵀ * A * F) x x) := by
    ext x y
    by_cases h : x = y
    · subst h; rw [Matrix.diagonal_apply_eq]
    · rw [Matrix.diagonal_apply_ne _ h, hA x y h]
  unfold inFrame
  rw [← hd, show F * (Fᵀ * A * F) * Fᵀ = (F * Fᵀ) * A * (F * Fᵀ) by simp only [Matrix.mul_assoc], hF2,
    Matrix.one_mul, Matrix.mul_one]

end Diag

theorem isSymm_sum {ι : Type*} (s : Finset ι) (A : ι → Matrix (Fin 3) (Fin 3) ℝ) (hA : ∀ i, (A i).IsSymm) :
    (∑ i ∈ s, A i).IsSymm := by
  unfold Matrix.IsSymm
  rw [Matrix.transpose_sum]
  exact Finset.sum_congr rfl fun i _ => (hA i).eq

theorem inFrame_isSymm (F : Matrix (Fin 3) (Fin 3) ℝ) (y : Fin 3 → ℝ) : (inFrame F y).IsSymm := by
  unfold Matrix.IsSymm inFrame
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.diagonal_transpose,
    Matrix.mul_assoc]

/-- **L228 item 3 for any diagonal bound**, at the block `a = 0`: if the other blocks are simultaneously diagonal in
one orthonormal frame `F` of `ℝ^J` and every weight's diagonal tensor obeys `P ≤ c ‖·‖³`, a Ricci-flat `W` obeys it. -/
theorem L228_item3_of (c : ℝ)
    (hc : ∀ w : Matrix (Fin 3 ⊕ Fin (m + 1)) (Fin 3 ⊕ Fin (m + 1)) ℝ, HamiltonsCubic.FamilyLayer.IsWeight w →
      Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) ≤ c * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3)
    (t : Fin (m + 1) → ℝ) (Xs : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 1) → Fin (m + 1) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hdiag : ∀ i : Fin m, DiagIn F (Xs i.succ)) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ c * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
          (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 := by
  obtain ⟨hP, hN⟩ := L228_item2 t Xs hX hXs K hK hK0
  set R := ∑ i : Fin m, Xs i.succ with hR
  set T := ∑ i : Fin m, Xs i.succ * Xs i.succ with hT
  set Bm := ∑ i : Fin m, beta t K 0 i.succ • Xs i.succ with hBm
  set Y := Xs 0 + (1 / 2 : ℝ) • R with hY
  set ℓ := (3 / 2 : ℝ) • (R * R) + (3 : ℝ) • T + (2 : ℝ) • Bm with hℓ
  have hRd : DiagIn F R := diagIn_sum _ _ hdiag
  have hTd : DiagIn F T := diagIn_sum _ _ fun i => diagIn_mul hF2 (hdiag i) (hdiag i)
  have hBd : DiagIn F Bm := diagIn_sum _ _ fun i => diagIn_smul _ (hdiag i)
  have hℓd : DiagIn F ℓ :=
    diagIn_add (diagIn_add (diagIn_smul _ (diagIn_mul hF2 hRd hRd)) (diagIn_smul _ hTd)) (diagIn_smul _ hBd)
  have hℓl := eq_inFrame hF2 hℓd
  set l := fun x => (Fᵀ * ℓ * F) x x with hl
  have hRs : R.IsSymm := isSymm_sum _ _ fun i => hXs i.succ
  have hYs : Y.IsSymm := by
    unfold Matrix.IsSymm
    rw [hY, Matrix.transpose_add, Matrix.transpose_smul, (hXs 0).eq, hRs.eq]
  obtain ⟨y, h3, h2, h1, hpair⟩ := align_to_frame F Y hF1 hF2 hYs l
  rw [← hℓl] at hpair
  set Y' := inFrame F y with hY'
  set Xs' : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ := Fin.cons (Y' - (1 / 2 : ℝ) • R) (fun i => Xs i.succ) with hXs'
  have hs0 : Xs' 0 = Y' - (1 / 2 : ℝ) • R := rfl
  have hss : ∀ i : Fin m, Xs' i.succ = Xs i.succ := fun i => rfl
  have hX' : ∀ a, (Xs' a).trace = 0 := by
    intro a
    refine Fin.cases ?_ (fun i => ?_) a
    · rw [hs0, Matrix.trace_sub, Matrix.trace_smul, h1, hY, Matrix.trace_add, Matrix.trace_smul, hX 0]
      simp only [smul_eq_mul]
      ring
    · rw [hss]; exact hX _
  have hXs'' : ∀ a, (Xs' a).IsSymm := by
    intro a
    refine Fin.cases ?_ (fun i => ?_) a
    · rw [hs0]
      unfold Matrix.IsSymm
      rw [Matrix.transpose_sub, Matrix.transpose_smul, (inFrame_isSymm F y).eq, hRs.eq]
    · rw [hss]; exact hXs _
  obtain ⟨hP', hN'⟩ := L228_item2 t Xs' hX' hXs'' K hK hK0
  simp only [hss, hs0] at hP' hN'
  rw [← hR, ← hT, ← hBm, ← hℓ] at hP'
  rw [← hR] at hN'
  have hcY : Y' - (1 / 2 : ℝ) • R + (1 / 2 : ℝ) • R = Y' := sub_add_cancel _ _
  rw [hcY] at hP' hN'
  -- `P` does not decrease and the norm is kept
  have hPle : Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ Pcubic (blockOp (∑ a, Xs' a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs' a) K) := by
    rw [hP, hP']; linarith [h3, hpair]
  have hnorm : HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs' a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs' a) K)
      = HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) := by
    unfold HamiltonsCubic.RealLayer.norm
    rw [hN, hN', h2]
  -- `W'` is Ricci-flat
  have hSym : ∀ Z : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ, (∀ a, (Z a).IsSymm) →
      (∑ a, Z a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)).IsSymm ∧
        ∀ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Z a).IsSymm := by
    intro Z hZ
    refine ⟨?_, fun a => ?_⟩
    · unfold Matrix.IsSymm
      rw [Matrix.transpose_sub, Matrix.transpose_smul, Matrix.transpose_one, (isSymm_sum _ _ hZ).eq]
    · unfold Matrix.IsSymm
      rw [Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_one, (hZ a).eq]
  obtain ⟨hSs, hMs⟩ := hSym Xs hXs
  obtain ⟨hS's, hM's⟩ := hSym Xs' hXs''
  obtain ⟨-, hO⟩ := (ricciFlat_iff _ hSs _ hMs K hK hK0).mp hRic
  have hRic' : ∀ i j, Ric (blockOp (∑ a, Xs' a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs' a) K) i j = 0 := by
    refine (ricciFlat_iff _ hS's _ hM's K hK hK0).mpr ⟨?_, fun a => ?_⟩
    · have hJ := (ricciJ_inverse _ _).mpr (N_shift t Xs' hX').symm
      rw [hJ, neg_add_cancel]
    · have h := hO a
      rw [Matrix.trace_add, hX a] at h
      rw [Matrix.trace_add, hX' a]
      exact h
  -- every block of `W'` is diagonal in `F`
  have hXd' : ∀ a, DiagIn F (Xs' a) := by
    intro a
    refine Fin.cases ?_ (fun i => ?_) a
    · rw [hs0]; exact diagIn_sub (diagIn_inFrame hF1 y) (diagIn_smul _ hRd)
    · rw [hss]; exact hdiag i
  have hSd : DiagIn F (∑ a, Xs' a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) :=
    diagIn_sub (diagIn_sum _ _ hXd') (diagIn_smul _ (diagIn_one hF1))
  have hMd : ∀ a, DiagIn F (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs' a) :=
    fun a => diagIn_add (diagIn_smul _ (diagIn_one hF1)) (hXd' a)
  have hL := L57_block_conj_of (m := m + 1) c hc _ hS's _ hM's K hK hK0 hRic' F hF1 hF2 hSd hMd
  rw [hnorm] at hL
  exact hPle.trans hL

/-- **L228 item 3**, `θ₀(n)` at `n = (m + 1) + 3`, the record's `Θₙ` at even `n`. -/
theorem L228_item3 (t : Fin (m + 1) → ℝ) (Xs : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 1) → Fin (m + 1) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hdiag : ∀ i : Fin m, DiagIn F (Xs i.succ)) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ Real.sqrt (2 * ((((m + 1 : ℕ) : ℝ) + 3) - 1) * ((((m + 1 : ℕ) : ℝ) + 3) - 2)) / (((m + 1 : ℕ) : ℝ) + 3)
        * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
          (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 :=
  L228_item3_of _ (diag_bound (by omega)) t Xs hX hXs K hK hK0 hRic F hF1 hF2 hdiag

/-- **L228 item 3 at odd `n = (m + 1) + 3 ≥ 5`**, with the record's odd constant `Θₙ`. -/
theorem L228_item3_odd (hm : 1 ≤ m) (hodd : ¬ Even (m + 1 + 3)) (t : Fin (m + 1) → ℝ)
    (Xs : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 1) → Fin (m + 1) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hdiag : ∀ i : Fin m, DiagIn F (Xs i.succ)) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ Real.sqrt (HamiltonsCubic.L57Critical.thetaOddSq (((m + 1 : ℕ) : ℝ) + 3))
        * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
          (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 :=
  L228_item3_of _ (diag_bound_odd (by omega) hodd) t Xs hX hXs K hK hK0 hRic F hF1 hF2 hdiag

end HamiltonsCubic.L228Item3
