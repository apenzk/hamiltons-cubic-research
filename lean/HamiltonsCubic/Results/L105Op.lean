import Mathlib
import HamiltonsCubic.Results.L244Frame
import HamiltonsCubic.Results.L105Closing
import HamiltonsCubic.Results.L71Theta
import HamiltonsCubic.Results.L75Statement

set_option linter.style.longLine false

/-!
# L105 at the operator: a two-valued unit critical point has `θ ≤ θ₀(n)`

[L105Closing.lean](L105Closing.lean) proves L105's two branches and the closing inequality from the class-1
and class-2 row identities and `uwN = 1`, which enter as hypotheses; the L105 row owes *"the two row
identities from L104's reduced system at the spectrum and $uwN=1$ from tracelessness and unit norm"*.
This file derives both at the operator, the row identities in their per-vector form, of which the record's
class rows are the class average, from L244's rows at `W`'s own eigenbasis
([L244Frame.lean](L244Frame.lean)): at a frame vector `x` of eigenvalue `λ`, rows (A), (B), (C) are three
linear equations in the class masses `b₀₀(x)`, `b₀₁(x)`, `b₁₁(x)`, and

* `row_u`: at `λ = u`, `(u+w)² b₀₁(x) = u((n-1)w - θ)`, so `b₀₁ ≥ 0` is the `Π`-bound `θ ≤ (n-1)w`;
* `row_w`: at `λ = -w`, `(u+w)² b₁₁(x) = (n-2)u² - 2uw - w² - wθ`, so `b₁₁ ≥ 0` is the tangent bound;
* `uwN_one`: tracelessness and unit norm give `uw·n(n-1)/2 = 1`, and `mult_rel` gives `ru = sw`, `r + s = N` for
  the multiplicities;
* `L105_branches`: both branch bounds at the operator;
* `L105_op`: at every unit critical linear Weyl operator on `ℝⁿ`, `n ≥ 3`, whose spectrum takes exactly
  the values `u > 0` and `-w < 0`, both, `θ ≤ √(2(n-1)(n-2))/n = θ₀(n)`.
  through `L105_branches` and `L105_closing`.
-/

namespace HamiltonsCubic.L105Op

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.EigenFrameExist
  HamiltonsCubic.SecondKind HamiltonsCubic.L244Frame HamiltonsCubic.L244RowA

variable {n : ℕ}

theorem bAB_nonneg' {r K : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a b : Fin K)
    (x : Matrix (Fin n) (Fin n) ℝ) : 0 ≤ bAB ψ cls a b x := by
  unfold bAB
  exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _)

/-- **The rows at a frame vector**, two classes. -/
theorem rows_two (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W) (θ : ℝ)
    (hc : IsCritical W θ) (u w : ℝ) (cls : Fin (Fintype.card (SecondKind.Pairs n)) → Fin 2)
    (hcls : ∀ k, evf W hW k = ![u, -w] (cls k)) (k : Fin (Fintype.card (SecondKind.Pairs n))) :
    let x := ψf W hW k
    let lc := evf W hW k
    let b00 := bAB (ψf W hW) cls 0 0 x
    let b01 := bAB (ψf W hW) cls 0 1 x
    let b11 := bAB (ψf W hW) cls 1 1 x
    b00 + 2 * b01 + b11 = (n : ℝ) - 2 ∧
      u * b00 + (u - w) * b01 - w * b11 = -lc ∧
      u ^ 2 * b00 - 2 * u * w * b01 + w ^ 2 * b11 = lc * (θ - lc) := by
  intro x lc b00 b01 b11
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  have hx : IsSkew x := ψf_skew W hW k
  have hunit : inner2 x x = 1 := by
    have := hf.orthonormal ((eF n).symm k) ((eF n).symm k)
    rw [if_pos rfl] at this
    exact this
  have hsym : bAB (ψf W hW) cls 1 0 x = b01 := bAB_symm _ _ 1 0 x
  have hA := rowA_frame (W := W) (hW := hW) cls x hx
  have hB := rowB_frame (W := W) (hW := hW) cls ![u, -w] hcls x hx
  have hC := rowC_frame (W := W) (hW := hW) cls ![u, -w] hcls x hx
  simp only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, hsym] at hA hB hC
  have hWx : W x = lc • x := ψf_eigen W hW k
  have hWxx : inner2 (W x) x = lc := by rw [hWx, FamilyLayer.inner2_smul_left, hunit, mul_one]
  have hsharp := HamiltonsCubic.L244RowBMass.rowC_critical W hW θ hc x hx lc hWx hunit
  rw [hunit, mul_one] at hA
  rw [hWxx] at hB
  rw [hsharp] at hC
  refine ⟨by linarith, by linarith, by linarith⟩

/-- **The `Π`-bound's identity** at a frame vector of eigenvalue `u`. -/
theorem row_u {n' u w θ b00 b01 b11 : ℝ}
    (hA : b00 + 2 * b01 + b11 = n' - 2) (hB : u * b00 + (u - w) * b01 - w * b11 = -u)
    (hC : u ^ 2 * b00 - 2 * u * w * b01 + w ^ 2 * b11 = u * (θ - u)) :
    (u + w) ^ 2 * b01 = u * ((n' - 1) * w - θ) := by
  linear_combination u * w * hA + (u - w) * hB - hC

/-- **The tangent bound's identity** at a frame vector of eigenvalue `-w`. -/
theorem row_w {n' u w θ b00 b01 b11 : ℝ}
    (hA : b00 + 2 * b01 + b11 = n' - 2) (hB : u * b00 + (u - w) * b01 - w * b11 = -(-w))
    (hC : u ^ 2 * b00 - 2 * u * w * b01 + w ^ 2 * b11 = (-w) * (θ - (-w))) :
    (u + w) ^ 2 * b11 = (n' - 2) * u ^ 2 - 2 * u * w - w ^ 2 - w * θ := by
  linear_combination u ^ 2 * hA - 2 * u * hB + hC

/-- **`uwN = 1`** from tracelessness and unit norm, at a spectrum taking exactly the values `u`, `-w`. -/
theorem uwN_one (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (hunit : normSq W = 1) (u w : ℝ) (hu : 0 < u) (hw : 0 < w)
    (htwo : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u ∨
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w) :
    u * w * ((n : ℝ) * ((n : ℝ) - 1) / 2) = 1 := by
  set ev := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
  have hne : u ≠ -w := by linarith
  have h1 := HamiltonsCubic.L71Theta.sum_two ev u (-w) hne htwo id
  have h2 := HamiltonsCubic.L71Theta.sum_two ev u (-w) hne htwo (fun x => x ^ 2)
  have h0 := HamiltonsCubic.L71Theta.sum_two ev u (-w) hne htwo (fun _ => (1 : ℝ))
  simp only [id, mul_one] at h1 h2 h0
  rw [sum_mu_zero W hW.1 hW.2.1 hW.2.2.1 hW.2.2.2.2] at h1
  rw [sum_mu_sq W hW.1 hW.2.1 hW.2.2.1, hunit] at h2
  rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at h0
  have hcard : (Fintype.card (SecondKind.Pairs n) : ℝ) = (n : ℝ) * ((n : ℝ) - 1) / 2 := by
    rw [show Fintype.card (SecondKind.Pairs n) = n.choose 2 from HamiltonsCubic.L75Statement.Proof.card_tri,
      Nat.cast_choose_two]
  set r := ((univ.filter fun j => ev j = u).card : ℝ)
  set s := ((univ.filter fun j => ev j = -w).card : ℝ)
  -- `r u = s w`, `r u² + s w² = 1`, `r + s = N`
  rw [← hcard, h0]
  have e1 : r * u = s * w := by linarith
  nlinarith [e1]

/-- **The two branches at the operator**: the `Π`-bound `θ ≤ (n-1)w` and the tangent bound
`θw ≤ (n-2)u² - 2uw - w²` at every critical linear Weyl operator whose spectrum takes exactly the values `u > 0`
and `-w < 0`. -/
theorem L105_branches (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (u w : ℝ) (hu : 0 < u) (hw : 0 < w)
    (htwo : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u ∨
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w)
    (hexu : ∃ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u)
    (hexw : ∃ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w) :
    θ ≤ ((n : ℝ) - 1) * w ∧ θ * w ≤ ((n : ℝ) - 2) * u ^ 2 - 2 * u * w - w ^ 2 := by
  have hne : u ≠ -w := by linarith
  -- the labelling of the frame by the two eigenvalues
  set cls : Fin (Fintype.card (SecondKind.Pairs n)) → Fin 2 := fun k => if evf W hW k = u then 0 else 1 with hclsdef
  have hcls : ∀ k, evf W hW k = ![u, -w] (cls k) := by
    intro k
    by_cases h : evf W hW k = u
    · show evf W hW k = ![u, -w] (if evf W hW k = u then 0 else 1)
      rw [if_pos h, h]; rfl
    · have := (htwo ((eF n).symm k)).resolve_left h
      show evf W hW k = ![u, -w] (if evf W hW k = u then 0 else 1)
      rw [if_neg h]; exact this
  -- the `Π`-bound at a frame vector of eigenvalue `u`
  obtain ⟨ju, hju⟩ := hexu
  have hku : evf W hW (eF n ju) = u := by
    show (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues ((eF n).symm (eF n ju)) = u
    rw [Equiv.symm_apply_apply]; exact hju
  obtain ⟨hA1, hB1, hC1⟩ := rows_two W hW θ hc u w cls hcls (eF n ju)
  rw [hku] at hB1 hC1
  have hu1 := row_u hA1 hB1 hC1
  have hb01 := bAB_nonneg' (ψf W hW) cls 0 1 (ψf W hW (eF n ju))
  have hpi : θ ≤ ((n : ℝ) - 1) * w := by
    have h0 := mul_nonneg (sq_nonneg (u + w)) hb01
    have : 0 ≤ u * (((n : ℝ) - 1) * w - θ) := by linarith [hu1]
    by_contra hcon; push Not at hcon
    have : u * (((n : ℝ) - 1) * w - θ) < 0 := mul_neg_of_pos_of_neg hu (by linarith)
    linarith
  -- the tangent bound at a frame vector of eigenvalue `-w`
  obtain ⟨jw, hjw⟩ := hexw
  have hkw : evf W hW (eF n jw) = -w := by
    show (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues ((eF n).symm (eF n jw)) = -w
    rw [Equiv.symm_apply_apply]; exact hjw
  obtain ⟨hA2, hB2, hC2⟩ := rows_two W hW θ hc u w cls hcls (eF n jw)
  rw [hkw] at hB2 hC2
  have hw1 := row_w hA2 hB2 hC2
  have hb11 := bAB_nonneg' (ψf W hW) cls 1 1 (ψf W hW (eF n jw))
  have htan : θ * w ≤ ((n : ℝ) - 2) * u ^ 2 - 2 * u * w - w ^ 2 := by
    have h0 := mul_nonneg (sq_nonneg (u + w)) hb11
    linarith [hw1]
  exact ⟨hpi, htan⟩

/-- **L105 at the operator.** -/
theorem L105_op (hn : 3 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (hunit : normSq W = 1) (u w : ℝ) (hu : 0 < u) (hw : 0 < w)
    (htwo : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u ∨
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w)
    (hexu : ∃ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u)
    (hexw : ∃ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w) :
    θ ≤ Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n := by
  obtain ⟨hpi, htan⟩ := L105_branches W hW θ hc u w hu hw htwo hexu hexw
  have hnR : (3 : ℝ) ≤ n := by exact_mod_cast hn
  exact HamiltonsCubic.Results.L105_closing (n : ℝ) u w θ hnR hu hw (uwN_one W hW hunit u w hu hw htwo) hpi htan

/-- **The multiplicities**: with `r`, `s` the multiplicities of `u` and `-w`, `r u = s w` and `r + s = N`. -/
theorem mult_rel (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (u w : ℝ) (hu : 0 < u) (hw : 0 < w)
    (htwo : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u ∨
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w) :
    ((univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u).card : ℝ) * u
        = ((univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w).card : ℝ) * w ∧
      ((univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u).card : ℝ)
        + ((univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w).card : ℝ)
        = (n : ℝ) * ((n : ℝ) - 1) / 2 := by
  set ev := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
  have hne : u ≠ -w := by linarith
  have h1 := HamiltonsCubic.L71Theta.sum_two ev u (-w) hne htwo id
  have h0 := HamiltonsCubic.L71Theta.sum_two ev u (-w) hne htwo (fun _ => (1 : ℝ))
  simp only [id, mul_one] at h1 h0
  rw [sum_mu_zero W hW.1 hW.2.1 hW.2.2.1 hW.2.2.2.2] at h1
  rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at h0
  have hcard : (Fintype.card (SecondKind.Pairs n) : ℝ) = (n : ℝ) * ((n : ℝ) - 1) / 2 := by
    rw [show Fintype.card (SecondKind.Pairs n) = n.choose 2 from HamiltonsCubic.L75Statement.Proof.card_tri,
      Nat.cast_choose_two]
  refine ⟨by linarith, ?_⟩
  rw [← hcard, h0]

end HamiltonsCubic.L105Op
