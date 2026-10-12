import HamiltonsCubic.Results.L191Statement
import HamiltonsCubic.Results.L184Proof

/-!
# L191, proved

**`L191` is the record's pair rigidity**, from [diagonal-half.md](../../../findings/diagonal-half.md)'s
*Lemma L191*:

> *Let `ω₁, ω₂` be `2`-forms with a common six-dimensional support, `ω₁² = ω₂²` and
> `ω₁ ∧ ω₁ = ω₂ ∧ ω₂`. Then `ω₂ = ±ω₁`.*

It is proved without the record's three cases, by the argument of [L184Proof.lean](L184Proof.lean):
`six_frame` carries both forms to `ℝ⁶` with `Pf(X₁) ≠ 0`, and the adjugate law of
[L193](L193Statement.lean) with one `σ` for both gives `Pf(X₁) X₁ = Pf(X₂) X₂`, so `X₂ = c X₁`.
Equal squares give `c² = 1`, since `X₁² ≠ 0` for a nonzero skew `X₁`. *Orthogonality is used
nowhere, and neither is a norm: equal norms follow from equal squares.*
[L191Statement.lean](L191Statement.lean)'s `falsifier_at_dim4` shows the six is sharp.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L191Statement

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer HamiltonsCubic.L184Statement

theorem pf6_zero : pf6 (0 : Matrix (Fin 6) (Fin 6) ℝ) = 0 := by
  simp [pf6, triple6]

/-- A nonzero skew matrix has nonzero square: `tr X² = -‖X‖²`. -/
theorem sq_ne_zero_of_skew {X : Matrix (Fin 6) (Fin 6) ℝ} (hX : IsSkew X) (h0 : X ≠ 0) :
    X * X ≠ 0 := by
  intro hsq
  apply h0
  have ht : (Xᵀ * X).trace = 0 := by
    unfold IsSkew at hX; rw [hX, Matrix.neg_mul, hsq, neg_zero, Matrix.trace_zero]
  have hsum : ∑ i, ∑ j, X j i * X j i = 0 := by
    rw [← ht]; simp [Matrix.trace, Matrix.mul_apply]
  ext i j
  have hnn : ∀ a ∈ (Finset.univ : Finset (Fin 6)), 0 ≤ ∑ b, X b a * X b a :=
    fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hsum j (Finset.mem_univ j)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun b _ => mul_self_nonneg (X b j))).mp h1 i
    (Finset.mem_univ i)
  simpa using h2

/-- **The rigidity at `ℝ⁶`.** -/
theorem rigid6 (X1 X2 : Matrix (Fin 6) (Fin 6) ℝ) (h1 : IsSkew X1) (h2 : IsSkew X2)
    (hsq : X1 * X1 = X2 * X2) (hw : wedgeSelf X1 = wedgeSelf X2) (hpf : pf6 X1 ≠ 0) :
    X2 = X1 ∨ X2 = -X1 := by
  have hs : L193Statement.sigma6 X1 = L193Statement.sigma6 X2 := by
    unfold L193Statement.sigma6; rw [hw]
  have e1 : X1 * X1 * L193Statement.sigma6 X1 = (-(pf6 X1)) • X1 := by
    rw [Matrix.mul_assoc, L193Statement.adjugate_law X1 h1, Matrix.mul_smul, Matrix.mul_one]
  have e2 : X2 * X2 * L193Statement.sigma6 X2 = (-(pf6 X2)) • X2 := by
    rw [Matrix.mul_assoc, L193Statement.adjugate_law X2 h2, Matrix.mul_smul, Matrix.mul_one]
  have e : (-(pf6 X1)) • X1 = (-(pf6 X2)) • X2 := by rw [← e1, ← e2, hsq, hs]
  set c := pf6 X2 / pf6 X1 with hc
  have hX1 : X1 = c • X2 := by
    have := congrArg (fun M => (-(pf6 X1))⁻¹ • M) e
    simp only [smul_smul] at this
    rw [inv_mul_cancel₀ (neg_ne_zero.mpr hpf), one_smul] at this
    rw [this, hc]; congr 1; field_simp
  have hX10 : X1 ≠ 0 := fun h => hpf (by rw [h, pf6_zero])
  have hsq0 := sq_ne_zero_of_skew h1 hX10
  have hc2 : c * c = 1 := by
    have h' : X1 * X1 = (c * c) • (X1 * X1) := by
      conv_lhs => rw [hX1]
      rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, ← hsq]
    have h'' : (1 - c * c) • (X1 * X1) = 0 := by
      rw [sub_smul, one_smul, ← h', sub_self]
    rcases smul_eq_zero.mp h'' with h | h
    · linarith
    · exact absurd h hsq0
  have hc' : c = 1 ∨ c = -1 := by
    have : (c - 1) * (c + 1) = 0 := by ring_nf; linarith
    rcases mul_eq_zero.mp this with h | h
    · left; linarith
    · right; linarith
  rcases hc' with h | h
  · left; rw [hX1, h, one_smul]
  · right; rw [hX1, h, neg_one_smul, neg_neg]

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **L191.** Two `2`-forms with a common six-dimensional support, equal squares and equal
self-wedges are equal up to sign. -/
theorem L191 (V : Submodule ℝ (ι → ℝ)) (om1 om2 : Matrix ι ι ℝ)
    (hs1 : IsSkew om1) (hs2 : IsSkew om2)
    (hsupp1 : support om1 = V) (hsupp2 : support om2 = V)
    (hdim : Module.finrank ℝ V = 6)
    (hsq : om1 * om1 = om2 * om2) (hwedge : wedgeSelf om1 = wedgeSelf om2) :
    om2 = om1 ∨ om2 = -om1 := by
  obtain ⟨U, hL1, hR1, hL2, hR2, hpf⟩ := six_frame V om1 om2 hs1 hs2 hsupp1 hsupp2 hdim
  have hskewX : ∀ om : Matrix ι ι ℝ, IsSkew om → IsSkew (Uᵀ * om * U) := by
    intro om hs; unfold IsSkew at hs ⊢
    rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hs]
    simp [Matrix.mul_assoc]
  have hsqX : ∀ om : Matrix ι ι ℝ, om * (U * Uᵀ) = om →
      (Uᵀ * om * U) * (Uᵀ * om * U) = Uᵀ * (om * om) * U := by
    intro om h
    calc (Uᵀ * om * U) * (Uᵀ * om * U) = Uᵀ * (om * (U * Uᵀ)) * om * U := by
          simp only [Matrix.mul_assoc]
      _ = _ := by rw [h, Matrix.mul_assoc Uᵀ om om]
  have hback : ∀ om : Matrix ι ι ℝ, U * Uᵀ * om = om → om * (U * Uᵀ) = om →
      U * (Uᵀ * om * U) * Uᵀ = om := by
    intro om hl hr
    calc U * (Uᵀ * om * U) * Uᵀ = U * Uᵀ * om * (U * Uᵀ) := by simp only [Matrix.mul_assoc]
      _ = om := by rw [hl, hr]
  have hsq6 : (Uᵀ * om1 * U) * (Uᵀ * om1 * U) = (Uᵀ * om2 * U) * (Uᵀ * om2 * U) := by
    rw [hsqX om1 hR1, hsqX om2 hR2, hsq]
  have hw6 : wedgeSelf (Uᵀ * om1 * U) = wedgeSelf (Uᵀ * om2 * U) := by
    funext a b c d; rw [wedgeSelf_congr, wedgeSelf_congr, hwedge]
  rcases rigid6 _ _ (hskewX om1 hs1) (hskewX om2 hs2) hsq6 hw6 hpf with h | h
  · left; rw [← hback om2 hL2 hR2, h, hback om1 hL1 hR1]
  · right; rw [← hback om2 hL2 hR2, h, Matrix.mul_neg, Matrix.neg_mul, hback om1 hL1 hR1]

end HamiltonsCubic.L191Statement
