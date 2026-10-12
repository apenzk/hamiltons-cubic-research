import HamiltonsCubic.Results.L107Frame
import HamiltonsCubic.Results.L35Weyl

set_option linter.style.longLine false

/-!
# L107's chord form: the bound over the true range of pair means

[findings/bounds.md](../../../findings/bounds.md), Lemma L107: *"the chord is taken over the wrong interval"*. In row
`a` the variable `X = (λ_b + λ_c)/2` ranges over means of two distinct eigenvalues away from `a`, inside
`[ℓ_a, σ_a] ⊆ [λ_min, λ_max]`, and running the row calculus over that range gives
`θ ≤ λ_max − ℓ_a − σ_a − (n − 2)ℓ_aσ_a/λ_max`. **This file proves it**:

- `L107_chord_row`, `L107_chord`: the row inequality and the top-row bound, for any `[ℓ, σ]` containing every mean
  carried by bracket mass in the row, which covers the record's `ℓ_a, σ_a`;
- `chord_dominates`: the chord row's right side is at most the boxed row's, the two chords differing by an affine
  function nonnegative on `[ℓ, σ]`;
- `chord_at_CP2`: at padded `W_{ℂP²}` the bound returns `3ε`, which is `√(3/2)` at unit norm;
- `signs_automatic`: `λ_max > 0` and `λ_min < 0` at every Weyl `W ≠ 0`, the block's sign remark.
-/

namespace HamiltonsCubic.L41Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement.Frame HamiltonsCubic.L7Frame

variable {ι : Type} [Fintype ι] [DecidableEq ι] {Γ : Type} [Fintype Γ] [DecidableEq Γ]

/-- **The chord row, over the true range**: at a critical point, if every pair `(a, b)` carrying mass in row `γ`
has its mean `(λ_a + λ_b)/2` in `[ℓ, σ]`, then `λ_γ(θ − λ_γ) ≤ −(ℓ + σ)λ_γ − (n − 2)ℓσ`. -/
theorem L107_chord_row {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W)
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) (γ : Γ)
    (ℓ σ : ℝ) (hsupp : ∀ a b, cst v γ a b ≠ 0 → ℓ ≤ (lam a + lam b) / 2 ∧ (lam a + lam b) / 2 ≤ σ) :
    lam γ * (θ - lam γ) ≤ -(ℓ + σ) * lam γ - ((Fintype.card ι : ℝ) - 2) * (ℓ * σ) := by
  have hC := crit_frame hWl hsk hf θ hc γ
  have hA := killing_frame hW hf γ
  have hB1 := aW2_frame hW hf γ
  have hB2 := aW2_mid hW hf γ
  have hω : ∀ a b, omegaF v a b γ ^ 2 = cst v γ a b ^ 2 := fun a b => by
    have : omegaF v a b γ = cst v a b γ := rfl
    rw [this, ← cst_cyclic hf]
  simp only [hω] at hC
  have hpt : ∀ a b, lam a * lam b * cst v γ a b ^ 2
      ≤ ((ℓ + σ) * ((lam a + lam b) / 2) - ℓ * σ) * cst v γ a b ^ 2 := by
    intro a b
    by_cases h0 : cst v γ a b = 0
    · rw [h0]; ring_nf; exact le_refl _
    apply mul_le_mul_of_nonneg_right _ (sq_nonneg _)
    obtain ⟨hl, hs⟩ := hsupp a b h0
    have h1 : lam a * lam b ≤ ((lam a + lam b) / 2) ^ 2 := by nlinarith [sq_nonneg (lam a - lam b)]
    have h2 : 0 ≤ ((lam a + lam b) / 2 - ℓ) * (σ - (lam a + lam b) / 2) := mul_nonneg (by linarith) (by linarith)
    nlinarith
  have hsum : ∑ a, ∑ b, lam a * lam b * cst v γ a b ^ 2
      ≤ ∑ a, ∑ b, ((ℓ + σ) * ((lam a + lam b) / 2) - ℓ * σ) * cst v γ a b ^ 2 :=
    Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun b _ => hpt a b
  have hR : ∑ a, ∑ b, ((ℓ + σ) * ((lam a + lam b) / 2) - ℓ * σ) * cst v γ a b ^ 2
      = (ℓ + σ) / 2 * (∑ a, ∑ b, lam a * cst v γ a b ^ 2 + ∑ a, ∑ b, lam b * cst v γ a b ^ 2)
        - ℓ * σ * ∑ a, ∑ b, cst v γ a b ^ 2 := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  rw [hR, hA, hB1, hB2] at hsum
  nlinarith [hsum, hC]

/-- **The chord bound at the top row**: `θ ≤ λ_max − ℓ − σ − (n − 2)ℓσ/λ_max`, the record's display. -/
theorem L107_chord {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W)
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) (γ : Γ)
    (M : ℝ) (hγ : lam γ = M) (hM : 0 < M)
    (ℓ σ : ℝ) (hsupp : ∀ a b, cst v γ a b ≠ 0 → ℓ ≤ (lam a + lam b) / 2 ∧ (lam a + lam b) / 2 ≤ σ) :
    θ ≤ M - ℓ - σ - ((Fintype.card ι : ℝ) - 2) * (ℓ * σ) / M := by
  have h := L107_chord_row hW hWl hsk hf θ hc γ ℓ σ hsupp
  rw [hγ] at h
  rw [show M - ℓ - σ - ((Fintype.card ι : ℝ) - 2) * (ℓ * σ) / M
      = (M * M - (ℓ + σ) * M - ((Fintype.card ι : ℝ) - 2) * (ℓ * σ)) / M by field_simp; ring, le_div_iff₀ hM]
  nlinarith

/-- **The chord bound dominates the boxed one**: with the support means in `[ℓ, σ] ⊆ [m, M]`, the chord row's
right side is at most the boxed row's, the two chords differing by an affine function nonnegative on `[ℓ, σ]`. -/
theorem chord_dominates {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W)
    (hf : EigenFrame W v lam) (γ : Γ) (ℓ σ m M : ℝ) (hml : m ≤ ℓ) (hσM : σ ≤ M)
    (hsupp : ∀ a b, cst v γ a b ≠ 0 → ℓ ≤ (lam a + lam b) / 2 ∧ (lam a + lam b) / 2 ≤ σ) :
    -(ℓ + σ) * lam γ - ((Fintype.card ι : ℝ) - 2) * (ℓ * σ)
      ≤ -(m + M) * lam γ - ((Fintype.card ι : ℝ) - 2) * (m * M) := by
  have hA := killing_frame hW hf γ
  have hB1 := aW2_frame hW hf γ
  have hB2 := aW2_mid hW hf γ
  have hpt : ∀ a b, ((ℓ + σ) * ((lam a + lam b) / 2) - ℓ * σ) * cst v γ a b ^ 2
      ≤ ((m + M) * ((lam a + lam b) / 2) - m * M) * cst v γ a b ^ 2 := by
    intro a b
    by_cases h0 : cst v γ a b = 0
    · rw [h0]; ring_nf; exact le_refl _
    apply mul_le_mul_of_nonneg_right _ (sq_nonneg _)
    obtain ⟨hl, hs⟩ := hsupp a b h0
    nlinarith [mul_nonneg (sub_nonneg.mpr hml) (by linarith : (0:ℝ) ≤ σ - (lam a + lam b) / 2),
      mul_nonneg (sub_nonneg.mpr hσM) (by linarith : (0:ℝ) ≤ (lam a + lam b) / 2 - ℓ),
      mul_nonneg (sub_nonneg.mpr hml) (sub_nonneg.mpr hσM)]
  have hsum := Finset.sum_le_sum fun a (_ : a ∈ Finset.univ) => Finset.sum_le_sum fun b (_ : b ∈ Finset.univ) => hpt a b
  have hR : ∀ p q : ℝ, ∑ a, ∑ b, ((p + q) * ((lam a + lam b) / 2) - p * q) * cst v γ a b ^ 2
      = (p + q) / 2 * (∑ a, ∑ b, lam a * cst v γ a b ^ 2 + ∑ a, ∑ b, lam b * cst v γ a b ^ 2)
        - p * q * ∑ a, ∑ b, cst v γ a b ^ 2 := fun p q => by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  rw [hR, hR, hA, hB1, hB2] at hsum
  nlinarith [hsum]

/-- **At padded `W_{ℂP²}`** (spectrum `(2ε, −ε, −ε, 0, …)`, top row `2ε`, other means `ℓ = −ε`, `σ = 0`) the chord
bound returns `3ε` exactly, which is `√(3/2)` at unit norm. -/
theorem chord_at_CP2 (ε n : ℝ) :
    2 * ε - (-ε) - 0 - (n - 2) * ((-ε) * 0) / (2 * ε) = 3 * ε := by
  simp; ring

/-- **Both sign conditions are automatic**: at a Weyl `W ≠ 0`, some eigenvalue is positive and some negative,
`∑λ = 0` (`frame_trace`) with `∑λ² = ‖W‖² > 0`. -/
theorem signs_automatic {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (hn : 0 < normSq W) : (∃ a, 0 < lam a) ∧ ∃ b, lam b < 0 := by
  have hsum := HamiltonsCubic.L35Residual.frame_trace hW hf
  have hsq : 0 < ∑ γ, lam γ ^ 2 := by rw [← normSq_frame hW hf]; exact hn
  have hne : ∃ a, lam a ≠ 0 := by
    by_contra h
    push Not at h
    simp [h] at hsq
  constructor
  · by_contra hpos
    push Not at hpos
    have hall : ∀ a, lam a = 0 := by
      intro a
      have := Finset.sum_eq_zero_iff_of_nonpos (fun b _ => hpos b) |>.mp hsum a (Finset.mem_univ a)
      exact this
    obtain ⟨a, ha⟩ := hne; exact ha (hall a)
  · by_contra hneg
    push Not at hneg
    have hall : ∀ a, lam a = 0 := by
      intro a
      exact (Finset.sum_eq_zero_iff_of_nonneg (fun b _ => hneg b)).mp hsum a (Finset.mem_univ a)
    obtain ⟨a, ha⟩ := hne; exact ha (hall a)

end HamiltonsCubic.L41Statement
