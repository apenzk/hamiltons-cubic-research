import Mathlib
import HamiltonsCubic.Results.L237Attain
import HamiltonsCubic.Results.L240SlotBasis

/-!
# L237's attainment at every even `r`: the doubled `k`-star

[L237](../../../findings/second-order.md): *"Equality at every even `r = 2k` once `n ≥ 2k + 2`: the
doubled `k`-star (centre weight `k`, `k` leaves of weight `1`, all one sign) has every load exactly
`2k + 2`."* This file proves it: `attains_star`, `Attains ι (2k) (2k + 2)` whenever
`k ≥ 1` and `2k + 2 ≤ n`, so with `kappa_cap_norm` the cap `κ_{2k} ≤ 2k + 2` is the supremum.

The star is the normal form `star e k` with `k + 1` blocks `(e 2c, e (2c+1))`, weight `k` on block
`0` and `1` on the rest. Its `2k` slots are the two plus slots of each pair `(0, c)`, `c ≥ 1`
(`slot_plus_general`, `slot_plus2_general` in [L240SlotBasis.lean](L240SlotBasis.lean)), each of
eigenvalue `(k + 1)²`; within a pair they are orthogonal by `pair_gram` and across pairs by
`cross_comb`. Against `⟨X, X⟩ = k² + k` (`X_norm`) the `2k` slots give
`2k (k + 1)² = (2k + 2)(k² + k)`.
-/

open HamiltonsCubic.RealLayer Matrix HamiltonsCubic.L240SlotBasis HamiltonsCubic.L237Attain

namespace HamiltonsCubic.L237Star

set_option linter.unusedSectionVars false

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The doubled `k`-star** at the indices of `e : Fin (2k+2) ↪ ι`: blocks `(e 2c, e (2c+1))`,
`c < k + 1`, weight `k` at the centre `c = 0` and `1` at each leaf. -/
def star (k : ℕ) (e : Fin (2 * k + 2) ↪ ι) : NormalForm ι (k + 1) where
  p c := e ⟨2 * c.val, by omega⟩
  q c := e ⟨2 * c.val + 1, by omega⟩
  s c := if c = 0 then (k : ℝ) else 1
  hp a b h := by
    have := e.injective h; simp only [Fin.mk.injEq] at this; exact Fin.ext (by omega)
  hq a b h := by
    have := e.injective h; simp only [Fin.mk.injEq] at this; exact Fin.ext (by omega)
  hpq a b h := by
    have := e.injective h; simp only [Fin.mk.injEq] at this; omega

theorem X_skew {m : ℕ} (N : NormalForm ι m) : IsSkew N.X := by
  have h : ∀ i j : ι, (phi i j)ᵀ = -phi i j := fun i j => phi_isSkew i j
  unfold IsSkew NormalForm.X
  rw [Matrix.transpose_sum]
  simp only [Matrix.transpose_smul, h, smul_neg, Finset.sum_neg_distrib]

/-- The plus slots of the pair `(0, c)`, at scale `√2`: `φ_{p₀ p_c} - φ_{q₀ q_c}` at `true` and
`φ_{p₀ q_c} + φ_{q₀ p_c}` at `false`, each written as `φ + ε • φ` for `cross_comb`. -/
noncomputable def slot {m : ℕ} (N : NormalForm ι (m + 1)) (c : Fin (m + 1)) (t : Bool) : Matrix ι ι ℝ :=
  phi (N.p 0) (if t then N.p c else N.q c) +
    (if t then (-1 : ℝ) else 1) • phi (N.q 0) (if t then N.q c else N.p c)

variable {m : ℕ} (N : NormalForm ι (m + 1))

theorem slot_true (c : Fin (m + 1)) :
    slot N c true = phi (N.p 0) (N.p c) - phi (N.q 0) (N.q c) := by
  simp only [slot, ↓reduceIte, neg_one_smul, sub_eq_add_neg]

theorem slot_false (c : Fin (m + 1)) :
    slot N c false = phi (N.p 0) (N.q c) + phi (N.q 0) (N.p c) := by
  simp only [slot, Bool.false_eq_true, ↓reduceIte, one_smul]

theorem slot_skew (c : Fin (m + 1)) (t : Bool) : IsSkew (slot N c t) := by
  unfold slot
  exact skew_add (phi_isSkew _ _) (skew_smul _ (phi_isSkew _ _))

/-- **Each slot of a pair `(0, c)`, `c ≠ 0`, has eigenvalue `(s₀ + s_c)²`.** -/
theorem slot_eigen {c : Fin (m + 1)} (hc : c ≠ 0) (t : Bool) :
    -br N.X (br N.X (slot N c t)) = (N.s 0 + N.s c) ^ 2 • slot N c t := by
  cases t
  · rw [slot_false]; exact slot_plus2_general N (Ne.symm hc)
  · rw [slot_true]; exact slot_plus_general N (Ne.symm hc)

theorem slot_norm {c : Fin (m + 1)} (hc : c ≠ 0) (t : Bool) :
    inner2 (br N.X (slot N c t)) (br N.X (slot N c t)) = 2 * (N.s 0 + N.s c) ^ 2 := by
  have h := KyFanPackaging.inner2_negAdSq N.X (slot N c t) (X_skew N)
  change inner2 (slot N c t) (-br N.X (br N.X (slot N c t))) = _ at h
  rw [← h, slot_eigen N hc, i2_smul_r]
  have g := pair_gram N (Ne.symm hc)
  cases t
  · rw [slot_false]; simp only [S2] at g; rw [g.2.1]; ring
  · rw [slot_true]; simp only [S1] at g; rw [g.1]; ring

/-- **The slots are orthogonal with squared norm `2`.** -/
theorem slot_gram {c d : Fin (m + 1)} (hc : c ≠ 0) (hd : d ≠ 0) (t u : Bool) :
    inner2 (slot N c t) (slot N d u) = if (c, t) = (d, u) then 2 else 0 := by
  by_cases hcd : c = d
  · subst hcd
    have g := pair_gram N (Ne.symm hc)
    simp only [S1, S2] at g
    cases t <;> cases u <;> simp only [slot_true, slot_false, Prod.mk.injEq, and_false,
      Bool.false_eq_true, Bool.true_eq_false, ↓reduceIte]
    · exact g.2.1
    · rw [inner2_comm]; exact g.2.2.2.2.1
    · exact g.2.2.2.2.1
    · exact g.1
  · have h0c : (0 : Fin (m + 1)) < c := lt_of_le_of_ne (Fin.zero_le c) (Ne.symm hc)
    have h0d : (0 : Fin (m + 1)) < d := lt_of_le_of_ne (Fin.zero_le d) (Ne.symm hd)
    have hne : ((0 : Fin (m + 1)), c) ≠ (0, d) := fun h => hcd (Prod.ext_iff.mp h).2
    have hp0 : N.InBlk 0 (N.p 0) := Or.inl rfl
    have hq0 : N.InBlk 0 (N.q 0) := Or.inr rfl
    have hpc : ∀ x : Fin (m + 1), N.InBlk x (N.p x) := fun x => Or.inl rfl
    have hqc : ∀ x : Fin (m + 1), N.InBlk x (N.q x) := fun x => Or.inr rfl
    have hr : ¬((c, t) = (d, u)) := fun h => hcd (Prod.ext_iff.mp h).1
    rw [if_neg hr]
    unfold slot
    cases t <;> cases u <;> simp only [Bool.false_eq_true, ↓reduceIte] <;>
      apply cross_comb N h0c h0d hne <;>
      first | exact hp0 | exact hq0 | exact hpc _ | exact hqc _

/-- **`⟨N.X, N.X⟩ = ∑_c s_c²`**, `L237SlotCounts.inner2_X_X` without its `LinearOrder ι`. -/
theorem X_norm {m : ℕ} (N : NormalForm ι m) : inner2 N.X N.X = ∑ c, N.s c ^ 2 := by
  have h : ∀ a b, inner2 (phi (N.p a) (N.q a)) (phi (N.p b) (N.q b)) = if a = b then 1 else 0 := by
    intro a b
    rw [HamiltonsCubic.Results.inner2_phi_phi]
    have h2 : ¬(N.p a = N.q b ∧ N.q a = N.p b) := fun h => N.hpq a b h.1
    by_cases hab : a = b
    · subst hab; simp [h2]
    · have h1 : ¬(N.p a = N.p b ∧ N.q a = N.q b) := fun h => hab (N.hp h.1)
      simp [h1, h2, hab]
  have e : ∀ A B : Matrix ι ι ℝ, inner2 A B = KyFanPackaging.inner2Form A B := fun A B =>
    (KyFanPackaging.inner2Form_apply A B).symm
  rw [e, NormalForm.X]
  simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul, ← e, h]
  simp [sq]

/-- The star's slots indexed by `Fin k × Bool`, the leaf `c + 1` and the slot type. -/
noncomputable def starSlot (k : ℕ) (e : Fin (2 * k + 2) ↪ ι) (j : Fin k × Bool) : Matrix ι ι ℝ :=
  slot (star k e) j.1.succ j.2

theorem star_s0 (k : ℕ) (e : Fin (2 * k + 2) ↪ ι) : (star k e).s 0 = k := by simp [star]
theorem star_ssucc (k : ℕ) (e : Fin (2 * k + 2) ↪ ι) (c : Fin k) : (star k e).s c.succ = 1 := by
  simp [star, Fin.succ_ne_zero]

theorem star_norm (k : ℕ) (e : Fin (2 * k + 2) ↪ ι) :
    inner2 (star k e).X (star k e).X = (k : ℝ) ^ 2 + k := by
  rw [X_norm, Fin.sum_univ_succ, star_s0]
  simp only [star_ssucc, one_pow, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
    nsmul_eq_mul, mul_one]

/-- **`κ_{2k} = 2k + 2` at `n ≥ 2k + 2`**: the doubled `k`-star attains the cap. -/
theorem attains_star {k : ℕ} (hk : 0 < k) (h : 2 * k + 2 ≤ Fintype.card ι) :
    Attains ι (2 * k) (2 * k + 2) := by
  obtain ⟨e⟩ := emb_of_le (ι := ι) h
  have hk2 : Fintype.card (Fin k × Bool) = 2 * k := by simp [mul_comm]
  let σ : Fin (2 * k) ≃ Fin k × Bool := (Fintype.equivFinOfCardEq hk2).symm
  have hsucc : ∀ c : Fin k, (c.succ : Fin (k + 1)) ≠ 0 := fun c => Fin.succ_ne_zero c
  refine attains_of_scaled (star k e).X (X_skew _) ?_ (fun j => starSlot k e (σ j))
    (fun j => slot_skew _ _ _) ?_ ?_
  · rw [star_norm]
    have : (0 : ℝ) < k := by exact_mod_cast hk
    positivity
  · intro i j
    simp only [starSlot]
    rw [slot_gram _ (hsucc _) (hsucc _)]
    congr 1
    apply propext
    constructor
    · intro hij
      have : σ i = σ j := Prod.ext (Fin.succ_injective _ (Prod.ext_iff.mp hij).1)
        (Prod.ext_iff.mp hij).2
      exact σ.injective this
    · rintro rfl; rfl
  · rw [Equiv.sum_comp σ (fun j => inner2 (br (star k e).X (starSlot k e j))
      (br (star k e).X (starSlot k e j)))]
    simp only [starSlot, slot_norm _ (hsucc _), star_s0, star_ssucc, star_norm]
    rw [Finset.sum_const, Finset.card_univ, hk2, nsmul_eq_mul]
    push_cast
    ring

end HamiltonsCubic.L237Star
