import HamiltonsCubic.Results.L167Stab

set_option linter.style.longLine false

/-!
# L167's second display at every `n`, in coordinates

[findings/route-a.md](../../../findings/route-a.md), Lemma L167: with `u = W_{ℂP²}` padded into `ℝⁿ`, `n = 4 + m`,
`𝔰𝔱𝔞𝔟(u) = 𝔲(2) ⊕ 𝔰𝔬(m)`. **This file proves it in coordinates**, `ρ(A) = [A, ·]` on skew matrices and `u = Wc n`:

* **`blk`**, **`pad`**: the `ℝ⁴` block `Eᵀ A E` and the padding `E B Eᵀ`, `E = Emb n`;
* **`Wc_blk`**: `Wc n X = pad (Wc 4 (blk X))`, the padded operator reads only the block;
* **`stab_full`**: a skew `A` on `ℝⁿ` has `[A, Wc n X] = Wc n [A, X]` for every skew `X` exactly when its mixed block
  `ℝ⁴ ⊗ ℝ^m` vanishes and its `ℝ⁴` block is `p J₀ + Σ q_a K_a`, the `ℝ^m` block being free: the span of `J₀` and
  `Λ⁻` plus `𝔰𝔬(m)`, which the record reads as `𝔲(2) ⊕ 𝔰𝔬(m)`;
* **`br_J0K`**, **`br_K01`**, **`br_K02`**, **`br_K12`**, **`u2_indep`**: that reading holds, `J₀` commuting with each
  `K_a`, the `K_a` closing as `𝔰𝔲(2)` (`[K_a, K_b] = -2ε_{abc} K_c`, so `e_a = -K_a/2` has the structure constants
  `ε_{abc}`, `su2_structure`), and the four generators independent, so the span is `𝔲(1) ⊕ 𝔰𝔲(2)` of dimension `4`.
  *No `LieSubalgebra` or `LieEquiv` object is built*: closure is read off the brackets and the isomorphism off the
  structure constants.
-/

namespace HamiltonsCubic.CP2Real

open Finset Matrix HamiltonsCubic.RealLayer

variable {n : ℕ}

/-- The `ℝ⁴` block. -/
noncomputable def blk (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin 4) (Fin 4) ℝ := (Emb n)ᵀ * A * Emb n

/-- The padding. -/
noncomputable def pad (B : Matrix (Fin 4) (Fin 4) ℝ) : Matrix (Fin n) (Fin n) ℝ := Emb n * B * (Emb n)ᵀ

theorem blk_pad (hn : 4 ≤ n) (B : Matrix (Fin 4) (Fin 4) ℝ) : blk (pad (n := n) B) = B := by
  unfold blk pad
  rw [show (Emb n)ᵀ * (Emb n * B * (Emb n)ᵀ) * Emb n = ((Emb n)ᵀ * Emb n) * B * ((Emb n)ᵀ * Emb n) by
    simp only [Matrix.mul_assoc], Emb_orth hn, Matrix.one_mul, Matrix.mul_one]

theorem inner2_pad (X : Matrix (Fin n) (Fin n) ℝ) (B : Matrix (Fin 4) (Fin 4) ℝ) :
    inner2 X (pad B) = inner2 (blk X) B := by
  unfold inner2 blk pad
  congr 1
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose]
  rw [show Xᵀ * (Emb n * B * (Emb n)ᵀ) = (Xᵀ * Emb n * B) * (Emb n)ᵀ by simp only [Matrix.mul_assoc],
    Matrix.trace_mul_comm]
  simp only [Matrix.mul_assoc]

theorem om_pad (a : Fin 3) : om (n := n) a = pad (sq2⁻¹ • J a) := by
  unfold om pad; rw [Matrix.mul_smul, Matrix.smul_mul]

theorem pad_smul (c : ℝ) (B : Matrix (Fin 4) (Fin 4) ℝ) : pad (n := n) (c • B) = c • pad B := by
  unfold pad; rw [Matrix.mul_smul, Matrix.smul_mul]

theorem pad_sum (f : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ) : pad (n := n) (∑ a, f a) = ∑ a, pad (f a) := by
  unfold pad; rw [Matrix.mul_sum, Matrix.sum_mul]

/-- **The padded operator reads only the block.** -/
theorem Wc_blk (X : Matrix (Fin n) (Fin n) ℝ) : Wc n X = pad (Wc 4 (blk X)) := by
  rw [Wc_four, pad_sum]
  unfold Wc
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [om_pad, inner2_pad, pad_smul, pad_smul, smul_smul,
    HamiltonsCubic.L41Statement.Frame.inner2_smul_r]
  congr 1
  have : sq2⁻¹ * sq2⁻¹ = 1 / 2 := by rw [← mul_inv, ← sq, sq2_sq]; norm_num
  linear_combination (mu a * inner2 (blk X) (J a)) * this

theorem blk_br (A X : Matrix (Fin n) (Fin n) ℝ) (hAE : A * Emb n = Emb n * blk A) (hEA : (Emb n)ᵀ * A = blk A * (Emb n)ᵀ) :
    blk (A * X - X * A) = blk A * blk X - blk X * blk A := by
  have h1 : blk (A * X) = blk A * blk X := by
    show (Emb n)ᵀ * (A * X) * Emb n = blk A * ((Emb n)ᵀ * X * Emb n)
    rw [show (Emb n)ᵀ * (A * X) * Emb n = ((Emb n)ᵀ * A) * X * Emb n by simp only [Matrix.mul_assoc], hEA]
    simp only [Matrix.mul_assoc]
  have h2 : blk (X * A) = blk X * blk A := by
    change (Emb n)ᵀ * (X * A) * Emb n = ((Emb n)ᵀ * X * Emb n) * blk A
    rw [show (Emb n)ᵀ * (X * A) * Emb n = (Emb n)ᵀ * X * (A * Emb n) by simp only [Matrix.mul_assoc], hAE]
    simp only [Matrix.mul_assoc]
  have hsub : blk (A * X - X * A) = blk (A * X) - blk (X * A) := by
    unfold blk; rw [Matrix.mul_sub, Matrix.sub_mul]
  rw [hsub, h1, h2]

theorem br_pad (A : Matrix (Fin n) (Fin n) ℝ) (W : Matrix (Fin 4) (Fin 4) ℝ)
    (hAE : A * Emb n = Emb n * blk A) (hEA : (Emb n)ᵀ * A = blk A * (Emb n)ᵀ) :
    A * pad W - pad W * A = pad (blk A * W - W * blk A) := by
  unfold pad
  rw [Matrix.mul_sub, Matrix.sub_mul]
  congr 1
  · rw [← Matrix.mul_assoc, ← Matrix.mul_assoc, hAE]; simp only [Matrix.mul_assoc]
  · rw [Matrix.mul_assoc, Matrix.mul_assoc, hEA]; simp only [Matrix.mul_assoc]

theorem blk_skew (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) : IsSkew (blk X) := by
  unfold IsSkew blk at *
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hX]
  simp [Matrix.mul_assoc, Matrix.neg_mul, Matrix.mul_neg]

theorem pad_skew (B : Matrix (Fin 4) (Fin 4) ℝ) (hB : IsSkew B) : IsSkew (pad (n := n) B) := by
  unfold IsSkew pad at *
  rw [conjT, hB]; simp [Matrix.mul_neg, Matrix.neg_mul]

/-- **No mixed block**: `A` vanishes on `ℝ⁴ ⊗ ℝ^m` (both orders). -/
def NoMixed (A : Matrix (Fin n) (Fin n) ℝ) : Prop := ∀ i j, In4 i → ¬ In4 j → A i j = 0 ∧ A j i = 0

/-- The embedded index of `x : Fin 4`. -/
def emb (hn : 4 ≤ n) (x : Fin 4) : Fin n := ⟨x, lt_of_lt_of_le x.2 hn⟩

theorem mul_Emb {α : Type*} (hn : 4 ≤ n) (M : Matrix α (Fin n) ℝ) (i : α) (x : Fin 4) :
    (M * Emb n) i x = M i (emb hn x) := by
  rw [Matrix.mul_apply, Finset.sum_eq_single (emb hn x)]
  · simp [Emb, emb]
  · intro k _ hk; simp only [Emb]; rw [if_neg, mul_zero]; intro h; exact hk (Fin.ext h)
  · simp

theorem EmbT_mul {β : Type*} (hn : 4 ≤ n) (M : Matrix (Fin n) β ℝ) (x : Fin 4) (j : β) :
    ((Emb n)ᵀ * M) x j = M (emb hn x) j := by
  rw [Matrix.mul_apply, Finset.sum_eq_single (emb hn x)]
  · simp [Emb, emb]
  · intro k _ hk; simp only [Matrix.transpose_apply, Emb]; rw [if_neg, zero_mul]; intro h; exact hk (Fin.ext h)
  · simp

theorem blk_apply (hn : 4 ≤ n) (A : Matrix (Fin n) (Fin n) ℝ) (x y : Fin 4) : blk A x y = A (emb hn x) (emb hn y) := by
  unfold blk; rw [mul_Emb hn, EmbT_mul hn]

theorem Emb_mul (B : Matrix (Fin 4) (Fin 4) ℝ) (i : Fin n) (x : Fin 4) :
    (Emb n * B) i x = if h : (i : ℕ) < 4 then B ⟨i, h⟩ x else 0 := by
  rw [Matrix.mul_apply]
  split_ifs with h
  · rw [Finset.sum_eq_single ⟨i, h⟩]
    · simp [Emb]
    · intro y _ hy; simp only [Emb]; rw [if_neg, zero_mul]; intro h'; exact hy (Fin.ext h'.symm)
    · simp
  · refine Finset.sum_eq_zero fun y _ => ?_
    simp only [Emb]; rw [if_neg, zero_mul]; intro h'; exact h (h' ▸ y.2)

theorem mul_EmbT (B : Matrix (Fin 4) (Fin 4) ℝ) (x : Fin 4) (j : Fin n) :
    (B * (Emb n)ᵀ) x j = if h : (j : ℕ) < 4 then B x ⟨j, h⟩ else 0 := by
  rw [Matrix.mul_apply]
  split_ifs with h
  · rw [Finset.sum_eq_single ⟨j, h⟩]
    · simp [Emb]
    · intro y _ hy; simp only [Matrix.transpose_apply, Emb]; rw [if_neg, mul_zero]; intro h'; exact hy (Fin.ext h'.symm)
    · simp
  · refine Finset.sum_eq_zero fun y _ => ?_
    simp only [Matrix.transpose_apply, Emb]; rw [if_neg, mul_zero]; intro h'; exact h (h' ▸ y.2)

theorem noMixed_AE (hn : 4 ≤ n) (A : Matrix (Fin n) (Fin n) ℝ) (h : NoMixed A) :
    A * Emb n = Emb n * blk A ∧ (Emb n)ᵀ * A = blk A * (Emb n)ᵀ := by
  constructor
  · ext i x
    rw [mul_Emb hn, Emb_mul]
    split_ifs with hi
    · rw [blk_apply hn]; rfl
    · exact (h (emb hn x) i (by simp [In4, emb]) (by simpa [In4] using hi)).2
  · ext x j
    rw [EmbT_mul hn, mul_EmbT]
    split_ifs with hj
    · rw [blk_apply hn]; rfl
    · exact (h (emb hn x) j (by simp [In4, emb]) (by simpa [In4] using hj)).1

theorem pad_out (B : Matrix (Fin 4) (Fin 4) ℝ) (i j : Fin n) (hi : ¬ In4 i) : pad (n := n) B i j = 0 := by
  unfold pad
  rw [Matrix.mul_apply]
  refine Finset.sum_eq_zero fun x _ => ?_
  rw [Emb_mul, dif_neg (by simpa [In4] using hi), zero_mul]

/-- **L167's second display in coordinates**: `ρ(A)` commutes with the padded `W_{ℂP²}` exactly when `A` has no
mixed block and its `ℝ⁴` block is `p J₀ + Σ q_a K_a`, the `ℝ^m` block free, which the record reads as `𝔲(2) ⊕ 𝔰𝔬(m)`. -/
theorem stab_full (hn : 4 ≤ n) (A : Matrix (Fin n) (Fin n) ℝ) (hA : IsSkew A) :
    (∀ X, IsSkew X → A * Wc n X - Wc n X * A = Wc n (A * X - X * A)) ↔
      NoMixed A ∧ ∃ (p : ℝ) (q : Fin 3 → ℝ), blk A = p • J 0 + ∑ a, q a • K a := by
  have hsk : ∀ i j, A j i = -A i j := fun i j => by
    have := congrFun (congrFun hA i) j; simpa [Matrix.transpose_apply] using this
  constructor
  · intro hstab
    -- the mixed block vanishes, at `X = om 0`
    have hrow : ∀ i j, ¬ In4 i → In4 j → A i j = 0 := by
      intro i j hi hj
      have hc := congrFun (congrFun (hstab (om 0) (om_skew 0)) i)
      have hAom : ∀ l, (A * om (n := n) 0) i l = 0 := fun l => by
        have h := hc l
        rw [Wc_om hn 0, Wc_blk, pad_out _ i l hi, Matrix.mul_smul, Matrix.smul_mul, ← smul_sub,
          Matrix.smul_apply, smul_eq_mul, Matrix.sub_apply] at h
        have h0 : (om (n := n) 0 * A) i l = 0 := by
          rw [Matrix.mul_apply]
          exact Finset.sum_eq_zero fun k _ => by rw [om_out 0 i k (fun h => hi h.1), zero_mul]
        have hmu : mu 0 ≠ 0 := by simp only [mu, Matrix.cons_val_zero]; positivity
        rw [h0, sub_zero] at h
        exact (mul_eq_zero.mp h).resolve_left hmu
      set o : Matrix (Fin n) (Fin n) ℝ := om 0 with ho
      have h2 : (A * o * o) i j = 0 := by
        rw [Matrix.mul_apply]
        exact Finset.sum_eq_zero fun l _ => by rw [hAom l, zero_mul]
      rw [Matrix.mul_assoc, ho, om_sq' hn, Matrix.mul_smul, Matrix.smul_apply, smul_eq_mul] at h2
      have hP : (A * (Emb n * (Emb n)ᵀ)) i j = A i j := by
        rw [Matrix.mul_apply, Finset.sum_eq_single j]
        · rw [EmbEmbT_apply, if_pos ⟨rfl, hj⟩, mul_one]
        · intro k _ hk; rw [EmbEmbT_apply, if_neg (fun h => hk h.1), mul_zero]
        · simp
      rw [hP] at h2
      have hc0 : -(sq2⁻¹ * sq2⁻¹) ≠ 0 := by
        have := sq2_pos
        exact neg_ne_zero.mpr (mul_ne_zero (inv_ne_zero this.ne') (inv_ne_zero this.ne'))
      exact (mul_eq_zero.mp h2).resolve_left hc0
    have hnm : NoMixed A := fun i j hi hj =>
      ⟨by rw [hsk j i, hrow j i hj hi, neg_zero], hrow j i hj hi⟩
    obtain ⟨hAE, hEA⟩ := noMixed_AE hn A hnm
    refine ⟨hnm, (stab_so4 (blk A) (blk_skew A hA)).mp fun Y hY => ?_⟩
    have e1 : Wc n (pad Y) = pad (Wc 4 Y) := by rw [Wc_blk (n := n) (pad Y), blk_pad hn]
    have e2 : blk (Wc n (A * pad Y - pad Y * A)) = Wc 4 (blk A * Y - Y * blk A) := by
      rw [Wc_blk (n := n) (A * pad Y - pad Y * A), blk_pad hn, blk_br A (pad Y) hAE hEA, blk_pad hn]
    have h := congrArg blk (hstab (pad Y) (pad_skew Y hY))
    rw [e1, br_pad A _ hAE hEA, blk_pad hn, e2] at h
    exact h
  · rintro ⟨hnm, hform⟩ X hX
    obtain ⟨hAE, hEA⟩ := noMixed_AE hn A hnm
    rw [Wc_blk (n := n) X, br_pad A _ hAE hEA, Wc_blk (n := n) (A * X - X * A), blk_br A X hAE hEA,
      (stab_so4 (blk A) (blk_skew A hA)).mpr hform (blk X) (blk_skew X hX)]

/-! ## The `𝔲(2)` reading: the span closes and its four generators are independent -/

theorem br_K01 : K 0 * K 1 - K 1 * K 0 = (-2 : ℝ) • K 2 := by
  rw [K_lit]; ext i j; fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num
theorem br_K02 : K 0 * K 2 - K 2 * K 0 = (2 : ℝ) • K 1 := by
  rw [K_lit]; ext i j; fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num
theorem br_K12 : K 1 * K 2 - K 2 * K 1 = (-2 : ℝ) • K 0 := by
  rw [K_lit]; ext i j; fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num

/-- `J₀` is central in the span: it commutes with every `K_a`. -/
theorem br_J0K (a : Fin 3) : J 0 * K a - K a * J 0 = 0 := by rw [JK_comm, sub_self]

theorem inner2_KK (a b : Fin 3) : inner2 (K a) (K b) = if a = b then 2 else 0 := by
  rw [K_lit]; fin_cases a <;> fin_cases b <;> simp [inner2_eq_sum, Fin.sum_univ_four] <;> norm_num

/-- **The four generators are independent**: `p J₀ + Σ q_a K_a = 0` forces `p = 0` and every `q_a = 0`. -/
theorem u2_indep (p : ℝ) (q : Fin 3 → ℝ) (h : p • J 0 + ∑ a, q a • K a = 0) : p = 0 ∧ ∀ a, q a = 0 := by
  have hJ := congrArg (fun M => inner2 M (J 0)) h
  have hK : ∀ b, inner2 (p • J 0 + ∑ a, q a • K a) (K b) = 0 := fun b => by rw [h]; simp [inner2_eq_sum]
  simp only [HamiltonsCubic.L41Statement.Frame.inner2_add_l, HamiltonsCubic.L41Statement.Frame.inner2_smul_l,
    HamiltonsCubic.L41Statement.Frame.inner2_sum_l, inner2_JJ, inner2_KJ] at hJ
  have h0 : inner2 (0 : Matrix (Fin 4) (Fin 4) ℝ) (J 0) = 0 := by simp [inner2_eq_sum]
  simp at hJ
  rw [h0] at hJ
  refine ⟨by linarith, fun b => ?_⟩
  have := hK b
  simp only [HamiltonsCubic.L41Statement.Frame.inner2_add_l, HamiltonsCubic.L41Statement.Frame.inner2_smul_l,
    HamiltonsCubic.L41Statement.Frame.inner2_sum_l, inner2_KK] at this
  rw [inner2_comm, inner2_KJ, Finset.sum_eq_single b (fun a _ hab => by rw [if_neg hab, mul_zero]) (by simp)] at this
  simp at this; linarith

/-- **`e_a = -K_a/2` has `𝔰𝔲(2)`'s structure constants**: `[e₀, e₁] = e₂`, `[e₁, e₂] = e₀`, `[e₂, e₀] = e₁`. -/
theorem su2_structure :
    let e : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ := fun a => (-1 / 2 : ℝ) • K a
    e 0 * e 1 - e 1 * e 0 = e 2 ∧ e 1 * e 2 - e 2 * e 1 = e 0 ∧ e 2 * e 0 - e 0 * e 2 = e 1 := by
  intro e
  simp only [e, Matrix.smul_mul, Matrix.mul_smul, smul_smul, ← smul_sub]
  refine ⟨?_, ?_, ?_⟩
  · rw [br_K01, smul_smul]; norm_num
  · rw [br_K12, smul_smul]; norm_num
  · rw [show K 2 * K 0 - K 0 * K 2 = -(K 0 * K 2 - K 2 * K 0) by abel, br_K02, smul_neg, smul_smul]; norm_num

end HamiltonsCubic.CP2Real
