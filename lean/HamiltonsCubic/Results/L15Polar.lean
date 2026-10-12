import HamiltonsCubic.Results.L15Statement

set_option linter.style.longLine false

/-!
# L15 polarised at two operators

[L15Statement.lean](L15Statement.lean)'s `L15`: `scal(R² + R#) = ‖Ric R‖² + 6‖Alt R‖²` for every `R`
linear, symmetric and preserving bivectors. [Lemma L7](../../../findings/bounds.md)'s last step
polarises it at `(W₊, W₋)`. **This file proves the polarised form for any two such operators whose
difference has vanishing Ricci contraction and vanishing `Alt`**:

- `sharpX A C η = −¼ ∑ ⟨[η, A[η, C φ_ij]], φ_ij⟩`, the mixed sharp form, with `sharpX A A = sharpQF A`,
  and `sharpTraceX` its trace over the `φ` basis;
- `L15_polar`: **if `Ric A = Ric C` and `Alt A = Alt C` then
  `sharpTraceX A C + sharpTraceX C A + 2⟨A, C⟩ = ‖Ric C‖² + 6‖Alt C‖²`**, from `L15` at `A`, `C` and
  `A − C`. At `A = W₊`, `C = W₋` of a Weyl `W = W₊ − W₋` the left side is `2 tr(W₊ # W₋)`, since
  `⟨W₊, W₋⟩ = 0`, and this is the record's `2 tr(W₊ # W₋) = ‖Ric(W₋)‖² + 6δ²`.
-/

namespace HamiltonsCubic.L15Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The mixed sharp form `−¼ ∑ ⟨[η, A[η, C φ]], φ⟩`. -/
noncomputable def sharpX (A C : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) : ℝ :=
  -(1/4) * ∑ i : ι, ∑ j : ι, inner2 (br η (A (br η (C (phi i j))))) (phi i j)

/-- Its trace over the `φ` basis. -/
noncomputable def sharpTraceX (A C : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  (1 / 2) * ∑ i : ι, ∑ j : ι, sharpX A C (phi i j)

omit [DecidableEq ι] in
theorem inner2_sub_left' (X Y Z : Matrix ι ι ℝ) : inner2 (X - Y) Z = inner2 X Z - inner2 Y Z := by
  unfold inner2; rw [Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring

omit [DecidableEq ι] in
theorem inner2_sub_right' (X Y Z : Matrix ι ι ℝ) : inner2 X (Y - Z) = inner2 X Y - inner2 X Z := by
  unfold inner2; rw [Matrix.mul_sub, Matrix.trace_sub]; ring

omit [DecidableEq ι] in
theorem br_sub_right (X Y Z : Matrix ι ι ℝ) : br X (Y - Z) = br X Y - br X Z := by
  unfold br; rw [Matrix.mul_sub, Matrix.sub_mul]; abel

omit [Fintype ι] [DecidableEq ι] in
theorem linOp_sub {A : Matrix ι ι ℝ → Matrix ι ι ℝ} (hA : IsLinearOp A) (X Y : Matrix ι ι ℝ) :
    A (X - Y) = A X - A Y := by
  have h1 := hA.1 X ((-1 : ℝ) • Y)
  rw [hA.2 (-1) Y, neg_one_smul, neg_one_smul, ← sub_eq_add_neg, ← sub_eq_add_neg] at h1
  exact h1

/-- The difference operator. -/
def subOp (A C : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => A X - C X

omit [Fintype ι] [DecidableEq ι] in
theorem subOp_lin {A C : Matrix ι ι ℝ → Matrix ι ι ℝ} (hA : IsLinearOp A) (hC : IsLinearOp C) :
    IsLinearOp (subOp A C) := by
  refine ⟨fun X Y => ?_, fun a X => ?_⟩
  · simp only [subOp, hA.1, hC.1]; abel
  · simp only [subOp, hA.2, hC.2, smul_sub]

omit [DecidableEq ι] in
theorem subOp_sym {A C : Matrix ι ι ℝ → Matrix ι ι ℝ} (hA : IsSymmetricOp A) (hC : IsSymmetricOp C) :
    IsSymmetricOp (subOp A C) := by
  intro X Y hX hY
  simp only [subOp, inner2_sub_left', inner2_sub_right', hA X Y hX hY, hC X Y hX hY]

omit [Fintype ι] [DecidableEq ι] in
theorem subOp_skew {A C : Matrix ι ι ℝ → Matrix ι ι ℝ} (hA : ∀ X, IsSkew X → IsSkew (A X))
    (hC : ∀ X, IsSkew X → IsSkew (C X)) : ∀ X, IsSkew X → IsSkew (subOp A C X) := by
  intro X hX
  have h1 := hA X hX; have h2 := hC X hX
  unfold IsSkew at *; simp only [subOp, Matrix.transpose_sub, h1, h2]; abel

/-- **`sharpQF` of a difference.** -/
theorem sharpQF_sub {A C : Matrix ι ι ℝ → Matrix ι ι ℝ} (hA : IsLinearOp A) (hC : IsLinearOp C)
    (η : Matrix ι ι ℝ) :
    sharpQF (subOp A C) η = sharpQF A η + sharpQF C η - sharpX A C η - sharpX C A η := by
  unfold sharpQF sharpX
  have key : ∀ i j : ι, inner2 (br η (subOp A C (br η (subOp A C (phi i j))))) (phi i j)
      = inner2 (br η (A (br η (A (phi i j))))) (phi i j) + inner2 (br η (C (br η (C (phi i j))))) (phi i j)
        - inner2 (br η (A (br η (C (phi i j))))) (phi i j)
        - inner2 (br η (C (br η (A (phi i j))))) (phi i j) := by
    intro i j
    simp only [subOp, br_sub_right, linOp_sub hA, linOp_sub hC, inner2_sub_left']
    ring
  simp only [key, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  ring

/-- **`sharpTrace` of a difference.** -/
theorem sharpTrace_sub {A C : Matrix ι ι ℝ → Matrix ι ι ℝ} (hA : IsLinearOp A) (hC : IsLinearOp C) :
    sharpTrace (subOp A C) = sharpTrace A + sharpTrace C - sharpTraceX A C - sharpTraceX C A := by
  unfold sharpTrace sharpTraceX
  simp only [sharpQF_sub hA hC, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  ring

/-- **`‖·‖²` of a difference.** -/
theorem normSq_sub' (A C : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    normSq (subOp A C) = normSq A + normSq C - 2 * innerOp A C := by
  unfold normSq innerOp
  have key : ∀ i j : ι, inner2 (subOp A C (phi i j)) (subOp A C (phi i j))
      = inner2 (A (phi i j)) (A (phi i j)) + inner2 (C (phi i j)) (C (phi i j))
        - 2 * inner2 (A (phi i j)) (C (phi i j)) := by
    intro i j
    simp only [subOp, inner2_sub_left', inner2_sub_right', inner2_comm (C (phi i j)) (A (phi i j))]
    ring
  simp only [key, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
  ring

theorem Ric_sub (A C : Matrix ι ι ℝ → Matrix ι ι ℝ) (a b : ι) :
    Ric (subOp A C) a b = Ric A a b - Ric C a b := by
  unfold Ric; simp only [subOp, inner2_sub_left', Finset.sum_sub_distrib]

theorem altCoeff_sub (A C : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    altCoeff (subOp A C) i j k l = altCoeff A i j k l - altCoeff C i j k l := by
  unfold altCoeff alt4 AltLayer.comp; simp only [subOp, inner2_sub_left']; ring

/-- **L15 POLARISED.** For `A`, `C` linear, symmetric and preserving bivectors, with equal Ricci
contractions and equal `Alt`, `sharpTraceX A C + sharpTraceX C A + 2⟨A, C⟩ = ‖Ric C‖² + 6‖Alt C‖²`. -/
theorem L15_polar {A C : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hAl : IsLinearOp A) (hAs : IsSymmetricOp A) (hAk : ∀ X, IsSkew X → IsSkew (A X))
    (hCl : IsLinearOp C) (hCs : IsSymmetricOp C) (hCk : ∀ X, IsSkew X → IsSkew (C X))
    (hRic : ∀ a b, Ric A a b = Ric C a b)
    (hAlt : ∀ i j k l, altCoeff A i j k l = altCoeff C i j k l) :
    sharpTraceX A C + sharpTraceX C A + 2 * innerOp A C = ricNormSq C + 6 * altNormSq C := by
  have hD := L15 (subOp A C) (subOp_lin hAl hCl) (subOp_sym hAs hCs) (subOp_skew hAk hCk)
  have hA := L15 A hAl hAs hAk
  have hC := L15 C hCl hCs hCk
  have hric0 : ricNormSq (subOp A C) = 0 := by
    unfold ricNormSq; simp [Ric_sub, hRic]
  have halt0 : altNormSq (subOp A C) = 0 := by
    unfold altNormSq fourNormSq fourInner; simp [altCoeff_sub, hAlt]
  have hricA : ricNormSq A = ricNormSq C := by unfold ricNormSq; simp [hRic]
  have haltA : altNormSq A = altNormSq C := by
    unfold altNormSq; congr 1; funext i j k l; exact hAlt i j k l
  unfold scalQ at hD hA hC
  rw [hric0, halt0, normSq_sub', sharpTrace_sub hAl hCl] at hD
  rw [hricA, haltA] at hA
  linarith

end HamiltonsCubic.L15Statement
