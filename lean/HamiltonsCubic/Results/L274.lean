import Mathlib

set_option linter.style.longLine false

/-!
# L274: a degree-refined traceless cubic bound (J1 at `Q = 0`)

[second-order.md](../../../findings/second-order.md)'s L274: for a real symmetric `m × m` matrix `W` with zero diagonal,
`m ≥ 3`, with `D i = Σ_j W_ij²` and `S = Σ_i D i`,
`tr W³ ≤ K_m (S² − Σ_i D_i²)/√S`, `K_m = √m (m − 2)/(m − 1)^{3/2}`, with equality at `J − I`.

The statement is typed here multiplied through by `√S`, so that `W = 0` needs no case, as `L274_bound`, and it is
proved. The proof follows the record's six steps: a row Cauchy–Schwarz (`rows`), a pairing with `√(D_i D_j)` (`pairing`),
the symmetrisation `(1 − p)(1 − p') ≤ ½(1 − p)² + ½(1 − p')²` over the reversible walk `p_ij = W_ij²/D_i`, the simplex
lemma of step (4) (`L274_simplex`, `hbound`), and a column Cauchy–Schwarz plus a tangent-line Jensen bound on
`Σ_i π_i Σ_j p_ij²` (`tangent`), the last four assembled in `walk`.
-/

namespace HamiltonsCubic.L274

open Matrix Finset

/-- **Step (4) of L274**: on a probability vector `p` over `n ≥ 2` points,
`Σ_k p_k (1 − p_k)(n p_k − 1) ≥ 0`, equivalently `h(p) = Σ_k p_k(1 − p_k)² ≤ ((n − 1)/n)² − ((n − 1)/n)(Σ_k p_k² − 1/n)`. -/
theorem L274_simplex (n : ℕ) (hn : 2 ≤ n) (p : Fin n → ℝ) (hp : ∀ k, 0 ≤ p k) (hs : ∑ k, p k = 1) :
    0 ≤ ∑ k, p k * (1 - p k) * (n * p k - 1) := by
  have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hn2 : (2 : ℝ) ≤ n := by exact_mod_cast hn
  set c : ℝ := 1 / n with hc
  have hcn : (n : ℝ) * c = 1 := by rw [hc]; field_simp
  -- the identity `Σ p(1 − p)(np − 1) = n Σ (p − c)²(1 − c − p)`
  have hsumc : ∑ k : Fin n, (p k - c) = 0 := by
    rw [Finset.sum_sub_distrib, hs, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, hcn]; ring
  have hid : ∑ k, p k * (1 - p k) * (n * p k - 1) = n * ∑ k, (p k - c) ^ 2 * (1 - c - p k) := by
    have e : ∀ k, p k * (1 - p k) * (n * p k - 1)
        = n * ((p k - c) ^ 2 * (1 - c - p k)) + n * (c * (1 - c)) * (p k - c) := fun k => by
      have : (n : ℝ) * p k - 1 = n * (p k - c) := by rw [mul_sub, hcn]
      rw [this]; ring
    rw [Finset.sum_congr rfl fun k _ => e k, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum, hsumc]
    ring
  rw [hid]
  apply mul_nonneg hn0.le
  by_cases hbig : ∃ k₀, 1 - c < p k₀
  · obtain ⟨k₀, hk₀⟩ := hbig
    set a := p k₀ with ha
    have hle : ∀ k, k ≠ k₀ → p k ≤ 1 - a := fun k hk => by
      have h2 : p k + p k₀ ≤ ∑ j, p j := by
        rw [← Finset.sum_pair hk]
        exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _) fun j _ _ => hp j
      linarith
    have hac : c < a - c + c := by
      have : c ≤ 1 - c := by
        rw [hc]; rw [div_le_iff₀ hn0]; nlinarith
      linarith
    -- the other coordinates
    set R := Finset.univ.erase k₀ with hR
    have hRcard : (R.card : ℝ) = n - 1 := by
      rw [hR, Finset.card_erase_of_mem (Finset.mem_univ _), Finset.card_univ, Fintype.card_fin]
      push_cast [show 1 ≤ n by omega]; ring
    have hRsum : ∑ k ∈ R, (p k - c) = c - a := by
      have := hsumc
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ k₀)] at this
      linarith
    have hcs : (c - a) ^ 2 ≤ (n - 1) * ∑ k ∈ R, (p k - c) ^ 2 := by
      rw [← hRsum, ← hRcard]; exact sq_sum_le_card_mul_sum_sq
    have hrest : (a - c) * ∑ k ∈ R, (p k - c) ^ 2 ≤ ∑ k ∈ R, (p k - c) ^ 2 * (1 - c - p k) := by
      rw [Finset.mul_sum]
      refine Finset.sum_le_sum fun k hk => ?_
      have hk' : k ≠ k₀ := Finset.ne_of_mem_erase hk
      have := hle k hk'
      nlinarith [sq_nonneg (p k - c)]
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ k₀)]
    change 0 ≤ (a - c) ^ 2 * (1 - c - a) + ∑ k ∈ R, (p k - c) ^ 2 * (1 - c - p k)
    have hn1 : (0 : ℝ) < n - 1 := by linarith
    have hsq : (a - c) ^ 2 / (n - 1) ≤ ∑ k ∈ R, (p k - c) ^ 2 := by
      rw [div_le_iff₀ hn1]; nlinarith [hcs]
    have hpos : 0 ≤ a - c := by linarith
    have h1 : (a - c) * ((a - c) ^ 2 / (n - 1)) ≤ ∑ k ∈ R, (p k - c) ^ 2 * (1 - c - p k) :=
      le_trans (mul_le_mul_of_nonneg_left hsq hpos) hrest
    have ha1 : a ≤ 1 := by
      have : p k₀ ≤ ∑ j, p j := Finset.single_le_sum (fun j _ => hp j) (Finset.mem_univ _)
      linarith
    have key : 0 ≤ (a - c) ^ 2 * (1 - c - a) + (a - c) * ((a - c) ^ 2 / (n - 1)) := by
      have e : (a - c) ^ 2 * (1 - c - a) + (a - c) * ((a - c) ^ 2 / (n - 1))
          = (a - c) ^ 2 * ((n - 2) / (n - 1) * (1 - a)) := by
        field_simp
        rw [hc]; field_simp; ring
      rw [e]
      apply mul_nonneg (sq_nonneg _)
      apply mul_nonneg (div_nonneg (by linarith) hn1.le) (by linarith)
    linarith
  · push Not at hbig
    exact Finset.sum_nonneg fun k _ => mul_nonneg (sq_nonneg _) (by linarith [hbig k])

/-- Step (4) on a finite set of `n ≥ 2` points, transferred from `L274_simplex`. -/
theorem simplexF {ι : Type*} (s : Finset ι) (hn : 2 ≤ s.card) (p : ι → ℝ)
    (hp : ∀ k ∈ s, 0 ≤ p k) (hs : ∑ k ∈ s, p k = 1) :
    0 ≤ ∑ k ∈ s, p k * (1 - p k) * (s.card * p k - 1) := by
  have tr : ∀ f : ι → ℝ, ∑ k ∈ s, f k = ∑ k : Fin s.card, f (s.equivFin.symm k) := fun f => by
    rw [← Finset.sum_coe_sort s f]
    exact (Equiv.sum_comp s.equivFin.symm (fun x : s => f x)).symm
  rw [tr]
  exact L274_simplex s.card hn (fun k => p (s.equivFin.symm k)) (fun k => hp _ (s.equivFin.symm k).2)
    (by rw [← tr]; exact hs)

/-- Step (4) in the form used: `Σ p(1 − p)² ≤ ((n − 1) − (n − 1)Σ p²)/n` on `n ≥ 2` points. -/
theorem hbound {ι : Type*} (s : Finset ι) (hn : 2 ≤ s.card) (p : ι → ℝ)
    (hp : ∀ k ∈ s, 0 ≤ p k) (hs : ∑ k ∈ s, p k = 1) :
    (s.card : ℝ) * ∑ k ∈ s, p k * (1 - p k) ^ 2 ≤ ((s.card : ℝ) - 1) - ((s.card : ℝ) - 1) * ∑ k ∈ s, p k ^ 2 := by
  have h := simplexF s hn p hp hs
  have e1 : ∑ k ∈ s, p k * (1 - p k) * (s.card * p k - 1)
      = ((s.card : ℝ) + 1) * ∑ k ∈ s, p k ^ 2 - ∑ k ∈ s, p k - (s.card : ℝ) * ∑ k ∈ s, p k ^ 3 := by
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun k _ => by ring
  have e2 : ∑ k ∈ s, p k * (1 - p k) ^ 2 = ∑ k ∈ s, p k - 2 * ∑ k ∈ s, p k ^ 2 + ∑ k ∈ s, p k ^ 3 := by
    rw [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun k _ => by ring
  rw [e1, hs] at h
  rw [e2, hs]
  nlinarith

/-- **Step (5)'s Jensen step, as a tangent line**: for `0 ≤ t`,
`t² ≥ (1 − t)[((n²−1)/n²)t² + 1/(n²(n+1)) + (3/n²)(t − 1/(n+1))]`, the difference being
`((n−1)t + 2)((n+1)t − 1)²/(n²(n+1))`. -/
theorem tangent (n t : ℝ) (hn : 1 ≤ n) (ht : 0 ≤ t) :
    (1 - t) * ((n ^ 2 - 1) / n ^ 2 * t ^ 2 + 1 / (n ^ 2 * (n + 1)) + 3 / n ^ 2 * (t - 1 / (n + 1))) ≤ t ^ 2 := by
  have hn0 : 0 < n := by linarith
  have e : t ^ 2 - (1 - t) * ((n ^ 2 - 1) / n ^ 2 * t ^ 2 + 1 / (n ^ 2 * (n + 1)) + 3 / n ^ 2 * (t - 1 / (n + 1)))
      = ((n - 1) * t + 2) * ((n + 1) * t - 1) ^ 2 / (n ^ 2 * (n + 1)) := by
    field_simp; ring
  have : 0 ≤ ((n - 1) * t + 2) * ((n + 1) * t - 1) ^ 2 / (n ^ 2 * (n + 1)) := by
    apply div_nonneg (mul_nonneg (by nlinarith) (sq_nonneg _)) (by positivity)
  linarith

section Rows

variable {m : ℕ} (W : Matrix (Fin m) (Fin m) ℝ)

theorem symm_entry (hW : Wᵀ = W) (i j : Fin m) : W j i = W i j := by
  have := congrFun (congrFun hW i) j
  rw [Matrix.transpose_apply] at this
  exact this

/-- **Step (1)**: the row Cauchy–Schwarz. -/
theorem rows (hW : Wᵀ = W) (hd : ∀ i, W i i = 0) :
    (W * W * W).trace ≤ ∑ i, ∑ j, |W i j| *
      Real.sqrt ((∑ k, W i k ^ 2 - W i j ^ 2) * (∑ k, W j k ^ 2 - W i j ^ 2)) := by
  have hs := symm_entry W hW
  have htr : (W * W * W).trace = ∑ i, ∑ j, W i j * ∑ k, W i k * W k j := by
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    rw [hs i j, Finset.sum_mul, Finset.mul_sum]
    exact Finset.sum_congr rfl fun k _ => by ring
  rw [htr]
  refine Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => ?_
  -- the inner sum without the terms `k = i, j`
  set a : Fin m → ℝ := fun k => if k = j then 0 else W i k with ha
  set b : Fin m → ℝ := fun k => if k = i then 0 else W k j with hb
  have hab : ∑ k, W i k * W k j = ∑ k, a k * b k := by
    refine Finset.sum_congr rfl fun k _ => ?_
    simp only [ha, hb]
    by_cases hkj : k = j
    · subst hkj; simp [hd]
    · by_cases hki : k = i
      · subst hki; simp [hd]
      · simp [hkj, hki]
  have hsa : ∑ k, a k ^ 2 = ∑ k, W i k ^ 2 - W i j ^ 2 := by
    have e : ∀ k, a k ^ 2 = W i k ^ 2 - (if k = j then W i j ^ 2 else 0) := fun k => by
      simp only [ha]; split_ifs with h <;> simp [h]
    rw [Finset.sum_congr rfl fun k _ => e k, Finset.sum_sub_distrib, Finset.sum_ite_eq']
    simp
  have hsb : ∑ k, b k ^ 2 = ∑ k, W j k ^ 2 - W i j ^ 2 := by
    have e : ∀ k, b k ^ 2 = W j k ^ 2 - (if k = i then W i j ^ 2 else 0) := fun k => by
      simp only [hb]; split_ifs with h
      · subst h; simp [hs]
      · simp [hs]
    rw [Finset.sum_congr rfl fun k _ => e k, Finset.sum_sub_distrib, Finset.sum_ite_eq']
    simp
  have hcs : (∑ k, a k * b k) ^ 2 ≤ (∑ k, a k ^ 2) * ∑ k, b k ^ 2 := Finset.sum_mul_sq_le_sq_mul_sq _ _ _
  rw [hab, ← hsa, ← hsb]
  calc W i j * ∑ k, a k * b k ≤ |W i j| * |∑ k, a k * b k| := by
        rw [← abs_mul]; exact le_abs_self _
    _ ≤ |W i j| * Real.sqrt ((∑ k, a k ^ 2) * ∑ k, b k ^ 2) :=
        mul_le_mul_of_nonneg_left (Real.abs_le_sqrt hcs) (abs_nonneg _)

end Rows

section Walk

variable {m : ℕ} (x : Fin m → Fin m → ℝ)

/-- **Steps (3) to (6)**: for a non-negative symmetric `x` with zero diagonal on `m ≥ 3` points, degrees `D_i` and
total `S > 0`, `S · Σ_{i,j} x_ij (D_i − x_ij)(D_j − x_ij)/(D_i D_j) ≤ K_m² (S² − Σ D_i²)`. -/
theorem walk (hm : 3 ≤ m) (hx0 : ∀ i j, 0 ≤ x i j) (hsym : ∀ i j, x i j = x j i) (hdiag : ∀ i, x i i = 0)
    (hS : 0 < ∑ i, ∑ k, x i k) :
    (∑ i, ∑ k, x i k) * ∑ i, ∑ j, x i j * ((∑ k, x i k) - x i j) * ((∑ k, x j k) - x i j) /
        ((∑ k, x i k) * (∑ k, x j k))
      ≤ ((m : ℝ) * ((m : ℝ) - 2) ^ 2 / ((m : ℝ) - 1) ^ 3) *
        ((∑ i, ∑ k, x i k) ^ 2 - ∑ i, (∑ k, x i k) ^ 2) := by
  set D : Fin m → ℝ := fun i => ∑ k, x i k with hD
  set S : ℝ := ∑ i, D i with hSdef
  change S * ∑ i, ∑ j, x i j * (D i - x i j) * (D j - x i j) / (D i * D j) ≤ _ * (S ^ 2 - ∑ i, D i ^ 2)
  have hD0 : ∀ i, 0 ≤ D i := fun i => Finset.sum_nonneg fun k _ => hx0 i k
  have hxD : ∀ i j, x i j ≤ D i := fun i j => Finset.single_le_sum (fun k _ => hx0 i k) (Finset.mem_univ j)
  have hxD' : ∀ i j, x i j ≤ D j := fun i j => by rw [hsym]; exact hxD j i
  have hm3 : (3 : ℝ) ≤ m := by exact_mod_cast hm
  set n : ℝ := (m : ℝ) - 1 with hn
  have hn2 : (2 : ℝ) ≤ n := by rw [hn]; linarith
  -- (a) the symmetrisation, pair by pair
  have hterm : ∀ i j, x i j * (D i - x i j) * (D j - x i j) / (D i * D j)
      ≤ (1 / 2) * (x i j * (1 - x i j / D i) ^ 2) + (1 / 2) * (x i j * (1 - x i j / D j) ^ 2) := by
    intro i j
    have hr : 0 ≤ (1 / 2) * (x i j * (1 - x i j / D i) ^ 2) + (1 / 2) * (x i j * (1 - x i j / D j) ^ 2) := by
      have := hx0 i j; positivity
    by_cases hi : D i = 0
    · have h0 : D i * D j = 0 := by rw [hi, zero_mul]
      rw [h0, div_zero]; exact hr
    by_cases hj : D j = 0
    · have h0 : D i * D j = 0 := by rw [hj, mul_zero]
      rw [h0, div_zero]; exact hr
    have hi' : 0 < D i := lt_of_le_of_ne (hD0 i) (Ne.symm hi)
    have hj' : 0 < D j := lt_of_le_of_ne (hD0 j) (Ne.symm hj)
    have e : x i j * (D i - x i j) * (D j - x i j) / (D i * D j)
        = x i j * ((1 - x i j / D i) * (1 - x i j / D j)) := by field_simp
    rw [e]
    nlinarith [mul_nonneg (hx0 i j) (sq_nonneg ((1 - x i j / D i) - (1 - x i j / D j)))]
  -- (b) summing and swapping
  have hsum_ab : ∑ i, ∑ j, x i j * (D i - x i j) * (D j - x i j) / (D i * D j)
      ≤ ∑ i, ∑ j, x i j * (1 - x i j / D i) ^ 2 := by
    calc _ ≤ ∑ i, ∑ j, ((1 / 2) * (x i j * (1 - x i j / D i) ^ 2) + (1 / 2) * (x i j * (1 - x i j / D j) ^ 2)) :=
          Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => hterm i j
      _ = _ := by
          simp only [Finset.sum_add_distrib, ← Finset.mul_sum]
          have : ∑ i, ∑ j, x i j * (1 - x i j / D j) ^ 2 = ∑ i, ∑ j, x i j * (1 - x i j / D i) ^ 2 := by
            rw [Finset.sum_comm]
            exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [hsym j i]
          rw [this]; ring
  -- (c) Lemma A row by row
  have hrow : ∀ i, ∑ j, x i j * (1 - x i j / D i) ^ 2 ≤ ((n - 1) * D i - (n - 1) * ∑ j, x i j ^ 2 / D i) / n := by
    intro i
    by_cases hi : D i = 0
    · have hz : ∀ j, x i j = 0 := fun j => le_antisymm (hi ▸ hxD i j) (hx0 i j)
      simp [hz, hi]
    have hi' : 0 < D i := lt_of_le_of_ne (hD0 i) (Ne.symm hi)
    set s := Finset.univ.erase i with hs
    have hcard : s.card = m - 1 := by rw [hs, Finset.card_erase_of_mem (Finset.mem_univ _), Finset.card_univ, Fintype.card_fin]
    have hcardR : (s.card : ℝ) = n := by rw [hcard, hn]; push_cast [show 1 ≤ m by omega]; ring
    have hc2 : 2 ≤ s.card := by rw [hcard]; omega
    set p : Fin m → ℝ := fun j => x i j / D i with hp
    have hp0 : ∀ k ∈ s, 0 ≤ p k := fun k _ => div_nonneg (hx0 i k) hi'.le
    have hrest : ∀ f : Fin m → ℝ, f i = 0 → ∑ j, f j = ∑ j ∈ s, f j := fun f hf => by
      rw [hs, ← Finset.add_sum_erase _ _ (Finset.mem_univ i), hf, zero_add]
    have hps : ∑ k ∈ s, p k = 1 := by
      rw [← hrest p (by simp [hp, hdiag])]
      simp only [hp]; rw [← Finset.sum_div]; exact div_self hi
    have hb := hbound s hc2 p hp0 hps
    rw [hcardR] at hb
    have e1 : ∑ j, x i j * (1 - x i j / D i) ^ 2 = D i * ∑ k ∈ s, p k * (1 - p k) ^ 2 := by
      rw [hrest _ (by simp [hdiag]), Finset.mul_sum]
      exact Finset.sum_congr rfl fun k _ => by simp only [hp]; field_simp
    have e2 : ∑ j, x i j ^ 2 / D i = D i * ∑ k ∈ s, p k ^ 2 := by
      rw [hrest _ (by simp [hdiag]), Finset.mul_sum]
      exact Finset.sum_congr rfl fun k _ => by simp only [hp]; field_simp
    rw [e1, e2, le_div_iff₀ (by linarith)]
    nlinarith [mul_le_mul_of_nonneg_left hb hi'.le]
  -- (d) Cauchy–Schwarz by columns
  have hcol : ∀ j, D j ^ 2 / (S - D j) ≤ ∑ i, x i j ^ 2 / D i := by
    intro j
    have hR : 0 ≤ ∑ i, x i j ^ 2 / D i := Finset.sum_nonneg fun i _ => div_nonneg (sq_nonneg _) (hD0 i)
    by_cases hj : D j = 0
    · rw [hj]; simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, zero_div]; exact hR
    have hj' : 0 < D j := lt_of_le_of_ne (hD0 j) (Ne.symm hj)
    set T := Finset.univ.filter (fun i => i ≠ j ∧ 0 < D i) with hT
    have hcolsum : ∑ i, x i j = D j := by
      simp only [hD]; exact Finset.sum_congr rfl fun i _ => hsym i j
    have hTx : ∑ i ∈ T, x i j = D j := by
      rw [← hcolsum, hT, Finset.sum_filter]
      refine Finset.sum_congr rfl fun i _ => ?_
      split_ifs with h
      · rfl
      · push Not at h
        by_cases hij : i = j
        · subst hij; exact (hdiag i).symm
        · have hDi : D i = 0 := le_antisymm (h hij) (hD0 i)
          exact (le_antisymm (hDi ▸ hxD i j) (hx0 i j)).symm
    have hTD : ∑ i ∈ T, D i ≤ S - D j := by
      have : ∑ i ∈ T, D i ≤ ∑ i ∈ Finset.univ.erase j, D i :=
        Finset.sum_le_sum_of_subset_of_nonneg (fun i hi => by
          simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hi
          exact Finset.mem_erase.2 ⟨hi.1, Finset.mem_univ _⟩) (fun i _ _ => hD0 i)
      have e : ∑ i ∈ Finset.univ.erase j, D i = S - D j := by
        rw [hSdef, ← Finset.add_sum_erase _ _ (Finset.mem_univ j)]; ring
      linarith
    have hTpos : ∀ i ∈ T, 0 < D i := fun i hi => by
      simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hi; exact hi.2
    have hTD0 : 0 < ∑ i ∈ T, D i := by
      have hne : T.Nonempty := by
        by_contra hc
        rw [Finset.not_nonempty_iff_eq_empty] at hc
        rw [hc, Finset.sum_empty] at hTx; linarith
      exact Finset.sum_pos hTpos hne
    have htitu := sq_sum_div_le_sum_sq_div T (fun i => x i j) hTpos
    rw [hTx] at htitu
    have hsub : ∑ i ∈ T, x i j ^ 2 / D i ≤ ∑ i, x i j ^ 2 / D i :=
      Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _) fun i _ _ => div_nonneg (sq_nonneg _) (hD0 i)
    calc D j ^ 2 / (S - D j) ≤ D j ^ 2 / ∑ i ∈ T, D i :=
          div_le_div_of_nonneg_left (sq_nonneg _) hTD0 hTD
      _ ≤ _ := le_trans htitu hsub
  -- (e) the tangent line, summed
  have hhalf : ∀ j, 2 * D j ≤ S := by
    intro j
    have h1 : D j = ∑ i ∈ Finset.univ.erase j, x i j := by
      have : ∑ i, x i j = D j := by simp only [hD]; exact Finset.sum_congr rfl fun i _ => hsym i j
      rw [← this, ← Finset.add_sum_erase _ _ (Finset.mem_univ j), hdiag, zero_add]
    have h2 : ∑ i ∈ Finset.univ.erase j, x i j ≤ ∑ i ∈ Finset.univ.erase j, D i :=
      Finset.sum_le_sum fun i _ => hxD i j
    have e : ∑ i ∈ Finset.univ.erase j, D i = S - D j := by
      rw [hSdef, ← Finset.add_sum_erase _ _ (Finset.mem_univ j)]; ring
    linarith
  have htan : ∀ j, (S ^ 2 * (1 / (n ^ 2 * (n + 1))) + (n ^ 2 - 1) / n ^ 2 * D j ^ 2
      + 3 / n ^ 2 * S * (D j - S / (n + 1))) / S ≤ D j ^ 2 / (S - D j) := by
    intro j
    have hlt : D j < S := by have := hhalf j; linarith [hD0 j]
    have ht := tangent n (D j / S) (by linarith) (div_nonneg (hD0 j) hS.le)
    rw [div_le_div_iff₀ hS (by linarith)]
    have hS2 : 0 < S := hS
    have key : (1 - D j / S) * ((n ^ 2 - 1) / n ^ 2 * (D j / S) ^ 2 + 1 / (n ^ 2 * (n + 1))
        + 3 / n ^ 2 * (D j / S - 1 / (n + 1))) * S ^ 3
        = (S ^ 2 * (1 / (n ^ 2 * (n + 1))) + (n ^ 2 - 1) / n ^ 2 * D j ^ 2 + 3 / n ^ 2 * S * (D j - S / (n + 1)))
          * (S - D j) := by
      field_simp; ring
    have hS3 : 0 < S ^ 3 := by positivity
    have := mul_le_mul_of_nonneg_right ht hS3.le
    rw [key] at this
    have e2 : (D j / S) ^ 2 * S ^ 3 = D j ^ 2 * S := by field_simp
    nlinarith [this, e2]
  have hcard : (Finset.univ : Finset (Fin m)).card = m := by simp
  have hsumtan : (S ^ 2 + (n ^ 2 - 1) * ∑ j, D j ^ 2) / (n ^ 2 * S) ≤ ∑ j, D j ^ 2 / (S - D j) := by
    have hs := Finset.sum_le_sum fun j (_ : j ∈ (Finset.univ : Finset (Fin m))) => htan j
    rw [← Finset.sum_div] at hs
    have e : ∑ j, (S ^ 2 * (1 / (n ^ 2 * (n + 1))) + (n ^ 2 - 1) / n ^ 2 * D j ^ 2
        + 3 / n ^ 2 * S * (D j - S / (n + 1))) = (S ^ 2 + (n ^ 2 - 1) * ∑ j, D j ^ 2) / n ^ 2 := by
      rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
        ← Finset.mul_sum, ← Finset.mul_sum, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
        ← hSdef]
      have hm' : (m : ℝ) = n + 1 := by rw [hn]; ring
      simp only [nsmul_eq_mul, hm']
      field_simp; ring
    rw [e] at hs
    rw [show (S ^ 2 + (n ^ 2 - 1) * ∑ j, D j ^ 2) / (n ^ 2 * S) = (S ^ 2 + (n ^ 2 - 1) * ∑ j, D j ^ 2) / n ^ 2 / S by
      rw [div_div]]
    exact hs
  -- (f) assembly
  have hcols : ∑ j, D j ^ 2 / (S - D j) ≤ ∑ i, ∑ j, x i j ^ 2 / D i := by
    rw [Finset.sum_comm]; exact Finset.sum_le_sum fun j _ => hcol j
  have hmain : ∑ i, ∑ j, x i j * (D i - x i j) * (D j - x i j) / (D i * D j)
      ≤ ((n - 1) * S - (n - 1) * ∑ i, ∑ j, x i j ^ 2 / D i) / n := by
    refine le_trans hsum_ab (le_trans (Finset.sum_le_sum fun i _ => hrow i) (le_of_eq ?_))
    rw [← Finset.sum_div, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum]
  have hn0 : 0 < n := by linarith
  have hK : (m : ℝ) * ((m : ℝ) - 2) ^ 2 / ((m : ℝ) - 1) ^ 3 = (n - 1) * (n ^ 2 - 1) / n ^ 3 := by
    have hm' : (m : ℝ) = n + 1 := by rw [hn]; ring
    have h3 : ((m : ℝ) - 1) ^ 3 ≠ 0 := by rw [hm']; exact (pow_pos (by linarith) 3).ne'
    rw [div_eq_div_iff h3 (pow_pos hn0 3).ne', hm']; ring
  rw [hK]
  have hn' : n ≠ 0 := hn0.ne'
  have hS' : S ≠ 0 := hS.ne'
  have step := mul_le_mul_of_nonneg_left hmain hS.le
  have hX : (S ^ 2 + (n ^ 2 - 1) * ∑ j, D j ^ 2) / (n ^ 2 * S) ≤ ∑ i, ∑ j, x i j ^ 2 / D i := le_trans hsumtan hcols
  have hfin : S * (((n - 1) * S - (n - 1) * ∑ i, ∑ j, x i j ^ 2 / D i) / n)
      ≤ S * (((n - 1) * S - (n - 1) * ((S ^ 2 + (n ^ 2 - 1) * ∑ j, D j ^ 2) / (n ^ 2 * S))) / n) := by
    apply mul_le_mul_of_nonneg_left _ hS.le
    apply div_le_div_of_nonneg_right _ hn0.le
    nlinarith [hX]
  refine le_trans step (le_trans hfin (le_of_eq ?_))
  field_simp; ring

end Walk

section Main

variable {m : ℕ} (W : Matrix (Fin m) (Fin m) ℝ)

/-- **Step (2)**: the pairing with `√(D_i D_j)`. -/
theorem pairing (hW : Wᵀ = W) (hd : ∀ i, W i i = 0) :
    ∑ i, ∑ j, |W i j| * Real.sqrt ((∑ k, W i k ^ 2 - W i j ^ 2) * (∑ k, W j k ^ 2 - W i j ^ 2))
      ≤ Real.sqrt (∑ i, ∑ j, W i j ^ 2 * ((∑ k, W i k ^ 2) - W i j ^ 2) * ((∑ k, W j k ^ 2) - W i j ^ 2) /
          ((∑ k, W i k ^ 2) * (∑ k, W j k ^ 2)))
        * Real.sqrt (∑ i, ∑ j, if i = j then 0 else (∑ k, W i k ^ 2) * (∑ k, W j k ^ 2)) := by
  have hs := symm_entry W hW
  set D : Fin m → ℝ := fun i => ∑ k, W i k ^ 2 with hD
  have hD0 : ∀ i, 0 ≤ D i := fun i => Finset.sum_nonneg fun k _ => sq_nonneg _
  have hWD : ∀ i j, W i j ^ 2 ≤ D i := fun i j => Finset.single_le_sum (fun k _ => sq_nonneg (W i k)) (Finset.mem_univ j)
  set f : Fin m → Fin m → ℝ := fun i j => W i j ^ 2 * (D i - W i j ^ 2) * (D j - W i j ^ 2) / (D i * D j) with hf
  set g : Fin m → Fin m → ℝ := fun i j => if i = j then 0 else D i * D j with hg
  have hf0 : ∀ i j, 0 ≤ f i j := fun i j => by
    have h1 : 0 ≤ D i - W i j ^ 2 := by linarith [hWD i j]
    have h2 : 0 ≤ D j - W i j ^ 2 := by have := hWD j i; rw [hs] at this; linarith
    exact div_nonneg (mul_nonneg (mul_nonneg (sq_nonneg _) h1) h2) (mul_nonneg (hD0 i) (hD0 j))
  have hg0 : ∀ i j, 0 ≤ g i j := fun i j => by
    simp only [hg]; split_ifs
    · exact le_refl 0
    · exact mul_nonneg (hD0 i) (hD0 j)
  have hpt : ∀ i j, |W i j| * Real.sqrt ((D i - W i j ^ 2) * (D j - W i j ^ 2))
      ≤ Real.sqrt (f i j) * Real.sqrt (g i j) := by
    intro i j
    have hR : 0 ≤ Real.sqrt (f i j) * Real.sqrt (g i j) := mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)
    by_cases hij : i = j
    · subst hij; rw [hd, abs_zero, zero_mul]; exact hR
    by_cases hi : D i = 0
    · have : W i j = 0 := by have := hWD i j; rw [hi] at this; nlinarith [sq_nonneg (W i j)]
      rw [this, abs_zero, zero_mul]; exact hR
    by_cases hj : D j = 0
    · have : W i j = 0 := by have := hWD j i; rw [hj, hs] at this; nlinarith [sq_nonneg (W i j)]
      rw [this, abs_zero, zero_mul]; exact hR
    have hi' : 0 < D i := lt_of_le_of_ne (hD0 i) (Ne.symm hi)
    have hj' : 0 < D j := lt_of_le_of_ne (hD0 j) (Ne.symm hj)
    have h1 : 0 ≤ D i - W i j ^ 2 := by linarith [hWD i j]
    have h2 : 0 ≤ D j - W i j ^ 2 := by have := hWD j i; rw [hs] at this; linarith
    have hfg : f i j * g i j = W i j ^ 2 * ((D i - W i j ^ 2) * (D j - W i j ^ 2)) := by
      simp only [hf, hg, if_neg hij]; field_simp
    rw [← Real.sqrt_mul (hf0 i j), hfg, Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq_eq_abs]
  have hsum : ∀ F : Fin m → Fin m → ℝ, ∑ i, ∑ j, F i j = ∑ p : Fin m × Fin m, F p.1 p.2 :=
    fun F => (Fintype.sum_prod_type' F).symm
  calc _ ≤ ∑ i, ∑ j, Real.sqrt (f i j) * Real.sqrt (g i j) :=
        Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => hpt i j
    _ = ∑ p : Fin m × Fin m, Real.sqrt (f p.1 p.2) * Real.sqrt (g p.1 p.2) := hsum _
    _ ≤ Real.sqrt (∑ p : Fin m × Fin m, f p.1 p.2) * Real.sqrt (∑ p : Fin m × Fin m, g p.1 p.2) :=
        Real.sum_sqrt_mul_sqrt_le _ (fun p => hf0 p.1 p.2) (fun p => hg0 p.1 p.2)
    _ = _ := by rw [← hsum f, ← hsum g]

end Main

/-- **L274.** For a real symmetric zero-diagonal `W` on `m ≥ 3` points, with `D_i = Σ_j W_ij²` and `S = Σ_i D_i`:
`tr W³ · √S ≤ K_m (S² − Σ_i D_i²)`, `K_m = √m (m − 2)/((m − 1)√(m − 1))`. -/
theorem L274_bound (m : ℕ) (hm : 3 ≤ m) (W : Matrix (Fin m) (Fin m) ℝ) (hW : Wᵀ = W) (hd : ∀ i, W i i = 0) :
    (W * W * W).trace * Real.sqrt (∑ i, ∑ j, W i j ^ 2)
      ≤ Real.sqrt m * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1)) *
        ((∑ i, ∑ j, W i j ^ 2) ^ 2 - ∑ i, (∑ j, W i j ^ 2) ^ 2) := by
  have hs := symm_entry W hW
  set D : Fin m → ℝ := fun i => ∑ k, W i k ^ 2 with hD
  set S : ℝ := ∑ i, D i with hSdef
  have hD0 : ∀ i, 0 ≤ D i := fun i => Finset.sum_nonneg fun k _ => sq_nonneg _
  have hA : S ^ 2 - ∑ i, D i ^ 2 = ∑ i, ∑ j, if i = j then 0 else D i * D j := by
    have e : ∀ i, ∑ j, (if i = j then 0 else D i * D j) = D i * S - D i ^ 2 := fun i => by
      have : ∑ j, (if i = j then 0 else D i * D j) = ∑ j, D i * D j - ∑ j, (if i = j then D i * D j else 0) := by
        rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by split_ifs <;> ring
      rw [this, Finset.sum_ite_eq, if_pos (Finset.mem_univ _), ← Finset.mul_sum]; ring
    rw [Finset.sum_congr rfl fun i _ => e i, Finset.sum_sub_distrib, ← Finset.sum_mul, sq]
  have hA0 : 0 ≤ S ^ 2 - ∑ i, D i ^ 2 := by
    rw [hA]; exact Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => by
      split_ifs
      · exact le_refl 0
      · exact mul_nonneg (hD0 i) (hD0 j)
  have hm3 : (3 : ℝ) ≤ m := by exact_mod_cast hm
  set K2 : ℝ := (m : ℝ) * ((m : ℝ) - 2) ^ 2 / ((m : ℝ) - 1) ^ 3 with hK2
  have hKeq : Real.sqrt m * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1)) = Real.sqrt K2 := by
    rw [hK2, Real.sqrt_div' _ (pow_nonneg (by linarith) 3), Real.sqrt_mul (by positivity), Real.sqrt_sq (by linarith)]
    have : Real.sqrt (((m : ℝ) - 1) ^ 3) = ((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1) := by
      rw [show ((m : ℝ) - 1) ^ 3 = ((m : ℝ) - 1) ^ 2 * ((m : ℝ) - 1) by ring, Real.sqrt_mul (by positivity),
        Real.sqrt_sq (by linarith)]
    rw [this]
  change (W * W * W).trace * Real.sqrt S ≤ _ * (S ^ 2 - ∑ i, D i ^ 2)
  rw [hKeq]
  by_cases hS0 : S = 0
  · have h0 : Real.sqrt S = 0 := by rw [hS0, Real.sqrt_zero]
    rw [h0, mul_zero]; exact mul_nonneg (Real.sqrt_nonneg _) hA0
  have hS : 0 < S := lt_of_le_of_ne (Finset.sum_nonneg fun i _ => hD0 i) (Ne.symm hS0)
  have h1 := rows W hW hd
  have h2 := pairing W hW hd
  rw [← hA] at h2
  set E : ℝ := ∑ i, ∑ j, W i j ^ 2 * ((∑ k, W i k ^ 2) - W i j ^ 2) * ((∑ k, W j k ^ 2) - W i j ^ 2) /
      ((∑ k, W i k ^ 2) * (∑ k, W j k ^ 2)) with hE
  have hw := walk (fun i j => W i j ^ 2) hm (fun i j => sq_nonneg _) (fun i j => by rw [hs]) (fun i => by simp [hd]) hS
  change S * E ≤ K2 * (S ^ 2 - ∑ i, D i ^ 2) at hw
  have hE0 : 0 ≤ E := by
    rw [hE]; refine Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => ?_
    have h1 : 0 ≤ (∑ k, W i k ^ 2) - W i j ^ 2 := by
      linarith [Finset.single_le_sum (fun k _ => sq_nonneg (W i k)) (Finset.mem_univ j)]
    have h2 : 0 ≤ (∑ k, W j k ^ 2) - W i j ^ 2 := by
      have := Finset.single_le_sum (fun k _ => sq_nonneg (W j k)) (Finset.mem_univ i); rw [hs] at this; linarith
    exact div_nonneg (mul_nonneg (mul_nonneg (sq_nonneg _) h1) h2) (mul_nonneg (hD0 i) (hD0 j))
  have hsq : Real.sqrt S * Real.sqrt E ≤ Real.sqrt K2 * Real.sqrt (S ^ 2 - ∑ i, D i ^ 2) := by
    have hK20 : 0 ≤ K2 := div_nonneg (mul_nonneg (by linarith) (sq_nonneg _)) (pow_nonneg (by linarith) 3)
    rw [← Real.sqrt_mul hS.le, ← Real.sqrt_mul hK20]
    exact Real.sqrt_le_sqrt (by linarith)
  calc (W * W * W).trace * Real.sqrt S
      ≤ Real.sqrt E * Real.sqrt (S ^ 2 - ∑ i, D i ^ 2) * Real.sqrt S :=
        mul_le_mul_of_nonneg_right (le_trans h1 h2) (Real.sqrt_nonneg _)
    _ = (Real.sqrt S * Real.sqrt E) * Real.sqrt (S ^ 2 - ∑ i, D i ^ 2) := by ring
    _ ≤ (Real.sqrt K2 * Real.sqrt (S ^ 2 - ∑ i, D i ^ 2)) * Real.sqrt (S ^ 2 - ∑ i, D i ^ 2) :=
        mul_le_mul_of_nonneg_right hsq (Real.sqrt_nonneg _)
    _ = Real.sqrt K2 * (S ^ 2 - ∑ i, D i ^ 2) := by
        rw [mul_assoc, Real.mul_self_sqrt hA0]

end HamiltonsCubic.L274
