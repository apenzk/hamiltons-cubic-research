import HamiltonsCubic.Results.CP2Real

set_option linter.style.longLine false

/-!
# L178 on `ℝⁿ`: every trace-free weight on the self-dual forms

Milestone 1 of [the L178 padding plan](../../../reviews/2026-09-26-lean-L178-padding-plan.md).
[CP2Real.lean](CP2Real.lean) builds the padded `W_{ℂP²} = Σ_a μ_a ⟨·, ω_a⟩ ω_a` on `ℝⁿ` at the one weight
`μ = (2,-1,-1)/√6`. Its proofs use `μ` only through `Σ μ = 0` until the last line, so here the weight is
any trace-free `μ`:

* **`Wm_weyl`**: `W_μ ∈ 𝒲ₙ` at every `n ≥ 4`, from `Σ μ = 0`;
* **`Wm_values`**: `‖W_μ‖² = Σ μ²`, `tr W_μ³ = Σ μ³` and `⟨W_μ, W_μ#⟩ = 6 μ₀μ₁μ₂`, through the eigenframe
  `ω ∪ g` and the frame identities of [L41Statement.lean](L41Statement.lean);
* **`Wm_P`**: `P(W_μ) = 9 μ₀μ₁μ₂`, the record's `θ = 9e₃` of step 4;
* **`Wm_bound`**: `P(W_μ)² ≤ (3/2) ‖W_μ‖⁶`, by `p₂³ - 54e₃² = 2 ∏(μᵢ - μⱼ)²`, the discriminant of step 5, with
  equality exactly at a repeated weight (`Wm_bound_eq_iff`);
* **`Wm_theta_le`**: `θ(W_μ) ≤ √(3/2)` at every nonzero trace-free `μ`.
-/

namespace HamiltonsCubic.CP2Real

open HamiltonsCubic.RealLayer

variable {n : ℕ}

/-- **`W_μ = Σ_a μ_a ⟨·, ω_a⟩ ω_a` on `ℝⁿ`**, padded by zero off the first four coordinates. -/
noncomputable def Wm (n : ℕ) (μ : Fin 3 → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ a, (μ a * inner2 X (om a)) • om a

theorem Wm_inner (μ : Fin 3 → ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ) :
    inner2 (Wm n μ X) Y = ∑ a, μ a * inner2 X (om a) * inner2 (om a) Y := by
  unfold Wm
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  exact Finset.sum_congr rfl fun a _ => by rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l]

/-- **`W_μ` is Weyl** for every trace-free `μ`. -/
theorem Wm_weyl (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) : IsWeyl (Wm n μ) := by
  have hphi : ∀ a i j, inner2 (phi i j) (om (n := n) a) = om a j i := fun a i j => by
    rw [inner2_comm, inner2_phi _ (om_skew a), HamiltonsCubic.L30Statement.skew_entry (om_skew a)]
    ring
  refine ⟨fun X _ => ?_, fun X Y _ _ => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · unfold Wm
    exact HamiltonsCubic.L41Statement.Frame.isSkew_sum _ _ _ fun a => om_skew a
  · rw [Wm_inner, inner2_comm X, Wm_inner]
    exact Finset.sum_congr rfl fun a _ => by rw [inner2_comm (om a) Y, inner2_comm X (om a)]; ring
  · unfold bianchi
    simp only [Wm_inner, hphi, inner2_comm (om _) (phi _ _)]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    calc _ = ∑ a, μ a * (sq2⁻¹ * sq2⁻¹ * ∑ x, ∑ y, ∑ z, ∑ t,
          Emb n i x * Emb n j y * Emb n k z * Emb n l t * cyc (J 0) x y z t) := by
          refine Finset.sum_congr rfl fun a _ => ?_
          have h := om_cyc a i j k l
          simp only [cyc_eq] at h
          rw [← h]
          ring
      _ = 0 := by rw [← Finset.sum_mul, hμ, zero_mul]
  · unfold Ric
    simp only [Wm_inner, hphi, inner2_comm (om _) (phi _ _)]
    rw [Finset.sum_comm]
    calc _ = ∑ α, μ α * (sq2⁻¹ * sq2⁻¹ * ∑ j, Emb n a j * Emb n b j) := by
          refine Finset.sum_congr rfl fun α _ => ?_
          have h := congrFun (congrFun (om_sq hn α) a) b
          simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.smul_apply, smul_eq_mul] at h
          rw [← h, Finset.mul_sum]
          exact Finset.sum_congr rfl fun c _ => by ring
      _ = 0 := by rw [← Finset.sum_mul, hμ, zero_mul]

theorem Wm_om (hn : 4 ≤ n) (μ : Fin 3 → ℝ) (b : Fin 3) : Wm n μ (om b) = μ b • om b := by
  unfold Wm
  simp only [om_inner hn, mul_ite, mul_one, mul_zero, ite_smul, zero_smul, Finset.sum_ite_eq, Finset.mem_univ,
    if_true]

theorem Wm_perp (μ : Fin 3 → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) (h : ∀ a, inner2 X (om a) = 0) :
    Wm n μ X = 0 := by
  unfold Wm; simp [h]

open HamiltonsCubic.L41Statement in
theorem Wm_frame (hn : 4 ≤ n) (μ : Fin 3 → ℝ) : ∃ (r : ℕ) (g : Fin r → Matrix (Fin n) (Fin n) ℝ),
    (∀ c a, inner2 (g c) (om a) = 0) ∧
    EigenFrame (Wm n μ) (Sum.elim om g) (Sum.elim μ (fun _ => (0 : ℝ))) := by
  obtain ⟨r, g, hgs, hgon, hfg, hcomp⟩ :=
    HamiltonsCubic.FrameExtension.extend_frame (om (n := n)) om_skew (om_inner hn)
  have hgf : ∀ c a, inner2 (g c) (om (n := n) a) = 0 := fun c a => by rw [inner2_comm]; exact hfg a c
  refine ⟨r, g, hgf, ⟨?_, ?_, ?_, ?_⟩⟩
  · rintro (a|c); exacts [om_skew a, hgs c]
  · rintro (a|c) (b|e) <;> simp [om_inner hn, hgon, hfg, hgf]
  · rintro (a|c)
    · simp [Wm_om hn]
    · simp [Wm_perp _ _ (hgf c)]
  · intro X hX; rw [Fintype.sum_sum_type]; exact hcomp X hX

open HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame in
/-- **The three invariants of `W_μ`**: `‖W‖² = Σ μ²`, `tr W³ = Σ μ³`, `⟨W, W#⟩ = 6 μ₀μ₁μ₂`. -/
theorem Wm_values (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    normSq (Wm n μ) = ∑ a, μ a ^ 2 ∧ trCube (Wm n μ) = ∑ a, μ a ^ 3 ∧
      sharpPair (Wm n μ) = 6 * (μ 0 * μ 1 * μ 2) := by
  obtain ⟨r, g, hgf, hf⟩ := Wm_frame hn μ
  have hW := Wm_weyl hn hμ
  refine ⟨?_, ?_, ?_⟩
  · rw [normSq_frame hW hf, Fintype.sum_sum_type]
    simp
  · rw [trCube_frame hW hf, Fintype.sum_sum_type]
    simp
  · rw [sharpPair_T hW hf]
    simp only [Fintype.sum_sum_type, Sum.elim_inl, Sum.elim_inr, zero_mul, mul_zero, Finset.sum_const_zero,
      add_zero]
    simp only [cst, Sum.elim_inl, cst_om hn]
    rw [eps_sum]
    ring

/-- **`P(W_μ) = 9 μ₀μ₁μ₂`** at trace-free `μ`, step 4's `θ = 9e₃`: `tr W³ = 3e₃` by Newton at `e₁ = 0`, and
`⟨W, W#⟩ = 6e₃`. -/
theorem Wm_P (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    Pcubic (Wm n μ) = 9 * (μ 0 * μ 1 * μ 2) := by
  obtain ⟨-, hc, hs⟩ := Wm_values hn hμ
  unfold Pcubic
  rw [hc, hs]
  simp only [Fin.sum_univ_three] at hμ ⊢
  have h2 : μ 2 = -μ 0 - μ 1 := by linarith
  rw [h2]; ring

/-- **The discriminant identity**, `p₂³ - 54e₃² = 2 ∏(μᵢ - μⱼ)²` at `e₁ = 0`. -/
theorem disc_identity {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    (∑ a, μ a ^ 2) ^ 3 - 54 * (μ 0 * μ 1 * μ 2) ^ 2
      = 2 * ((μ 0 - μ 1) * (μ 1 - μ 2) * (μ 2 - μ 0)) ^ 2 := by
  simp only [Fin.sum_univ_three] at hμ ⊢
  have h2 : μ 2 = -μ 0 - μ 1 := by linarith
  rw [h2]; ring

/-- **L178's bound on the padded self-dual family**: `P(W_μ)² ≤ (3/2) ‖W_μ‖⁶`. -/
theorem Wm_bound (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    Pcubic (Wm n μ) ^ 2 ≤ (3 / 2) * normSq (Wm n μ) ^ 3 := by
  rw [Wm_P hn hμ, (Wm_values hn hμ).1]
  have := disc_identity hμ
  nlinarith [sq_nonneg ((μ 0 - μ 1) * (μ 1 - μ 2) * (μ 2 - μ 0))]

/-- **Equality exactly at a repeated weight**, which at unit norm is `μ = ±(2,-1,-1)/√6` up to order. -/
theorem Wm_bound_eq_iff (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    Pcubic (Wm n μ) ^ 2 = (3 / 2) * normSq (Wm n μ) ^ 3 ↔ μ 0 = μ 1 ∨ μ 1 = μ 2 ∨ μ 2 = μ 0 := by
  rw [Wm_P hn hμ, (Wm_values hn hμ).1]
  have := disc_identity hμ
  constructor
  · intro h
    have h0 : ((μ 0 - μ 1) * (μ 1 - μ 2) * (μ 2 - μ 0)) ^ 2 = 0 := by nlinarith
    have h1 := pow_eq_zero_iff (two_ne_zero) |>.mp h0
    rcases mul_eq_zero.mp h1 with h | h
    · rcases mul_eq_zero.mp h with h | h
      · left; linarith
      · right; left; linarith
    · right; right; linarith
  · intro h
    have hz : (μ 0 - μ 1) * (μ 1 - μ 2) * (μ 2 - μ 0) = 0 := by
      rcases h with h | h | h <;> simp [h]
    rw [hz] at this
    nlinarith [this]

/-- **`θ(W_μ) ≤ √(3/2)`** at every nonzero trace-free weight. -/
theorem Wm_theta_le (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) (h0 : μ ≠ 0) :
    theta (Wm n μ) ≤ Real.sqrt (3 / 2) := by
  have hN : 0 < normSq (Wm n μ) := by
    rw [(Wm_values hn hμ).1]
    obtain ⟨a, ha⟩ : ∃ a, μ a ≠ 0 := by
      by_contra h; push Not at h; exact h0 (funext h)
    have := Finset.single_le_sum (f := fun a => μ a ^ 2) (fun b _ => sq_nonneg (μ b)) (Finset.mem_univ a)
    have : 0 < μ a ^ 2 := by positivity
    linarith
  have hb := Wm_bound hn hμ
  unfold theta HamiltonsCubic.RealLayer.norm
  have hs : 0 < Real.sqrt (normSq (Wm n μ)) := Real.sqrt_pos.mpr hN
  rw [div_le_iff₀ (by positivity)]
  have hsq : Real.sqrt (normSq (Wm n μ)) ^ 2 = normSq (Wm n μ) := Real.sq_sqrt hN.le
  have h32 : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have hrhs : 0 ≤ Real.sqrt (3 / 2) * Real.sqrt (normSq (Wm n μ)) ^ 3 := by positivity
  have hsq' : (Real.sqrt (3 / 2) * Real.sqrt (normSq (Wm n μ)) ^ 3) ^ 2 = (3 / 2) * normSq (Wm n μ) ^ 3 := by
    rw [mul_pow, h32, ← pow_mul, show 3 * 2 = 2 * 3 by rfl, pow_mul, hsq]
  exact abs_le_of_sq_le_sq' (by rw [hsq']; exact hb) hrhs |>.2

end HamiltonsCubic.CP2Real
