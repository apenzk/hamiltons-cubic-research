import HamiltonsCubic.Results.FrameInv
import HamiltonsCubic.Results.EigenFrameExist
import HamiltonsCubic.Results.FoxBridge
import HamiltonsCubic.Results.L24Sharp

set_option linter.style.longLine false

/-!
# The frame change preserves `‖·‖` and `θ`

Milestone 2 of [the frame-invariance plan](../../../reviews/2026-09-26-lean-frame-invariance-plan.md), on
[FrameInv.lean](FrameInv.lean)'s `isWeyl_conj` and `eigenFrame_conj`. A frame change carries an eigenframe
`v` to `U v Uᵀ` with the same eigenvalues and the same structure constants `⟨[v_γ, v_a], v_b⟩`, and the layer's
frame identities compute `‖W‖²`, `tr W³` and `⟨W, W#⟩` from those alone:

* **`invariants_conj_of_frame`**: `‖U·R‖ = ‖R‖` and `P(U·R) = P(R)` for a Weyl `R` with an eigenframe;
* **`theta_congr_skew`**: `θ` reads an operator on bivectors only;
* **`invariants_conj`**: **`‖U·R‖ = ‖R‖` and `θ(U·R) = θ(R)` for every Weyl operator on `ℝⁿ`** and orthogonal `U`, through the linear
  operator `X ↦ R(skew X)` that agrees with `R` on bivectors and has an eigenframe by `eigenFrame_exists`.
-/

namespace HamiltonsCubic.FrameLayer

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame

section Frame

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

/-- **`‖·‖²` and `P` are unchanged by a frame change**, at a Weyl operator with an eigenframe. -/
theorem invariants_conj_of_frame {U : Matrix ι ι ℝ} (hU : IsOrth U) {R : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hW : IsWeyl R) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} (hf : EigenFrame R v lam) :
    normSq (conjOp U R) = normSq R ∧ Pcubic (conjOp U R) = Pcubic R := by
  have hW' := isWeyl_conj hU hW
  have hf' := eigenFrame_conj hU hf
  refine ⟨by rw [normSq_frame hW' hf', normSq_frame hW hf], ?_⟩
  unfold Pcubic
  rw [trCube_frame hW' hf', trCube_frame hW hf, sharpPair_T hW' hf', sharpPair_T hW hf]
  simp only [cst_conj hU]

end Frame

section Congr

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`θ` reads an operator on bivectors only.** -/
theorem theta_congr_skew {R S : Matrix ι ι ℝ → Matrix ι ι ℝ} (hR : ∀ X, IsSkew X → IsSkew (R X))
    (hRS : ∀ X, IsSkew X → R X = S X) : theta R = theta S := by
  have hcomp : ∀ X, IsSkew X → compOp R X = compOp S X := fun X hX => by
    unfold compOp; rw [hRS X hX, hRS _ (by rw [← hRS X hX]; exact hR X hX)]
  have hsharp : ∀ X, IsSkew X → sharpOp R X = sharpOp S X :=
    HamiltonsCubic.TensorBridge.sharpOp_congr_on_skew hR hRS
  have hN : normSq R = normSq S := innerOp_congr_skew hRS hRS
  have hP : Pcubic R = Pcubic S := by
    unfold Pcubic trCube sharpPair
    rw [innerOp_congr_skew hcomp hRS, innerOp_congr_skew hRS hsharp]
  unfold theta HamiltonsCubic.RealLayer.norm
  rw [hN, hP]

/-- The skew part `½(X - Xᵀ)`. -/
noncomputable def skewPart (X : Matrix ι ι ℝ) : Matrix ι ι ℝ := (1 / 2 : ℝ) • (X - Xᵀ)

theorem skewPart_skew (X : Matrix ι ι ℝ) : IsSkew (skewPart X) := by
  unfold IsSkew skewPart
  rw [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_transpose, ← neg_sub, smul_neg]

theorem skewPart_of_skew {X : Matrix ι ι ℝ} (hX : IsSkew X) : skewPart X = X := by
  unfold skewPart; unfold IsSkew at hX; rw [hX, sub_neg_eq_add, ← two_smul ℝ X, smul_smul]; norm_num

/-- **The linear extension** `X ↦ R(skew X)` of an operator known on bivectors. -/
noncomputable def linExt (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => R (skewPart X)

theorem linExt_agree (R : Matrix ι ι ℝ → Matrix ι ι ℝ) {X : Matrix ι ι ℝ} (hX : IsSkew X) : linExt R X = R X := by
  unfold linExt; rw [skewPart_of_skew hX]

theorem linExt_isWeyl {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) : IsWeyl (linExt R) := by
  refine ⟨fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · rw [linExt_agree R hX]; exact hW.1 X hX
  · rw [linExt_agree R hX, linExt_agree R hY]; exact hW.2.1 X Y hX hY
  · have h := hW.2.2.1 i j k l
    unfold bianchi at h ⊢
    simp only [linExt_agree R (phi_isSkew _ _)]
    exact h
  · have h := hW.2.2.2 a b
    unfold Ric at h ⊢
    simp only [linExt_agree R (phi_isSkew _ _)]
    exact h

theorem linExt_lin {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) : IsLinOp (linExt R) := by
  have hadd : ∀ A B, IsSkew A → IsSkew B → R (A + B) = R A + R B := fun A B hA hB => by
    have h := weyl_lin hW Finset.univ (fun _ : Fin 2 => (1 : ℝ)) ![A, B] (fun k => by fin_cases k <;> simpa)
    simpa [Fin.sum_univ_two] using h
  have hsmul : ∀ (c : ℝ) A, IsSkew A → R (c • A) = c • R A := fun c A hA => by
    have h := weyl_lin hW Finset.univ (fun _ : Fin 1 => c) ![A] (fun k => by fin_cases k; simpa)
    simpa using h
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · unfold linExt
    have : skewPart (X + Y) = skewPart X + skewPart Y := by
      unfold skewPart; rw [Matrix.transpose_add, ← smul_add]; congr 1; abel
    rw [this, hadd _ _ (skewPart_skew X) (skewPart_skew Y)]
  · unfold linExt
    have : skewPart (c • X) = c • skewPart X := by
      unfold skewPart; rw [Matrix.transpose_smul, ← smul_sub, smul_comm]
    rw [this, hsmul _ _ (skewPart_skew X)]

end Congr

section Fin

variable {n : ℕ}

/-- **`‖·‖` and `θ` are invariant under every frame change**, at every Weyl operator on `ℝⁿ`. -/
theorem invariants_conj {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U)
    {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R) :
    normSq (conjOp U R) = normSq R ∧ theta (conjOp U R) = theta R := by
  set R' := linExt R
  have hW' : IsWeyl R' := linExt_isWeyl hW
  have hL : IsLinOp R' := linExt_lin hW
  have hf := HamiltonsCubic.EigenFrameExist.eigenFrame_exists R' hL hW'.1 hW'.2.1
  have hag : ∀ X, IsSkew X → R' X = R X := fun X hX => linExt_agree R hX
  have hagc : ∀ X, IsSkew X → conjOp U R' X = conjOp U R X := fun X hX => by
    unfold conjOp; rw [hag _ (isSkew_conj hX)]
  have hinv := invariants_conj_of_frame hU hW' hf
  have hN1 : normSq (conjOp U R) = normSq (conjOp U R') := (innerOp_congr_skew hagc hagc).symm
  have hN2 : normSq R' = normSq R := innerOp_congr_skew hag hag
  refine ⟨by rw [hN1, hinv.1, hN2], ?_⟩
  have h1 : theta (conjOp U R') = theta (conjOp U R) := theta_congr_skew (isWeyl_conj hU hW').1 hagc
  have h2 : theta (conjOp U R') = theta R' := by
    unfold theta HamiltonsCubic.RealLayer.norm; rw [hinv.1, hinv.2]
  have h3 : theta R' = theta R := theta_congr_skew hW'.1 hag
  rw [← h1, h2, h3]

end Fin

end HamiltonsCubic.FrameLayer
