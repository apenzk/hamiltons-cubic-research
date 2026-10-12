import HamiltonsCubic.Results.L41Statement
import HamiltonsCubic.Results.L155Frame

set_option linter.style.longLine false

/-!
# The frame expansion of `X_inv`

[findings/bounds.md](../../../findings/bounds.md), Lemmas L154, L155 and L7, read
`X_inv = |W|^# − P₊W^#P₊ + P₋W^#P₋` through the eigenframe of `W`.
[L155Frame.lean](L155Frame.lean) proves L155 and L154 (i) for the frame matrix `Xinv`. **This file
proves that the record's `X_inv` has those entries**, so both lemmas hold for it:

- `sharpQF_frame_lin`: [L41Statement.lean](L41Statement.lean)'s `sharpQF_frame`,
  `⟨R^# η, η⟩ = ½ ∑ λ_α λ_β ⟨[η, v_α], v_β⟩²`, for any operator linear on bivectors with an
  orthonormal eigenframe, so that it applies to `|W|`, which is not Weyl;
- `sharpBil_frame`: polarised, `⟨R^# v_γ, v_δ⟩ = ½ ∑ λ_α λ_β ω_{αβγ} ω_{αβδ}` with
  `ω_{αβγ} = ⟨[v_α, v_β], v_γ⟩` (`omegaF`), which is rank-one positivity summed over the frame;
- `XinvRec`: the record's `X_inv` on the frame, `P_±` keeping the entries with both indices of that
  sign, and `XinvRec_eq`: **it is `Xinv lam ω`**;
- `L155_record` and `L154_record`: the two lemmas for the record's `X_inv`.
-/

namespace HamiltonsCubic.L41Statement

open HamiltonsCubic.RealLayer Frame

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {Γ : Type} [Fintype Γ] [DecidableEq Γ]

/-- **`⟨W# η, η⟩` in the eigenframe**: `½ Σ_{αβ} λ_α λ_β ⟨[η, v_α], v_β⟩²`. -/
theorem sharpQF_frame_lin {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ}
    {lam : Γ → ℝ} (hf : EigenFrame W v lam) (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    sharpQF W η = (1 / 2) * ∑ α, ∑ β, lam α * lam β * inner2 (br η (v α)) (v β) ^ 2 := by
  set F : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => br η (W (br η (W X))) with hF
  have hlin : ∀ c : Γ → ℝ, F (∑ α, c α • v α) = ∑ α, c α • F (v α) := by
    intro c
    simp only [hF]
    rw [hWl _ c v hf.skew, br_sum_r,
      hWl _ c (fun α => br η (W (v α))) (fun α => br_skew hη (hsk _ (hf.skew α))), br_sum_r]
  have hid : ∀ c : Γ → ℝ, (fun X : Matrix ι ι ℝ => X) (∑ α, c α • v α) = ∑ α, c α • (fun X => X) (v α) :=
    fun c => rfl
  have hQ : sharpQF W η = -(1 / 2) * innerOp F (fun X => X) := by
    unfold sharpQF innerOp; simp only [hF]; ring
  rw [hQ, innerOp_frame hf F (fun X => X) hlin hid]
  -- evaluate `⟨F v_α, v_α⟩`
  have hFa : ∀ α, inner2 (F (v α)) (v α)
      = -(lam α * ∑ β, lam β * inner2 (br η (v α)) (v β) ^ 2) := by
    intro α
    have hWs : W (lam α • br η (v α)) = lam α • W (br η (v α)) := by
      have := hWl (Finset.univ : Finset (Fin 1)) (fun _ => lam α) (fun _ => br η (v α))
        (fun _ => br_skew hη (hf.skew α))
      simpa using this
    have hexp := hf.complete _ (br_skew hη (hf.skew α))
    have hWb : W (br η (v α)) = ∑ β, (inner2 (br η (v α)) (v β) * lam β) • v β := by
      conv_lhs => rw [hexp]
      rw [hWl _ _ v hf.skew]
      exact Finset.sum_congr rfl fun β _ => by rw [hf.eigen β, smul_smul]
    have hc : ∀ β, inner2 (br η (v β)) (v α) = -inner2 (br η (v α)) (v β) := fun β => by
      rw [adinv _ hη (hf.skew β), inner2_comm]
    simp only [hF, hf.eigen α, br_smul_r, hWs, hWb, br_sum_r, inner2_smul_l, inner2_sum_l, hc]
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun β _ => by ring
  simp only [hFa, Finset.mul_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  ring

/-- The frame's bracket coefficients, `ω_{αβγ} = ⟨[v_α, v_β], v_γ⟩`. -/
noncomputable def omegaF (v : Γ → Matrix ι ι ℝ) (α β γ : Γ) : ℝ := inner2 (br (v α) (v β)) (v γ)

/-- **Rotation**: `⟨[v_γ, v_α], v_β⟩ = ω_{αβγ}`, by ad-invariance. -/
theorem omegaF_rot {v : Γ → Matrix ι ι ℝ} (hs : ∀ γ, IsSkew (v γ)) (α β γ : Γ) :
    inner2 (br (v γ) (v α)) (v β) = omegaF v α β γ := by
  unfold omegaF
  rw [adinv _ (hs α) (hs β)]
  have : br (v α) (v γ) = -br (v γ) (v α) := by unfold br; abel
  rw [this, inner2_neg_r', neg_neg, inner2_comm]

/-- **`⟨R^# v_γ, v_δ⟩ = ½ ∑ λ_α λ_β ω_{αβγ} ω_{αβδ}`**, the polarised frame form of the sharp,
for any operator linear on bivectors with an orthonormal eigenframe. -/
theorem sharpBil_frame {W : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (γ δ : Γ) :
    sharpBil W (v γ) (v δ)
      = (1 / 2) * ∑ α, ∑ β, lam α * lam β * (omegaF v α β γ * omegaF v α β δ) := by
  have hsum : IsSkew (v γ + v δ) := by
    have h1 := hf.skew γ; have h2 := hf.skew δ
    unfold IsSkew at *; rw [Matrix.transpose_add, h1, h2, neg_add]
  unfold sharpBil
  rw [sharpQF_frame_lin hWl hsk hf _ hsum, sharpQF_frame_lin hWl hsk hf _ (hf.skew γ),
    sharpQF_frame_lin hWl hsk hf _ (hf.skew δ)]
  simp only [br_add_l', inner2_add_l, omegaF_rot hf.skew]
  rw [← mul_sub, ← mul_sub, ← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
  simp only [← Finset.sum_sub_distrib, Finset.mul_sum]
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  ring

/-- **The record's `X_inv` on the frame**: `⟨|W|^# v_γ, v_δ⟩ − [γ,δ ∈ +]⟨W^# v_γ, v_δ⟩ +
[γ,δ ∈ −]⟨W^# v_γ, v_δ⟩`, `P_±` keeping the entries with both indices of that sign. -/
noncomputable def XinvRec (W Wabs : Matrix ι ι ℝ → Matrix ι ι ℝ) (v : Γ → Matrix ι ι ℝ)
    (lam : Γ → ℝ) (γ δ : Γ) : ℝ :=
  sharpBil Wabs (v γ) (v δ)
    - (if 0 < lam γ ∧ 0 < lam δ then sharpBil W (v γ) (v δ) else 0)
    + (if lam γ < 0 ∧ lam δ < 0 then sharpBil W (v γ) (v δ) else 0)

/-- **THE FRAME EXPANSION**: the record's `X_inv` on the frame is `Xinv lam ω`, for `W` and `|W|`
sharing an orthonormal eigenframe with eigenvalues `λ` and `|λ|`. -/
theorem XinvRec_eq {W Wabs : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X))
    (hAl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      Wabs (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • Wabs (x k))
    (hAsk : ∀ X, IsSkew X → IsSkew (Wabs X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (hfa : EigenFrame Wabs v fun α => |lam α|) (γ δ : Γ) :
    XinvRec W Wabs v lam γ δ = HamiltonsCubic.L155Frame.Xinv lam (omegaF v) γ δ := by
  have e : ∀ (c : Prop) [Decidable c] (S : ℝ), (if c then S else 0) = (if c then (1 : ℝ) else 0) * S :=
    fun c _ S => by split_ifs <;> ring
  unfold XinvRec HamiltonsCubic.L155Frame.Xinv HamiltonsCubic.L155Frame.wt
  rw [e (0 < lam γ ∧ 0 < lam δ), e (lam γ < 0 ∧ lam δ < 0), sharpBil_frame hAl hAsk hfa,
    sharpBil_frame hWl hsk hf]
  generalize (if 0 < lam γ ∧ 0 < lam δ then (1 : ℝ) else 0) = a
  generalize (if lam γ < 0 ∧ lam δ < 0 then (1 : ℝ) else 0) = b
  simp only [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  rw [abs_mul]; ring

/-- **L155 FOR THE RECORD'S `X_inv`**: it vanishes iff the eigenspaces are graded. -/
theorem L155_record {W Wabs : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X))
    (hAl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      Wabs (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • Wabs (x k))
    (hAsk : ∀ X, IsSkew X → IsSkew (Wabs X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (hfa : EigenFrame Wabs v fun α => |lam α|) :
    (∀ γ δ, XinvRec W Wabs v lam γ δ = 0) ↔ HamiltonsCubic.L155Frame.Graded lam (omegaF v) := by
  simp only [XinvRec_eq hWl hsk hAl hAsk hf hfa]
  exact HamiltonsCubic.L155Frame.L155_frame lam (omegaF v)

/-- **L154 (i) FOR THE RECORD'S `X_inv`**: its trace vanishes iff it does. -/
theorem L154_record {W Wabs : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X))
    (hAl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      Wabs (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • Wabs (x k))
    (hAsk : ∀ X, IsSkew X → IsSkew (Wabs X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (hfa : EigenFrame Wabs v fun α => |lam α|) :
    ∑ γ, XinvRec W Wabs v lam γ γ = 0 ↔ ∀ γ δ, XinvRec W Wabs v lam γ δ = 0 := by
  simp only [XinvRec_eq hWl hsk hAl hAsk hf hfa]
  exact HamiltonsCubic.L155Frame.L154_frame lam (omegaF v)

end HamiltonsCubic.L41Statement
