import HamiltonsCubic.Base.AltPart
import HamiltonsCubic.Results.L41Statement

set_option linter.style.longLine false

/-!
# The defect is at most a quarter: `δ² ≤ ¼‖W‖²`

[ATTEMPTS.md](../../../ATTEMPTS.md), Result 7's analytic by-products: *"`Alt(W₊) = Alt(W₋)` for every Bianchi
`W`; `δ² = ½⟨Alt(W₋), |W|⟩ ≤ ¼` unconditionally"*. [findings/route-a.md](../../../findings/route-a.md)'s
Lemma L134(c) uses it for the padded flat's `c₂ ≤ 5/36`, and L135 refers to the same ceiling.

The proof here is two lines of the layer's own lemmas. [AltPart.lean](../Base/AltPart.lean)'s `altNormSq_absOp` gives
`‖Alt(|W|)‖² = 4δ²` for a Bianchi `W`, and `altNormSq_le_normSq` gives `‖Alt(|W|)‖² ≤ ‖|W|‖²`. In an orthonormal
eigenframe `‖|W|‖² = ∑|λ|² = ∑λ² = ‖W‖²` (`normSq_absOp`), so `4δ² ≤ ‖W‖²`.

- `specOp_eq`: the spectral presentation agrees with `W` on bivectors;
- `normSq_absOp`: `‖|W|‖² = ∑ λ²`;
- **`defectSq_le_quarter`**: `δ² ≤ ¼‖W‖²` for every Weyl `W` and every orthonormal eigenframe of it.
-/

namespace HamiltonsCubic.DefectQuarter

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {r : ℕ}

/-- `specOp` as a linear map. -/
noncomputable def specLin (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) : Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ where
  toFun := specOp lam om
  map_add' := specOp_add lam om
  map_smul' c X := specOp_smul c lam om X

theorem specOp_sum (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) {κ : Type*} (s : Finset κ) (c : κ → ℝ)
    (x : κ → Matrix ι ι ℝ) : specOp lam om (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • specOp lam om (x k) := by
  change specLin lam om (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • specLin lam om (x k)
  rw [map_sum]
  simp only [map_smul]

variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {om : Fin r → Matrix ι ι ℝ} {lam : Fin r → ℝ}

/-- **The spectral presentation is `W` on bivectors.** -/
theorem specOp_eq (hW : IsWeyl W) (hf : EigenFrame W om lam) (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    specOp lam om X = W X := by
  conv_rhs => rw [hf.complete X hX]
  rw [weyl_lin hW _ _ om hf.skew]
  unfold specOp
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [hf.eigen γ, smul_smul, inner2_comm]
  ring_nf

theorem bianchi_specOp (hW : IsWeyl W) (hf : EigenFrame W om lam) (i j k l : ι) :
    bianchi (specOp lam om) i j k l = 0 := by
  have h := hW.2.2.1 i j k l
  unfold bianchi at h ⊢
  rw [specOp_eq hW hf _ (phi_isSkew _ _), specOp_eq hW hf _ (phi_isSkew _ _), specOp_eq hW hf _ (phi_isSkew _ _)]
  exact h

/-- **`|W|` in the same frame**, eigenvalues `|λ|`. -/
theorem absOp_frame (hf : EigenFrame W om lam) : EigenFrame (absOp lam om) om (fun γ => |lam γ|) where
  skew := hf.skew
  orthonormal := hf.orthonormal
  eigen γ := by
    unfold absOp specOp
    simp only [hf.orthonormal, mul_ite, mul_one, mul_zero, ite_smul, zero_smul, Finset.sum_ite_eq', Finset.mem_univ,
      if_true]
  complete := hf.complete

/-- **`‖|W|‖² = ∑ λ²`.** -/
theorem normSq_absOp (hf : EigenFrame W om lam) : normSq (absOp lam om) = ∑ γ, lam γ ^ 2 := by
  have hA := absOp_frame hf
  unfold normSq
  rw [innerOp_frame hA (absOp lam om) (absOp lam om) (fun c => specOp_sum _ om _ c om)
    (fun c => specOp_sum _ om _ c om)]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [hA.eigen γ, inner2_smul_l, inner2_smul_r, hf.orthonormal, if_pos rfl, mul_one, ← sq, sq_abs]

/-- **`δ² ≤ ¼‖W‖²`**, for every Weyl `W` and every orthonormal eigenframe of it. -/
theorem defectSq_le_quarter (hW : IsWeyl W) (hf : EigenFrame W om lam) :
    defectSq (ι := ι) lam om ≤ (1 / 4) * normSq W := by
  have h4 := altNormSq_absOp lam om (bianchi_specOp hW hf)
  have hle := altNormSq_le_normSq (absOp lam om) (fun i j => specOp_isSkew _ om hf.skew _)
  rw [normSq_absOp hf] at hle
  rw [normSq_frame hW hf]
  linarith

/-! ## The ceiling at any orthonormal presentation

*`EigenFrame` asks the frame to span every bivector. A presentation of an operator supported on a block cannot, so
the ceiling is also stated for an orthonormal presentation alone.*
-/

/-- **`‖Σ μ ω ⊗ ω‖² = Σ μ²`** for orthonormal skew `ω`, by Parseval, with no completeness. -/
theorem normSq_specOp_orth {s : ℕ} (mu : Fin s → ℝ) (eta : Fin s → Matrix ι ι ℝ) (hsk : ∀ δ, IsSkew (eta δ))
    (horth : ∀ δ ε, inner2 (eta δ) (eta ε) = if δ = ε then 1 else 0) :
    normSq (specOp mu eta) = ∑ δ, mu δ ^ 2 := by
  unfold normSq innerOp
  have e : ∀ i j, inner2 (specOp mu eta (phi i j)) (specOp mu eta (phi i j))
      = ∑ δ, mu δ ^ 2 * (inner2 (eta δ) (phi i j) * inner2 (eta δ) (phi i j)) := by
    intro i j
    rw [inner2_specOp]
    refine Finset.sum_congr rfl fun δ _ => ?_
    rw [inner2_comm (eta δ) (specOp mu eta (phi i j)), inner2_specOp]
    simp only [horth, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
    ring
  simp only [e]
  have hsw : ∀ F : ι → ι → Fin s → ℝ, ∑ i, ∑ j, ∑ δ, F i j δ = ∑ δ, ∑ i, ∑ j, F i j δ := fun F =>
    (Finset.sum_congr rfl fun i _ => Finset.sum_comm).trans Finset.sum_comm
  rw [hsw, Finset.mul_sum]
  refine Finset.sum_congr rfl fun δ _ => ?_
  have hp := parseval (eta δ) (eta δ) (hsk δ) (hsk δ)
  rw [horth, if_pos rfl] at hp
  calc 1 / 2 * ∑ i, ∑ j, mu δ ^ 2 * (inner2 (eta δ) (phi i j) * inner2 (eta δ) (phi i j))
      = mu δ ^ 2 * ((1 / 2) * ∑ i, ∑ j, inner2 (eta δ) (phi i j) * inner2 (eta δ) (phi i j)) := by
        simp only [Finset.mul_sum]
        exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
    _ = mu δ ^ 2 := by rw [hp, mul_one]

/-- **`δ² ≤ ¼ Σ μ²` at any orthonormal presentation satisfying first Bianchi**, `Σ μ²` being the operator's
`‖·‖²` by `normSq_specOp_orth`. -/
theorem defectSq_le_quarter_pres {s : ℕ} (mu : Fin s → ℝ) (eta : Fin s → Matrix ι ι ℝ)
    (hsk : ∀ δ, IsSkew (eta δ)) (horth : ∀ δ ε, inner2 (eta δ) (eta ε) = if δ = ε then 1 else 0)
    (hB : ∀ i j k l, bianchi (specOp mu eta) i j k l = 0) :
    defectSq (ι := ι) mu eta ≤ (1 / 4) * ∑ δ, mu δ ^ 2 := by
  have h4 := altNormSq_absOp mu eta hB
  have hle := altNormSq_le_normSq (absOp mu eta) (fun i j => specOp_isSkew _ eta hsk _)
  have hn : normSq (absOp mu eta) = ∑ δ, mu δ ^ 2 := by
    unfold absOp; rw [normSq_specOp_orth _ eta hsk horth]; simp [sq_abs]
  rw [hn] at hle
  linarith

end HamiltonsCubic.DefectQuarter
