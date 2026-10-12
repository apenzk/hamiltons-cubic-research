import HamiltonsCubic.Results.L178Pad

set_option linter.style.longLine false

/-!
# L178 on `ℝⁿ` over any `𝔰𝔲(2)` frame of `Λ²ℝ⁴`

Milestones 2 and 3 of [the L178 padding plan](../../../reviews/2026-09-26-lean-L178-padding-plan.md) share
one shape. [L178Pad.lean](L178Pad.lean) runs on CP2Real's three self-dual complex structures `J_a`, and its
proofs use them only through five facts: skew, orthogonal, pairwise orthogonal of norm `4`, closed under the
bracket as `2s ε`, and one common cyclic sum. **An `SUFrame` is any triple of `4 × 4` matrices with those
five facts and two more**, anticommutation and a vanishing mixed cyclic sum, which the construction here
does not use and the rotation of [L178Rot.lean](L178Rot.lean) does. This file runs the construction on one:

* `omF F a = E F_a Eᵀ/√2`, orthonormal bivectors on `ℝⁿ`, with `[ω_a, ω_b] = √2 s Σ_c ε_{abc} ω_c`;
* **`WF_weyl`**, **`WF_values`**, **`WF_P`**, **`WF_bound`**, **`WF_bound_eq_iff`**, **`WF_theta_le`**: for
  every trace-free weight `μ`, `W = Σ_a μ_a ⟨·, ω_a⟩ ω_a` is Weyl with `‖W‖² = Σ μ²`, `tr W³ = Σ μ³`,
  `⟨W, W#⟩ = 6 μ₀μ₁μ₂`, `P = 9 μ₀μ₁μ₂` and `θ ≤ √(3/2)`, with `|θ| = √(3/2)` exactly at a repeated weight;
* **`stdFrame`**: CP2Real's `J` is an `SUFrame` with `s = 1`.
-/

namespace HamiltonsCubic.CP2Real

open Matrix HamiltonsCubic.RealLayer

/-- The mixed cyclic sum `M_{qp}N_{sr} + M_{rp}N_{qs} + M_{sp}N_{rq}`, bilinear, with `cyc2 M M = cyc M`. -/
def cyc2 (M N : Matrix (Fin 4) (Fin 4) ℝ) (p q r s : Fin 4) : ℝ :=
  M q p * N s r + M r p * N q s + M s p * N r q

/-- **An `𝔰𝔲(2)` frame of `Λ²ℝ⁴`**: three skew orthogonal `4 × 4` matrices, pairwise orthogonal of Frobenius
norm `4` and anticommuting, with brackets `2s ε` for a sign `s`, one common cyclic sum, and vanishing mixed
cyclic sums. -/
structure SUFrame where
  F : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ
  s : ℝ
  s_sq : s ^ 2 = 1
  skew : ∀ a, (F a)ᵀ = -(F a)
  orth : ∀ a, (F a)ᵀ * F a = 1
  inner : ∀ a b, ((F a)ᵀ * F b).trace = if a = b then 4 else 0
  br : ∀ a b, F a * F b - F b * F a = (2 * s) • ∑ c, ((eps a b c : ℤ) : ℝ) • F c
  cyc_eq : ∀ a p q r t, cyc (F a) p q r t = cyc (F 0) p q r t
  anti : ∀ a b, a ≠ b → F a * F b + F b * F a = 0
  cyc_cross : ∀ a b, a ≠ b → ∀ p q r t, cyc2 (F a) (F b) p q r t + cyc2 (F b) (F a) p q r t = 0

theorem Jz_anti : ∀ a b : Fin 3, a ≠ b → ∀ i j : Fin 4,
    ∑ k, Jz a i k * Jz b k j + ∑ k, Jz b i k * Jz a k j = 0 := by decide

theorem Jz_cyc_cross : ∀ a b : Fin 3, a ≠ b → ∀ p q r t : Fin 4,
    (Jz a q p * Jz b t r + Jz a r p * Jz b q t + Jz a t p * Jz b r q)
      + (Jz b q p * Jz a t r + Jz b r p * Jz a q t + Jz b t p * Jz a r q) = 0 := by decide

theorem J_anti (a b : Fin 3) (hab : a ≠ b) : J a * J b + J b * J a = 0 := by
  ext i j
  have h := Jz_anti a b hab i j
  simp only [Matrix.add_apply, Matrix.mul_apply, Matrix.zero_apply, J_cast]
  exact_mod_cast h

theorem J_cyc_cross (a b : Fin 3) (hab : a ≠ b) (p q r t : Fin 4) :
    cyc2 (J a) (J b) p q r t + cyc2 (J b) (J a) p q r t = 0 := by
  have h := Jz_cyc_cross a b hab p q r t
  simp only [cyc2, J_cast]
  exact_mod_cast h

/-- CP2Real's self-dual structures are an `SUFrame` with `s = 1`. -/
noncomputable def stdFrame : SUFrame where
  F := J
  s := 1
  s_sq := by norm_num
  skew := J_skew
  orth := J_orth
  inner := J_inner
  br := fun a b => by rw [J_br]; norm_num
  cyc_eq := cyc_eq
  anti := J_anti
  cyc_cross := J_cyc_cross

variable {n : ℕ} (Φ : SUFrame)

/-- The frame's bivectors on `ℝⁿ`, `ω_a = E F_a Eᵀ/√2`. -/
noncomputable def omF (a : Fin 3) : Matrix (Fin n) (Fin n) ℝ := sq2⁻¹ • (Emb n * Φ.F a * (Emb n)ᵀ)

theorem omF_skew (a : Fin 3) : IsSkew (omF (n := n) Φ a) := by
  unfold IsSkew omF
  rw [Matrix.transpose_smul, Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, Φ.skew]
  simp [Matrix.mul_assoc, Matrix.neg_mul, Matrix.mul_neg]

theorem omF_entry (a : Fin 3) (p q : Fin n) :
    omF Φ a q p = sq2⁻¹ * dotProduct (fun x => Emb n q x) (Φ.F a *ᵥ fun x => Emb n p x) := by
  simp only [omF, Matrix.smul_apply, smul_eq_mul, Matrix.mul_apply, Matrix.transpose_apply, dotProduct,
    Matrix.mulVec, Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by ring

theorem omF_inner (hn : 4 ≤ n) (a b : Fin 3) : inner2 (omF (n := n) Φ a) (omF Φ b) = if a = b then 1 else 0 := by
  have h : (omF (n := n) Φ a)ᵀ * omF Φ b = (sq2⁻¹ * sq2⁻¹) • (Emb n * ((Φ.F a)ᵀ * Φ.F b) * (Emb n)ᵀ) := by
    unfold omF
    rw [Matrix.transpose_smul, conjT, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hn]
  unfold inner2
  rw [h, Matrix.trace_smul, Matrix.trace_mul_comm, ← Matrix.mul_assoc, Emb_orth hn, Matrix.one_mul, Φ.inner,
    smul_eq_mul]
  have := sq2_sq
  have := sq2_pos
  split_ifs
  · field_simp; linarith
  · simp

theorem omF_br (hn : 4 ≤ n) (a b : Fin 3) :
    br (omF (n := n) Φ a) (omF Φ b) = (sq2⁻¹ * sq2⁻¹) • (Emb n * (Φ.F a * Φ.F b - Φ.F b * Φ.F a) * (Emb n)ᵀ) := by
  unfold br omF
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hn, Matrix.smul_mul, Matrix.mul_smul, smul_smul,
    sandwich hn, ← smul_sub, Matrix.mul_sub, Matrix.sub_mul]

theorem omF_sq (hn : 4 ≤ n) (a : Fin 3) :
    (omF (n := n) Φ a)ᵀ * omF Φ a = (sq2⁻¹ * sq2⁻¹) • (Emb n * (Emb n)ᵀ) := by
  unfold omF
  rw [Matrix.transpose_smul, conjT, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hn, Φ.orth,
    Matrix.mul_one]

theorem omF_cyc (a : Fin 3) (i j k l : Fin n) :
    omF (n := n) Φ a j i * omF Φ a l k + omF Φ a k i * omF Φ a j l + omF Φ a l i * omF Φ a k j
      = sq2⁻¹ * sq2⁻¹ * ∑ x, ∑ y, ∑ z, ∑ t, Emb n i x * Emb n j y * Emb n k z * Emb n l t * cyc (Φ.F a) x y z t := by
  rw [omF_entry Φ a i j, omF_entry Φ a k l, omF_entry Φ a i k, omF_entry Φ a l j, omF_entry Φ a i l,
    omF_entry Φ a j k]
  set ri : Fin 4 → ℝ := fun x => Emb n i x
  set rj : Fin 4 → ℝ := fun x => Emb n j x
  set rk : Fin 4 → ℝ := fun x => Emb n k x
  set rl : Fin 4 → ℝ := fun x => Emb n l x
  calc _ = sq2⁻¹ * sq2⁻¹ * (dotProduct rj (Φ.F a *ᵥ ri) * dotProduct rl (Φ.F a *ᵥ rk)
        + dotProduct rk (Φ.F a *ᵥ ri) * dotProduct rj (Φ.F a *ᵥ rl)
        + dotProduct rl (Φ.F a *ᵥ ri) * dotProduct rk (Φ.F a *ᵥ rj)) := by ring
    _ = _ := by
      rw [HamiltonsCubic.L30Statement.e1, HamiltonsCubic.L30Statement.e2, HamiltonsCubic.L30Statement.e3]
      congr 1
      simp only [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ =>
        Finset.sum_congr rfl fun z _ => Finset.sum_congr rfl fun t _ => ?_
      simp only [cyc, ri, rj, rk, rl]; ring

theorem EFE (a : Fin 3) : Emb n * Φ.F a * (Emb n)ᵀ = sq2 • omF (n := n) Φ a := by
  unfold omF; rw [smul_smul, mul_inv_cancel₀ sq2_pos.ne', one_smul]

theorem omF_br_eps (hn : 4 ≤ n) (a b : Fin 3) :
    br (omF (n := n) Φ a) (omF Φ b) = (sq2 * Φ.s) • ∑ c, ((eps a b c : ℤ) : ℝ) • omF Φ c := by
  rw [omF_br Φ hn, Φ.br, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_sum, Matrix.sum_mul]
  simp only [Matrix.mul_smul, Matrix.smul_mul, EFE, smul_smul, Finset.smul_sum]
  refine Finset.sum_congr rfl fun c _ => ?_
  congr 1
  have h2 := sq2_sq
  have hp := sq2_pos
  field_simp
  rw [h2]

theorem cst_omF (hn : 4 ≤ n) (a b c : Fin 3) :
    inner2 (br (omF (n := n) Φ a) (omF Φ b)) (omF Φ c) = sq2 * Φ.s * ((eps a b c : ℤ) : ℝ) := by
  rw [omF_br_eps Φ hn, HamiltonsCubic.L41Statement.Frame.inner2_smul_l, HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  simp only [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, omF_inner Φ hn, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq', Finset.mem_univ, if_true]

/-! ## The operator and its invariants -/

/-- **`W = Σ_a μ_a ⟨·, ω_a⟩ ω_a` on `ℝⁿ`** over the frame. -/
noncomputable def WF (n : ℕ) (μ : Fin 3 → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ a, (μ a * inner2 X (omF Φ a)) • omF Φ a

theorem WF_inner (μ : Fin 3 → ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ) :
    inner2 (WF Φ n μ X) Y = ∑ a, μ a * inner2 X (omF Φ a) * inner2 (omF Φ a) Y := by
  unfold WF
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  exact Finset.sum_congr rfl fun a _ => by rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l]

theorem WF_weyl (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) : IsWeyl (WF Φ n μ) := by
  have hphi : ∀ a i j, inner2 (phi i j) (omF (n := n) Φ a) = omF Φ a j i := fun a i j => by
    rw [inner2_comm, inner2_phi _ (omF_skew Φ a), HamiltonsCubic.L30Statement.skew_entry (omF_skew Φ a)]
    ring
  refine ⟨fun X _ => ?_, fun X Y _ _ => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · unfold WF
    exact HamiltonsCubic.L41Statement.Frame.isSkew_sum _ _ _ fun a => omF_skew Φ a
  · rw [WF_inner, inner2_comm X, WF_inner]
    exact Finset.sum_congr rfl fun a _ => by rw [inner2_comm (omF Φ a) Y, inner2_comm X (omF Φ a)]; ring
  · unfold bianchi
    simp only [WF_inner, hphi, inner2_comm (omF Φ _) (phi _ _)]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    calc _ = ∑ a, μ a * (sq2⁻¹ * sq2⁻¹ * ∑ x, ∑ y, ∑ z, ∑ t,
          Emb n i x * Emb n j y * Emb n k z * Emb n l t * cyc (Φ.F 0) x y z t) := by
          refine Finset.sum_congr rfl fun a _ => ?_
          have h := omF_cyc Φ a i j k l
          simp only [Φ.cyc_eq] at h
          rw [← h]
          ring
      _ = 0 := by rw [← Finset.sum_mul, hμ, zero_mul]
  · unfold Ric
    simp only [WF_inner, hphi, inner2_comm (omF Φ _) (phi _ _)]
    rw [Finset.sum_comm]
    calc _ = ∑ α, μ α * (sq2⁻¹ * sq2⁻¹ * ∑ j, Emb n a j * Emb n b j) := by
          refine Finset.sum_congr rfl fun α _ => ?_
          have h := congrFun (congrFun (omF_sq Φ hn α) a) b
          simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.smul_apply, smul_eq_mul] at h
          rw [← h, Finset.mul_sum]
          exact Finset.sum_congr rfl fun c _ => by ring
      _ = 0 := by rw [← Finset.sum_mul, hμ, zero_mul]

theorem WF_om (hn : 4 ≤ n) (μ : Fin 3 → ℝ) (b : Fin 3) : WF Φ n μ (omF Φ b) = μ b • omF Φ b := by
  unfold WF
  simp only [omF_inner Φ hn, mul_ite, mul_one, mul_zero, ite_smul, zero_smul, Finset.sum_ite_eq, Finset.mem_univ,
    if_true]

theorem WF_perp (μ : Fin 3 → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) (h : ∀ a, inner2 X (omF Φ a) = 0) :
    WF Φ n μ X = 0 := by
  unfold WF; simp [h]

open HamiltonsCubic.L41Statement in
theorem WF_frame (hn : 4 ≤ n) (μ : Fin 3 → ℝ) : ∃ (r : ℕ) (g : Fin r → Matrix (Fin n) (Fin n) ℝ),
    (∀ c a, inner2 (g c) (omF Φ a) = 0) ∧
    EigenFrame (WF Φ n μ) (Sum.elim (omF Φ) g) (Sum.elim μ (fun _ => (0 : ℝ))) := by
  obtain ⟨r, g, hgs, hgon, hfg, hcomp⟩ :=
    HamiltonsCubic.FrameExtension.extend_frame (omF (n := n) Φ) (omF_skew Φ) (omF_inner Φ hn)
  have hgf : ∀ c a, inner2 (g c) (omF (n := n) Φ a) = 0 := fun c a => by rw [inner2_comm]; exact hfg a c
  refine ⟨r, g, hgf, ⟨?_, ?_, ?_, ?_⟩⟩
  · rintro (a|c); exacts [omF_skew Φ a, hgs c]
  · rintro (a|c) (b|e) <;> simp [omF_inner Φ hn, hgon, hfg, hgf]
  · rintro (a|c)
    · simp [WF_om Φ hn]
    · simp [WF_perp Φ _ _ (hgf c)]
  · intro X hX; rw [Fintype.sum_sum_type]; exact hcomp X hX

theorem eps_sum_s (f : Fin 3 → ℝ) (s : ℝ) (hs : s ^ 2 = 1) :
    ∑ a, ∑ b, ∑ c, f a * f b * f c * (sq2 * s * ((eps a b c : ℤ) : ℝ)) ^ 2 = 12 * f 0 * f 1 * f 2 := by
  simp only [Fin.sum_univ_three, eps, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.head_cons, Matrix.tail_cons, mul_pow, sq2_sq, hs]
  push_cast
  ring

open HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame in
/-- **The three invariants**: `‖W‖² = Σ μ²`, `tr W³ = Σ μ³`, `⟨W, W#⟩ = 6 μ₀μ₁μ₂`. -/
theorem WF_values (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    normSq (WF Φ n μ) = ∑ a, μ a ^ 2 ∧ trCube (WF Φ n μ) = ∑ a, μ a ^ 3 ∧
      sharpPair (WF Φ n μ) = 6 * (μ 0 * μ 1 * μ 2) := by
  obtain ⟨r, g, hgf, hf⟩ := WF_frame Φ hn μ
  have hW := WF_weyl Φ hn hμ
  refine ⟨?_, ?_, ?_⟩
  · rw [normSq_frame hW hf, Fintype.sum_sum_type]
    simp
  · rw [trCube_frame hW hf, Fintype.sum_sum_type]
    simp
  · rw [sharpPair_T hW hf]
    simp only [Fintype.sum_sum_type, Sum.elim_inl, Sum.elim_inr, zero_mul, mul_zero, Finset.sum_const_zero,
      add_zero]
    simp only [cst, Sum.elim_inl, cst_omF Φ hn]
    rw [eps_sum_s _ _ Φ.s_sq]
    ring

theorem WF_P (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    Pcubic (WF Φ n μ) = 9 * (μ 0 * μ 1 * μ 2) := by
  obtain ⟨-, hc, hs⟩ := WF_values Φ hn hμ
  unfold Pcubic
  rw [hc, hs]
  simp only [Fin.sum_univ_three] at hμ ⊢
  have h2 : μ 2 = -μ 0 - μ 1 := by linarith
  rw [h2]; ring

theorem WF_bound (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    Pcubic (WF Φ n μ) ^ 2 ≤ (3 / 2) * normSq (WF Φ n μ) ^ 3 := by
  rw [WF_P Φ hn hμ, (WF_values Φ hn hμ).1]
  have := disc_identity hμ
  nlinarith [sq_nonneg ((μ 0 - μ 1) * (μ 1 - μ 2) * (μ 2 - μ 0))]

theorem WF_bound_eq_iff (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) :
    Pcubic (WF Φ n μ) ^ 2 = (3 / 2) * normSq (WF Φ n μ) ^ 3 ↔ μ 0 = μ 1 ∨ μ 1 = μ 2 ∨ μ 2 = μ 0 := by
  rw [WF_P Φ hn hμ, (WF_values Φ hn hμ).1]
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

theorem WF_theta_le (hn : 4 ≤ n) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) (h0 : μ ≠ 0) :
    theta (WF Φ n μ) ≤ Real.sqrt (3 / 2) := by
  have hN : 0 < normSq (WF Φ n μ) := by
    rw [(WF_values Φ hn hμ).1]
    obtain ⟨a, ha⟩ : ∃ a, μ a ≠ 0 := by
      by_contra h; push Not at h; exact h0 (funext h)
    have := Finset.single_le_sum (f := fun a => μ a ^ 2) (fun b _ => sq_nonneg (μ b)) (Finset.mem_univ a)
    have : 0 < μ a ^ 2 := by positivity
    linarith
  have hb := WF_bound Φ hn hμ
  unfold theta HamiltonsCubic.RealLayer.norm
  have hs : 0 < Real.sqrt (normSq (WF Φ n μ)) := Real.sqrt_pos.mpr hN
  rw [div_le_iff₀ (by positivity)]
  have hsq : Real.sqrt (normSq (WF Φ n μ)) ^ 2 = normSq (WF Φ n μ) := Real.sq_sqrt hN.le
  have h32 : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have hrhs : 0 ≤ Real.sqrt (3 / 2) * Real.sqrt (normSq (WF Φ n μ)) ^ 3 := by positivity
  have hsq' : (Real.sqrt (3 / 2) * Real.sqrt (normSq (WF Φ n μ)) ^ 3) ^ 2 = (3 / 2) * normSq (WF Φ n μ) ^ 3 := by
    rw [mul_pow, h32, ← pow_mul, show 3 * 2 = 2 * 3 by rfl, pow_mul, hsq]
  exact abs_le_of_sq_le_sq' (by rw [hsq']; exact hb) hrhs |>.2

end HamiltonsCubic.CP2Real
