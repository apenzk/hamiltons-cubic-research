import HamiltonsCubic.Results.SecondKindMatrix
import HamiltonsCubic.Results.L52Bound

set_option linter.style.longLine false

/-!
# L52 at the record's objects, in the stipulated basis

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52: `K'` is the diagonal of `W̊`
**in the basis `{φ_ab, ψ_k}` whose `ψ_k` are an eigenbasis of `K`**. [SecondKindMatrix.lean](SecondKindMatrix.lean)
writes `W̊` in the basis with `E_aa` on the diagonal block. **This file replaces that block by
`diag(w_k)` for any complete family `w` of `ℝⁿ`** (`∑_k w_k(i) w_k(j) = δ_ij`):

- `ew w`, `Bw`: the basis and the matrix, `frob_ew` its orthonormality, with `expand_sym_w`, `Bw_comp` and `trace_Bw_eq` as
  before, so the power sums of the spectrum are again `tr_{S²} W̊²` and `tr_{S²} W̊³`;
- `Bw_diag_pair`: the `φ`-block diagonal is `K_ab`, and `Bw_diag_psi`: the `ψ`-block diagonal is
  `-w_kᵀ K w_k`, which is `-κ_k` when `K w_k = κ_k w_k`;
- `L52_record`: **the record's display at a unit `R` that is linear, preserves and is self-adjoint
  on bivectors, and satisfies first Bianchi**, `P ≤ (3/2)[p₃(K) + 3M₊(1 − p₂(K))]
  − (1/2)[p₃(K') + 3m(p₂(K') − 3)]`, `K` the pair diagonal of `M` and `K'` the diagonal of `W̊` in
  the basis `{φ_ab} ∪ {diag w_k}`.

With `w` an eigenbasis of `K` on `ℝⁿ`, `K'` is `(K_ab)_{a<b}` together with `-κ` over all of `ℝⁿ`,
the record's `K'` with one extra `0` from `K 𝟏 = 0` (`K_row_sum`), which `p₂` and `p₃` do not see.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ}

/-- The basis of `S²` with the diagonal block `diag(w_k)`. -/
noncomputable def ew (w : Fin n → Fin n → ℝ) : S2Idx n → Matrix (Fin n) (Fin n) ℝ
  | Sum.inl p => (Real.sqrt 2) • symB p.1.1 p.1.2
  | Sum.inr k => Matrix.diagonal (w k)

theorem ew_isSymm (w : Fin n → Fin n → ℝ) (u : S2Idx n) : (ew w u).IsSymm := by
  cases u with
  | inl p => exact (symB_isSymm _ _).smul _
  | inr k => exact Matrix.isSymm_diagonal _

theorem frob_diag_left (d : Fin n → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    frob X (Matrix.diagonal d) = ∑ a, X a a * d a := by
  unfold frob
  refine Finset.sum_congr rfl fun a _ => ?_
  simp [Matrix.diagonal_apply]

/-- **The two diagonal blocks agree** for a complete family: `∑_k ⟨h, D_k⟩ D_k = ∑_a ⟨h, E_aa⟩ E_aa`. -/
theorem diag_block_expand (w : Fin n → Fin n → ℝ)
    (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0) (h : Matrix (Fin n) (Fin n) ℝ) :
    ∑ k, frob h (Matrix.diagonal (w k)) • Matrix.diagonal (w k)
      = ∑ a, frob h (e (Sum.inr a)) • e (Sum.inr a) := by
  ext i j
  simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, frob_diag_left, e]
  have hEaa : ∀ a : Fin n, symB a a = Matrix.single a a (1 : ℝ) := fun a => by
    unfold symB; rw [← two_smul ℝ (Matrix.single a a (1 : ℝ)), smul_smul]; norm_num
  simp only [hEaa]
  have hfE : ∀ a : Fin n, frob h (Matrix.single a a (1 : ℝ)) = h a a := fun a => by
    unfold frob
    rw [Finset.sum_eq_single a (fun b _ hb => Finset.sum_eq_zero fun c _ => by
      simp [Ne.symm hb]) (by simp)]
    rw [Finset.sum_eq_single a (fun c _ hc => by simp [Ne.symm hc]) (by simp)]
    simp
  simp only [hfE, Matrix.diagonal_apply, Matrix.single_apply]
  by_cases hij : i = j
  · subst hij
    simp only [if_true, mul_one]
    have : ∑ k, (∑ a, h a a * w k a) * w k i = ∑ a, h a a * ∑ k, w k a * w k i := by
      simp only [Finset.sum_mul, Finset.mul_sum]
      rw [Finset.sum_comm]
      exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun k _ => by ring
    rw [this]
    simp [hw]
  · simp only [hij, if_false, mul_zero, Finset.sum_const_zero]
    symm
    apply Finset.sum_eq_zero
    intro x _
    rw [if_neg, mul_zero]
    rintro ⟨h1, h2⟩
    exact hij (h1.symm.trans h2)

/-- **A symmetric matrix expands in `ew w`.** -/
theorem expand_sym_w (w : Fin n → Fin n → ℝ)
    (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0)
    (h : Matrix (Fin n) (Fin n) ℝ) (hh : h.IsSymm) :
    ∑ u : S2Idx n, frob h (ew w u) • ew w u = h := by
  have h0 := expand_sym h hh
  rw [Fintype.sum_sum_type] at h0 ⊢
  simp only [ew]
  rw [diag_block_expand w hw h]
  exact h0

theorem frob_comm' (X Y : Matrix (Fin n) (Fin n) ℝ) : frob X Y = frob Y X := by
  unfold frob; exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => mul_comm _ _

/-- A complete square family is orthonormal: `∑_a w_k(a) w_l(a) = δ_kl`. -/
theorem w_orth (w : Fin n → Fin n → ℝ) (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0)
    (k l : Fin n) : ∑ a, w k a * w l a = if k = l then 1 else 0 := by
  set M : Matrix (Fin n) (Fin n) ℝ := Matrix.of fun a k => w k a
  have h1 : M * M.transpose = 1 := by
    ext i j; simp only [M, Matrix.mul_apply, Matrix.transpose_apply, Matrix.of_apply, Matrix.one_apply]
    exact hw i j
  have h2 : M.transpose * M = 1 := mul_eq_one_comm.mp h1
  have := congrFun (congrFun h2 k) l
  simpa [M, Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply] using this

/-- **`ew w` is orthonormal** for a complete family `w`. -/
theorem frob_ew (w : Fin n → Fin n → ℝ) (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0)
    (u v : S2Idx n) : frob (ew w u) (ew w v) = if u = v then 1 else 0 := by
  cases u with
  | inl p =>
    cases v with
    | inl q => exact frob_e (Sum.inl p) (Sum.inl q)
    | inr k =>
      show frob ((Real.sqrt 2) • symB p.1.1 p.1.2) (Matrix.diagonal (w k)) = _
      rw [frob_diag_left]
      have hp := p.2
      have hz : ∀ a, symB p.1.1 p.1.2 a a = 0 := fun a => by
        rw [symB_apply]
        have h1 : ¬(p.1.1 = a ∧ p.1.2 = a) := fun h => absurd (h.1 ▸ h.2 ▸ hp) (lt_irrefl _)
        have h2 : ¬(p.1.2 = a ∧ p.1.1 = a) := fun h => h1 ⟨h.2, h.1⟩
        rw [if_neg h1, if_neg h2]; ring
      simp [hz]
  | inr k =>
    cases v with
    | inl q =>
      rw [frob_comm']
      show frob ((Real.sqrt 2) • symB q.1.1 q.1.2) (Matrix.diagonal (w k)) = _
      rw [frob_diag_left]
      have hq := q.2
      have hz : ∀ a, symB q.1.1 q.1.2 a a = 0 := fun a => by
        rw [symB_apply]
        have h1 : ¬(q.1.1 = a ∧ q.1.2 = a) := fun h => absurd (h.1 ▸ h.2 ▸ hq) (lt_irrefl _)
        have h2 : ¬(q.1.2 = a ∧ q.1.1 = a) := fun h => h1 ⟨h.2, h.1⟩
        rw [if_neg h1, if_neg h2]; ring
      simp [hz]
    | inr l =>
      show frob (Matrix.diagonal (w k)) (Matrix.diagonal (w l)) = _
      rw [frob_diag_left]
      simp only [Matrix.diagonal_apply_eq]
      rw [w_orth w hw k l]
      by_cases hkl : k = l
      · subst hkl; simp
      · simp [hkl]

/-- `W̊` in the basis `ew w`. -/
noncomputable def Bw (w : Fin n → Fin n → ℝ) (L : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) :
    Matrix (S2Idx n) (S2Idx n) ℝ :=
  fun u v => frob (L (ew w u)) (ew w v)

section W

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (w : Fin n → Fin n → ℝ) (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0)

include hw in
theorem Bw_comp (L' : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hL' : ∀ u, (L' (ew w u)).IsSymm) :
    Bw w (fun h => ringW R (L' h)) = Bw w L' * Bw w (ringW R) := by
  ext u v
  simp only [Bw, Matrix.mul_apply]
  conv_lhs => rw [← expand_sym_w w hw (L' (ew w u)) (hL' u), ringW_sum_smul, frob_sum_left]
  exact Finset.sum_congr rfl fun x _ => by rw [frob_smul_left]

theorem diagonal_eq_sum (d : Fin n → ℝ) : Matrix.diagonal d = ∑ a, d a • e (Sum.inr a) := by
  have hEaa : ∀ a : Fin n, symB a a = Matrix.single a a (1 : ℝ) := fun a => by
    unfold symB; rw [← two_smul ℝ (Matrix.single a a (1 : ℝ)), smul_smul]; norm_num
  ext i j
  simp only [e, hEaa, Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, Matrix.single_apply,
    Matrix.diagonal_apply]
  by_cases hij : i = j
  · subst hij; simp
  · simp only [hij, if_false]
    symm; apply Finset.sum_eq_zero; intro x _
    rw [if_neg, mul_zero]; rintro ⟨h1, h2⟩; exact hij (h1.symm.trans h2)

include hw in
/-- **The trace does not depend on the diagonal block's basis**, for a map linear on diagonal
matrices. -/
theorem trace_Bw_eq (L : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hlin : ∀ c : Fin n → ℝ, L (∑ a, c a • e (Sum.inr a)) = ∑ a, c a • L (e (Sum.inr a))) :
    (Bw w L).trace = (Bmat L).trace := by
  rw [Matrix.trace, Matrix.trace, Fintype.sum_sum_type, Fintype.sum_sum_type]
  congr 1
  simp only [Matrix.diag, Bw, Bmat, ew]
  have hk : ∀ k, frob (L (Matrix.diagonal (w k))) (Matrix.diagonal (w k))
      = ∑ a, ∑ b, w k a * w k b * frob (L (e (Sum.inr a))) (e (Sum.inr b)) := by
    intro k
    rw [diagonal_eq_sum, hlin, frob_sum_left]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [frob_smul_left, frob_comm', frob_sum_left, Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [frob_smul_left, frob_comm']; ring
  simp only [hk]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  simp only [← Finset.sum_mul]
  rw [Finset.sum_eq_single a (fun b _ hb => by rw [hw a b, if_neg (Ne.symm hb), zero_mul])
    (by simp), hw a a, if_pos rfl, one_mul]

include hR hskew hsym hw

theorem Bw_isHermitian : (Bw w (ringW R)).IsHermitian := by
  ext u v
  simp only [Matrix.conjTranspose_apply, star_trivial, Bw]
  rw [ringW_selfAdjoint R hR hskew hsym, frob_comm']

theorem Bw_sq : Bw w (ringW R) ^ 2 = Bw w (fun h => ringW R (ringW R h)) := by
  rw [pow_two, Bw_comp R w hw (ringW R) fun u => ringW_isSymm_of R hR hskew hsym _ (ew_isSymm w u)]

theorem Bw_cube : Bw w (ringW R) ^ 3 = Bw w (fun h => ringW R (ringW R (ringW R h))) := by
  rw [pow_succ, Bw_sq R hR hskew hsym w hw,
    Bw_comp R w hw (fun h => ringW R (ringW R h)) fun u =>
      ringW_isSymm_of R hR hskew hsym _ (ringW_isSymm_of R hR hskew hsym _ (ew_isSymm w u))]

omit hR hskew hsym hw in
theorem ringW_lin_diag (c : Fin n → ℝ) :
    ringW R (∑ a, c a • e (Sum.inr a)) = ∑ a, c a • ringW R (e (Sum.inr a)) :=
  ringW_sum_smul R _ c _

/-- **`∑ ω³ = tr_{S²} W̊³`** for `ω` the spectrum of `W̊` in the basis `ew w`. -/
theorem sum_omega_w_cube :
    ∑ j, (Bw_isHermitian R hR hskew hsym w hw).eigenvalues j ^ 3
      = trS2 (fun h => ringW R (ringW R (ringW R h))) := by
  rw [← trace_pow_eq_sum_eigenvalues, Bw_cube R hR hskew hsym w hw,
    trace_Bw_eq w hw _ (fun c => by simp only [ringW_sum_smul]), ← Bmat_cube R hR hskew hsym,
    trace_pow_eq_sum_eigenvalues _ (Bmat_isHermitian R hR hskew hsym)]
  exact sum_omega_cube R hR hskew hsym

/-- **`∑ ω² = 3‖R‖²`** in the basis `ew w`. -/
theorem sum_omega_w_sq (hB : ∀ i j k l, bianchi R i j k l = 0) :
    ∑ j, (Bw_isHermitian R hR hskew hsym w hw).eigenvalues j ^ 2 = 3 * normSq R := by
  rw [← trace_pow_eq_sum_eigenvalues, Bw_sq R hR hskew hsym w hw,
    trace_Bw_eq w hw _ (fun c => by simp only [ringW_sum_smul]), ← Bmat_sq R hR hskew hsym,
    trace_pow_eq_sum_eigenvalues _ (Bmat_isHermitian R hR hskew hsym)]
  exact sum_omega_sq R hR hskew hsym hB

omit hw in
/-- The `φ`-block diagonal of `W̊` in `ew w` is `K`. -/
theorem Bw_diag_pair (p : Pairs n) : Bw w (ringW R) (Sum.inl p) (Sum.inl p) = Kmat R p.1.1 p.1.2 :=
  phi_block_diag R hR hskew hsym p.1.1 p.1.2

omit hw in
/-- The `ψ`-block diagonal of `W̊` in `ew w` is `-w_kᵀ K w_k`. -/
theorem Bw_diag_psi (k : Fin n) :
    Bw w (ringW R) (Sum.inr k) (Sum.inr k) = -(w k ⬝ᵥ (Kmat R *ᵥ w k)) :=
  diag_block R hR hskew hsym (w k) (w k)

/-- **L52 AT THE RECORD'S OBJECTS.** For `R` linear, self-adjoint on bivectors, first Bianchi and
unit norm, with `μ ≤ M₊` on the spectrum of `M` and `ω ≥ −m` on that of `W̊`,
`P ≤ (3/2)[p₃(K) + 3M₊(1 − p₂(K))] − (1/2)[p₃(K') + 3m(p₂(K') − 3)]`, `K` the pair diagonal of
`M` and `K'` the diagonal of `W̊` in `ew w`. -/
theorem L52_record (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1) (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bw_isHermitian R hR hskew hsym w hw).eigenvalues j) :
    Pcubic R ≤ (3 / 2) * (∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 3
          + 3 * Mp * (1 - ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2))
        - (1 / 2) * (∑ u, Bw w (ringW R) u u ^ 3
          + 3 * m * (∑ u, Bw w (ringW R) u u ^ 2 - 3)) := by
  have h := L52Bound.L52_matrix_bound (Mpair R) (Mpair_isHermitian R hR hskew hsym)
    (Bw w (ringW R)) (Bw_isHermitian R hR hskew hsym w hw) Mp m hμ hω
    (by rw [sum_mu_sq R hR hskew hsym, hunit])
    (by rw [sum_omega_w_sq R hR hskew hsym w hw hB, hunit]; ring)
  rw [sum_omega_w_cube R hR hskew hsym w hw] at h
  rw [L50Spectra.L50_bispectral R hR hskew hsym hB, ← sum_mu_cube R hR hskew hsym]
  exact h

end W

end HamiltonsCubic.SecondKind
