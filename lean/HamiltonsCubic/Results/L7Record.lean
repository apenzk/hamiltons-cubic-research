import HamiltonsCubic.Results.XinvFrame
import HamiltonsCubic.Results.L7Frame
import HamiltonsCubic.Results.L40Statement

set_option linter.style.longLine false

/-!
# L7 for the record's operator

[L7Frame.lean](L7Frame.lean) proves L7's bound, slack identity and equality class for an abstract
frame under the diagonal criticality equations. **This file supplies those equations from the
record's criticality** ([L40Statement.lean](L40Statement.lean)'s `IsCritical`, the bilinear form of
`Q(W) = θW` on bivectors) at an orthonormal eigenframe of `W`, with `ω` the frame's bracket
coefficients (`omegaF`):

- `crit_frame`: `½ ∑ λ_α λ_β ω_{αβγ}² = θ λ_γ − λ_γ²`, from `sharpBil_frame`;
- `L7_record`: **`θ tr W₋ + tr W₋² ≤ 2 tr(W₊ # W₋)`** at every critical `W` with an eigenframe;
- `L7_equality_record`: **equality iff the eigenframe is graded**, the class L155 identifies.

With [EigenFrameExist.lean](EigenFrameExist.lean)'s `eigenFrame_exists` the frame is supplied for
every `W` linear, preserving bivectors and self-adjoint on them.
-/

namespace HamiltonsCubic.L41Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement.Frame HamiltonsCubic.L7Frame

variable {ι : Type} [Fintype ι] [DecidableEq ι] {Γ : Type} [Fintype Γ] [DecidableEq Γ]

omit [DecidableEq ι] [Fintype Γ] [DecidableEq Γ] in
/-- The bracket coefficients are antisymmetric in the first two slots, so their squares agree. -/
theorem omegaF_sq_swap (v : Γ → Matrix ι ι ℝ) (α β γ : Γ) :
    omegaF v β α γ ^ 2 = omegaF v α β γ ^ 2 := by
  unfold omegaF
  have : br (v β) (v α) = -br (v α) (v β) := by unfold br; abel
  rw [this]
  have e : inner2 (-br (v α) (v β)) (v γ) = -inner2 (br (v α) (v β)) (v γ) := by
    unfold inner2; simp [Matrix.transpose_neg, Matrix.trace_neg]
  rw [e, neg_sq]

/-- **The diagonal criticality equations in the frame.** -/
theorem crit_frame {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) (γ : Γ) :
    (1 / 2) * ∑ α, ∑ β, lam α * lam β * omegaF v α β γ ^ 2 = θ * lam γ - lam γ ^ 2 := by
  have h := hc (v γ) (v γ) (hf.skew γ) (hf.skew γ)
  have hsb := sharpBil_frame hWl hsk hf γ γ
  have h1 : inner2 (v γ) (v γ) = 1 := by rw [hf.orthonormal γ γ, if_pos rfl]
  have hW : W (v γ) = lam γ • v γ := hf.eigen γ
  have hWW : compOp W (v γ) = (lam γ * lam γ) • v γ := by
    unfold compOp
    rw [hW]
    have := hWl (Finset.univ : Finset Unit) (fun _ => lam γ) (fun _ => v γ) (fun _ => hf.skew γ)
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_unit, one_smul] at this
    rw [this, hW, smul_smul]
  rw [hWW, hW, inner2_smul_l, inner2_smul_l, h1, hsb] at h
  have e : ∑ α, ∑ β, lam α * lam β * (omegaF v α β γ * omegaF v α β γ)
      = ∑ α, ∑ β, lam α * lam β * omegaF v α β γ ^ 2 := by
    simp only [sq]
  rw [e] at h
  linarith

/-- **L7 FOR THE RECORD'S OPERATOR**: `θ tr W₋ + tr W₋² ≤ 2 tr(W₊ # W₋)`. -/
theorem L7_record {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) :
    θ * negTr lam + negTr2 lam ≤ cross2 lam (omegaF v) :=
  L7_frame lam (omegaF v) θ (omegaF_sq_swap v) (crit_frame hWl hsk hf θ hc)

/-- **L7's EQUALITY CLASS FOR THE RECORD'S OPERATOR**: equality iff the eigenframe is graded. -/
theorem L7_equality_record {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) :
    θ * negTr lam + negTr2 lam = cross2 lam (omegaF v) ↔
      HamiltonsCubic.L155Frame.Graded lam (omegaF v) :=
  L7_equality_frame lam (omegaF v) θ (omegaF_sq_swap v) (crit_frame hWl hsk hf θ hc)

end HamiltonsCubic.L41Statement
