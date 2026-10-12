import HamiltonsCubic.Results.L237SlotCounts
import HamiltonsCubic.Results.L240NormalForm

set_option linter.style.longLine false

/-!
# L82's free bound: every unit skew matrix has `s₁ + s₂ ≥ min{1, 2/√⌊m/2⌋}`

[findings/isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L82: *"Every unit skew matrix satisfies
`s₁+s₂ ≥ min{1, 2/√⌊m/2⌋}`, which is `1` at every `m ≤ 9`"*, with `s₁ ≥ s₂` the two largest pair values and the unit
taken in the record's `½tr(XᵀY)` pairing (`inner2`). [L82.lean](L82.lean) proves the arithmetic of the cut-off at
`m = 10`. **This file proves the bound**, in squares so no root is taken:

* **`free_bound_scalar`**: `0 ≤ b ≤ a` and `a² + (k-1)b² ≥ 1` give `a + b ≥ 1` or `k(a+b)² ≥ 4`, since along
  `a + b = t` the quadratic `(t-b)² + (k-1)b²` is convex in `b` and at most `max(t², kt²/4)` on `0 ≤ b ≤ t/2`;
* **`top_two_bound`**: for weights with `Σ s² = 1` and `|s_i| ≥ |s_j|` the two largest, `|s_i| + |s_j| ≥ 1` or
  `k(|s_i|+|s_j|)² ≥ 4`;
* **`pairs_le_half`**: a normal form on `ι` has `2k ≤ |ι|`, so `k ≤ ⌊m/2⌋`;
* **`free_bound_skew`**: for a unit skew `X = O N.X Oᵀ` in normal form with at least two blocks, `s₁ + s₂ ≥ 1` or
  `⌊m/2⌋(s₁+s₂)² ≥ 4`;
* **`free_bound_every`**: every unit skew matrix has a normal form with either one block, of value `1` (the rank-two
  `φ₀₁`, where `s₁ + s₂ = 1`), or two largest values satisfying that bound, through
  [L240NormalForm.lean](L240NormalForm.lean)'s `skew_normal_form`.

At `⌊m/2⌋ = 4` the bound is [L82Statement.lean](L82Statement.lean)'s `sum_two_ge_one`.
-/

namespace HamiltonsCubic.L82Free

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L240SlotBasis

/-- **The scalar core**: `0 ≤ b ≤ a`, `a² + (k-1)b² ≥ 1` give `a + b ≥ 1` or `k(a+b)² ≥ 4`. -/
theorem free_bound_scalar {a b k : ℝ} (hb : 0 ≤ b) (hab : b ≤ a) (hk : 1 ≤ k)
    (h : 1 ≤ a ^ 2 + (k - 1) * b ^ 2) : 1 ≤ a + b ∨ 4 ≤ k * (a + b) ^ 2 := by
  by_contra hc
  push Not at hc
  obtain ⟨h1, h2⟩ := hc
  set t := a + b with ht
  have ht0 : 0 ≤ t := by linarith
  have hb2 : b ≤ t / 2 := by linarith
  -- chord: `t · f(b) ≤ t²(t - 2b) + (k t²/2) b`
  have hchord : t * (a ^ 2 + (k - 1) * b ^ 2) = t ^ 2 * (t - 2 * b) + k * t ^ 2 / 2 * b - k * t * b * (t / 2 - b) := by
    rw [ht]; ring
  have hkb : 0 ≤ k * t * b * (t / 2 - b) := by
    have : 0 ≤ k := by linarith
    have := mul_nonneg (mul_nonneg (mul_nonneg this ht0) hb) (by linarith : (0 : ℝ) ≤ t / 2 - b)
    linarith
  have hlt1 : t ^ 2 * (t - 2 * b) ≤ t - 2 * b := by
    have : t ^ 2 ≤ 1 := by nlinarith
    nlinarith [mul_le_mul_of_nonneg_right this (by linarith : (0 : ℝ) ≤ t - 2 * b)]
  have hlt2 : k * t ^ 2 / 2 * b ≤ 2 * b := by nlinarith
  have hsum : t * (a ^ 2 + (k - 1) * b ^ 2) ≤ t := by nlinarith
  have htpos : 0 < t := by
    rcases eq_or_lt_of_le ht0 with h0 | h0
    · exfalso
      have ha : a = 0 := by linarith
      have hb0 : b = 0 := by linarith
      rw [ha, hb0] at h; norm_num at h
    · exact h0
  -- strictness: one of the two chord bounds is strict
  have hstrict : t * (a ^ 2 + (k - 1) * b ^ 2) < t := by
    rcases eq_or_lt_of_le hb with hb0 | hbpos
    · have hlt : t ^ 2 * (t - 2 * b) < t - 2 * b := by
        rw [← hb0]; simp only [mul_zero, sub_zero]; nlinarith
      nlinarith
    · have : k * t ^ 2 / 2 * b < 2 * b := by nlinarith
      nlinarith
  have := mul_le_mul_of_nonneg_left h htpos.le
  linarith

/-- **The two largest weights**: `Σ s² = 1`, `|s_j| ≤ |s_i|` and every other `|s_l| ≤ |s_j|`. -/
theorem top_two_bound {k : ℕ} (s : Fin k → ℝ) (hs : ∑ c, s c ^ 2 = 1) {i j : Fin k} (hij : i ≠ j)
    (hji : |s j| ≤ |s i|) (htop : ∀ l, l ≠ i → |s l| ≤ |s j|) :
    1 ≤ |s i| + |s j| ∨ 4 ≤ (k : ℝ) * (|s i| + |s j|) ^ 2 := by
  have hk : (2 : ℝ) ≤ k := by
    have : 2 ≤ Fintype.card (Fin k) := by
      rw [← Finset.card_pair hij]; exact Finset.card_le_univ _
    simpa using (by exact_mod_cast this : ((2 : ℕ) : ℝ) ≤ (Fintype.card (Fin k) : ℝ))
  have hbound : 1 ≤ |s i| ^ 2 + ((k : ℝ) - 1) * |s j| ^ 2 := by
    have hsplit : s i ^ 2 + ∑ c ∈ univ.erase i, s c ^ 2 = 1 := by
      rw [Finset.add_sum_erase _ (fun c => s c ^ 2) (Finset.mem_univ i)]; exact hs
    have hrest : ∑ c ∈ univ.erase i, s c ^ 2 ≤ ∑ c ∈ univ.erase i, |s j| ^ 2 :=
      Finset.sum_le_sum fun c hc => by
        rw [← sq_abs]
        exact pow_le_pow_left₀ (abs_nonneg _) (htop c (Finset.ne_of_mem_erase hc)) 2
    rw [Finset.sum_const, Finset.card_erase_of_mem (Finset.mem_univ i), Finset.card_univ, Fintype.card_fin,
      nsmul_eq_mul] at hrest
    have hcast : ((k - 1 : ℕ) : ℝ) = (k : ℝ) - 1 := by
      rw [Nat.cast_sub (by exact_mod_cast (by linarith : (1 : ℝ) ≤ k))]; simp
    rw [hcast] at hrest
    rw [sq_abs]; linarith
  exact free_bound_scalar (abs_nonneg _) hji (by linarith) hbound

/-- **A normal form on `ι` has at most `|ι|/2` blocks.** -/
theorem pairs_le_half {ι : Type*} [Fintype ι] {k : ℕ} (N : NormalForm ι k) :
    2 * k ≤ Fintype.card ι := by
  classical
  have hdisj : Disjoint (univ.image N.p) (univ.image N.q) := by
    rw [Finset.disjoint_left]
    intro x hx hx'
    obtain ⟨a, _, rfl⟩ := Finset.mem_image.mp hx
    obtain ⟨b, _, hb⟩ := Finset.mem_image.mp hx'
    exact N.hpq a b hb.symm
  have h := Finset.card_le_univ (univ.image N.p ∪ univ.image N.q)
  rw [Finset.card_union_of_disjoint hdisj, Finset.card_image_of_injective _ N.hp,
    Finset.card_image_of_injective _ N.hq, Finset.card_univ, Fintype.card_fin] at h
  omega

/-- **L82's free bound on a unit skew matrix with at least two blocks**: with `X = O N.X Oᵀ`, `O` orthogonal,
`⟨X, X⟩ = 1` and `s_i`, `s_j` (`i ≠ j`) the two largest pair values, `s_i + s_j ≥ 1` or `⌊m/2⌋ (s_i + s_j)² ≥ 4`. The
one-block case is in `free_bound_every`. -/
theorem free_bound_skew {ι : Type*} [Fintype ι] [DecidableEq ι] [LinearOrder ι] {k : ℕ} (N : NormalForm ι k)
    {O X : Matrix ι ι ℝ} (hO' : Oᵀ * O = 1) (hX : X = O * N.X * Oᵀ) (hunit : inner2 X X = 1)
    {i j : Fin k} (hij : i ≠ j) (hji : |N.s j| ≤ |N.s i|) (htop : ∀ l, l ≠ i → |N.s l| ≤ |N.s j|) :
    1 ≤ |N.s i| + |N.s j| ∨ 4 ≤ ((Fintype.card ι / 2 : ℕ) : ℝ) * (|N.s i| + |N.s j|) ^ 2 := by
  have hs : ∑ c, N.s c ^ 2 = 1 := by
    rw [← HamiltonsCubic.L237SlotCounts.inner2_X_X N, ← hunit, hX]
    have := HamiltonsCubic.L240NormalForm.inner2_conj (O := Oᵀ) (by rw [transpose_transpose]; exact hO') N.X N.X
    rw [transpose_transpose] at this
    exact this.symm
  rcases top_two_bound N.s hs hij hji htop with h | h
  · exact Or.inl h
  · right
    have hk : (k : ℝ) ≤ ((Fintype.card ι / 2 : ℕ) : ℝ) := by
      exact_mod_cast (by have := pairs_le_half N; omega : k ≤ Fintype.card ι / 2)
    nlinarith [sq_nonneg (|N.s i| + |N.s j|)]

/-- **Every unit skew matrix**: some normal form `X = O N.X Oᵀ` has either one block, of value `1`, or two largest pair
values `s_i`, `s_j` with `s_i + s_j ≥ 1` or `⌊m/2⌋ (s_i + s_j)² ≥ 4`. -/
theorem free_bound_every {ι : Type*} [Fintype ι] [DecidableEq ι] [LinearOrder ι] (X : Matrix ι ι ℝ) (hXs : IsSkew X)
    (hunit : inner2 X X = 1) :
    ∃ (k : ℕ) (N : NormalForm ι k) (O : Matrix ι ι ℝ), O * Oᵀ = 1 ∧ Oᵀ * O = 1 ∧ X = O * N.X * Oᵀ ∧
      ((∃ i : Fin k, k = 1 ∧ |N.s i| = 1) ∨
       ∃ i j : Fin k, i ≠ j ∧ |N.s j| ≤ |N.s i| ∧ (∀ l, l ≠ i → |N.s l| ≤ |N.s j|) ∧
         (1 ≤ |N.s i| + |N.s j| ∨ 4 ≤ ((Fintype.card ι / 2 : ℕ) : ℝ) * (|N.s i| + |N.s j|) ^ 2)) := by
  obtain ⟨k, N, O, hO, hO', hX⟩ := HamiltonsCubic.L240NormalForm.skew_normal_form X hXs
  refine ⟨k, N, O, hO, hO', hX, ?_⟩
  have hs : ∑ c, N.s c ^ 2 = 1 := by
    rw [← HamiltonsCubic.L237SlotCounts.inner2_X_X N, ← hunit, hX]
    have := HamiltonsCubic.L240NormalForm.inner2_conj (O := Oᵀ) (by rw [transpose_transpose]; exact hO') N.X N.X
    rw [transpose_transpose] at this
    exact this.symm
  rcases Nat.lt_or_ge k 2 with hk | hk
  · -- one block (zero blocks contradicts the unit norm)
    left
    have hk0 : k ≠ 0 := by
      rintro rfl; simp at hs
    have hk1 : k = 1 := by omega
    subst hk1
    refine ⟨0, rfl, ?_⟩
    rw [Fin.sum_univ_one] at hs
    have : |N.s 0| ^ 2 = 1 := by rw [sq_abs]; exact hs
    nlinarith [abs_nonneg (N.s 0)]
  · right
    have hne : (univ : Finset (Fin k)).Nonempty := ⟨⟨0, by omega⟩, mem_univ _⟩
    obtain ⟨i, _, hi⟩ := Finset.exists_max_image univ (fun c => |N.s c|) hne
    have hne' : (univ.erase i).Nonempty := by
      rw [← Finset.card_pos, Finset.card_erase_of_mem (mem_univ i), Finset.card_univ, Fintype.card_fin]; omega
    obtain ⟨j, hjmem, hj⟩ := Finset.exists_max_image (univ.erase i) (fun c => |N.s c|) hne'
    have hij : i ≠ j := (Finset.ne_of_mem_erase hjmem).symm
    have hji : |N.s j| ≤ |N.s i| := hi j (mem_univ _)
    have htop : ∀ l, l ≠ i → |N.s l| ≤ |N.s j| := fun l hl => hj l (Finset.mem_erase.mpr ⟨hl, mem_univ _⟩)
    exact ⟨i, j, hij, hji, htop, free_bound_skew N hO' hX hunit hij hji htop⟩

end HamiltonsCubic.L82Free
