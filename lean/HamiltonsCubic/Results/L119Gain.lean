import Mathlib

set_option linter.style.longLine false

/-!
# L119's gain cap and the non-emptiness of `𝔭`

[findings/bounds-relaxations.md](../../../findings/bounds-relaxations.md), Lemma L119: *"tracelessness keeps `𝔭` non-empty
and `𝔭` is the strictly positive eigenspace, so `λ^min_𝔭 > 0` always. The gain is capped by `Δ/(4√dim 𝔭)`, from
`dim 𝔭 (λ^min_𝔭)² ≤ 1`."* With `λ` the spectrum, `Σ λ = 0`, `Σ λ² = 1`, and `𝔭 = {γ : λ_γ > 0}`:

* **`p_nonempty`**: a traceless spectrum with `Σ λ² = 1` has a strictly positive entry, so `𝔭 ≠ ∅`;
* **`dim_p_mul_sq_le`**: `|𝔭| · (λ^min_𝔭)² ≤ 1`, each of the `|𝔭|` positive eigenvalues being at least `λ^min_𝔭`;
* **`gain_le`**, **`gain_cap`**: the gain `λ^min_𝔭 Δ/4` is at most `Δ/(4√|𝔭|)` for `Δ ≥ 0`, `gain_cap` composing the
  three at the spectrum itself.
-/

namespace HamiltonsCubic.L119Gain

open Finset

variable {ι : Type*} [Fintype ι]

/-- **Tracelessness keeps `𝔭` non-empty.** -/
theorem p_nonempty (lam : ι → ℝ) (htr : ∑ g, lam g = 0) (hn : ∑ g, lam g ^ 2 = 1) : ∃ g, 0 < lam g := by
  classical
  by_contra h
  push Not at h
  have hz : ∀ g, lam g = 0 := by
    intro g
    by_contra hg
    have hneg : lam g < 0 := lt_of_le_of_ne (h g) hg
    have : ∑ x, lam x < 0 := by
      calc ∑ x, lam x ≤ lam g := by
            rw [← Finset.add_sum_erase _ _ (Finset.mem_univ g)]
            have : ∑ x ∈ univ.erase g, lam x ≤ 0 := Finset.sum_nonpos fun x _ => h x
            linarith
        _ < 0 := hneg
    linarith
  simp [hz] at hn

/-- **`|𝔭| (λ^min_𝔭)² ≤ 1`**, with `μ` a lower bound for the positive eigenvalues. -/
theorem dim_p_mul_sq_le (lam : ι → ℝ) (hn : ∑ g, lam g ^ 2 = 1) {μ : ℝ} (hμ0 : 0 ≤ μ)
    (hμ : ∀ g, 0 < lam g → μ ≤ lam g) [DecidablePred fun g => 0 < lam g] :
    ((univ.filter fun g => 0 < lam g).card : ℝ) * μ ^ 2 ≤ 1 := by
  calc ((univ.filter fun g => 0 < lam g).card : ℝ) * μ ^ 2
        = ∑ g ∈ univ.filter (fun g => 0 < lam g), μ ^ 2 := by rw [Finset.sum_const, nsmul_eq_mul]
    _ ≤ ∑ g ∈ univ.filter (fun g => 0 < lam g), lam g ^ 2 :=
        Finset.sum_le_sum fun g hg => pow_le_pow_left₀ hμ0 (hμ g (Finset.mem_filter.mp hg).2) 2
    _ ≤ ∑ g, lam g ^ 2 := Finset.sum_le_sum_of_subset_of_nonneg (Finset.filter_subset _ _)
        fun _ _ _ => sq_nonneg _
    _ = 1 := hn

/-- **The gain cap**: `μ Δ/4 ≤ Δ/(4√d)` when `d μ² ≤ 1`, `d > 0`, `Δ ≥ 0`. -/
theorem gain_le {d μ Δ : ℝ} (hd : 0 < d) (hΔ : 0 ≤ Δ) (h : d * μ ^ 2 ≤ 1) :
    μ * Δ / 4 ≤ Δ / (4 * Real.sqrt d) := by
  have hsd : 0 < Real.sqrt d := Real.sqrt_pos.mpr hd
  have hμ : μ ≤ 1 / Real.sqrt d := by
    rw [le_div_iff₀ hsd]
    have : (μ * Real.sqrt d) ^ 2 ≤ 1 := by rw [mul_pow, Real.sq_sqrt hd.le]; linarith
    nlinarith [sq_nonneg (μ * Real.sqrt d - 1)]
  calc μ * Δ / 4 ≤ (1 / Real.sqrt d) * Δ / 4 := by gcongr
    _ = Δ / (4 * Real.sqrt d) := by field_simp

/-- **The gain cap at the spectrum**: with `𝔭 = {γ : λ_γ > 0}` (non-empty by `p_nonempty`) and `λ^min_𝔭` its least
eigenvalue, the gain `λ^min_𝔭 Δ/4` is at most `Δ/(4√|𝔭|)`. -/
theorem gain_cap (lam : ι → ℝ) (htr : ∑ g, lam g = 0) (hn : ∑ g, lam g ^ 2 = 1) {Δ : ℝ} (hΔ : 0 ≤ Δ)
    [DecidablePred fun g => 0 < lam g] :
    ∃ hP : (univ.filter fun g => 0 < lam g).Nonempty,
      (univ.filter fun g => 0 < lam g).inf' hP lam * Δ / 4
        ≤ Δ / (4 * Real.sqrt ((univ.filter fun g => 0 < lam g).card : ℝ)) := by
  obtain ⟨g0, hg0⟩ := p_nonempty lam htr hn
  have hP : (univ.filter fun g => 0 < lam g).Nonempty := ⟨g0, by simp [hg0]⟩
  refine ⟨hP, ?_⟩
  set μ := (univ.filter fun g => 0 < lam g).inf' hP lam with hμ
  have hμpos : 0 < μ := by
    obtain ⟨g, hg, hgμ⟩ := Finset.exists_mem_eq_inf' hP lam
    rw [hμ, hgμ]; exact (Finset.mem_filter.mp hg).2
  have hlow : ∀ g, 0 < lam g → μ ≤ lam g := fun g hg =>
    Finset.inf'_le _ (Finset.mem_filter.mpr ⟨Finset.mem_univ g, hg⟩)
  have hd : (0 : ℝ) < (univ.filter fun g => 0 < lam g).card := by exact_mod_cast hP.card_pos
  exact gain_le hd hΔ (dim_p_mul_sq_le lam hn hμpos.le hlow)

end HamiltonsCubic.L119Gain
