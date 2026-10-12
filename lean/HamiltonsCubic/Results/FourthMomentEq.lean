import HamiltonsCubic.Results.FourthMoment

set_option linter.style.longLine false

/-!
# The equality case of the odd fourth-moment lemma

At odd `n ≥ 5`, a vector on `{∑ v = 0, ∑ v² = 1}` with `∑ v⁴ = (n²+3)/(n(n²−1))` is a minimiser, so
`min_cubic` applies; the three-value branch gives `∑ v⁴ ≥ 1/(n−1)`, strictly above the bound, and the
two-value branch gives `4pq = n² − 1`: **`v` takes exactly two values at multiplicities differing by
one** (`fourth_moment_odd_eq`), the unbalanced split.
-/

namespace HamiltonsCubic.FourthMoment

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem fourth_moment_odd_eq (hn : 5 ≤ Fintype.card ι) (hodd : ¬ Even (Fintype.card ι))
    (v : ι → ℝ) (hv : v ∈ Kset ι) (heq : ∑ i, v i ^ 4 = gOdd (Fintype.card ι : ℝ)) :
    ∃ x y : ℝ, x ≠ y ∧ (∀ i, v i = x ∨ v i = y) ∧
      (((Finset.univ.filter fun i => v i = x).card : ℤ) - (Finset.univ.filter fun i => v i = y).card) ^ 2 = 1 := by
  have hmin : ∀ u ∈ Kset ι, ∑ i, v i ^ 4 ≤ ∑ i, u i ^ 4 := fun u hu => by
    rw [heq]; exact fourth_moment_odd (by omega) hodd u hu.1 hu.2
  have hcub := min_cubic hv hmin
  obtain ⟨h1, h2⟩ := hv
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  set b := ∑ j, v j ^ 4 with hb
  set a := (∑ j, v j ^ 3) / n with ha
  have hn3 : (5 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨i0⟩ := hne
  set x := v i0 with hxdef
  -- a second value exists
  obtain ⟨j, hj⟩ : ∃ j, v j ≠ x := by
    by_contra h
    push Not at h
    have : ∑ i, v i = n * x := by
      simp only [h, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]; try rfl
    have hx0 : x = 0 := by rw [h1] at this; nlinarith
    have : ∑ i, v i ^ 2 = 0 := by simp only [h, hx0]; simp
    linarith
  set y := v j with hydef
  have hxy : x ≠ y := fun e => hj e.symm
  have hbxy := pair_root (hcub i0) (hcub j) hxy
  have hnpos : 0 < n := by linarith
  have hgle : gOdd n ≤ 1 / (n - 1) := by
    unfold gOdd
    rw [div_le_div_iff₀ (by nlinarith) (by linarith)]
    nlinarith
  by_cases hthree : ∃ k, v k ≠ x ∧ v k ≠ y
  · obtain ⟨k, hkx, hky⟩ := hthree
    set z := v k with hzdef
    have hxz : x ≠ z := fun e => hkx e.symm
    have hyz : y ≠ z := fun e => hky e.symm
    have hsum0 := triple_sum (hcub i0) (hcub j) (hcub k) hxy hxz hyz
    have hvals : ∀ i, v i = x ∨ v i = y ∨ v i = z := by
      intro i
      by_contra hc
      push Not at hc
      obtain ⟨h1', h2', h3'⟩ := hc
      have := triple_sum (hcub i0) (hcub j) (hcub i) hxy (Ne.symm h1') (Ne.symm h2')
      exact h3' (by linarith)
    set c1 := ∑ i, (if v i = x then (1 : ℝ) else 0)
    set c2 := ∑ i, (if v i = y then (1 : ℝ) else 0)
    set c3 := ∑ i, (if v i = z then (1 : ℝ) else 0)
    have hsplit : ∀ f : ℝ → ℝ, ∑ i, f (v i) = c1 * f x + c2 * f y + c3 * f z := by
      intro f
      have e : ∀ i, f (v i) = (if v i = x then (1 : ℝ) else 0) * f x + (if v i = y then (1 : ℝ) else 0) * f y
          + (if v i = z then (1 : ℝ) else 0) * f z := by
        intro i
        rcases hvals i with h | h | h
        · rw [if_pos h, if_neg (h ▸ hxy), if_neg (h ▸ hxz), h]; ring
        · rw [if_neg (fun e => hxy (h ▸ e).symm), if_pos h, if_neg (h ▸ hyz), h]; ring
        · rw [if_neg (fun e => hxz (h ▸ e).symm), if_neg (fun e => hyz (h ▸ e).symm), if_pos h, h]; ring
      simp only [e, Finset.sum_add_distrib, ← Finset.sum_mul]
      try rfl
    have hc1 : 1 ≤ c1 := count_pos v i0
    have hc2 : 1 ≤ c2 := count_pos v j
    have hc3 : 1 ≤ c3 := count_pos v k
    have hn : c1 + c2 + c3 = n := by
      have := hsplit (fun _ => 1)
      simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at this
      linarith
    have hs1 : c1 * x + c2 * y + c3 * z = 0 := by rw [← h1, hsplit (fun t => t)]
    have hs2 : c1 * x ^ 2 + c2 * y ^ 2 + c3 * z ^ 2 = 1 := by rw [← h2, hsplit (fun t => t ^ 2)]
    have h3v := three_value_bound c1 c2 c3 x y z hc1 hc2 hc3 hsum0 hs1 hs2
    rw [hn] at h3v
    have hbz : b = (x ^ 2 + y ^ 2 + z ^ 2) / 2 := by
      have hz : z = -(x + y) := by linarith
      rw [← hbxy, hz]; ring
    rw [← hbz] at h3v
    exfalso
    have hstrict : gOdd n < 1 / (n - 1) := by
      unfold gOdd
      rw [div_lt_div_iff₀ (by nlinarith) (by linarith)]
      nlinarith
    have hbv : b = gOdd n := heq
    rw [hbv] at h3v
    linarith
  · push Not at hthree
    have hvals : ∀ i, v i = x ∨ v i = y := by
      intro i; by_cases h : v i = x
      · exact Or.inl h
      · exact Or.inr (hthree i h)
    set p := (Finset.univ.filter fun i => v i = x).card with hp
    set q := (Finset.univ.filter fun i => v i = y).card with hq
    have hsplit : ∀ f : ℝ → ℝ, ∑ i, f (v i) = (p : ℝ) * f x + (q : ℝ) * f y := by
      intro f
      have e : ∀ i, f (v i) = (if v i = x then (1 : ℝ) else 0) * f x + (if v i = y then (1 : ℝ) else 0) * f y := by
        intro i
        rcases hvals i with h | h
        · rw [if_pos h, if_neg (h ▸ hxy), h]; ring
        · rw [if_neg (fun e => hxy (h ▸ e).symm), if_pos h, h]; ring
      simp only [e, Finset.sum_add_distrib, ← Finset.sum_mul, count_eq]
      try rfl
    have hpq : (p : ℝ) + q = n := by
      have := hsplit (fun _ => 1)
      simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at this
      linarith
    have hpqN : p + q = Fintype.card ι := by
      have : ((p + q : ℕ) : ℝ) = (Fintype.card ι : ℝ) := by push_cast; rw [hpq]
      exact_mod_cast this
    have hp1 : (1 : ℝ) ≤ p := by rw [← count_eq]; exact count_pos v i0
    have hq1 : (1 : ℝ) ≤ q := by rw [← count_eq]; exact count_pos v j
    have hs1 : (p : ℝ) * x + q * y = 0 := by rw [← h1, hsplit (fun t => t)]
    have hs2 : (p : ℝ) * x ^ 2 + q * y ^ 2 = 1 := by rw [← h2, hsplit (fun t => t ^ 2)]
    -- `xy = −1/n`, `x² = q/(np)`, `y² = p/(nq)`
    have hxy1 : n * (x * y) = -1 := by
      have e1 : (p : ℝ) * x ^ 2 = -(q * (x * y)) := by linear_combination x * hs1
      have e2 : (q : ℝ) * y ^ 2 = -(p * (x * y)) := by linear_combination y * hs1
      rw [← hpq]; linear_combination -hs2 + e1 + e2
    have hx2 : (p : ℝ) * n * x ^ 2 = q := by
      have e1 : (p : ℝ) * x ^ 2 = -(q * (x * y)) := by linear_combination x * hs1
      linear_combination n * e1 - q * hxy1
    have hy2 : (q : ℝ) * n * y ^ 2 = p := by
      have e2 : (q : ℝ) * y ^ 2 = -(p * (x * y)) := by linear_combination y * hs1
      linear_combination n * e2 - p * hxy1
    -- `pq ≤ (n²−1)/4` since `p ≠ q` at odd `n`
    have hpne : p ≠ q := by
      intro e; apply hodd
      have : Fintype.card ι = q + q := by omega
      rw [this]; exact ⟨q, rfl⟩
    have hdiff : (1 : ℝ) ≤ ((p : ℝ) - q) ^ 2 := by
      rcases lt_or_gt_of_ne hpne with h | h
      · have : (p : ℝ) + 1 ≤ q := by exact_mod_cast h
        nlinarith
      · have : (q : ℝ) + 1 ≤ p := by exact_mod_cast h
        nlinarith
    -- assemble: `b n p q = q² + p² − pq`
    have hpos : 0 < (p : ℝ) * q * n := mul_pos (mul_pos (by linarith) (by linarith)) hnpos
    have hbpq : b * ((p : ℝ) * q * n) = (q : ℝ) ^ 2 + (p : ℝ) ^ 2 - p * q := by
      rw [← hbxy]
      have : (x ^ 2 + x * y + y ^ 2) * ((p : ℝ) * q * n)
          = (q : ℝ) * ((p : ℝ) * n * x ^ 2) + (p : ℝ) * ((q : ℝ) * n * y ^ 2) + (p : ℝ) * q * (n * (x * y)) := by
        ring
      rw [this, hx2, hy2, hxy1]; ring
    have hn2 : n ^ 2 = ((p : ℝ) + q) ^ 2 := by rw [hpq]
    have hsq : (q : ℝ) ^ 2 + (p : ℝ) ^ 2 - p * q = n ^ 2 - 3 * (p * q) := by rw [hn2]; ring
    have hn21 : 1 < n ^ 2 := one_lt_pow₀ (by linarith) two_ne_zero
    -- `b = gOdd` forces `4pq = n² − 1`
    have hbg : b * (n * (n ^ 2 - 1)) = n ^ 2 + 3 := by
      rw [show b = gOdd n from heq]; unfold gOdd
      have h' : n ^ 2 - 1 ≠ 0 := by linarith
      field_simp
    have h4 : 4 * ((p : ℝ) * q) = n ^ 2 - 1 := by
      have e : (n ^ 2 - 1) * (b * ((p : ℝ) * q * n)) = (b * (n * (n ^ 2 - 1))) * ((p : ℝ) * q) := by ring
      rw [hbpq, hsq, hbg] at e
      have h0 : n ^ 2 * (n ^ 2 - 1 - 4 * ((p : ℝ) * q)) = 0 := by linear_combination e
      rcases mul_eq_zero.mp h0 with h | h
      · exfalso; nlinarith
      · linarith
    refine ⟨x, y, hxy, hvals, ?_⟩
    have hr : (((p : ℤ) - q) ^ 2 : ℝ) = 1 := by
      push_cast
      have : ((p : ℝ) - q) ^ 2 = ((p : ℝ) + q) ^ 2 - 4 * ((p : ℝ) * q) := by ring
      rw [this, ← hn2, h4]; ring
    exact_mod_cast hr

end HamiltonsCubic.FourthMoment
