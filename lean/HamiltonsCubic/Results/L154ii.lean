import HamiltonsCubic.Results.EigenFrameExist
import HamiltonsCubic.Results.L15Statement

set_option linter.style.longLine false

/-!
# L154 (ii): at scalar `h`, `J₅ = λ scal(X_inv) ≥ 0`, with equality iff `X_inv = 0`

[findings/bounds.md](../../../findings/bounds.md), Lemma L154 (ii): *if `h = Ric(|W|) = λ id` then
`λ = 2 tr|W|/n > 0`, `H = Ric*(h) = 2λ Id`, `J₅ = λ scal(X_inv) ≥ 0`, and `J₅ = 0` iff `X_inv = 0`.*

- `ricStar h X = hX + Xh`, and `ricStar_adjoint`: **it is the adjoint of the Ricci contraction**,
  `∑_{ab} Ric(A)_{ab} h_{ab} = ⟨A, Ric*(h)⟩_{Λ²}` at symmetric `h` and linear `A` preserving bivectors;
  `ricStar_scalar`: **`Ric*(λ id) = 2λ Id`**;
- `sum_Ric_diag`: `∑_a Ric(A)_aa = 2 tr_{Λ²} A`, and `traceOp_absOp`: `tr_{Λ²}|W| = ∑ |λ_k|`, so
  `lam_eq`: **`λ = 2 tr|W|/n`**, positive at `W ≠ 0` (`lam_pos`);
- `J5` is `⟨X_inv, H⟩ = ∑_{γδ} X_{γδ} ⟨H v_γ, v_δ⟩` in the frame (the record's definition, as in
  `J5_zero_of_graded`), and `J5_scalar`: **`J₅ = 2λ tr X_inv = λ scal(X_inv)`**;
- `L154_ii`: **`J₅ ≥ 0`, and `J₅ = 0` iff `X_inv = 0`**, from L154 (i).
-/

namespace HamiltonsCubic.EigenFrameExist

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SecondKind HamiltonsCubic.L41Statement
  HamiltonsCubic.L41Statement.Frame

variable {n : ℕ}

/-- `Ric*(h) X = hX + Xh`. -/
def ricStar (h X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := h * X + X * h

/-- `(h φᵢⱼ)_{ab}`. -/
theorem mul_phi_apply (h : Matrix (Fin n) (Fin n) ℝ) (i j a b : Fin n) :
    (h * phi i j) a b = (if b = i then h a j else 0) - (if b = j then h a i else 0) := by
  simp [phi, Matrix.mul_apply, Matrix.sub_apply, Matrix.single_apply, mul_sub, Finset.sum_sub_distrib,
    ite_and, eq_comm]

/-- `(φᵢⱼ h)_{ab}`. -/
theorem phi_mul_apply (h : Matrix (Fin n) (Fin n) ℝ) (i j a b : Fin n) :
    (phi i j * h) a b = (if a = j then h i b else 0) - (if a = i then h j b else 0) := by
  simp [phi, Matrix.mul_apply, Matrix.sub_apply, Matrix.single_apply, sub_mul, Finset.sum_sub_distrib,
    ite_and, eq_comm]

/-- `⟨Y, Ric*(h) φᵢⱼ⟩ = ∑_k (h_{jk} Y_{ki} − h_{ik} Y_{kj})` at skew `Y` and symmetric `h`. -/
theorem inner2_ricStar_phi (h Y : Matrix (Fin n) (Fin n) ℝ) (hh : hᵀ = h) (hY : IsSkew Y) (i j : Fin n) :
    inner2 Y (ricStar h (phi i j)) = ∑ k, (h j k * Y k i - h i k * Y k j) := by
  have hY' : ∀ a b, Y b a = - Y a b := fun a b => by
    have := congrFun (congrFun hY a) b; simpa [Matrix.transpose_apply] using this
  have hh' : ∀ a b, h b a = h a b := fun a b => by
    have := congrFun (congrFun hh a) b; simpa [Matrix.transpose_apply] using this
  unfold ricStar
  rw [inner2_eq_sum]
  simp only [Matrix.add_apply, mul_phi_apply, phi_mul_apply, mul_add, mul_sub, mul_ite, mul_zero,
    Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_ite_irrel, Finset.sum_const_zero,
    Finset.sum_ite_eq', Finset.mem_univ, if_true]
  simp only [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [hY' i k, hY' j k, hh' k j, hh' k i]
  ring

/-- **`Ric*` is the adjoint of the Ricci contraction**: `⟨Ric(A), h⟩ = ⟨A, Ric*(h)⟩_{Λ²}` at symmetric `h`,
for a linear `A` preserving bivectors. -/
theorem ricStar_adjoint (A : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hA : IsLinOp A)
    (hskew : ∀ X, IsSkew X → IsSkew (A X)) (h : Matrix (Fin n) (Fin n) ℝ) (hh : hᵀ = h) :
    ∑ a, ∑ b, Ric A a b * h a b = innerOp A (ricStar h) := by
  have hneg : ∀ i j, A (phi j i) = - A (phi i j) := fun i j => by
    rw [phi_swap, show -phi i j = (-1 : ℝ) • phi i j by simp, hA.2]; simp
  have hS : ∀ i j, IsSkew (A (phi i j)) := fun i j => hskew _ (phi_isSkew i j)
  have hh' : ∀ a b, h b a = h a b := fun a b => by
    have := congrFun (congrFun hh a) b; simpa [Matrix.transpose_apply] using this
  unfold innerOp Ric
  simp only [fun i j => inner2_ricStar_phi h _ hh (hS i j) i j, fun a c b => inner2_phi _ (hS a c) b c,
    Finset.sum_mul, Finset.sum_sub_distrib, Finset.mul_sum, mul_sub]
  -- the first half is the second after `i ↔ j`
  have e : ∑ i, ∑ j, ∑ k, (1 / 2 : ℝ) * (h j k * A (phi i j) k i)
      = ∑ i, ∑ j, ∑ k, -((1 / 2 : ℝ) * (h i k * A (phi i j) k j)) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
    rw [hneg]; simp only [Matrix.neg_apply]; ring
  rw [e]
  refine (Finset.sum_congr rfl fun a _ => Finset.sum_comm).trans ?_
  rw [← sub_eq_zero]
  simp only [← Finset.sum_sub_distrib]
  refine Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun c _ => Finset.sum_eq_zero fun b _ => ?_
  ring

/-- **`Ric*(λ id) = 2λ Id`.** -/
theorem ricStar_scalar (lam0 : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    ricStar (lam0 • (1 : Matrix (Fin n) (Fin n) ℝ)) X = (2 * lam0) • X := by
  unfold ricStar
  rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.one_mul, Matrix.mul_one, ← add_smul]
  ring_nf

/-- `∑_a Ric(A)_aa = 2 tr_{Λ²} A`. -/
theorem sum_Ric_diag (A : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) :
    ∑ a, Ric A a a = 2 * HamiltonsCubic.L15Statement.traceOp A := by
  unfold Ric HamiltonsCubic.L15Statement.traceOp; ring

section frame

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

/-- **`tr_{Λ²}|W| = ∑ |λ_k|`.** -/
theorem traceOp_absOp :
    HamiltonsCubic.L15Statement.traceOp (absOp R hR hskew hsym)
      = ∑ k, |(Mpair_isHermitian R hR hskew hsym).eigenvalues k| := by
  have hf := absOp_eigenFrame R hR hskew hsym
  have hF : ∀ c : Pairs n → ℝ, absOp R hR hskew hsym (∑ γ, c γ • frameVec R hR hskew hsym γ)
      = ∑ γ, c γ • absOp R hR hskew hsym (frameVec R hR hskew hsym γ) :=
    fun c => absOp_lin R hR hskew hsym _ c _ (fun k => frameVec_skew R hR hskew hsym k)
  have hid : ∀ c : Pairs n → ℝ, (fun X : Matrix (Fin n) (Fin n) ℝ => X)
      (∑ γ, c γ • frameVec R hR hskew hsym γ) = ∑ γ, c γ • (fun X => X) (frameVec R hR hskew hsym γ) :=
    fun c => rfl
  have e : HamiltonsCubic.L15Statement.traceOp (absOp R hR hskew hsym)
      = innerOp (absOp R hR hskew hsym) (fun X => X) := by
    unfold HamiltonsCubic.L15Statement.traceOp innerOp; rfl
  rw [e, innerOp_frame hf _ _ hF hid]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [hf.eigen k, inner2_smul_l, hf.orthonormal k k, if_pos rfl, mul_one]

/-- **`λ = 2 tr|W|/n`** when `Ric(|W|) = λ id`. -/
theorem lam_eq (hn : 0 < n) (lam0 : ℝ)
    (hscal : ∀ a b, Ric (absOp R hR hskew hsym) a b = if a = b then lam0 else 0) :
    lam0 = 2 * (∑ k, |(Mpair_isHermitian R hR hskew hsym).eigenvalues k|) / n := by
  have h := sum_Ric_diag (absOp R hR hskew hsym)
  rw [traceOp_absOp R hR hskew hsym] at h
  simp only [hscal, ite_true, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul] at h
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  field_simp
  linarith

/-- **`λ > 0` at `W ≠ 0`**, some eigenvalue being nonzero. -/
theorem lam_pos (hn : 0 < n) (lam0 : ℝ)
    (hscal : ∀ a b, Ric (absOp R hR hskew hsym) a b = if a = b then lam0 else 0)
    (hW0 : ∃ k, (Mpair_isHermitian R hR hskew hsym).eigenvalues k ≠ 0) : 0 < lam0 := by
  rw [lam_eq R hR hskew hsym hn lam0 hscal]
  obtain ⟨k, hk⟩ := hW0
  have hsum : 0 < ∑ k, |(Mpair_isHermitian R hR hskew hsym).eigenvalues k| :=
    lt_of_lt_of_le (abs_pos.mpr hk)
      (Finset.single_le_sum (f := fun j => |(Mpair_isHermitian R hR hskew hsym).eigenvalues j|)
        (fun j _ => abs_nonneg _) (Finset.mem_univ k))
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  positivity

/-- `J₅ = ⟨X_inv, H⟩` in the frame, at `H = Ric*(h)`. -/
noncomputable def J5 (h : Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  ∑ γ, ∑ δ, XinvRec R (absOp R hR hskew hsym) (frameVec R hR hskew hsym)
      (Mpair_isHermitian R hR hskew hsym).eigenvalues γ δ
    * inner2 (ricStar h (frameVec R hR hskew hsym γ)) (frameVec R hR hskew hsym δ)

/-- **At scalar `h`, `J₅ = 2λ tr X_inv`**, i.e. `λ scal(X_inv)`. -/
theorem J5_scalar (lam0 : ℝ) :
    J5 R hR hskew hsym (lam0 • 1) = 2 * lam0 * ∑ γ, XinvRec R (absOp R hR hskew hsym)
      (frameVec R hR hskew hsym) (Mpair_isHermitian R hR hskew hsym).eigenvalues γ γ := by
  unfold J5
  simp only [ricStar_scalar, inner2_smul_l, frameVec_orth, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq, Finset.mem_univ, if_true, Finset.mul_sum]
  exact Finset.sum_congr rfl fun γ _ => by ring

/-- **L154 (ii)**: at `h = Ric(|W|) = λ id` with `W ≠ 0`, `J₅ ≥ 0`, and `J₅ = 0` iff `X_inv = 0`. -/
theorem L154_ii (hn : 0 < n) (lam0 : ℝ)
    (hscal : ∀ a b, Ric (absOp R hR hskew hsym) a b = if a = b then lam0 else 0)
    (hW0 : ∃ k, (Mpair_isHermitian R hR hskew hsym).eigenvalues k ≠ 0) :
    0 ≤ J5 R hR hskew hsym (lam0 • 1) ∧
      (J5 R hR hskew hsym (lam0 • 1) = 0 ↔ ∀ γ δ, XinvRec R (absOp R hR hskew hsym)
        (frameVec R hR hskew hsym) (Mpair_isHermitian R hR hskew hsym).eigenvalues γ δ = 0) := by
  have hl := lam_pos R hR hskew hsym hn lam0 hscal hW0
  have hdiag : ∀ γ, 0 ≤ XinvRec R (absOp R hR hskew hsym) (frameVec R hR hskew hsym)
      (Mpair_isHermitian R hR hskew hsym).eigenvalues γ γ := by
    intro γ
    rw [XinvRec_eq (fun s' c x hx => R_lin R hR s' c x hx) hskew
      (fun s' c x hx => absOp_lin R hR hskew hsym s' c x hx) (fun X _ => absOp_skew R hR hskew hsym X)
      (eigenFrame_exists R hR hskew hsym) (absOp_eigenFrame R hR hskew hsym)]
    exact HamiltonsCubic.L155Frame.Xinv_diag_nonneg _ _ γ
  have htr : 0 ≤ ∑ γ, XinvRec R (absOp R hR hskew hsym) (frameVec R hR hskew hsym)
      (Mpair_isHermitian R hR hskew hsym).eigenvalues γ γ := Finset.sum_nonneg fun γ _ => hdiag γ
  rw [J5_scalar]
  refine ⟨by positivity, ?_⟩
  rw [← L154_exists R hR hskew hsym]
  constructor
  · intro h0
    rcases mul_eq_zero.mp h0 with h1 | h1
    · linarith
    · exact h1
  · intro h0; rw [h0, mul_zero]

end frame

end HamiltonsCubic.EigenFrameExist
