import HamiltonsCubic.Base.Schur
import HamiltonsCubic.Base.WeylIneq

set_option linter.style.longLine false

/-!
# The negative part of a block-diagonal perturbation, exactly

Milestone 4 of [the build plan for L17's derivative](../../../reviews/2026-09-26-lean-DK-plan.md). Let `g` be the
negative part, characterised by `g = 0` on `(0, ∞)`, `g(x) = −x` on `(−∞, 0)` and positive homogeneity. For symmetric
`u` and `H`, with `H_blk = ∑_λ P_λ H P_λ` ([Schur.lean](Schur.lean)'s `blkPart`), **`specFn_blk`** gives `t₀ > 0` with

`g(u + t H_blk) = g(u) + t (−∑_{λ<0} P_λ H P_λ + g(P₀ H P₀))` for every `0 ≤ t ≤ t₀`.

On a block at `λ ≠ 0` every eigenvalue of `u + t H_blk` stays on the side of `0` that `λ` is on, so `g` is affine
there. On the kernel block `u` vanishes, and `g(t P₀HP₀) = t g(P₀HP₀)` by homogeneity. The proof checks the right-hand
side on each window `Π₋ v`, `Π₀ v`, `Π₊ v` of an eigenvector `v` and concludes by `specFn_unique`.
-/

namespace HamiltonsCubic.SpectralFn

open Module

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  {n : ℕ} (hn : finrank ℝ E = n) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric)

/-! ## Windows and multipliers -/

/-- `[x < 0]`. -/
noncomputable def indNeg (x : ℝ) : ℝ := if x < 0 then 1 else 0
/-- `[x = 0]`. -/
noncomputable def indZero (x : ℝ) : ℝ := if x = 0 then 1 else 0
/-- `[x > 0]`. -/
noncomputable def indPos (x : ℝ) : ℝ := if 0 < x then 1 else 0
/-- `[a = b < 0]`, the multiplier of `∑_{λ<0} P_λ H P_λ`. -/
noncomputable def negBlkφ (a b : ℝ) : ℝ := if a = b ∧ a < 0 then 1 else 0
/-- `[a = 0][b = 0]`, the multiplier of `P₀ H P₀`. -/
noncomputable def zeroφ (a b : ℝ) : ℝ := if a = 0 ∧ b = 0 then 1 else 0

theorem zeroφ_symm (a b : ℝ) : zeroφ a b = zeroφ b a := by
  unfold zeroφ; by_cases ha : a = 0 <;> by_cases hb : b = 0 <;> simp [ha, hb]

theorem ind_sum (x : ℝ) : indNeg x + indZero x + indPos x = 1 := by
  unfold indNeg indZero indPos
  rcases lt_trichotomy x 0 with h | h | h
  · simp [h, h.ne, not_lt.mpr h.le]
  · simp [h]
  · simp [h, h.ne', not_lt.mpr h.le]

/-! ## Spectral-function algebra -/

theorem specFn_comp (f h : ℝ → ℝ) :
    specFn hn f hu ∘ₗ specFn hn h hu = specFn hn (fun x => f x * h x) hu :=
  specFn_unique hn _ hu _ fun μ v hv => by
    rw [LinearMap.comp_apply, specFn_apply_of_eigen hn h hu hv, map_smul, specFn_apply_of_eigen hn f hu hv,
      smul_smul, mul_comm]

theorem specFn_add (f h : ℝ → ℝ) :
    specFn hn f hu + specFn hn h hu = specFn hn (fun x => f x + h x) hu :=
  specFn_unique hn _ hu _ fun μ v hv => by
    rw [LinearMap.add_apply, specFn_apply_of_eigen hn f hu hv, specFn_apply_of_eigen hn h hu hv, add_smul]

theorem specFn_const (c : ℝ) : specFn hn (fun _ => c) hu = c • LinearMap.id :=
  (specFn_unique hn _ hu _ fun _ _ _ => by simp).symm

theorem specFn_negFn (h : ℝ → ℝ) : specFn hn (fun x => -h x) hu = -specFn hn h hu :=
  (specFn_unique hn _ hu _ fun μ v hv => by
    rw [LinearMap.neg_apply, specFn_apply_of_eigen hn h hu hv, neg_smul]).symm

/-- A spectral function that vanishes on the spectrum is `0`. -/
theorem specFn_eq_zero {f : ℝ → ℝ} (hf : ∀ x, f x = 0) : specFn hn f hu = 0 := by
  rw [specFn_congr hn f hu (fun _ => 0) fun i => hf _, specFn_const, zero_smul]

theorem schur_zero {φ : ℝ → ℝ → ℝ} (hφ : ∀ a b, φ a b = 0) (H : E →ₗ[ℝ] E) : schur hn hu φ H = 0 :=
  ext_entries hn hu fun k l => by rw [entry_schur, hφ]; simp

/-- **Every `f(u)` commutes with `u`.** -/
theorem specFn_comm_u (f : ℝ → ℝ) : u ∘ₗ specFn hn f hu = specFn hn f hu ∘ₗ u := by
  have h1 := specFn_comp hn hu id f
  have h2 := specFn_comp hn hu f id
  rw [specFn_id] at h1 h2
  rw [h1, h2]
  exact specFn_congr hn _ hu _ fun i => by simp only [id]; ring

/-! ## Quadratic bounds on a window -/

theorem norm_sq_eq_sum (w : E) : ‖w‖ ^ 2 = ∑ i, inner ℝ (hu.eigenvectorBasis hn i) w ^ 2 := by
  rw [← real_inner_self_eq_norm_sq, ← (hu.eigenvectorBasis hn).sum_inner_mul_inner w w]
  exact Finset.sum_congr rfl fun i _ => by rw [real_inner_comm w]; ring

theorem inner_eigvec_specFn (f : ℝ → ℝ) (i : Fin n) (v : E) :
    inner ℝ (hu.eigenvectorBasis hn i) (specFn hn f hu v) = f (hu.eigenvalues hn i) * inner ℝ (hu.eigenvectorBasis hn i) v := by
  rw [← specFn_isSymmetric, specFn_apply_of_eigen hn f hu (apply_eigvec hn hu i), real_inner_smul_left]

/-- **On a window above `γ`, `⟪u w, w⟫ ≥ γ ‖w‖²`.** -/
theorem inner_window_ge (f : ℝ → ℝ) {γ : ℝ} (hf : ∀ i, f (hu.eigenvalues hn i) ≠ 0 → γ ≤ hu.eigenvalues hn i) (v : E) :
    γ * ‖specFn hn f hu v‖ ^ 2 ≤ inner ℝ (u (specFn hn f hu v)) (specFn hn f hu v) := by
  rw [WeylIneq.inner_apply_eq_sum hn hu, norm_sq_eq_sum hn hu, Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  rw [inner_eigvec_specFn]
  by_cases h0 : f (hu.eigenvalues hn i) = 0
  · simp [h0]
  · exact mul_le_mul_of_nonneg_right (hf i h0) (sq_nonneg _)

/-- **On a window below `−γ`, `⟪u w, w⟫ ≤ −γ ‖w‖²`.** -/
theorem inner_window_le (f : ℝ → ℝ) {γ : ℝ} (hf : ∀ i, f (hu.eigenvalues hn i) ≠ 0 → hu.eigenvalues hn i ≤ -γ) (v : E) :
    inner ℝ (u (specFn hn f hu v)) (specFn hn f hu v) ≤ -γ * ‖specFn hn f hu v‖ ^ 2 := by
  rw [WeylIneq.inner_apply_eq_sum hn hu, norm_sq_eq_sum hn hu, Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  rw [inner_eigvec_specFn]
  by_cases h0 : f (hu.eigenvalues hn i) = 0
  · simp [h0]
  · exact mul_le_mul_of_nonneg_right (hf i h0) (sq_nonneg _)

omit [FiniteDimensional ℝ E] in
/-- `|⟪X w, w⟫| ≤ (‖X‖²_HS + 1) ‖w‖²`, a crude bound with no square root. -/
theorem abs_inner_le_hs [FiniteDimensional ℝ E] (X : E →ₗ[ℝ] E) (w : E) :
    |inner ℝ (X w) w| ≤ (hsSq X + 1) * ‖w‖ ^ 2 := by
  have h1 := norm_apply_sq_le X w
  have hh := hsSq_nonneg X
  have h2 : ‖X w‖ ≤ (hsSq X + 1) * ‖w‖ := by
    by_contra hc
    push Not at hc
    have hw := norm_nonneg w
    have h3 : ((hsSq X + 1) * ‖w‖) ^ 2 < ‖X w‖ ^ 2 := pow_lt_pow_left₀ hc (by positivity) two_ne_zero
    nlinarith [mul_nonneg hh (sq_nonneg ‖w‖), mul_nonneg (mul_nonneg hh hh) (sq_nonneg ‖w‖), sq_nonneg ‖w‖]
  calc |inner ℝ (X w) w| ≤ ‖X w‖ * ‖w‖ := abs_real_inner_le_norm _ _
    _ ≤ (hsSq X + 1) * ‖w‖ * ‖w‖ := mul_le_mul_of_nonneg_right h2 (norm_nonneg _)
    _ = (hsSq X + 1) * ‖w‖ ^ 2 := by ring

/-- **The spectral gap**: some `γ > 0` lies below every nonzero `|λᵢ|`. -/
theorem exists_gap : ∃ γ > 0, ∀ i, hu.eigenvalues hn i ≠ 0 → γ ≤ |hu.eigenvalues hn i| := by
  classical
  by_cases hs : (Finset.univ.filter fun i => hu.eigenvalues hn i ≠ 0).Nonempty
  · refine ⟨(Finset.univ.filter fun i => hu.eigenvalues hn i ≠ 0).inf' hs fun i => |hu.eigenvalues hn i|, ?_, ?_⟩
    · change 0 < _
      rw [Finset.lt_inf'_iff]
      intro i hi
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hi
      exact abs_pos.mpr hi
    · intro i hi
      exact Finset.inf'_le _ (by simp [hi])
  · refine ⟨1, one_pos, fun i hi => absurd ⟨i, by simp [hi]⟩ hs⟩

/-! ## The exact value -/

/-- **The exact block value with an explicit threshold**: for any `γ > 0` below the nonzero `|λᵢ|`, any
`C ≥ ‖H_blk‖²_HS` and `0 ≤ t` with `t (C + 1) ≤ γ/2`, `g(u + t H_blk) = g(u) + t (−∑_{λ<0} P_λ H P_λ + g(P₀ H P₀))`.
*The threshold depends on `H` only through `C`, so one `t₀` serves a bounded family of `H`.* -/
theorem specFn_blk_bound (g : ℝ → ℝ) (hpos : ∀ x, 0 < x → g x = 0) (hneg : ∀ x, x < 0 → g x = -x)
    (hhom : ∀ c x, 0 ≤ c → g (c * x) = c * g x) {H : E →ₗ[ℝ] E} (hH : H.IsSymmetric)
    {γ : ℝ} (hγ : 0 < γ) (hgap : ∀ i, hu.eigenvalues hn i ≠ 0 → γ ≤ |hu.eigenvalues hn i|)
    {C : ℝ} (hC : hsSq (blkPart hn hu H) ≤ C) {t : ℝ} (ht0 : 0 ≤ t) (htC : t * (C + 1) ≤ γ / 2)
    (hW : (u + t • blkPart hn hu H).IsSymmetric) :
    specFn hn g hW = specFn hn g hu +
      t • (-schur hn hu negBlkφ H + specFn hn g (schur_isSymmetric hn hu zeroφ_symm hH)) := by
  have g0 : g 0 = 0 := by simpa using hhom 0 0 le_rfl
  have hP0 := schur_isSymmetric hn hu zeroφ_symm hH
  refine (specFn_unique hn g hW _ fun μ v hv => ?_).symm
  -- the three windows partition the identity
  have hid : specFn hn indNeg hu + specFn hn indZero hu + specFn hn indPos hu = LinearMap.id := by
    rw [specFn_add, specFn_add, specFn_congr hn _ hu (fun _ => 1) (fun i => ind_sum _), specFn_const, one_smul]
  have hdec : v = specFn hn indNeg hu v + specFn hn indZero hu v + specFn hn indPos hu v := by
    have := LinearMap.congr_fun hid v
    simp only [LinearMap.add_apply, LinearMap.id_apply] at this
    exact this.symm
  -- each window of an eigenvector is an eigenvector
  have heig : ∀ f : ℝ → ℝ, u (specFn hn f hu v) + t • blkPart hn hu H (specFn hn f hu v) = μ • specFn hn f hu v := fun f => by
    have c1 := LinearMap.congr_fun (specFn_comm_u hn hu f) v
    have c2 := LinearMap.congr_fun (blkPart_comm_specFn hn hu f H) v
    simp only [LinearMap.comp_apply] at c1 c2
    rw [c1, c2, ← map_smul, ← map_add]
    rw [LinearMap.add_apply, LinearMap.smul_apply] at hv
    rw [hv, map_smul]
  -- the operator identities, applied to v
  have e1 : specFn hn g hu (specFn hn indPos hu v) = 0 := by
    have := LinearMap.congr_fun (specFn_comp hn hu g indPos) v
    rw [LinearMap.comp_apply] at this
    rw [this, specFn_eq_zero hn hu fun x => ?_, LinearMap.zero_apply]
    unfold indPos; split_ifs with h
    · rw [hpos x h, zero_mul]
    · rw [mul_zero]
  have e2 : specFn hn g hu (specFn hn indZero hu v) = 0 := by
    have := LinearMap.congr_fun (specFn_comp hn hu g indZero) v
    rw [LinearMap.comp_apply] at this
    rw [this, specFn_eq_zero hn hu fun x => ?_, LinearMap.zero_apply]
    unfold indZero; split_ifs with h
    · rw [h, g0, zero_mul]
    · rw [mul_zero]
  have e3 : specFn hn g hu (specFn hn indNeg hu v) = -u (specFn hn indNeg hu v) := by
    have := LinearMap.congr_fun (specFn_comp hn hu g indNeg) v
    rw [LinearMap.comp_apply] at this
    have hc : specFn hn (fun x => g x * indNeg x) hu = specFn hn (fun x => -(id x * indNeg x)) hu :=
      specFn_congr hn _ hu _ fun i => by
        unfold indNeg; split_ifs with h
        · rw [hneg _ h]; simp
        · simp
    rw [this, hc, specFn_negFn, ← specFn_comp, specFn_id, LinearMap.neg_apply, LinearMap.comp_apply]
  have e4 : schur hn hu negBlkφ H (specFn hn indPos hu v) = 0 := by
    have := LinearMap.congr_fun (schur_comp_specFn hn hu negBlkφ indPos H) v
    rw [LinearMap.comp_apply] at this
    rw [this, schur_zero hn hu (fun a b => ?_), LinearMap.zero_apply]
    unfold negBlkφ indPos; split_ifs with h1 h2 <;> first | (exfalso; rcases h1 with ⟨h1a, h1b⟩; subst h1a; linarith) | simp
  have e5 : schur hn hu negBlkφ H (specFn hn indZero hu v) = 0 := by
    have := LinearMap.congr_fun (schur_comp_specFn hn hu negBlkφ indZero H) v
    rw [LinearMap.comp_apply] at this
    rw [this, schur_zero hn hu (fun a b => ?_), LinearMap.zero_apply]
    unfold negBlkφ indZero; split_ifs with h1 h2 <;> first | (exfalso; rcases h1 with ⟨h1a, h1b⟩; subst h1a; linarith) | simp
  have e6 : schur hn hu negBlkφ H (specFn hn indNeg hu v) = blkPart hn hu H (specFn hn indNeg hu v) := by
    have h1 := LinearMap.congr_fun (schur_comp_specFn hn hu negBlkφ indNeg H) v
    have h2 := LinearMap.congr_fun (schur_comp_specFn hn hu blkφ indNeg H) v
    rw [LinearMap.comp_apply] at h1 h2
    unfold blkPart
    rw [h1, h2, schur_congr hn hu H fun i j => ?_]
    unfold negBlkφ blkφ indNeg
    by_cases hab : hu.eigenvalues hn i = hu.eigenvalues hn j
    · by_cases hb : hu.eigenvalues hn j < 0 <;> simp [hab, hb]
    · simp [hab]
  have e7 : schur hn hu zeroφ H (specFn hn indPos hu v) = 0 := by
    have := LinearMap.congr_fun (schur_comp_specFn hn hu zeroφ indPos H) v
    rw [LinearMap.comp_apply] at this
    rw [this, schur_zero hn hu (fun a b => ?_), LinearMap.zero_apply]
    unfold zeroφ indPos; split_ifs with h1 h2 <;> first | (exfalso; rcases h1 with ⟨h1a, h1b⟩; linarith) | simp
  have e8 : schur hn hu zeroφ H (specFn hn indNeg hu v) = 0 := by
    have := LinearMap.congr_fun (schur_comp_specFn hn hu zeroφ indNeg H) v
    rw [LinearMap.comp_apply] at this
    rw [this, schur_zero hn hu (fun a b => ?_), LinearMap.zero_apply]
    unfold zeroφ indNeg; split_ifs with h1 h2 <;> first | (exfalso; rcases h1 with ⟨h1a, h1b⟩; linarith) | simp
  have e9 : schur hn hu zeroφ H (specFn hn indZero hu v) = blkPart hn hu H (specFn hn indZero hu v) := by
    have h1 := LinearMap.congr_fun (schur_comp_specFn hn hu zeroφ indZero H) v
    have h2 := LinearMap.congr_fun (schur_comp_specFn hn hu blkφ indZero H) v
    rw [LinearMap.comp_apply] at h1 h2
    unfold blkPart
    rw [h1, h2, schur_congr hn hu H fun i j => ?_]
    unfold zeroφ blkφ indZero
    by_cases hb : hu.eigenvalues hn j = 0
    · by_cases ha : hu.eigenvalues hn i = 0 <;> simp [ha, hb]
    · simp [hb]
  have e10 : u (specFn hn indZero hu v) = 0 := by
    have := LinearMap.congr_fun (specFn_comp hn hu id indZero) v
    rw [LinearMap.comp_apply, specFn_id] at this
    rw [this, specFn_eq_zero hn hu fun x => ?_, LinearMap.zero_apply]
    unfold indZero; split_ifs with h
    · rw [h]; simp
    · rw [mul_zero]
  have eP0 : ∀ w : E, schur hn hu zeroφ H w = 0 → specFn hn g hP0 w = 0 := fun w hw => by
    rw [specFn_apply_of_eigen hn g hP0 (μ := 0) (by rw [hw, zero_smul]), g0, zero_smul]
  -- the sign of μ on a window
  have hquad : ∀ f : ℝ → ℝ, inner ℝ (u (specFn hn f hu v)) (specFn hn f hu v) +
      t * inner ℝ (blkPart hn hu H (specFn hn f hu v)) (specFn hn f hu v) = μ * ‖specFn hn f hu v‖ ^ 2 := fun f => by
    have := congrArg (fun x => inner ℝ x (specFn hn f hu v)) (heig f)
    simp only [inner_add_left, real_inner_smul_left, real_inner_self_eq_norm_sq] at this
    exact this
  have hHb : ∀ w : E, -((C + 1) * ‖w‖ ^ 2) ≤ inner ℝ (blkPart hn hu H w) w ∧
      inner ℝ (blkPart hn hu H w) w ≤ (C + 1) * ‖w‖ ^ 2 := fun w => by
    have h := abs_le.mp (abs_inner_le_hs (blkPart hn hu H) w)
    have hw := sq_nonneg ‖w‖
    constructor <;> nlinarith [h.1, h.2, mul_le_mul_of_nonneg_right hC hw]
  have hA : (specFn hn g hu + t • (-schur hn hu negBlkφ H + specFn hn g hP0)) (specFn hn indPos hu v) =
      g μ • specFn hn indPos hu v := by
    simp only [LinearMap.add_apply, LinearMap.smul_apply, LinearMap.neg_apply, e1, e4, eP0 _ e7, neg_zero,
      add_zero, smul_zero]
    by_cases hw : specFn hn indPos hu v = 0
    · rw [hw, smul_zero]
    have hn2 : 0 < ‖specFn hn indPos hu v‖ ^ 2 := by positivity
    have hq := inner_window_ge hn hu indPos (γ := γ) (fun i hi => by
      unfold indPos at hi
      split_ifs at hi with h
      · exact (hgap i h.ne').trans (abs_of_pos h).le
      · exact absurd rfl hi) v
    have h1 := hquad indPos
    have h2 := (hHb (specFn hn indPos hu v)).1
    have hμ : 0 < μ := by
      by_contra hc; push Not at hc
      nlinarith [mul_le_mul_of_nonneg_left h2 ht0]
    rw [hpos μ hμ, zero_smul]
  have hB : (specFn hn g hu + t • (-schur hn hu negBlkφ H + specFn hn g hP0)) (specFn hn indNeg hu v) =
      g μ • specFn hn indNeg hu v := by
    simp only [LinearMap.add_apply, LinearMap.smul_apply, LinearMap.neg_apply, e3, e6, eP0 _ e8, add_zero]
    rw [smul_neg, ← neg_add, heig indNeg]
    by_cases hw : specFn hn indNeg hu v = 0
    · rw [hw, smul_zero, smul_zero, neg_zero]
    have hn2 : 0 < ‖specFn hn indNeg hu v‖ ^ 2 := by positivity
    have hq := inner_window_le hn hu indNeg (γ := γ) (fun i hi => by
      unfold indNeg at hi
      split_ifs at hi with h
      · have := hgap i h.ne; rw [abs_of_neg h] at this; linarith
      · exact absurd rfl hi) v
    have h1 := hquad indNeg
    have h2 := (hHb (specFn hn indNeg hu v)).2
    have hμ : μ < 0 := by
      by_contra hc; push Not at hc
      nlinarith [mul_le_mul_of_nonneg_left h2 ht0]
    rw [hneg μ hμ, neg_smul]
  have hZ : (specFn hn g hu + t • (-schur hn hu negBlkφ H + specFn hn g hP0)) (specFn hn indZero hu v) =
      g μ • specFn hn indZero hu v := by
    simp only [LinearMap.add_apply, LinearMap.smul_apply, LinearMap.neg_apply, e2, e5, neg_zero]
    rw [zero_add, zero_add]
    have h1 := heig indZero
    rw [e10, zero_add, ← e9] at h1
    rcases ht0.eq_or_lt with h0 | hpos'
    · subst h0
      rw [zero_smul] at h1 ⊢
      rcases smul_eq_zero.mp h1.symm with hμ | hw
      · rw [hμ, g0, zero_smul]
      · rw [hw, smul_zero]
    · have hP : schur hn hu zeroφ H (specFn hn indZero hu v) = (μ / t) • specFn hn indZero hu v := by
        rw [div_eq_inv_mul, ← smul_smul, ← h1, smul_smul, inv_mul_cancel₀ hpos'.ne', one_smul]
      rw [specFn_apply_of_eigen hn g hP0 hP, smul_smul, ← hhom t (μ / t) ht0, mul_div_cancel₀ _ hpos'.ne']
  rw [hdec, map_add, map_add, hA, hB, hZ, smul_add, smul_add]

/-- **`g(u + t H_blk) = g(u) + t (−∑_{λ<0} P_λ H P_λ + g(P₀ H P₀))` for `0 ≤ t ≤ t₀`**, `g` the negative part. -/
theorem specFn_blk (g : ℝ → ℝ) (hpos : ∀ x, 0 < x → g x = 0) (hneg : ∀ x, x < 0 → g x = -x)
    (hhom : ∀ c x, 0 ≤ c → g (c * x) = c * g x) {H : E →ₗ[ℝ] E} (hH : H.IsSymmetric) :
    ∃ t₀ > 0, ∀ t : ℝ, 0 ≤ t → t ≤ t₀ → ∀ hW : (u + t • blkPart hn hu H).IsSymmetric,
      specFn hn g hW = specFn hn g hu +
        t • (-schur hn hu negBlkφ H + specFn hn g (schur_isSymmetric hn hu zeroφ_symm hH)) := by
  obtain ⟨γ, hγ, hgap⟩ := exists_gap hn hu
  have hC1 : 1 ≤ hsSq (blkPart hn hu H) + 1 := by have := hsSq_nonneg (blkPart hn hu H); linarith
  refine ⟨γ / (2 * (hsSq (blkPart hn hu H) + 1)), by positivity, fun t ht0 ht hW => ?_⟩
  have htC : t * (hsSq (blkPart hn hu H) + 1) ≤ γ / 2 := by
    rw [le_div_iff₀ (by positivity)] at ht; linarith
  exact specFn_blk_bound hn hu g hpos hneg hhom hH hγ hgap le_rfl ht0 htC hW

end HamiltonsCubic.SpectralFn
