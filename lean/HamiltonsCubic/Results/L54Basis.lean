import HamiltonsCubic.Results.SecondKind
import HamiltonsCubic.Results.L50Spectra

set_option linter.style.longLine false

/-!
# L54, the basis identifications: the `φ`-block diagonal is `K`, the diagonal block is `-K`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L54 (1): in a frame, with
`K_ab = W_abab`, `M_{(ab),(ab)} = K_ab` and `⟨W̊ φ_ab, φ_ab⟩ = K_ab` for `φ_ab = (e_a ⊙ e_b)/√2`,
and on diagonal tensors `⟨W̊ diag(u), diag(v)⟩ = -uᵀ K v`, so in an orthonormal eigenbasis of `K`
on `𝟏^⊥` the `ψ`-block is `diag(-κ_k)`. Step (0), `K 𝟏 = 0`, is Ricci-flatness.

[L54.lean](L54.lean) proves the arithmetic downstream of these identifications. **This file proves
the identifications themselves** against [SecondKind.lean](SecondKind.lean)'s `ringW` and the
Frobenius pairing `frob`, the frame being the coordinate one (`R4` reads `W` in it):

- `Kmat`: `K_ab = W_abab`, and `M_diag`: `M_{(ab),(ab)} = K_ab`, by definition;
- `phi_block_diag`: `⟨W̊ φ_ab, φ_ab⟩ = K_ab`, with `φ_ab = √2 · symB a b`;
- `diag_block`: `⟨W̊ diag(u), diag(v)⟩ = -uᵀ K v` for all `u, v`;
- `psi_block`: in an orthonormal family of eigenvectors of `K`, that block is `diag(-κ_k)`;
- `K_row_sum`: `∑_b K_ab = 0` at a Ricci-flat `W`, so `K 𝟏 = 0`;
- `tF_le` and `tF_eq_iff`, **L54 (3)**: `t_F = ∑ K_ab² ≤ 2‖M‖²`, with equality exactly when `W` is
  coordinate-diagonal in the frame (`IsCoordDiag`), each row of the pair basis carrying at least
  twice its diagonal square.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The sectional-curvature matrix of the frame**, `K_ab = W_abab`. -/
noncomputable def Kmat (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ := fun a b => R4 R a b a b

/-- `M_{(ab),(ab)} = K_ab`: the pair-basis diagonal of `M` is `K`. -/
theorem M_diag (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (a b : ι) : R4 R a b a b = Kmat R a b := rfl

section ident

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

omit hskew hsym in
/-- A repeated first pair vanishes: `φ_ii = 0`. -/
theorem R4_self_left (i j k : ι) : R4 R i i j k = 0 := by
  unfold R4
  rw [show phi i i = 0 by unfold phi; simp]
  have hl := hR.2 0 0
  simp at hl
  simp [hl, inner2]

/-- **The `φ`-block diagonal of `W̊`, unnormalised**: `⟨W̊ s_ab, s_ab⟩ = K_ab / 2` for
`s_ab = symB a b = ½(E_ab + E_ba)`; at `a = b` both sides vanish. -/
theorem symB_block_diag (a b : ι) :
    frob (ringW R (symB a b)) (symB a b) = Kmat R a b / 2 := by
  have hA2 := R4_anti2 R hR
  have h1 : R4 R b a b a = R4 R a b a b := by
    rw [R4_anti1 R hR hskew hsym a b b a, hA2 a b a b]; ring
  have hsym' : ∀ i j, symB a b i j
      = (1 / 2) * ((if i = a then (if j = b then 1 else 0) else 0)
        + (if i = b then (if j = a then 1 else 0) else 0)) := by
    intro i j; unfold symB; simp [Matrix.single_apply, ite_and, eq_comm]
  have hcol : ∀ (p q : ι) (F : ι → ι → ℝ),
      (∑ x, ∑ y, if x = p then (if y = q then F x y else 0) else 0) = F p q := by
    intro p q F
    rw [Fintype.sum_eq_single p (fun x hx => by simp [hx])]
    simp
  unfold frob
  simp only [hsym', ringW_symB, mul_add, Finset.sum_add_distrib, mul_ite, mul_one, mul_zero]
  rw [hcol a b (fun x y => (1 / 2 * R4 R x a b y + 1 / 2 * R4 R x b a y) * (1 / 2)),
    hcol b a (fun x y => (1 / 2 * R4 R x a b y + 1 / 2 * R4 R x b a y) * (1 / 2))]
  rw [R4_self_left R hR, R4_self_left R hR, h1]
  unfold Kmat
  ring

/-- **The `φ`-block diagonal of `W̊` is `K`**: `⟨W̊ φ_ab, φ_ab⟩ = K_ab` for the unit
`φ_ab = √2 · symB a b = (E_ab + E_ba)/√2`, the record's basis at `a ≠ b`. -/
theorem phi_block_diag (a b : ι) :
    frob (ringW R ((Real.sqrt 2) • symB a b)) ((Real.sqrt 2) • symB a b) = Kmat R a b := by
  have hsmul : ringW R ((Real.sqrt 2) • symB a b) = (Real.sqrt 2) • ringW R (symB a b) := by
    ext i j
    show (∑ k, ∑ l, R4 R i k l j * ((Real.sqrt 2) • symB a b) k l)
      = Real.sqrt 2 * ∑ k, ∑ l, R4 R i k l j * symB a b k l
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    simp only [Matrix.smul_apply, smul_eq_mul]
    ring
  have hsq : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hf : frob ((Real.sqrt 2) • ringW R (symB a b)) ((Real.sqrt 2) • symB a b)
      = (Real.sqrt 2 * Real.sqrt 2) * frob (ringW R (symB a b)) (symB a b) := by
    unfold frob
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    simp only [Matrix.smul_apply, smul_eq_mul]
    ring
  rw [hsmul, hf, hsq, symB_block_diag R hR hskew hsym a b]
  ring

/-- **On diagonal tensors `W̊` is `-K`**: `⟨W̊ diag(u), diag(v)⟩ = -uᵀ K v`, for all `u, v`. -/
theorem diag_block (u v : ι → ℝ) :
    frob (ringW R (Matrix.diagonal u)) (Matrix.diagonal v) = -(u ⬝ᵥ (Kmat R *ᵥ v)) := by
  have hA2 := R4_anti2 R hR
  unfold frob ringW Kmat
  simp only [Matrix.diagonal_apply, mul_ite, mul_zero, Finset.sum_ite_eq,
    Finset.mem_univ, if_true, dotProduct, Matrix.mulVec, Finset.mul_sum, ← Finset.sum_neg_distrib]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [hA2 k i k i, R4_anti1 R hR hskew hsym i k k i, hA2 i k i k]
  ring

/-- **The `ψ`-block in an eigenbasis of `K` is `diag(-κ)`**: for orthonormal `w_j` with
`K w_j = κ_j w_j`, `⟨W̊ diag(w_j), diag(w_k)⟩ = -κ_k δ_jk`. -/
theorem psi_block {m : Type*} [DecidableEq m] (w : m → ι → ℝ) (κ : m → ℝ)
    (heig : ∀ k, Kmat R *ᵥ w k = κ k • w k)
    (horth : ∀ j k, w j ⬝ᵥ w k = if j = k then 1 else 0) (j k : m) :
    frob (ringW R (Matrix.diagonal (w j))) (Matrix.diagonal (w k))
      = if j = k then -κ k else 0 := by
  rw [diag_block R hR hskew hsym, heig, dotProduct_smul, horth]
  split_ifs <;> simp

end ident

/-- **`K 𝟏 = 0` at a Ricci-flat `W`**: every row of `K` sums to zero, L54's step (0). -/
theorem K_row_sum (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hRic : ∀ a b, Ric R a b = 0) (a : ι) :
    ∑ b, Kmat R a b = 0 := by
  have h := hRic a a
  unfold Ric at h
  unfold Kmat R4
  exact h


/-! ## L54 (3): `t_F ≤ 2‖M‖²` -/

/-- Two distinct entries of a nonnegative double sum. -/
theorem two_le_double_sum (f : ι → ι → ℝ) (hf : ∀ k l, 0 ≤ f k l) {i j : ι} (hij : i ≠ j) :
    f i j + f j i ≤ ∑ k, ∑ l, f k l := by
  rw [← Finset.sum_product' (f := f)]
  have hsub : ({(i, j), (j, i)} : Finset (ι × ι)) ⊆ Finset.univ ×ˢ Finset.univ := by
    intro x _; simp
  have hne : (i, j) ≠ (j, i) := fun h => hij (Prod.mk.inj h).1
  have := Finset.sum_le_sum_of_subset_of_nonneg hsub (fun x _ _ => hf x.1 x.2)
  rwa [Finset.sum_pair hne] at this

section tF

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
include hR

/-- Each row of the pair basis carries at least twice its diagonal square:
`∑_{k,l} W_{ijkl}² ≥ 2 K_ij²`. -/
theorem row_ge (i j : ι) : 2 * Kmat R i j ^ 2 ≤ ∑ k, ∑ l, R4 R i j k l ^ 2 := by
  by_cases hij : i = j
  · subst hij
    have h0 : Kmat R i i = 0 := by unfold Kmat; exact R4_self_left R hR i i i
    rw [h0]; norm_num
    exact Finset.sum_nonneg fun k _ => Finset.sum_nonneg fun l _ => sq_nonneg _
  · have h : R4 R i j i j ^ 2 + R4 R i j j i ^ 2 ≤ ∑ k, ∑ l, R4 R i j k l ^ 2 :=
      two_le_double_sum (fun k l => R4 R i j k l ^ 2) (fun _ _ => sq_nonneg _) hij
    rw [R4_anti2 R hR i j i j] at h
    show 2 * R4 R i j i j ^ 2 ≤ _
    nlinarith [h]

include hskew in
/-- **L54 (3)**: `t_F = ∑_{a,b} K_ab² ≤ 2‖M‖²`, the norm being the record's `normSq`. -/
theorem tF_le : ∑ a, ∑ b, Kmat R a b ^ 2 ≤ 2 * normSq R := by
  rw [normSq, L50Spectra.innerOp_R4 R R hskew]
  have h : ∑ a, ∑ b, 2 * Kmat R a b ^ 2 ≤ ∑ a, ∑ b, ∑ k, ∑ l, R4 R a b k l ^ 2 :=
    Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun b _ => row_ge R hR a b
  simp only [← Finset.mul_sum] at h
  have e : ∑ a, ∑ b, ∑ k, ∑ l, R4 R a b k l * R4 R a b k l
      = ∑ a, ∑ b, ∑ k, ∑ l, R4 R a b k l ^ 2 := by simp only [sq]
  rw [e]; linarith

/-- **Coordinate-diagonal in the frame**: `W_{ijkl} = 0` unless `(k,l)` is `(i,j)` or `(j,i)`. -/
def IsCoordDiag (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  ∀ i j k l, ¬((k = i ∧ l = j) ∨ (k = j ∧ l = i)) → R4 R i j k l = 0

/-- A row whose two diagonal slots carry the whole sum has every other entry zero. -/
theorem row_rest_zero (i j : ι) (hij : i ≠ j)
    (h : ∑ k, ∑ l, R4 R i j k l ^ 2 = R4 R i j i j ^ 2 + R4 R i j j i ^ 2) (k l : ι)
    (hkl : ¬((k = i ∧ l = j) ∨ (k = j ∧ l = i))) : R4 R i j k l = 0 := by
  set f : ι × ι → ℝ := fun p => R4 R i j p.1 p.2 ^ 2 with hf
  have hsum : ∑ p ∈ (Finset.univ : Finset (ι × ι)), f p = f (i, j) + f (j, i) := by
    rw [Finset.univ_product_univ.symm, Finset.sum_product]; exact h
  have hne : (i, j) ≠ (j, i) := fun h => hij (Prod.mk.inj h).1
  have hsplit : ∑ p ∈ (Finset.univ : Finset (ι × ι)), f p
      = (∑ p ∈ ({(i, j), (j, i)} : Finset (ι × ι)), f p)
        + ∑ p ∈ Finset.univ \ {(i, j), (j, i)}, f p := by
    rw [add_comm, Finset.sum_sdiff (Finset.subset_univ _)]
  rw [hsplit, Finset.sum_pair hne] at hsum
  have hrest : ∑ p ∈ Finset.univ \ {(i, j), (j, i)}, f p = 0 := by linarith
  have hz := (Finset.sum_eq_zero_iff_of_nonneg (fun p _ => sq_nonneg (R4 R i j p.1 p.2))).mp hrest
    (k, l) (by
      simp only [Finset.mem_sdiff, Finset.mem_univ, Finset.mem_insert, Finset.mem_singleton,
        Prod.mk.injEq, true_and]
      tauto)
  exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hz

include hskew in
/-- **L54 (3), the equality case**: `t_F = 2‖M‖²` exactly when `W` is coordinate-diagonal. -/
theorem tF_eq_iff : ∑ a, ∑ b, Kmat R a b ^ 2 = 2 * normSq R ↔ IsCoordDiag R := by
  have hA2 := R4_anti2 R hR
  have hN : 2 * normSq R = (1 / 2) * ∑ a, ∑ b, ∑ k, ∑ l, R4 R a b k l ^ 2 := by
    rw [normSq, L50Spectra.innerOp_R4 R R hskew]; simp only [sq]; ring
  rw [hN]
  constructor
  · intro heq i j k l hkl
    by_cases hij : i = j
    · subst hij; exact R4_self_left R hR i k l
    have hle : ∀ a b, 2 * Kmat R a b ^ 2 ≤ ∑ k, ∑ l, R4 R a b k l ^ 2 := row_ge R hR
    have hall : ∑ a, ∑ b, 2 * Kmat R a b ^ 2 = ∑ a, ∑ b, ∑ k, ∑ l, R4 R a b k l ^ 2 := by
      simp only [← Finset.mul_sum]; linarith
    have hrow : 2 * Kmat R i j ^ 2 = ∑ k, ∑ l, R4 R i j k l ^ 2 := by
      have h1 := (Finset.sum_eq_sum_iff_of_le (fun a _ => Finset.sum_le_sum fun b _ => hle a b)).mp
        hall i (Finset.mem_univ _)
      exact (Finset.sum_eq_sum_iff_of_le (fun b _ => hle i b)).mp h1 j (Finset.mem_univ _)
    refine row_rest_zero R hR i j hij ?_ k l hkl
    rw [← hrow, hA2 i j i j]; unfold Kmat; ring
  · intro hd
    have hrow : ∀ a b, ∑ k, ∑ l, R4 R a b k l ^ 2 = 2 * Kmat R a b ^ 2 := by
      intro a b
      by_cases hab : a = b
      · subst hab
        have : ∀ k l, R4 R a a k l = 0 := fun k l => R4_self_left R hR a k l
        simp [this, Kmat]
      · have hsplit : ∀ k l, R4 R a b k l ^ 2
            = (if k = a ∧ l = b then R4 R a b a b ^ 2 else 0)
              + (if k = b ∧ l = a then R4 R a b b a ^ 2 else 0) := by
          intro k l
          by_cases h1 : k = a ∧ l = b
          · obtain ⟨hk, hl⟩ := h1
            subst hk; subst hl
            have h2 : ¬(k = l ∧ l = k) := fun h => hab h.1
            rw [if_pos ⟨rfl, rfl⟩, if_neg h2, add_zero]
          · by_cases h2 : k = b ∧ l = a
            · obtain ⟨hk, hl⟩ := h2
              subst hk; subst hl
              rw [if_neg h1, if_pos ⟨rfl, rfl⟩, zero_add]
            · rw [hd a b k l (by tauto), if_neg h1, if_neg h2]; ring
        rw [Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => hsplit k l]
        have hcol : ∀ (p q : ι) (c : ℝ),
            (∑ x, ∑ y, if x = p then (if y = q then c else 0) else 0) = c := by
          intro p q c
          rw [Fintype.sum_eq_single p (fun x hx => by simp [hx])]
          simp
        simp only [Finset.sum_add_distrib, ite_and]
        rw [hcol, hcol, hA2 a b a b]; unfold Kmat; ring
    simp only [hrow, ← Finset.mul_sum]; ring

end tF

end HamiltonsCubic.SecondKind
