import Mathlib

/-!
# `𝔰𝔬(n)` is simple for `n ≥ 5`

**`so_simple`**: a subspace of skew matrices closed under bracketing with every skew matrix, and
containing a nonzero element, contains every skew matrix. **`center_zero`**: at `n ≥ 3` a skew matrix
commuting with every `φ_ab` is zero.

**The proof isolates a basis rotation by masks.** For `r ≠ s`, `A ↦ A + [φ_rs,[φ_rs,A]]` keeps exactly the
entries of a skew `A` with both indices off `{r,s}` or on `{r,s}` itself (`mask_entry`), and its
complement keeps the entries with exactly one index in `{r,s}`. With `A_qp ≠ 0` and three further
indices `t, u, v`, the complements at `{p,t}` and `{q,t}` and the masks at `{t,u}` and `{u,v}` leave only
the `{p,q}` entries, so `φ_pq` lies in the ideal (`ph_mem_of_nonzero`); **`n ≥ 5` is exactly the number of
indices this uses.** Then `[φ_ab, φ_bc] = -φ_ac` spreads it to every `φ_ab`, and those span.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.SoSimple

open Matrix

variable {n : ℕ}

/-- `φ_rs`: `+1` at `(s,r)`, `-1` at `(r,s)`. -/
def ph (r s : Fin n) : Matrix (Fin n) (Fin n) ℝ := Matrix.single s r 1 - Matrix.single r s 1

def bk (X Y : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := X * Y - Y * X

theorem bk_entry (r s : Fin n) (A : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) :
    bk (ph r s) A i j = (if i = s then A r j else 0) - (if i = r then A s j else 0)
      - (if j = r then A i s else 0) + (if j = s then A i r else 0) := by
  simp only [bk, ph, Matrix.sub_apply, Matrix.mul_apply, Matrix.sub_mul, Matrix.mul_sub, Matrix.single_apply]
  simp only [ite_mul, one_mul, zero_mul, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq', ite_and, eq_comm]
  ring

/-- **The mask**: `A + [φ_rs,[φ_rs,A]]` keeps exactly the entries of `A` with both indices off `{r,s}`
or with `{i,j} = {r,s}`, for skew `A` and `r ≠ s`. -/
theorem mask_entry {A : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = -A) {r s : Fin n} (hrs : r ≠ s) (i j : Fin n) :
    (A + bk (ph r s) (bk (ph r s) A)) i j =
      if (i ≠ r ∧ i ≠ s ∧ j ≠ r ∧ j ≠ s) ∨ (i = r ∧ j = s) ∨ (i = s ∧ j = r) then A i j else 0 := by
  have hsk : ∀ a b, A b a = -A a b := fun a b => by
    have := congrFun (congrFun hA a) b; simpa [Matrix.transpose_apply] using this
  have hd : ∀ a, A a a = 0 := fun a => by have := hsk a a; linarith
  simp only [Matrix.add_apply, bk_entry]
  have hsr : s ≠ r := Ne.symm hrs
  by_cases h1 : r = i
  · subst h1
    by_cases h3 : r = j
    · subst h3; simp [hrs, hsr, hd]
    · by_cases h4 : s = j
      · subst h4; simp [hrs, hsr, hd] <;> linarith [hsk r s]
      · have h3' : j ≠ r := Ne.symm h3; have h4' : j ≠ s := Ne.symm h4
        simp [hrs, hsr, hd, h3', h4'] <;> linarith [hsk r j, hsk j r]
  · have h1' : i ≠ r := Ne.symm h1
    by_cases h2 : s = i
    · subst h2
      by_cases h3 : r = j
      · subst h3; simp [hrs, hsr, hd] <;> linarith [hsk r s]
      · by_cases h4 : s = j
        · subst h4; simp [hrs, hsr, hd]
        · have h3' : j ≠ r := Ne.symm h3; have h4' : j ≠ s := Ne.symm h4
          simp [hrs, hsr, hd, h3', h4'] <;> linarith [hsk s j, hsk j s]
    · have h2' : i ≠ s := Ne.symm h2
      by_cases h3 : r = j
      · subst h3; simp [hrs, hsr, hd, h1', h2'] <;> linarith [hsk i r, hsk r i]
      · have h3' : j ≠ r := Ne.symm h3
        by_cases h4 : s = j
        · subst h4; simp [hrs, hsr, hd, h1', h2', h3'] <;> linarith [hsk i s, hsk s i]
        · have h4' : j ≠ s := Ne.symm h4
          simp [hrs, hsr, hd, h1', h2', h3', h4']


theorem ph_skew (r s : Fin n) : (ph r s)ᵀ = -(ph r s) := by
  unfold ph; rw [Matrix.transpose_sub, Matrix.transpose_single, Matrix.transpose_single]; abel

theorem bk_skew {X Y : Matrix (Fin n) (Fin n) ℝ} (hX : Xᵀ = -X) (hY : Yᵀ = -Y) : (bk X Y)ᵀ = -(bk X Y) := by
  unfold bk; rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hX, hY]; noncomm_ring

theorem ph_entry (r s i j : Fin n) : ph r s i j = (if s = i ∧ r = j then 1 else 0) - (if r = i ∧ s = j then 1 else 0) := by
  simp [ph, Matrix.single_apply]

/-- **`[φ_ab, φ_bc] = -φ_ac`** for distinct `a, b, c`. -/
theorem bk_ph_ph {a b c : Fin n} (hab : a ≠ b) (hbc : b ≠ c) (hac : a ≠ c) :
    bk (ph a b) (ph b c) = -ph a c := by
  unfold bk ph
  have z1 : single b a (1:ℝ) * single c b 1 = 0 := by simp [Matrix.single_mul_single_of_ne, hac, Ne.symm hac]
  have z2 : single b a (1:ℝ) * single b c 1 = 0 := by simp [Matrix.single_mul_single_of_ne, hab, Ne.symm hab]
  have z3 : single a b (1:ℝ) * single c b 1 = 0 := by simp [Matrix.single_mul_single_of_ne, hbc, Ne.symm hbc]
  have z4 : single c b (1:ℝ) * single a b 1 = 0 := by simp [Matrix.single_mul_single_of_ne, hab, Ne.symm hab]
  have z5 : single b c (1:ℝ) * single b a 1 = 0 := by simp [Matrix.single_mul_single_of_ne, hbc, Ne.symm hbc]
  have z6 : single b c (1:ℝ) * single a b 1 = 0 := by simp [Matrix.single_mul_single_of_ne, hac, Ne.symm hac]
  simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.single_mul_single_same, z1, z2, z3, z4, z5, z6, mul_one]
  abel

/-- **The center of `𝔰𝔬(n)` is zero** at `n ≥ 3`. -/
theorem center_zero (hn : 3 ≤ n) {z : Matrix (Fin n) (Fin n) ℝ} (hz : zᵀ = -z)
    (hc : ∀ a b : Fin n, bk (ph a b) z = 0) : z = 0 := by
  have hsk : ∀ a b, z b a = -z a b := fun a b => by
    have := congrFun (congrFun hz a) b; simpa [Matrix.transpose_apply] using this
  ext a j
  by_cases haj : a = j
  · subst haj; have := hsk a a; simp; linarith
  obtain ⟨b, hba, hbj⟩ : ∃ b : Fin n, b ≠ a ∧ b ≠ j := by
    by_contra h
    push Not at h
    have e : ∀ b : Fin n, b = a ∨ b = j := fun b => by
      by_contra hh; push Not at hh; exact absurd (h b hh.1) hh.2
    rcases e ⟨0, by omega⟩ with h0 | h0 <;> rcases e ⟨1, by omega⟩ with h1 | h1 <;>
      rcases e ⟨2, by omega⟩ with h2 | h2 <;> simp only [Fin.ext_iff] at h0 h1 h2 haj <;> omega
  have := congrFun (congrFun (hc a b) b) j
  rw [bk_entry] at this
  simp [hba, Ne.symm hba, hbj, Ne.symm hbj, Ne.symm haj] at this
  simpa using this

section Ideal

variable (I : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) (hIs : ∀ A ∈ I, Aᵀ = -A)
  (hI : ∀ A ∈ I, ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → bk X A ∈ I)
include hIs hI

theorem mask_mem {A : Matrix (Fin n) (Fin n) ℝ} (hA : A ∈ I) (r s : Fin n) :
    A + bk (ph r s) (bk (ph r s) A) ∈ I :=
  I.add_mem hA (hI _ (hI _ hA _ (ph_skew r s)) _ (ph_skew r s))

theorem pmask_mem {A : Matrix (Fin n) (Fin n) ℝ} (hA : A ∈ I) (r s : Fin n) :
    -bk (ph r s) (bk (ph r s) A) ∈ I :=
  I.neg_mem (hI _ (hI _ hA _ (ph_skew r s)) _ (ph_skew r s))

end Ideal


theorem pmask_entry {A : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = -A) {r s : Fin n} (hrs : r ≠ s) (i j : Fin n) :
    (-bk (ph r s) (bk (ph r s) A)) i j =
      if (i ≠ r ∧ i ≠ s ∧ j ≠ r ∧ j ≠ s) ∨ (i = r ∧ j = s) ∨ (i = s ∧ j = r) then 0 else A i j := by
  have h := mask_entry hA hrs i j
  rw [Matrix.add_apply] at h
  rw [Matrix.neg_apply]
  split_ifs at h ⊢ <;> linarith

theorem mask_skew {A : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = -A) (r s : Fin n) :
    (A + bk (ph r s) (bk (ph r s) A))ᵀ = -(A + bk (ph r s) (bk (ph r s) A)) := by
  rw [Matrix.transpose_add, hA, bk_skew (ph_skew r s) (bk_skew (ph_skew r s) hA)]; abel

theorem pmask_skew {A : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = -A) (r s : Fin n) :
    (-bk (ph r s) (bk (ph r s) A))ᵀ = -(-bk (ph r s) (bk (ph r s) A)) := by
  rw [Matrix.transpose_neg, bk_skew (ph_skew r s) (bk_skew (ph_skew r s) hA)]

theorem ite_nest (c1 c2 c3 c4 : Prop) [Decidable c1] [Decidable c2] [Decidable c3] [Decidable c4] (x : ℝ) :
    (if c1 then (if c2 then (if c3 then 0 else (if c4 then 0 else x)) else 0) else 0)
      = if c1 ∧ c2 ∧ ¬c3 ∧ ¬c4 then x else 0 := by
  by_cases h1 : c1 <;> by_cases h2 : c2 <;> by_cases h3 : c3 <;> by_cases h4 : c4 <;> simp [h1, h2, h3, h4]

theorem three_others (hn : 5 ≤ n) (p q : Fin n) :
    ∃ t u v : Fin n, t ≠ p ∧ t ≠ q ∧ u ≠ p ∧ u ≠ q ∧ v ≠ p ∧ v ≠ q ∧ t ≠ u ∧ t ≠ v ∧ u ≠ v := by
  have hc : 2 < ((Finset.univ : Finset (Fin n)) \ {p, q}).card := by
    rw [← Finset.compl_eq_univ_sdiff, Finset.card_compl, Fintype.card_fin]
    have := Finset.card_le_two (a := p) (b := q)
    omega
  obtain ⟨t, u, v, ht, hu, hv, htu, htv, huv⟩ := Finset.two_lt_card_iff.mp hc
  simp only [Finset.mem_sdiff, Finset.mem_univ, Finset.mem_insert, Finset.mem_singleton, true_and, not_or] at ht hu hv
  exact ⟨t, u, v, ht.1, ht.2, hu.1, hu.2, hv.1, hv.2, htu, htv, huv⟩

section Ideal2

variable (I : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) (hIs : ∀ A ∈ I, Aᵀ = -A)
  (hI : ∀ A ∈ I, ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → bk X A ∈ I)
include hIs hI

set_option maxHeartbeats 4000000 in
theorem ph_mem_of_nonzero (hn : 5 ≤ n) {A : Matrix (Fin n) (Fin n) ℝ} (hA : A ∈ I) {p q : Fin n} (hpq : p ≠ q)
    (hqp : A q p ≠ 0) : ph p q ∈ I := by
  have hAs := hIs A hA
  obtain ⟨t, u, v, htp, htq, hup, huq, hvp, hvq, htu, htv, huv⟩ := three_others hn p q
  set B1 := -bk (ph p t) (bk (ph p t) A) with hB1
  set B2 := -bk (ph q t) (bk (ph q t) B1) with hB2
  set B3 := B2 + bk (ph t u) (bk (ph t u) B2) with hB3
  set B4 := B3 + bk (ph u v) (bk (ph u v) B3) with hB4
  have h1 : B1 ∈ I := pmask_mem I hIs hI hA p t
  have h2 : B2 ∈ I := pmask_mem I hIs hI h1 q t
  have h3 : B3 ∈ I := mask_mem I hIs hI h2 t u
  have h4 : B4 ∈ I := mask_mem I hIs hI h3 u v
  have s1 : B1ᵀ = -B1 := pmask_skew hAs p t
  have s2 : B2ᵀ = -B2 := pmask_skew s1 q t
  have s3 : B3ᵀ = -B3 := mask_skew s2 t u
  have key : ∀ i j, B4 i j = if (i = p ∧ j = q) ∨ (i = q ∧ j = p) then A i j else 0 := by
    intro i j
    rw [hB4, mask_entry s3 huv, hB3, mask_entry s2 htu, hB2, pmask_entry s1 (Ne.symm htq), hB1,
      pmask_entry hAs (Ne.symm htp)]
    rw [ite_nest]
    simp only [ne_eq, Fin.ext_iff] at htp htq hup huq hvp hvq htu htv huv hpq ⊢
    split_ifs with hL hR hR <;> first | (exfalso; omega) | simp
  have hsk : ∀ a b, A b a = -A a b := fun a b => by
    have := congrFun (congrFun hAs a) b; simpa [Matrix.transpose_apply] using this
  have hB : B4 = A q p • ph p q := by
    ext i j
    rw [key, Matrix.smul_apply, ph_entry, smul_eq_mul]
    have hqp' : q ≠ p := Ne.symm hpq
    by_cases h1 : p = i
    · subst h1
      by_cases h2 : q = j
      · subst h2; simp [hpq, hqp']; linarith [hsk p q]
      · have h2' : j ≠ q := Ne.symm h2
        by_cases h3 : p = j
        · subst h3; simp [hpq, hqp']
        · have h3' : j ≠ p := Ne.symm h3
          simp [hpq, hqp', h2', h3', h2, h3]
    · have h1' : i ≠ p := Ne.symm h1
      by_cases h4 : q = i
      · subst h4
        by_cases h5 : p = j
        · subst h5; simp [hpq, hqp']
        · have h5' : j ≠ p := Ne.symm h5
          by_cases h6 : q = j
          · subst h6; simp [hpq, hqp']
          · have h6' : j ≠ q := Ne.symm h6
            simp [hpq, hqp', h5', h6', h5, h6]
      · have h4' : i ≠ q := Ne.symm h4
        simp [h1', h4', h1, h4]
  have : ph p q = (A q p)⁻¹ • B4 := by rw [hB, smul_smul, inv_mul_cancel₀ hqp, one_smul]
  rw [this]; exact I.smul_mem _ h4

end Ideal2


theorem bk_anti (X Y : Matrix (Fin n) (Fin n) ℝ) : bk X Y = -bk Y X := by unfold bk; abel

theorem ph_swap (a b : Fin n) : ph b a = -ph a b := by unfold ph; abel

theorem ph_self (a : Fin n) : ph a a = 0 := by unfold ph; simp

theorem skew_expand {X : Matrix (Fin n) (Fin n) ℝ} (hX : Xᵀ = -X) :
    X = ∑ a, ∑ b, (X b a / 2) • ph a b := by
  have hsk : ∀ a b, X b a = -X a b := fun a b => by
    have := congrFun (congrFun hX a) b; simpa [Matrix.transpose_apply] using this
  ext i j
  simp only [Matrix.sum_apply, Matrix.smul_apply, ph_entry, smul_eq_mul, mul_sub, mul_ite, mul_one, mul_zero,
    Finset.sum_sub_distrib]
  simp only [ite_and, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  rw [Finset.sum_eq_single i (fun b _ hb => by simp [hb]) (by simp)]
  simp
  linarith [hsk i j]

section Ideal3

variable (I : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) (hIs : ∀ A ∈ I, Aᵀ = -A)
  (hI : ∀ A ∈ I, ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → bk X A ∈ I)
include hIs hI

theorem ph_step {a b c : Fin n} (hab : a ≠ b) (hbc : b ≠ c) (hac : a ≠ c) (h : ph a b ∈ I) : ph a c ∈ I := by
  have := hI _ h _ (ph_skew b c)
  rw [bk_anti, bk_ph_ph hab hbc hac, neg_neg] at this
  exact this

/-- **`𝔰𝔬(n)` is simple for `n ≥ 5`**: an ideal containing a nonzero element is everything. -/
theorem so_simple (hn : 5 ≤ n) (hne : ∃ A ∈ I, A ≠ 0) : ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → X ∈ I := by
  obtain ⟨A, hA, hA0⟩ := hne
  have hAs := hIs A hA
  have hsk : ∀ a b, A b a = -A a b := fun a b => by
    have := congrFun (congrFun hAs a) b; simpa [Matrix.transpose_apply] using this
  obtain ⟨q, p, hqp⟩ : ∃ q p, A q p ≠ 0 := by
    by_contra h; push Not at h; exact hA0 (Matrix.ext h)
  have hpq : p ≠ q := fun h => by subst h; have := hsk p p; exact hqp (by linarith)
  have h0 : ph p q ∈ I := ph_mem_of_nonzero I hIs hI hn hA hpq hqp
  have hneg : ∀ a b, ph a b ∈ I → ph b a ∈ I := fun a b h => by rw [ph_swap]; exact I.neg_mem h
  have hp : ∀ x, x ≠ p → ph p x ∈ I := by
    intro x hx
    by_cases hxq : x = q
    · subst hxq; exact h0
    · exact ph_step I hIs hI hpq (Ne.symm hxq) (Ne.symm hx) h0
  have hall : ∀ a b, ph a b ∈ I := by
    intro a b
    by_cases hab : a = b
    · subst hab; rw [ph_self]; exact I.zero_mem
    by_cases hap : a = p
    · subst hap; exact hp b (Ne.symm hab)
    have hap' : ph a p ∈ I := hneg _ _ (hp a hap)
    by_cases hbp : b = p
    · subst hbp; exact hap'
    · exact ph_step I hIs hI hap (Ne.symm hbp) hab hap'
  intro X hX
  rw [skew_expand hX]
  exact I.sum_mem fun a _ => I.sum_mem fun b _ => I.smul_mem _ (hall a b)

end Ideal3

end HamiltonsCubic.SoSimple
