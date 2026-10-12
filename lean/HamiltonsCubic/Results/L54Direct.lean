import HamiltonsCubic.Results.L54Rigid

set_option linter.style.longLine false

/-!
# L54's cheaper route: at `t_F = 2` the two operators ARE their diagonals

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L54 (4), *"And directly"*: by (3) `M` is
diagonal in the pair basis, so its spectrum is `d_φ`; a coordinate-diagonal `W` makes `W̊` diagonal on the
`φ`-block and `−K` on the diagonal block, hence diagonal in the eigenbasis, with spectrum `d`.
[L54Rigid.lean](L54Rigid.lean) proves the sorted equalities through majorisation. **This file proves the
unsorted ones**, as matrix identities:

- `Bw_pair_off`, `Bw_pair_psi`: at a coordinate-diagonal `W` the `φ`–`φ` entries off the diagonal and the
  `φ`–`ψ` entries of `W̊` vanish, each `R4` term killed by `IsCoordDiag` and the ordering `a < b`;
- `wK_orth`: Mathlib's eigenbasis of `K` is orthonormal, so `psi_block` makes the `ψ`–`ψ` block `diag(−κ)`;
- **`L54_direct`**: at `t_F = 2` and unit norm, `Mpair R = diag(d_φ)` and `W̊` in `{φ_ab, ψ_k}` equals the
  diagonal matrix of its own diagonal, through `tF_eq_iff`. As in [L54Rigid.lean](L54Rigid.lean), the
  `ψ`-block runs over `ℝⁿ` with Mathlib's eigenbasis of `K`, one dimension more than the record's `𝟏^⊥`.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ}

theorem frob_symB_gen (X : Matrix (Fin n) (Fin n) ℝ) (c d : Fin n) :
    frob X (symB c d) = (1 / 2) * (X c d + X d c) := by
  unfold frob symB
  simp only [Matrix.smul_apply, Matrix.add_apply, Matrix.single_apply, smul_eq_mul, mul_add, mul_ite,
    mul_one, mul_zero, ite_and, Finset.sum_add_distrib]
  rw [Finset.sum_eq_single c (fun x _ hx => Finset.sum_eq_zero fun y _ => by rw [if_neg (Ne.symm hx)])
      (by simp), Finset.sum_eq_single d (fun y _ hy => by rw [if_pos rfl, if_neg (Ne.symm hy)]) (by simp),
    Finset.sum_eq_single d (fun x _ hx => Finset.sum_eq_zero fun y _ => by rw [if_neg (Ne.symm hx)])
      (by simp), Finset.sum_eq_single c (fun y _ hy => by rw [if_pos rfl, if_neg (Ne.symm hy)]) (by simp)]
  simp only [if_true]
  ring

theorem frob_smul_left' (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ) : frob (c • X) Y = c * frob X Y := by
  unfold frob; simp only [Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring

theorem frob_smul_right' (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ) : frob X (c • Y) = c * frob X Y := by
  unfold frob; simp only [Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring

theorem ringW_smul' (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (c : ℝ) (h : Matrix (Fin n) (Fin n) ℝ) :
    ringW R (c • h) = c • ringW R h := by
  ext i j
  simp only [ringW, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by ring

section K

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

/-- Two distinct ordered pairs `a < b`, `c < d`: coordinate-diagonality kills `R4 c a b d`. -/
theorem cd_zero1 (hcd : IsCoordDiag R) {a b c d : Fin n} (hab : a < b) (hcd' : c < d) :
    R4 R c a b d = 0 :=
  hcd c a b d (by
    rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
    · exact lt_asymm hab hcd'
    · exact lt_irrefl _ hab)

theorem cd_zero2 (hcd : IsCoordDiag R) {a b c d : Fin n} (hab : a < b) (hne : ¬(a = c ∧ b = d)) :
    R4 R c b a d = 0 :=
  hcd c b a d (by
    rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
    · exact hne ⟨rfl, rfl⟩
    · exact lt_irrefl _ hab)

theorem cd_zero3 (hcd : IsCoordDiag R) {a b c d : Fin n} (hab : a < b) (hne : ¬(a = c ∧ b = d)) :
    R4 R d a b c = 0 :=
  hcd d a b c (by
    rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
    · exact hne ⟨rfl, rfl⟩
    · exact lt_irrefl _ hab)

theorem cd_zero4 (hcd : IsCoordDiag R) {a b c d : Fin n} (hab : a < b) (hcd' : c < d) :
    R4 R d b a c = 0 :=
  hcd d b a c (by
    rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
    · exact lt_asymm hab hcd'
    · exact lt_irrefl _ hab)

theorem cd_zero_diag (hcd : IsCoordDiag R) {a b : Fin n} (hab : a < b) (i : Fin n) :
    R4 R i a b i = 0 ∧ R4 R i b a i = 0 :=
  ⟨hcd i a b i (by
      rintro (⟨h1, h2⟩ | ⟨h1, _⟩)
      · exact hab.ne' (h1.trans h2)
      · exact hab.ne' h1),
   hcd i b a i (by
      rintro (⟨h1, h2⟩ | ⟨h1, _⟩)
      · exact hab.ne (h1.trans h2)
      · exact hab.ne h1)⟩

/-- The pair-pair entries of `W̊` vanish off the diagonal at a coordinate-diagonal `W`. -/
theorem Bw_pair_off (w : Fin n → Fin n → ℝ) (hcd : IsCoordDiag R) (p q : Pairs n) (hpq : p ≠ q) :
    Bw w (ringW R) (Sum.inl p) (Sum.inl q) = 0 := by
  have hne : ¬(p.1.1 = q.1.1 ∧ p.1.2 = q.1.2) := fun h => hpq (Subtype.ext (Prod.ext h.1 h.2))
  show frob (ringW R ((Real.sqrt 2) • symB p.1.1 p.1.2)) ((Real.sqrt 2) • symB q.1.1 q.1.2) = 0
  rw [ringW_smul', frob_smul_left', frob_smul_right', frob_symB_gen, ringW_symB, ringW_symB,
    cd_zero1 R hcd p.2 q.2, cd_zero2 R hcd p.2 hne, cd_zero3 R hcd p.2 hne, cd_zero4 R hcd p.2 q.2]
  ring

/-- The pair-diagonal entries of `W̊` vanish at a coordinate-diagonal `W`. -/
theorem Bw_pair_psi (w : Fin n → Fin n → ℝ) (hcd : IsCoordDiag R) (p : Pairs n) (k : Fin n) :
    Bw w (ringW R) (Sum.inl p) (Sum.inr k) = 0 := by
  show frob (ringW R ((Real.sqrt 2) • symB p.1.1 p.1.2)) (Matrix.diagonal (w k)) = 0
  rw [ringW_smul', frob_smul_left', frob_diag_left]
  simp only [ringW_symB, (cd_zero_diag R hcd p.2 _).1, (cd_zero_diag R hcd p.2 _).2]
  simp

include hR hskew hsym in
theorem wK_orth (j k : Fin n) :
    wK R hR hskew hsym j ⬝ᵥ wK R hR hskew hsym k = if j = k then 1 else 0 := by
  have hU := Matrix.mem_unitaryGroup_iff'.mp (Kmat_isHermitian R hR hskew hsym).eigenvectorUnitary.2
  have h := congrFun (congrFun hU j) k
  simp only [Matrix.mul_apply, Matrix.star_apply, star_trivial, Matrix.one_apply] at h
  rw [← h]
  unfold wK dotProduct
  refine Finset.sum_congr rfl fun i _ => ?_
  simp [Matrix.IsHermitian.eigenvectorUnitary_apply]

/-- **L54's cheaper route, as vector equalities**: at `t_F = 2` and unit norm, `M` in the pair basis IS the
diagonal matrix `diag(d_φ)`, and `W̊` in the basis `{φ_ab, ψ_k}` IS the diagonal matrix of its own diagonal
`d`, so their spectra are `d_φ` and `d` entry by entry, no sorting. -/
theorem L54_direct (hunit : normSq R = 1) (ht : tF R = 2) :
    Mpair R = Matrix.diagonal (fun p : Pairs n => Kmat R p.1.1 p.1.2) ∧
      Bw (wK R hR hskew hsym) (ringW R)
        = Matrix.diagonal (fun u => Bw (wK R hR hskew hsym) (ringW R) u u) := by
  have hcd : IsCoordDiag R := (tF_eq_iff R hR hskew).mp (by rw [hunit]; unfold tF at ht; linarith)
  constructor
  · ext p q
    by_cases hpq : p = q
    · subst hpq; simp [Mpair_diag]
    · rw [Matrix.diagonal_apply_ne _ hpq]
      show R4 R p.1.1 p.1.2 q.1.1 q.1.2 = 0
      refine hcd _ _ _ _ ?_
      rintro (⟨h1, h2⟩ | ⟨h1, h2⟩)
      · exact hpq (Subtype.ext (Prod.ext h1.symm h2.symm))
      · have := q.2; rw [h1, h2] at this; exact lt_asymm p.2 this
  · ext u v
    by_cases huv : u = v
    · subst huv; simp
    rw [Matrix.diagonal_apply_ne _ huv]
    rcases u with p | j <;> rcases v with q | k
    · exact Bw_pair_off R _ hcd p q (fun h => huv (congrArg Sum.inl h))
    · exact Bw_pair_psi R _ hcd p k
    · rw [← (Bw_isHermitian R hR hskew hsym _ (wK_complete R hR hskew hsym)).apply]
      simp only [star_trivial]
      exact Bw_pair_psi R _ hcd q j
    · have hjk : j ≠ k := fun h => huv (congrArg Sum.inr h)
      show frob (ringW R (Matrix.diagonal (wK R hR hskew hsym j))) (Matrix.diagonal (wK R hR hskew hsym k)) = 0
      rw [psi_block R hR hskew hsym _ _ (wK_eigen R hR hskew hsym) (wK_orth R hR hskew hsym), if_neg hjk]

end K

end HamiltonsCubic.SecondKind
