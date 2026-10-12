import Mathlib
import HamiltonsCubic.Results.L71Odd
import HamiltonsCubic.Results.SpectralTrace

set_option linter.style.longLine false

/-!
# L71: a saturating critical point at unit norm has `θ = θ₀(n)`, without the classification

[findings/bounds.md](../../../findings/bounds.md), Lemma L71: *"... and $W$ is the Weyl tensor of the
balanced sphere product $S^{n/2}\times S^{n/2}$. Consequently $\theta=\theta_0(n)$ exactly"*. The record
reads `θ₀(n)` off the classification. The spectrum alone fixes it: [L71Cor.lean](L71Cor.lean) makes it
two-valued and [L71Odd.lean](L71Odd.lean) gives the multiplicities, `4 dim 𝔪 = n²` at `λ_min` and
`4 dim 𝔥 = n(n-2)` at `λ_max`. Then

* the trace vanishes (L50Traces' `sum_mu_zero`): `n² λ_min + n(n-2) λ_max = 0`;
* the norm is the sum of squares (SpectralTrace's `sum_mu_sq`): `n² λ_min² + n(n-2) λ_max² = 4 ‖W‖²`;
* saturation gives `θ = λ_min + (n-2)λ_max = -(n-1)λ_min`,

so at `‖W‖² = 1`, `θ² n² = 2(n-1)(n-2)`, that is `θ² = θ₀(n)²`, and `θ > 0`:

* `sum_two`: a sum over a two-valued spectrum, read at `g = id` for the trace and `g = (·)²` for the norm;
* `L71_theta_sq`, `L71_theta`: `θ² = theta0Sq n` and `θ = theta0 n` at every saturating critical point
  of unit norm, `n ≥ 5`.

And the rest of the record's *"W has exactly two eigenvalues"* and *"𝔰𝔬(n) = 𝔥 ⊕ 𝔪"*
([r1718](../../../reviews/REVIEW_r1718.md)):

* `coeff_zero`, `mem_span_iff`: at any eigenframe of a self-adjoint linear `W`, a skew `X` lies in
  `span{v_k : λ_k = c}` exactly when `W X = c X`, so `𝔪` and `𝔥` are the eigenspaces `E_min`, `E_max`;
* `lmax_occurs`: `λ_max` is an eigenvalue at every saturating point, `4·#{λ_k = λ_max} = n(n-2) > 0`;
* `spectrum_two`: every eigenvalue of `W` on a nonzero bivector is `λ_min` or `λ_max`;
* `sup_eq_skewSub`: `𝔪 ⊔ 𝔥 = Λ²`, with L71Cor's `inf_eq_bot` the direct sum.
-/

namespace HamiltonsCubic.L71Theta

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.EigenFrameExist
  HamiltonsCubic.SecondKind HamiltonsCubic.L71Cor HamiltonsCubic.L71Odd

variable {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

omit [DecidableEq Γ] in
/-- A function taking two values sums as `#{= a}·a + #{= b}·b`. -/
theorem sum_two (f : Γ → ℝ) (a b : ℝ) (hab : a ≠ b) (htwo : ∀ j, f j = a ∨ f j = b) (g : ℝ → ℝ) :
    ∑ j, g (f j) = (univ.filter fun j => f j = a).card * g a
      + (univ.filter fun j => f j = b).card * g b := by
  rw [← Finset.sum_filter_add_sum_filter_not univ (fun j => f j = a)]
  have hnot : (univ.filter fun j => ¬ f j = a) = univ.filter fun j => f j = b := by
    ext j
    simp only [Finset.mem_filter, Finset.mem_univ, true_and]
    constructor
    · intro h; exact (htwo j).resolve_left h
    · intro h h'; exact hab (h'.symm.trans h)
  rw [hnot]
  rw [Finset.sum_congr rfl fun j hj => by rw [(Finset.mem_filter.mp hj).2],
    Finset.sum_congr rfl (fun j hj => by rw [(Finset.mem_filter.mp hj).2] : ∀ j ∈ univ.filter fun j => f j = b, g (f j) = g b)]
  simp [Finset.sum_const, nsmul_eq_mul]

variable {n : ℕ}

/-- **`θ² = θ₀(n)²`** at every saturating critical point of unit norm. -/
theorem L71_theta_sq (hn : 5 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin)
    (hnorm : normSq W = 1) :
    θ ^ 2 = theta0Sq n ∧ 0 < θ := by
  set ev := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues with hev
  have htwo := (L71_corollaries hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat hex).1
  have hdim := L71_dim_m hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat hex
  have hne : lmin ≠ lmax := by linarith
  set cm := (univ.filter fun j => ev j = lmin).card with hcm
  set cM := (univ.filter fun j => ev j = lmax).card with hcM
  have hnR : (5 : ℝ) ≤ n := by exact_mod_cast hn
  have hcm' : (4 : ℝ) * cm = (n : ℝ) ^ 2 := by exact_mod_cast hdim.1
  have hcM' : (4 : ℝ) * cM = (n : ℝ) * ((n : ℝ) - 2) := by
    have h := hdim.2
    have : ((4 * cM : ℕ) : ℝ) = ((n * (n - 2) : ℕ) : ℝ) := by rw [h]
    push_cast [Nat.cast_sub (show 2 ≤ n by omega)] at this
    linarith
  -- trace and norm
  have htr : ∑ j, ev j = 0 := sum_mu_zero W hW.1 hW.2.1 hW.2.2.1 hW.2.2.2.2
  have hsq : ∑ j, ev j ^ 2 = 1 := by rw [← hnorm]; exact sum_mu_sq W hW.1 hW.2.1 hW.2.2.1
  have h1s := sum_two ev lmin lmax hne htwo id
  have h2s := sum_two ev lmin lmax hne htwo (fun x => x ^ 2)
  simp only [id] at h1s h2s
  rw [htr] at h1s
  rw [hsq] at h2s
  -- the three relations, with N = n
  set N : ℝ := (n : ℝ) with hN
  have E1 : lmax * (N - 2) + N * lmin = 0 := by
    have : (N : ℝ) ≠ 0 := by linarith
    have h4 : N ^ 2 * lmin + N * (N - 2) * lmax = 0 := by
      linear_combination (-4) * h1s - lmin * hcm' - lmax * hcM'
    have : N * (lmax * (N - 2) + N * lmin) = 0 := by linarith
    rcases mul_eq_zero.mp this with h | h
    · exact absurd h (by linarith)
    · exact h
  have E2 : N ^ 2 * lmin ^ 2 + N * (N - 2) * lmax ^ 2 = 4 := by
    linear_combination (-4) * h2s - lmin ^ 2 * hcm' - lmax ^ 2 * hcM'
  have hA : θ + (N - 1) * lmin = 0 := by rw [hsat]; linear_combination E1
  have hB : N ^ 2 * lmin ^ 2 * (2 * N - 2) = 4 * (N - 2) := by
    linear_combination (N - 2) * E2 - N * ((N - 2) * lmax - N * lmin) * E1
  have hC : θ ^ 2 * N ^ 2 = 2 * (N - 1) * (N - 2) := by
    linear_combination N ^ 2 * (θ - (N - 1) * lmin) * hA + ((N - 1) / 2) * hB
  refine ⟨?_, ?_⟩
  · unfold theta0Sq
    have : N ^ 2 ≠ 0 := by positivity
    rw [eq_div_iff this]
    linear_combination hC
  · have : θ = -(N - 1) * lmin := by linarith
    rw [this]
    nlinarith

/-- **`θ = θ₀(n)` exactly** at every saturating critical point of unit norm. -/
theorem L71_theta (hn : 5 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin)
    (hnorm : normSq W = 1) :
    θ = theta0 n := by
  obtain ⟨h2, hpos'⟩ := L71_theta_sq hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat hex hnorm
  unfold theta0
  rw [← h2, Real.sqrt_sq hpos'.le]

/-! ## The spans are the eigenspaces, and the spectrum on `Λ²` is `{λ_min, λ_max}` ([r1718](../../../reviews/REVIEW_r1718.md)) -/

section frame

variable {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ}
  {v : Γ → Matrix (Fin n) (Fin n) ℝ} {ev : Γ → ℝ}

/-- Pairing an eigenvector equation with a frame vector: `(λ_j - μ) ⟨X, v_j⟩ = 0`. -/
theorem coeff_zero (hsa : ∀ X Y, IsSkew X → IsSkew Y → inner2 (W X) Y = inner2 X (W Y))
    (hf : L41Statement.EigenFrame W v ev) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) (μ : ℝ)
    (h : W X = μ • X) (j : Γ) : (ev j - μ) * inner2 X (v j) = 0 := by
  have e1 := hsa X (v j) hX (hf.skew j)
  rw [h, hf.eigen j, FamilyLayer.inner2_smul_left, inner2_comm X (ev j • v j),
    FamilyLayer.inner2_smul_left, inner2_comm (v j) X] at e1
  linarith

/-- **Every span is its eigenspace**: at any eigenframe of a self-adjoint linear `W`, a skew `X` lies in
`span{v_k : λ_k = c}` exactly when `W X = c X`. -/
theorem mem_span_iff (hlin : IsLinOp W)
    (hsa : ∀ X Y, IsSkew X → IsSkew Y → inner2 (W X) Y = inner2 X (W Y))
    (hf : L41Statement.EigenFrame W v ev) (c : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    X ∈ L71Sat.spanOf v (fun k => ev k = c) ↔ W X = c • X := by
  constructor
  · intro hmem
    let E : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ) :=
      { carrier := {Y | W Y = c • Y}
        zero_mem' := by
          show W 0 = c • 0
          have := hlin.2 0 0
          simpa using this
        add_mem' := by
          intro A B hA hB
          show W (A + B) = c • (A + B)
          rw [hlin.1, show W A = c • A from hA, show W B = c • B from hB, smul_add]
        smul_mem' := by
          intro t A hA
          show W (t • A) = c • (t • A)
          rw [hlin.2, show W A = c • A from hA, smul_comm] }
    have hle : L71Sat.spanOf v (fun k => ev k = c) ≤ E := by
      refine Submodule.span_le.mpr ?_
      rintro _ ⟨k, hk, rfl⟩
      show W (v k) = c • v k
      rw [hf.eigen k, show ev k = c from hk]
    exact hle hmem
  · intro h
    rw [hf.complete X hX]
    refine Submodule.sum_mem _ fun k _ => ?_
    by_cases hk : ev k = c
    · exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨k, hk, rfl⟩)
    · have hz := coeff_zero hsa hf X hX c h k
      have : inner2 X (v k) = 0 := by
        rcases mul_eq_zero.mp hz with h' | h'
        · exact absurd (by linarith) hk
        · exact h'
      rw [this, zero_smul]
      exact Submodule.zero_mem _

end frame

/-- **`λ_max` occurs** at every saturating point: `4·#{λ_k = λ_max} = n(n-2) > 0`. -/
theorem lmax_occurs (hn : 5 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin) :
    ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmax := by
  have h := (L71_dim_m hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat hex).2
  by_contra hno
  push Not at hno
  have hempty : (univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmax) = ∅ := by
    ext j; simp [hno j]
  rw [hempty, Finset.card_empty] at h
  have : 0 < n * (n - 2) := Nat.mul_pos (by omega) (by omega)
  omega

/-- **The `Λ²` spectrum lies in `{λ_min, λ_max}`**: every eigenvalue of `W` on a nonzero bivector is one
of the two. Both occur, by `hex` and `lmax_occurs`. -/
theorem spectrum_two (hn : 5 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin)
    (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) (hX0 : X ≠ 0) (μ : ℝ) (h : W X = μ • X) :
    μ = lmin ∨ μ = lmax := by
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  have htwo := (L71_corollaries hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat hex).1
  by_contra hμ
  push Not at hμ
  have hc0 : ∀ j, inner2 X (frameVec W hW.1 hW.2.1 hW.2.2.1 j) = 0 := by
    intro j
    have hz := coeff_zero hW.2.2.1 hf X hX μ h j
    rcases mul_eq_zero.mp hz with h' | h'
    · rcases htwo j with e | e
      · exact absurd (by linarith : μ = lmin) hμ.1
      · exact absurd (by linarith : μ = lmax) hμ.2
    · exact h'
  apply hX0
  rw [hf.complete X hX]
  simp [hc0]

/-- **`𝔪 ⊔ 𝔥` is all of `Λ²`** at every saturating point. -/
theorem sup_eq_skewSub (hn : 5 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0)
    (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (hex : ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin) :
    let v := frameVec W hW.1 hW.2.1 hW.2.2.1;
    let ev := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues;
    L71Sat.spanOf v (fun k => ev k = lmin) ⊔ L71Sat.spanOf v (fun k => ev k = lmax) = skewSub (Fin n) := by
  intro v ev
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  have hcor := L71_corollaries hn W hW θ hc lmin lmax hneg hpos hlo hhi hsat hex
  apply le_antisymm
  · refine sup_le (Submodule.span_le.mpr ?_) (Submodule.span_le.mpr ?_) <;>
      rintro _ ⟨k, -, rfl⟩ <;> exact hf.skew k
  · intro X hX
    exact hcor.2.1 X hX

end HamiltonsCubic.L71Theta
