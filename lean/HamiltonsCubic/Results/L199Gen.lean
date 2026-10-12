import Mathlib
import HamiltonsCubic.Results.L244Unit

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L199 at every `n`: the orbit-tangent form is `4(W²#I) − 4W#W`, with no hypothesis beyond symmetry

[findings/bounds.md](../../../findings/bounds.md), Lemma L199: *Let $W$ be any symmetric operator on $\Lambda^2\mathbb R^n$ and let $G_W$
be the symmetric operator with $\langle G_Wx,x\rangle=\lVert[\mathrm{ad}(x),W]\rVert^2$. Then $G_W=4(W^2\#I)-4(W\#W)$, with no hypothesis
of any kind.* [L199Statement.lean](L199Statement.lean) proves it at `n = 4` over `ℚ`. Here it holds at every `n`, as the quadratic form
of both sides at every bivector `η`: `innerOp` is the record's norm on operators, `sharpQF W η` is `⟨(W#W)η, η⟩` and
`mixSym A B η` is `2⟨(A#B)η, η⟩`.

* **`G_eq_sharp_gen`**: `‖[ad η, W]‖² = 2 mixSym(W², I)(η) − 4 sharpQF W η` for every linear `W` preserving bivectors and symmetric on
  them, i.e. `⟨G_W η, η⟩ = 4⟨(W²#I)η, η⟩ − 4⟨(W#W)η, η⟩`.
-/

namespace HamiltonsCubic.L199Gen

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results

variable {n : ℕ}

/-- `[ad η, W] : X ↦ [η, W X] − W [η, X]`. -/
def adComm (η : Matrix (Fin n) (Fin n) ℝ) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) :
    Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ :=
  fun X => br η (W X) - W (br η X)

theorem br_skew {A B : Matrix (Fin n) (Fin n) ℝ} (hA : IsSkew A) (hB : IsSkew B) : IsSkew (br A B) :=
  HamiltonsCubic.L244RowA.br_isSkew hA hB

/-- **L199 at every `n`.** -/
theorem G_eq_sharp_gen (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hlin : IsLinOp W)
    (hskew : ∀ X, IsSkew X → IsSkew (W X)) (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (W X) Y = inner2 X (W Y))
    (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) :
    innerOp (adComm η W) (adComm η W) = 2 * mixSym (fun X => W (W X)) (fun X => X) η - 4 * sharpQF W η := by
  have hφ : ∀ i j : Fin n, IsSkew (phi i j) := fun i j => phi_isSkew i j
  -- the three sums
  set A1 := ∑ i, ∑ j, inner2 (br η (W (phi i j))) (br η (W (phi i j))) with hA1
  set A2 := ∑ i, ∑ j, inner2 (br η (W (phi i j))) (W (br η (phi i j))) with hA2
  set A3 := ∑ i, ∑ j, inner2 (W (br η (phi i j))) (W (br η (phi i j))) with hA3
  have hexp : innerOp (adComm η W) (adComm η W) = (1 / 2) * (A1 - 2 * A2 + A3) := by
    have e : ∀ i j : Fin n, inner2 (br η (W (phi i j)) - W (br η (phi i j))) (br η (W (phi i j)) - W (br η (phi i j)))
        = inner2 (br η (W (phi i j))) (br η (W (phi i j))) - 2 * inner2 (br η (W (phi i j))) (W (br η (phi i j)))
          + inner2 (W (br η (phi i j))) (W (br η (phi i j))) := by
      intro i j
      rw [HamiltonsCubic.L244Unit.i_sub_l, HamiltonsCubic.L244Unit.i_sub_r, HamiltonsCubic.L244Unit.i_sub_r,
        inner2_comm (W (br η (phi i j))) (br η (W (phi i j)))]
      ring
    unfold innerOp adComm
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
    rw [hA1, hA2, hA3]
  -- `sharpQF W η = ¼ A2`
  have hS : sharpQF W η = (1 / 4) * A2 := by
    unfold sharpQF
    rw [hA2, Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [inner2_br_skew η _ _ hη, hsym _ _ (br_skew hη (hskew _ (hφ i j))) (br_skew hη (hφ i j)), inner2_comm]
    ring
  -- `mixQF (W²) I η = ¼ A3`
  have hM1 : mixQF (fun X => W (W X)) (fun X => X) η = (1 / 4) * A3 := by
    unfold mixQF
    rw [hA3, Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [inner2_br_skew η _ _ hη, hsym _ _ (hskew _ (br_skew hη (hφ i j))) (br_skew hη (hφ i j))]
    ring
  -- `mixQF I (W²) η = ¼ A1`, through the cyclicity of the trace
  have hM2 : mixQF (fun X => X) (fun X => W (W X)) η = (1 / 4) * A1 := by
    have hAd : IsLinOp (fun X => -br η (br η X)) := by
      have had := HamiltonsCubic.L244RowB.ad_isLinOp η
      refine ⟨fun X Y => ?_, fun c X => ?_⟩
      · simp only [had.1]; abel
      · simp only [had.2, smul_neg]
    have hT : IsLinOp (fun X => -br η (br η (W X))) :=
      ⟨fun X Y => by simp only [hlin.1, hAd.1], fun c X => by simp only [hlin.2, hAd.2]⟩
    have hcyc := HamiltonsCubic.L244RowB.trace_cyc W (fun X => -br η (br η (W X))) hlin hT
      (fun i j => hskew _ (hφ i j))
      (fun i j => by
        have := br_skew hη (br_skew hη (hskew _ (hφ i j)))
        unfold IsSkew at this ⊢; rw [Matrix.transpose_neg, this])
    have e1 : ∀ i j : Fin n, inner2 (br η (W (phi i j))) (br η (W (phi i j)))
        = inner2 (W (-br η (br η (W (phi i j))))) (phi i j) := by
      intro i j
      have hZ : IsSkew (-br η (br η (W (phi i j)))) := by
        have := br_skew hη (br_skew hη (hskew _ (hφ i j))); unfold IsSkew at this ⊢; rw [Matrix.transpose_neg, this]
      rw [inner2_br_skew η _ _ hη, hsym _ _ hZ (hφ i j), inner2_comm _ (W (phi i j))]
      unfold inner2; simp only [Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg, Matrix.trace_neg]; ring
    unfold mixQF
    rw [hA1]
    simp only [e1]
    rw [hcyc]
    rw [Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    unfold inner2; simp only [Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg, Matrix.trace_neg]; ring
  unfold mixSym
  rw [hexp, hS, hM1, hM2]
  ring

end HamiltonsCubic.L199Gen
