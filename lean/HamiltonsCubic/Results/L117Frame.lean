import HamiltonsCubic.Results.L70Compose
import HamiltonsCubic.Results.L50Traces
import HamiltonsCubic.Results.L75Statement

set_option linter.style.longLine false

/-!
# L117, the rigidity corollary of L70: `θ = (n−1)|λ_min|` and `θ ≥ θ₀(n)` at saturation

[findings/bounds.md](../../../findings/bounds.md), Lemma L117: *(1) `D(v) = 0` puts the mass `2(n−2)` on `E_min × E_max`,
and relation (B) gives `(n−2)(M − m) = 2m`; (2) L70's boxed identity then gives `θ = (n−1)m`; (3) summing the chord
inequality `(λ_a + m)(M − λ_a) ≥ 0` over all `N = C(n,2)` eigenvalues with `tr W = 0`, `‖W‖ = 1` gives `1 ≤ mMN` and
hence `θ ≥ θ₀(n)`.* Here `m = −λ_min`, `M = λ_max`.

- `L117_mass`: at a saturating critical point, **`(λ_min + λ_max)(n−2) = −2λ_min`**, from the support condition
  (`support_of_saturation`) and rows (A), (B) in the spectral-theorem eigenframe;
- `L117_theta`: **`θ = (n−1)(−λ_min)`**;
- `L117_bound`: **`θ ≥ √(2(n−1)(n−2))/n = θ₀(n)`** at unit norm.
-/

namespace HamiltonsCubic.EigenFrameExist

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SecondKind HamiltonsCubic.L41Statement
  HamiltonsCubic.L41Statement.Frame

variable {n : ℕ}

/-- **L117 (1)**: at saturation, `(λ_min + λ_max)(n−2) = −2λ_min`. -/
theorem L117_mass (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax) :
    (lmin + lmax) * ((n : ℝ) - 2) = -2 * lmin := by
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  set v := frameVec W hW.1 hW.2.1 hW.2.2.1
  set μ := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
  have hsupp := support_of_saturation W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat
  have hA := killing_frame hW.2 hf γ₀
  have hB1 := aW2_frame hW.2 hf γ₀
  have hB2 := aW2_mid hW.2 hf γ₀
  have hpt : ∀ a b, (μ a + μ b) * cst v γ₀ a b ^ 2 = (lmin + lmax) * cst v γ₀ a b ^ 2 := by
    intro a b
    by_cases h0 : cst v γ₀ a b = 0
    · rw [h0]; ring
    · rcases hsupp a b h0 with ⟨ha, hb⟩ | ⟨ha, hb⟩
      · rw [show μ a = lmin from ha, show μ b = lmax from hb]
      · rw [show μ a = lmax from ha, show μ b = lmin from hb]; ring
  have hsum : ∑ a, ∑ b, (μ a + μ b) * cst v γ₀ a b ^ 2 = (lmin + lmax) * ∑ a, ∑ b, cst v γ₀ a b ^ 2 := by
    simp only [hpt, Finset.mul_sum]
  have hL : ∑ a, ∑ b, (μ a + μ b) * cst v γ₀ a b ^ 2
      = ∑ a, ∑ b, μ a * cst v γ₀ a b ^ 2 + ∑ a, ∑ b, μ b * cst v γ₀ a b ^ 2 := by
    simp only [add_mul, Finset.sum_add_distrib]
  rw [hL, hB1, hB2, hA, hγ] at hsum
  simp only [Fintype.card_fin] at hsum
  linarith

/-- **L117 (2)**: at saturation, `θ = (n−1)(−λ_min)`. -/
theorem L117_theta (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax) :
    θ = ((n : ℝ) - 1) * (-lmin) := by
  have h := L117_mass W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat
  rw [hsat]; linarith

/-- **L117 (3)**: at a saturating critical point of unit norm, `θ ≥ θ₀(n) = √(2(n−1)(n−2))/n`. -/
theorem L117_bound (hn : 3 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (hunit : normSq W = 1) (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax) :
    Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n ≤ θ := by
  have hmass := L117_mass W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat
  have hθ := L117_theta W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat
  set μ := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
  have h1 : ∑ j, μ j = 0 := sum_mu_zero W hW.1 hW.2.1 hW.2.2.1 hW.2.2.2.2
  have h2 : ∑ j, μ j ^ 2 = 1 := by rw [sum_mu_sq W hW.1 hW.2.1 hW.2.2.1, hunit]
  have hN : (Fintype.card (Pairs n) : ℝ) = (n : ℝ) * ((n : ℝ) - 1) / 2 := by
    have : Fintype.card (Pairs n) = n.choose 2 := HamiltonsCubic.L75Statement.Proof.card_tri
    rw [this, Nat.cast_choose_two]
  -- the chord inequality, summed
  have hchord : 0 ≤ ∑ j, (μ j - lmin) * (lmax - μ j) :=
    Finset.sum_nonneg fun j _ => mul_nonneg (by linarith [hlo j]) (by linarith [hhi j])
  have hexp : ∑ j, (μ j - lmin) * (lmax - μ j)
      = -(∑ j, μ j ^ 2) + (lmin + lmax) * ∑ j, μ j - (Fintype.card (Pairs n) : ℝ) * (lmin * lmax) := by
    simp only [Finset.mul_sum, ← Finset.sum_neg_distrib, ← Finset.sum_add_distrib]
    rw [← Finset.card_univ, ← nsmul_eq_mul, ← Finset.sum_const, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun j _ => by ring
  rw [hexp, h1, h2, hN] at hchord
  have hn3 : (3 : ℝ) ≤ n := by exact_mod_cast hn
  have hM : lmax * ((n : ℝ) - 2) = -(n : ℝ) * lmin := by linarith
  have hA : 1 ≤ (n : ℝ) * ((n : ℝ) - 1) / 2 * (-lmin * lmax) := by nlinarith
  have hB : (n : ℝ) - 2 ≤ (n : ℝ) * ((n : ℝ) - 1) / 2 * ((n : ℝ) * lmin ^ 2) := by
    have h2n : 0 ≤ (n : ℝ) - 2 := by linarith
    have := mul_le_mul_of_nonneg_right hA h2n
    have e : (n : ℝ) * ((n : ℝ) - 1) / 2 * (-lmin * lmax) * ((n : ℝ) - 2)
        = (n : ℝ) * ((n : ℝ) - 1) / 2 * ((n : ℝ) * lmin ^ 2) := by
      have : -lmin * lmax * ((n : ℝ) - 2) = (n : ℝ) * lmin ^ 2 := by nlinarith
      calc (n : ℝ) * ((n : ℝ) - 1) / 2 * (-lmin * lmax) * ((n : ℝ) - 2)
          = (n : ℝ) * ((n : ℝ) - 1) / 2 * (-lmin * lmax * ((n : ℝ) - 2)) := by ring
        _ = _ := by rw [this]
    linarith
  have hθpos : 0 ≤ θ := by rw [hθ]; nlinarith
  have hsq : 2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) / (n : ℝ) ^ 2 ≤ θ ^ 2 := by
    rw [hθ, div_le_iff₀ (by positivity)]
    have h1n : 0 ≤ (n : ℝ) - 1 := by linarith
    nlinarith [mul_le_mul_of_nonneg_left hB (by positivity : (0 : ℝ) ≤ 2 * ((n : ℝ) - 1))]
  have hn0 : (0 : ℝ) < n := by linarith
  calc Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n
      = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) / (n : ℝ) ^ 2) := by
        rw [Real.sqrt_div' _ (by positivity), Real.sqrt_sq hn0.le]
    _ ≤ Real.sqrt (θ ^ 2) := Real.sqrt_le_sqrt hsq
    _ = θ := Real.sqrt_sq hθpos

/-- **L117's equality case**: at a saturating critical point of unit norm, `θ = θ₀(n)` iff every eigenvalue is `λ_min`
or `λ_max`, i.e. two eigenvalues (no kernel, both being nonzero). -/
theorem L117_eq (hn : 3 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (hunit : normSq W = 1) (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax) :
    θ = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n ↔
      ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmin ∨
        (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmax := by
  have hmass := L117_mass W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat
  have hθ := L117_theta W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat
  set μ := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
  have h1 : ∑ j, μ j = 0 := sum_mu_zero W hW.1 hW.2.1 hW.2.2.1 hW.2.2.2.2
  have h2 : ∑ j, μ j ^ 2 = 1 := by rw [sum_mu_sq W hW.1 hW.2.1 hW.2.2.1, hunit]
  have hN : (Fintype.card (Pairs n) : ℝ) = (n : ℝ) * ((n : ℝ) - 1) / 2 := by
    have : Fintype.card (Pairs n) = n.choose 2 := HamiltonsCubic.L75Statement.Proof.card_tri
    rw [this, Nat.cast_choose_two]
  set C := ∑ j, (μ j - lmin) * (lmax - μ j) with hC
  have hterm : ∀ j, 0 ≤ (μ j - lmin) * (lmax - μ j) := fun j =>
    mul_nonneg (by linarith [hlo j]) (by linarith [hhi j])
  have hexp : C = -1 - (n : ℝ) * ((n : ℝ) - 1) / 2 * (lmin * lmax) := by
    have e : ∑ j, (μ j - lmin) * (lmax - μ j)
        = -(∑ j, μ j ^ 2) + (lmin + lmax) * ∑ j, μ j - (Fintype.card (Pairs n) : ℝ) * (lmin * lmax) := by
      simp only [Finset.mul_sum, ← Finset.sum_neg_distrib, ← Finset.sum_add_distrib]
      rw [← Finset.card_univ, ← nsmul_eq_mul, ← Finset.sum_const, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun j _ => by ring
    rw [hC, e, h1, h2, hN]; ring
  have hn3 : (3 : ℝ) ≤ n := by exact_mod_cast hn
  have hn0 : (0 : ℝ) < n := by linarith
  -- `θ² = θ₀² (1 + C)`
  have hkey : θ ^ 2 = 2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) / (n : ℝ) ^ 2 * (1 + C) := by
    have hM : -lmin * lmax * ((n : ℝ) - 2) = (n : ℝ) * lmin ^ 2 := by nlinarith
    rw [hθ, hexp]
    have h2n : (n : ℝ) - 2 ≠ 0 := by linarith
    field_simp
    linear_combination (-(n : ℝ) * ((n : ℝ) - 1) ^ 2) * hM
  have hθpos : 0 ≤ θ := by rw [hθ]; nlinarith
  have hθ0 : 0 < 2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) / (n : ℝ) ^ 2 := by
    apply div_pos _ (by positivity); nlinarith
  have hsq0 : (Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n) ^ 2
      = 2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) / (n : ℝ) ^ 2 := by
    rw [div_pow, Real.sq_sqrt (by nlinarith)]
  constructor
  · intro h
    have hC0 : C = 0 := by
      have : θ ^ 2 = 2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) / (n : ℝ) ^ 2 := by rw [h, hsq0]
      rw [hkey] at this
      have := mul_left_cancel₀ hθ0.ne' (this.trans (mul_one _).symm)
      linarith
    have hz := (Finset.sum_eq_zero_iff_of_nonneg fun j _ => hterm j).mp hC0
    intro j
    rcases mul_eq_zero.mp (hz j (Finset.mem_univ j)) with h' | h'
    · left; linarith
    · right; linarith
  · intro hall
    have hC0 : C = 0 := Finset.sum_eq_zero fun j _ => by
      rcases hall j with h' | h' <;> rw [h'] <;> ring
    have hsq : θ ^ 2 = (Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n) ^ 2 := by
      rw [hkey, hC0, hsq0]; ring
    have hpos' : 0 ≤ Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n := by positivity
    nlinarith [sq_nonneg (θ - Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n),
      sq_nonneg (θ + Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n)]

/-- **The eigenvalue count at equality**: if every eigenvalue is `λ_min` or `λ_max` at a saturating critical point, then
`4·#λ_max = n(n−2)` and `4·#λ_min = n²`, so equality is impossible at odd `n`. -/
theorem L117_counts (hn : 3 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
    (htwo : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmin ∨
        (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmax) :
    4 * (univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmax).card = n * (n - 2) ∧
      4 * (univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmin).card = n ^ 2 := by
  have hmass := L117_mass W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat
  set μ := (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
  have h1 : ∑ j, μ j = 0 := sum_mu_zero W hW.1 hW.2.1 hW.2.2.1 hW.2.2.2.2
  set A := univ.filter fun j => μ j = lmax
  set B := univ.filter fun j => μ j = lmin
  have hne : lmin ≠ lmax := by linarith
  have hBA : B = Aᶜ := by
    ext j; simp only [A, B, Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_compl]
    constructor
    · intro h h'; exact hne (h.symm.trans h')
    · intro h; exact (htwo j).resolve_right h
  have htot : A.card + B.card = n.choose 2 := by
    rw [hBA, Finset.card_add_card_compl]; exact HamiltonsCubic.L75Statement.Proof.card_tri
  have hsum : (A.card : ℝ) * lmax + (B.card : ℝ) * lmin = 0 := by
    rw [← h1, hBA, ← Finset.sum_add_sum_compl A]
    rw [Finset.sum_congr rfl fun j hj => (Finset.mem_filter.mp hj).2,
      Finset.sum_congr rfl fun j hj => (htwo j).resolve_right (by
        intro h; exact (Finset.mem_compl.mp hj) (Finset.mem_filter.mpr ⟨Finset.mem_univ _, h⟩))]
    simp only [Finset.sum_const, nsmul_eq_mul]; ring
  have hn3 : (3 : ℝ) ≤ n := by exact_mod_cast hn
  have hM : lmax * ((n : ℝ) - 2) = -(n : ℝ) * lmin := by linarith
  -- `#A (n−2) … `: from `#A λ_max = −#B λ_min` and `λ_max (n−2) = −n λ_min`
  have hrel : (A.card : ℝ) * (n : ℝ) = (B.card : ℝ) * ((n : ℝ) - 2) := by
    have : (A.card : ℝ) * (lmax * ((n : ℝ) - 2)) = -(B.card : ℝ) * lmin * ((n : ℝ) - 2) := by
      have := congrArg (· * ((n : ℝ) - 2)) hsum; nlinarith
    rw [hM] at this
    have hl : lmin ≠ 0 := by linarith
    apply mul_right_cancel₀ hl; nlinarith
  have htotR : (A.card : ℝ) + B.card = (n : ℝ) * ((n : ℝ) - 1) / 2 := by
    have := congrArg (fun x : ℕ => (x : ℝ)) htot; simp only [Nat.cast_add] at this
    rw [this, Nat.cast_choose_two]
  have hA4 : 4 * (A.card : ℝ) = (n : ℝ) * ((n : ℝ) - 2) := by nlinarith
  have hB4 : 4 * (B.card : ℝ) = (n : ℝ) ^ 2 := by nlinarith
  constructor
  · have : ((4 * A.card : ℕ) : ℝ) = ((n * (n - 2) : ℕ) : ℝ) := by
      push_cast [Nat.cast_sub (show 2 ≤ n by omega)]; linarith
    exact_mod_cast this
  · have : ((4 * B.card : ℕ) : ℝ) = ((n ^ 2 : ℕ) : ℝ) := by push_cast; linarith
    exact_mod_cast this

/-- **So equality in L117 is impossible at odd `n`.** -/
theorem L117_no_eq_odd (hn : 3 ≤ n) (hodd : ¬ Even n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (γ₀ : Pairs n) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax) :
    ¬ ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmin ∨
        (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmax := by
  intro htwo
  have h := (L117_counts hn W hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat htwo).2
  apply hodd
  have : Even (n ^ 2) := ⟨2 * (univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = lmin).card, by omega⟩
  exact (Nat.even_pow' two_ne_zero).mp this

end HamiltonsCubic.EigenFrameExist
