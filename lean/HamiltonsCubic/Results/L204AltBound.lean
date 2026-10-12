import HamiltonsCubic.Base.SelfDual

open scoped Matrix

/-!
# Lemma L204, the sharp bound on the $\Lambda^4$ part of a positive operator

[findings/bounds.md](../../../findings/bounds.md), the uncontracted-rows section. The record
carried TWO unaudited reviewer bounds on `‖Alt(W²)‖`, one in `n` and one in
`m = ⌊n/2⌋`, agreeing at even `n` and parting at odd `n`. This file types the ruling.

`Alt(A) = (1/6) ∑ μ_α ω_α ∧ ω_α` over an orthonormal eigenbasis, so for a POSITIVE
semidefinite `A` the triangle inequality gives `‖Alt A‖ ≤ (1/6) (max‖ω ∧ ω‖) tr A`, and the
maximum of `‖ω ∧ ω‖` over unit bivectors is `√(12(m-1)/m)`, attained at the balanced
bivector `∑ φ_{2i-1,2i} / √m`. The two combine to `√((m-1)/(3m)) tr A`.

The norm on both sides is the record's, `‖R‖² = (1/4) ∑ R_{ijkl}²`.

`altConst_le_altConstN` is the ruling and it is PROVED: the `m`-form is at most the `n`-form at
every `n ≥ 2`, with equality exactly when `n` is even. So the `m`-form is right and the
`n`-form is its even-`n` specialisation.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open Real

/-- The record's norm on a four-index tensor, `(1/4) ∑ T_{ijkl}²`, as a squared value. -/
noncomputable def tensorNormSq {ι : Type*} [Fintype ι] (T : ι → ι → ι → ι → ℝ) : ℝ :=
  (1 / 4) * ∑ i, ∑ j, ∑ k, ∑ l, (T i j k l) ^ 2

/-- **The bound's constant**, `√((m-1)/(3m))` at `m = ⌊n/2⌋`. -/
noncomputable def altConst (m : ℕ) : ℝ := Real.sqrt (((m : ℝ) - 1) / (3 * m))

/-- **The constant the other bound proposed**, `√((n-2)/(3n))`. -/
noncomputable def altConstN (n : ℕ) : ℝ := Real.sqrt (((n : ℝ) - 2) / (3 * n))

/-- **THE RULING, and it is proved.** At every `n ≥ 2` the `m`-form is at most the `n`-form,
so the `m`-form is the sharper of the two, and they agree exactly when `n` is even. -/
theorem altConst_le_altConstN (n : ℕ) (hn : 2 ≤ n) :
    altConst (n / 2) ≤ altConstN n := by
  unfold altConst altConstN
  apply Real.sqrt_le_sqrt
  rcases Nat.even_or_odd n with he | ho
  · obtain ⟨k, hk⟩ := he
    have hk2 : n / 2 = k := by omega
    have hnk : (n : ℝ) = 2 * k := by rw [hk]; push_cast; ring
    have hkpos : (1 : ℝ) ≤ k := by
      have : 1 ≤ k := by omega
      exact_mod_cast this
    rw [hk2, hnk]
    have h6 : (0 : ℝ) < 6 * k := by linarith
    rw [div_le_div_iff₀ (by linarith) (by linarith)]
    ring_nf
    nlinarith [hkpos]
  · obtain ⟨k, hk⟩ := ho
    have hk2 : n / 2 = k := by omega
    have hnk : (n : ℝ) = 2 * k + 1 := by rw [hk]; push_cast; ring
    have hkpos : (1 : ℝ) ≤ k := by
      have : 1 ≤ k := by omega
      exact_mod_cast this
    rw [hk2, hnk]
    rw [div_le_div_iff₀ (by linarith) (by linarith)]
    nlinarith [hkpos]

/-- **At even `n` they agree**, which is why one reviewer's figure looked right everywhere it
was checked. *This is the forward half only: that they agree at NO odd `n` is witnessed here at
`n = 9` alone, by `altConst_lt_altConstN_n9`, rather than proved in general.* -/
theorem altConst_eq_altConstN_of_even {n : ℕ} (hn : 2 ≤ n) (he : Even n) :
    altConst (n / 2) = altConstN n := by
  obtain ⟨k, hk⟩ := he
  have hk2 : n / 2 = k := by omega
  have hnk : (n : ℝ) = 2 * k := by rw [hk]; push_cast; ring
  have hkpos : (0 : ℝ) < k := by
    have : 1 ≤ k := by omega
    have : (1 : ℝ) ≤ k := by exact_mod_cast this
    linarith
  unfold altConst altConstN
  rw [hk2, hnk]
  congr 1
  field_simp

/-- **They part at odd `n`, strictly**, so the two bounds are genuinely different statements
and the `n`-form is not merely a rewriting. Stated at `n = 9`, where the values are `1/2`
against `√(7/27)`. -/
theorem altConst_lt_altConstN_n9 : altConst 4 < altConstN 9 := by
  unfold altConst altConstN
  apply Real.sqrt_lt_sqrt (by norm_num)
  norm_num

/-! ## The proof's pieces

*The identity `‖ω ∧ ω‖² = 12‖ω‖⁴ - 6 tr ω⁴` (`wedge_normSq`), the trace bound
`⌊n/2⌋ · tr ω⁴ ≥ 2` for a unit bivector (`trace_bound`), and the triangle inequality through the
Euclidean norm, of which the record's `‖·‖` is one half.* **The trace bound does not use the evenness
of a skew matrix's rank**: at odd `n`, `det ω = 0` supplies a unit kernel vector `u`, and Cauchy–Schwarz
against `I - uuᵀ`, whose squared Frobenius norm is `n - 1`, gives what the rank count would. -/

namespace L204Proof

open Matrix

variable {n : ℕ}

theorem reindex4 (f g : Fin n → Fin n → Fin n → Fin n → ℝ) (c : ℝ)
    (σ : Fin n × Fin n × Fin n × Fin n ≃ Fin n × Fin n × Fin n × Fin n)
    (h : ∀ a b c' d, f a b c' d
      = c * g (σ (a, b, c', d)).1 (σ (a, b, c', d)).2.1 (σ (a, b, c', d)).2.2.1 (σ (a, b, c', d)).2.2.2) :
    ∑ a, ∑ b, ∑ c', ∑ d, f a b c' d = c * ∑ a, ∑ b, ∑ c', ∑ d, g a b c' d := by
  have e : ∀ F : Fin n → Fin n → Fin n → Fin n → ℝ,
      ∑ a, ∑ b, ∑ c', ∑ d, F a b c' d = ∑ p : Fin n × Fin n × Fin n × Fin n, F p.1 p.2.1 p.2.2.1 p.2.2.2 := by
    intro F; simp only [Fintype.sum_prod_type]
  rw [e f, e g, Finset.mul_sum]
  exact Fintype.sum_equiv σ _ _ fun ⟨a, b, c', d⟩ => h a b c' d

/-- `Σ ω_ab ω_bc ω_cd ω_da`, which is `tr ω⁴`. -/
def Q4 (w : Matrix (Fin n) (Fin n) ℝ) : ℝ := ∑ a, ∑ b, ∑ c, ∑ d, w a b * w b c * w c d * w d a

theorem trace_pow4 (w : Matrix (Fin n) (Fin n) ℝ) : (w * w * w * w).trace = Q4 w := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Finset.sum_mul, Q4]
  exact (reindex4 _ (fun a b c d => w a b * w b c * w c d * w d a) 1
    ⟨fun p => (p.1, p.2.2.2, p.2.2.1, p.2.1), fun p => (p.1, p.2.2.2, p.2.2.1, p.2.1),
      fun _ => rfl, fun _ => rfl⟩ (fun a b c d => by simp only [Equiv.coe_fn_mk]; ring)).trans (one_mul _)

/-- **`‖ω ∧ ω‖² = 12‖ω‖⁴ - 6 tr ω⁴`** in the record's norms, `‖ω‖² = ½ Σ ω_ij²`. -/
theorem wedge_normSq (w : Matrix (Fin n) (Fin n) ℝ) (hw : wᵀ = -w) :
    tensorNormSq (HamiltonsCubic.SelfDualLayer.wedgeSelf w)
      = 3 * (∑ i, ∑ j, w i j ^ 2) ^ 2 - 6 * Q4 w := by
  have hs : ∀ i j, w j i = -w i j := fun i j => by
    have := congrFun (congrFun hw i) j; simpa [Matrix.transpose_apply] using this
  have hN : ∀ F : Fin n → Fin n → Fin n → Fin n → ℝ, (∀ i j k l, F i j k l = w i j ^ 2 * w k l ^ 2) →
      ∑ i, ∑ j, ∑ k, ∑ l, F i j k l = (∑ i, ∑ j, w i j ^ 2) ^ 2 := by
    intro F hF
    simp only [hF]
    rw [sq, Finset.sum_mul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum]
  unfold tensorNormSq HamiltonsCubic.SelfDualLayer.wedgeSelf HamiltonsCubic.SelfDualLayer.wedge2
    HamiltonsCubic.SelfDualLayer.halfw
  simp only [Pi.add_apply]
  have e : ∀ i j k l, (w i j * w k l - w i k * w j l + w i l * w j k
      + (w i j * w k l - w i k * w j l + w i l * w j k)) ^ 2
      = 4 * ((w i j * w k l) ^ 2 + (w i k * w j l) ^ 2 + (w i l * w j k) ^ 2
        - 2 * (w i j * w k l * (w i k * w j l)) + 2 * (w i j * w k l * (w i l * w j k))
        - 2 * (w i k * w j l * (w i l * w j k))) := fun i j k l => by ring
  simp only [e, ← Finset.mul_sum, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  have hA : ∑ i, ∑ j, ∑ k, ∑ l, (w i j * w k l) ^ 2 = (∑ i, ∑ j, w i j ^ 2) ^ 2 :=
    hN _ fun i j k l => by ring
  have hB : ∑ i, ∑ j, ∑ k, ∑ l, (w i k * w j l) ^ 2 = (∑ i, ∑ j, w i j ^ 2) ^ 2 := by
    rw [reindex4 _ (fun i j k l => (w i j * w k l) ^ 2) 1
      ⟨fun p => (p.1, p.2.2.1, p.2.1, p.2.2.2), fun p => (p.1, p.2.2.1, p.2.1, p.2.2.2),
        fun _ => rfl, fun _ => rfl⟩ (fun a b c d => by simp only [Equiv.coe_fn_mk]; ring), one_mul, hA]
  have hC : ∑ i, ∑ j, ∑ k, ∑ l, (w i l * w j k) ^ 2 = (∑ i, ∑ j, w i j ^ 2) ^ 2 := by
    rw [reindex4 _ (fun i j k l => (w i j * w k l) ^ 2) 1
      ⟨fun p => (p.1, p.2.2.2, p.2.1, p.2.2.1), fun p => (p.1, p.2.2.1, p.2.2.2, p.2.1),
        fun _ => rfl, fun _ => rfl⟩ (fun a b c d => by simp only [Equiv.coe_fn_mk]; ring), one_mul, hA]
  have hAB : ∑ i, ∑ j, ∑ k, ∑ l, w i j * w k l * (w i k * w j l) = Q4 w := by
    rw [reindex4 _ (fun a b c d => w a b * w b c * w c d * w d a) 1
      ⟨fun p => (p.1, p.2.1, p.2.2.2, p.2.2.1), fun p => (p.1, p.2.1, p.2.2.2, p.2.2.1),
        fun _ => rfl, fun _ => rfl⟩ (fun i j k l => by
          show _ = 1 * (w i j * w j l * w l k * w k i)
          rw [hs k l, hs i k]; ring), one_mul]
    rfl
  have hAC : ∑ i, ∑ j, ∑ k, ∑ l, w i j * w k l * (w i l * w j k) = -Q4 w := by
    rw [reindex4 _ (fun a b c d => w a b * w b c * w c d * w d a) (-1) (Equiv.refl _)
      (fun i j k l => by
          show _ = -1 * (w i j * w j k * w k l * w l i)
          rw [hs i l]; ring)]
    unfold Q4; ring
  have hBC : ∑ i, ∑ j, ∑ k, ∑ l, w i k * w j l * (w i l * w j k) = Q4 w := by
    rw [reindex4 _ (fun a b c d => w a b * w b c * w c d * w d a) 1
      ⟨fun p => (p.1, p.2.2.1, p.2.1, p.2.2.2), fun p => (p.1, p.2.2.1, p.2.1, p.2.2.2),
        fun _ => rfl, fun _ => rfl⟩ (fun i j k l => by
          show _ = 1 * (w i k * w k j * w j l * w l i)
          rw [hs j k, hs i l]; ring), one_mul]
    rfl
  rw [hA, hB, hC, hAB, hAC, hBC]
  ring


/-- Cauchy–Schwarz over a pair of indices. -/
theorem cs2 (a b : Fin n → Fin n → ℝ) :
    (∑ i, ∑ j, a i j * b i j) ^ 2 ≤ (∑ i, ∑ j, a i j ^ 2) * ∑ i, ∑ j, b i j ^ 2 := by
  have e : ∀ F : Fin n → Fin n → ℝ, ∑ i, ∑ j, F i j = ∑ p : Fin n × Fin n, F p.1 p.2 := fun F => by
    simp only [Fintype.sum_prod_type]
  rw [e (fun i j => a i j * b i j), e (fun i j => a i j ^ 2), e (fun i j => b i j ^ 2)]
  exact Finset.sum_mul_sq_le_sq_mul_sq _ _ _

/-- **`⌊n/2⌋ · tr ω⁴ ≥ 2` for a unit bivector**, without the evenness of a skew matrix's rank: at
odd `n` a kernel vector `v` of `ω` supplies the projector `I - vvᵀ`, whose trace is `n - 1`. -/
theorem trace_bound (hn : 2 ≤ n) (w : Matrix (Fin n) (Fin n) ℝ) (hw : wᵀ = -w)
    (hunit : (1 / 2 : ℝ) * (wᵀ * w).trace = 1) : 2 ≤ ((n / 2 : ℕ) : ℝ) * Q4 w := by
  classical
  have hs : ∀ i j, w j i = -w i j := fun i j => by
    have := congrFun (congrFun hw i) j; simpa [Matrix.transpose_apply] using this
  set S := w * w with hS
  have hSsym : ∀ i j, S j i = S i j := fun i j => by
    simp only [hS, Matrix.mul_apply]
    exact Finset.sum_congr rfl fun k _ => by rw [hs k i, hs j k]; ring
  have htrS : ∑ i, S i i = -2 := by
    have : (wᵀ * w).trace = 2 := by linarith
    rw [hw, Matrix.neg_mul, Matrix.trace_neg] at this
    have h2 : (w * w).trace = -2 := by linarith
    simpa [Matrix.trace] using h2
  have hQ4 : Q4 w = ∑ i, ∑ j, S i j ^ 2 := by
    rw [← trace_pow4, show w * w * w * w = S * S by rw [hS, ← Matrix.mul_assoc]]
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [hSsym i j]; ring
  -- a matrix `Q` with `Σ S_ij Q_ij = tr S` and `Σ Q_ij² = 2⌊n/2⌋`
  obtain ⟨Q, hQS, hQQ⟩ : ∃ Q : Matrix (Fin n) (Fin n) ℝ,
      ∑ i, ∑ j, S i j * Q i j = -2 ∧ ∑ i, ∑ j, Q i j ^ 2 = 2 * ((n / 2 : ℕ) : ℝ) := by
    rcases Nat.even_or_odd n with he | ho
    · refine ⟨1, ?_, ?_⟩
      · rw [← htrS]
        refine Finset.sum_congr rfl fun i _ => ?_
        simp [Matrix.one_apply]
      · simp only [Matrix.one_apply, ite_pow, one_pow, zero_pow two_ne_zero, Finset.sum_ite_eq,
          Finset.mem_univ, if_true, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul,
          mul_one]
        obtain ⟨k, hk⟩ := he
        have : n / 2 = k := by omega
        rw [this]; push_cast [hk]; ring
    · have hdet : w.det = 0 := by
        have h1 : wᵀ.det = w.det := Matrix.det_transpose w
        rw [hw, Matrix.det_neg, Fintype.card_fin, Odd.neg_one_pow ho] at h1
        linarith
      obtain ⟨v, hv0, hwv⟩ := Matrix.exists_mulVec_eq_zero_iff.mpr hdet
      have hvpos : 0 < ∑ i, v i ^ 2 := by
        obtain ⟨i, hi⟩ := Function.ne_iff.mp hv0
        exact lt_of_lt_of_le (lt_of_le_of_ne (sq_nonneg _) (Ne.symm (pow_ne_zero 2 hi)))
          (Finset.single_le_sum (f := fun i => v i ^ 2)
          (fun j _ => sq_nonneg _) (Finset.mem_univ i))
      set r := Real.sqrt (∑ i, v i ^ 2) with hr
      have hr0 : 0 < r := Real.sqrt_pos.mpr hvpos
      have hr2 : r ^ 2 = ∑ i, v i ^ 2 := Real.sq_sqrt hvpos.le
      let u : Fin n → ℝ := fun i => v i / r
      have hu1 : ∑ i, u i ^ 2 = 1 := by
        simp only [u, div_pow, ← Finset.sum_div, ← hr2]; field_simp
      have hwu : ∀ i, ∑ k, w i k * u k = 0 := fun i => by
        have := congrFun hwv i
        simp only [Matrix.mulVec, dotProduct, Pi.zero_apply] at this
        simp only [u, mul_div_assoc', ← Finset.sum_div, this, zero_div]
      refine ⟨fun i j => (if i = j then 1 else 0) - u i * u j, ?_, ?_⟩
      · have hvSv : ∑ i, ∑ j, S i j * (u i * u j) = 0 := by
          simp only [hS, Matrix.mul_apply, Finset.sum_mul]
          have : ∀ i, ∑ j, ∑ k, w i k * w k j * (u i * u j) = 0 := fun i => by
            rw [Finset.sum_comm]
            refine Finset.sum_eq_zero fun k _ => ?_
            have := hwu k
            calc ∑ j, w i k * w k j * (u i * u j) = w i k * u i * ∑ j, w k j * u j := by
                  rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by ring
              _ = 0 := by rw [this, mul_zero]
          exact Finset.sum_eq_zero fun i _ => this i
        simp only [mul_sub, Finset.sum_sub_distrib, hvSv, sub_zero]
        rw [← htrS]
        refine Finset.sum_congr rfl fun i _ => ?_
        simp [mul_ite]
      · have e : ∀ i j, ((if i = j then (1 : ℝ) else 0) - u i * u j) ^ 2
            = (if i = j then 1 else 0) - 2 * (if i = j then 1 else 0) * (u i * u j) + u i ^ 2 * u j ^ 2 := by
          intro i j; split_ifs <;> ring
        simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ,
          if_true, mul_ite, ite_mul, mul_one, one_mul, mul_zero, zero_mul, Finset.sum_const,
          Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
        simp only [← Finset.mul_sum, ← Finset.sum_mul, ← sq, hu1]
        obtain ⟨k, hk⟩ := ho
        have : n / 2 = k := by omega
        rw [this]; push_cast [hk]; ring
  have hcs := cs2 S Q
  rw [hQS, hQQ, ← hQ4] at hcs
  nlinarith [hcs]

theorem alt_le' {n : ℕ} (hn : 2 ≤ n)
    (μ : Fin (n * (n - 1) / 2) → ℝ) (hμ : ∀ a, 0 ≤ μ a)
    (ω : Fin (n * (n - 1) / 2) → Matrix (Fin n) (Fin n) ℝ)
    (hskew : ∀ a, Matrix.transpose (ω a) = -(ω a))
    (hunit : ∀ a, (1 / 2 : ℝ) * (Matrix.transpose (ω a) * (ω a)).trace = 1)
    (horth : ∀ a b, a ≠ b → (1 / 2 : ℝ) * (Matrix.transpose (ω a) * (ω b)).trace = 0)
    (T : Fin n → Fin n → Fin n → Fin n → ℝ)
    (hT : T = fun i j k l => (1 / 6 : ℝ) *
      ∑ a, μ a * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l) :
    Real.sqrt (tensorNormSq T) ≤ altConst (n / 2) * ∑ a, μ a := by
  subst hT
  let toE : (Fin n → Fin n → Fin n → Fin n → ℝ) → EuclideanSpace ℝ (Fin n × Fin n × Fin n × Fin n) :=
    fun X => WithLp.toLp 2 (fun p : Fin n × Fin n × Fin n × Fin n => X p.1 p.2.1 p.2.2.1 p.2.2.2)
  have hnE : ∀ X, Real.sqrt (tensorNormSq X) = (1 / 2) * ‖toE X‖ := by
    intro X
    rw [EuclideanSpace.norm_eq]
    unfold tensorNormSq
    simp only [toE, Real.norm_eq_abs, sq_abs, Fintype.sum_prod_type]
    rw [Real.sqrt_mul (by norm_num), show Real.sqrt (1 / 4) = 1 / 2 by
      rw [show (1 / 4 : ℝ) = (1 / 2) ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
  have hsum : toE (fun i j k l => (1 / 6 : ℝ) * ∑ a, μ a * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)
      = ∑ a, μ a • toE (fun i j k l => (1 / 6 : ℝ) * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l) := by
    simp only [toE, ← WithLp.toLp_smul, ← WithLp.toLp_sum]
    congr 1
    funext p
    simp only [Finset.sum_apply, Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => by ring
  have hterm : ∀ a, ‖toE (fun i j k l => (1 / 6 : ℝ) * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)‖
      ≤ 2 * altConst (n / 2) := by
    intro a
    have h1 := hnE (fun i j k l => (1 / 6 : ℝ) * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)
    have hts : tensorNormSq (fun i j k l => (1 / 6 : ℝ) * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)
        = (1 / 36) * tensorNormSq (HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a)) := by
      unfold tensorNormSq
      simp only [mul_pow, ← Finset.mul_sum]
      ring
    rw [wedge_normSq (ω a) (hskew a)] at hts
    have ht : ∑ i, ∑ j, ω a j i * ω a j i = 2 := by
      have := hunit a
      simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply] at this
      linarith
    have hN : ∑ i, ∑ j, ω a i j ^ 2 = 2 := by
      rw [Finset.sum_comm] at ht; simpa [sq] using ht
    have htb := trace_bound hn (ω a) (hskew a) (hunit a)
    have hm : (1 : ℝ) ≤ ((n / 2 : ℕ) : ℝ) := by exact_mod_cast (by omega : 1 ≤ n / 2)
    have hle : tensorNormSq (fun i j k l => (1 / 6 : ℝ) * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)
        ≤ (((n / 2 : ℕ) : ℝ) - 1) / (3 * ((n / 2 : ℕ) : ℝ)) := by
      rw [hts, hN, le_div_iff₀ (by positivity)]
      nlinarith
    have hs : Real.sqrt (tensorNormSq (fun i j k l => (1 / 6 : ℝ) *
        HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)) ≤ altConst (n / 2) :=
      Real.sqrt_le_sqrt hle
    linarith
  rw [hnE, hsum]
  calc (1 / 2) * ‖∑ a, μ a • toE (fun i j k l => (1 / 6 : ℝ) *
          HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)‖
      ≤ (1 / 2) * ∑ a, ‖μ a • toE (fun i j k l => (1 / 6 : ℝ) *
          HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)‖ := by
        gcongr; exact norm_sum_le _ _
    _ = (1 / 2) * ∑ a, μ a * ‖toE (fun i j k l => (1 / 6 : ℝ) *
          HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l)‖ := by
        congr 1
        exact Finset.sum_congr rfl fun a _ => by rw [norm_smul, Real.norm_of_nonneg (hμ a)]
    _ ≤ (1 / 2) * ∑ a, μ a * (2 * altConst (n / 2)) := by
        exact mul_le_mul_of_nonneg_left (Finset.sum_le_sum fun a _ =>
          mul_le_mul_of_nonneg_left (hterm a) (hμ a)) (by norm_num)
    _ = altConst (n / 2) * ∑ a, μ a := by
        rw [Finset.mul_sum, Finset.mul_sum]
        exact Finset.sum_congr rfl fun a _ => by ring

end L204Proof

/-- **The bound itself, PROVED.** For a positive semidefinite `A` on
`Λ²ℝⁿ` presented by an ORTHONORMAL eigenbasis `ω` indexed by `Fin (n*(n-1)/2)` with
nonnegative eigenvalues `μ`, `‖Alt A‖ ≤ √((m-1)/(3m)) · tr A` at `m = ⌊n/2⌋`.

**The hypotheses are what the earlier statement lacked and is why that one was FALSE rather
than open**: nothing constrained `ω`, so scaling one bivector broke the conclusion because
`wedgeSelf` is degree-two homogeneous, and the basis was indexed by `Fin n` where `Λ²ℝⁿ`
has `n(n-1)/2` eigenpairs. Both defects are repaired here.

*The maximisation `max‖ω ∧ ω‖ = √(12(m-1)/m)` over unit bivectors is `L204Proof.wedge_normSq`
with `L204Proof.trace_bound`, WITHOUT a canonical form, and the triangle inequality over the
eigenbasis finishes it.*

**AND `hT` DEFINES `T` RATHER THAN ASSERTING WHAT IT IS, WHICH REMAINS A GAP IN THE STATEMENT
now that the proof is complete.** *Nothing here says `T` is `Alt` of `A`'s four-index form: `hT` sets it to
`(1/6) ∑ μ • wedgeSelf ω`, so the statement types the triangle inequality and the maximisation
while ASSUMING the eigen-expansion, which is step 1 of the prose derivation.* Both Gate 2
readers found this independently.

**The evenness of a skew matrix's rank is not needed**: at odd `n`, `det ω = 0` (since
`det ωᵀ = (-1)ⁿ det ω`) gives a kernel vector, and Cauchy–Schwarz against the projector onto its
complement delivers the same bound. Odd `n` is exactly where the ruling between the two constants
bites. -/
theorem alt_le_altConst_trace {n : ℕ} (hn : 2 ≤ n)
    (μ : Fin (n * (n - 1) / 2) → ℝ) (hμ : ∀ a, 0 ≤ μ a)
    (ω : Fin (n * (n - 1) / 2) → Matrix (Fin n) (Fin n) ℝ)
    (hskew : ∀ a, Matrix.transpose (ω a) = -(ω a))
    (hunit : ∀ a, (1 / 2 : ℝ) * (Matrix.transpose (ω a) * (ω a)).trace = 1)
    (horth : ∀ a b, a ≠ b → (1 / 2 : ℝ) * (Matrix.transpose (ω a) * (ω b)).trace = 0)
    (T : Fin n → Fin n → Fin n → Fin n → ℝ)
    (hT : T = fun i j k l => (1 / 6 : ℝ) *
      ∑ a, μ a * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l) :
    Real.sqrt (tensorNormSq T) ≤ altConst (n / 2) * ∑ a, μ a :=
  L204Proof.alt_le' hn μ hμ ω hskew hunit horth T hT

end HamiltonsCubic.Results
