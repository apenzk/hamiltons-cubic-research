import Mathlib

/-!
# `𝔰𝔭(k)`'s torus system on the equal-weight sector: only `I/c`

[The working note](../../../reviews/2026-09-28l-I117-g2-torus.md) on I117's R48, "On the sector
`p = q`, `I/c` is the only positive-definite idempotent of `𝔰𝔭(k)`'s torus family", numbered L285
in [second-order.md](../../../findings/second-order.md).

**The source's statement.** With `S` the symmetric matrix of the short weights `s_{ij}` (zero
diagonal, positive off the diagonal) and `U = diag(u)`, the rows read
`S² = 2S − 3(US + SU) + 4U − 8U²`; then every `u_i` equals `1/(k+1)` and every off-diagonal
`s_{ij}` equals `2/(k+1)`.

**Typed**: the square completion `(S + 3U − 1)² = (1 − U)²` (`square_completion`), the equality of
all `u_i` (`u_equal`), the elementary Perron–Frobenius step (`eigvec_proportional`: two positive
eigenvectors of `S` for one eigenvalue are proportional), and the statement itself
(`equal_weight_unique`), which is the note's steps 3 to 7, and the statement from the torus rows
(`equal_weight_torus`), which adds steps 1 and 2. **Not typed**: the reduction of `C # C = C` on
the torus family to the displayed rows (the product table, Gate 2 [r1888], [r1889]).
-/

namespace HamiltonsCubic.SpTorusEqualWeight

open Matrix

variable {k : ℕ}

/-- **The square completion.** -/
theorem square_completion (S : Matrix (Fin k) (Fin k) ℝ) (u : Fin k → ℝ)
    (heq : S * S = (2 : ℝ) • S - (3 : ℝ) • (diagonal u * S + S * diagonal u)
      + (4 : ℝ) • diagonal u - (8 : ℝ) • (diagonal u * diagonal u)) :
    (S + (3 : ℝ) • diagonal u - 1) * (S + (3 : ℝ) • diagonal u - 1)
      = (1 - diagonal u) * (1 - diagonal u) := by
  have e : (S + (3 : ℝ) • diagonal u - 1) * (S + (3 : ℝ) • diagonal u - 1)
      = S * S + (3 : ℝ) • (diagonal u * S + S * diagonal u)
        + (9 : ℝ) • (diagonal u * diagonal u) - (2 : ℝ) • S - (6 : ℝ) • diagonal u + 1 := by
    simp only [add_mul, mul_add, sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm, one_mul,
      mul_one]
    module
  rw [e, heq]
  simp only [sub_mul, mul_sub, one_mul, mul_one]
  module

/-- **All `u_i` are equal**, from the square completion and the positive off-diagonal entries. -/
theorem u_equal (S : Matrix (Fin k) (Fin k) ℝ) (u : Fin k → ℝ)
    (_hdiag : ∀ i, S i i = 0) (hpos : ∀ i j, i ≠ j → 0 < S i j) (hu : ∀ i, u i < 1)
    (heq : S * S = (2 : ℝ) • S - (3 : ℝ) • (diagonal u * S + S * diagonal u)
      + (4 : ℝ) • diagonal u - (8 : ℝ) • (diagonal u * diagonal u)) (i j : Fin k) :
    u i = u j := by
  by_cases hij : i = j
  · rw [hij]
  set T := S + (3 : ℝ) • diagonal u - 1 with hT
  have hsq := square_completion S u heq
  have hcomm : T * ((1 - diagonal u) * (1 - diagonal u))
      = ((1 - diagonal u) * (1 - diagonal u)) * T := by
    rw [← hsq, ← Matrix.mul_assoc]
  have hD : (1 - diagonal u) * (1 - diagonal u) = diagonal (fun l => (1 - u l) ^ 2) := by
    rw [← diagonal_one, diagonal_sub, diagonal_mul_diagonal]
    congr 1; funext l; ring
  rw [hD] at hcomm
  have hent := congrFun (congrFun hcomm i) j
  rw [mul_diagonal, diagonal_mul] at hent
  have hTij : T i j = S i j := by
    simp [hT, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, diagonal_apply_ne _ hij,
      Matrix.one_apply_ne hij]
  rw [hTij] at hent
  have hs := hpos i j hij
  have h1 : S i j * ((1 - u j) ^ 2 - (1 - u i) ^ 2) = 0 := by linear_combination hent
  rcases mul_eq_zero.mp h1 with h | h
  · exact absurd h (ne_of_gt hs)
  · have h3 : (u i - u j) * (2 - u i - u j) = 0 := by linear_combination h
    rcases mul_eq_zero.mp h3 with h4 | h4
    · linarith
    · have := hu i; have := hu j; linarith


/-- **Two positive eigenvectors for one eigenvalue are proportional**, for a matrix with zero
diagonal and positive off-diagonal entries: the elementary step of Perron–Frobenius. -/
theorem eigvec_proportional (S : Matrix (Fin k) (Fin k) ℝ) (hdiag : ∀ i, S i i = 0)
    (hpos : ∀ i j, i ≠ j → 0 < S i j) (c : ℝ) (x y : Fin k → ℝ) (hy : ∀ i, 0 < y i)
    (hx : ∀ i, ∑ l, S i l * x l = c * x i) (hy' : ∀ i, ∑ l, S i l * y l = c * y i) :
    ∃ t : ℝ, ∀ i, x i = t * y i := by
  rcases isEmpty_or_nonempty (Fin k) with h | h
  · exact ⟨0, fun i => (IsEmpty.false i).elim⟩
  obtain ⟨m, -, hm⟩ :=
    Finset.exists_min_image Finset.univ (fun i => x i / y i) Finset.univ_nonempty
  refine ⟨x m / y m, fun i => ?_⟩
  set t := x m / y m with ht
  have hz : ∀ l, 0 ≤ x l - t * y l := by
    intro l
    have h1 : t ≤ x l / y l := hm l (Finset.mem_univ l)
    rw [le_div_iff₀ (hy l)] at h1
    linarith
  have hzm : x m - t * y m = 0 := by
    rw [ht, div_mul_cancel₀ _ (hy m).ne']
    ring
  have hsum : ∑ l, S m l * (x l - t * y l) = 0 := by
    have e : ∑ l, S m l * (x l - t * y l) = (∑ l, S m l * x l) - t * ∑ l, S m l * y l := by
      rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun l _ => by ring
    rw [e, hx m, hy' m]
    linear_combination c * hzm
  have hnn : ∀ l ∈ Finset.univ, 0 ≤ S m l * (x l - t * y l) := by
    intro l _
    refine mul_nonneg ?_ (hz l)
    by_cases hl : l = m
    · rw [hl, hdiag]
    · exact (hpos m l (Ne.symm hl)).le
  have hall := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hsum
  by_cases hi : i = m
  · rw [hi]
    linarith
  · have h0 := hall i (Finset.mem_univ i)
    rcases mul_eq_zero.mp h0 with h | h
    · exact absurd h (hpos m i (Ne.symm hi)).ne'
    · linarith

/-- **The equal-weight sector has only the uniform solution**: every `u_i` is `1/(k+1)` and every
off-diagonal `s_{ij}` is `2/(k+1)`. -/
theorem equal_weight_unique (S : Matrix (Fin k) (Fin k) ℝ) (u : Fin k → ℝ) (hsym : Sᵀ = S)
    (hdiag : ∀ i, S i i = 0) (hpos : ∀ i j, i ≠ j → 0 < S i j) (hu0 : ∀ i, 0 < u i)
    (hu : ∀ i, u i < 1)
    (heq : S * S = (2 : ℝ) • S - (3 : ℝ) • (diagonal u * S + S * diagonal u)
      + (4 : ℝ) • diagonal u - (8 : ℝ) • (diagonal u * diagonal u)) :
    (∀ i, u i = 1 / (k + 1)) ∧ ∀ i j, i ≠ j → S i j = 2 / (k + 1) := by
  rcases isEmpty_or_nonempty (Fin k) with h | ⟨⟨i0⟩⟩
  · exact ⟨fun i => (IsEmpty.false i).elim, fun i => (IsEmpty.false i).elim⟩
  set w := u i0 with hw
  have hU : ∀ i, u i = w := fun i => u_equal S u hdiag hpos hu heq i i0
  have hw0 : 0 < w := hu0 i0
  have hdu : diagonal u = w • (1 : Matrix (Fin k) (Fin k) ℝ) := by
    rw [show u = fun _ => w from funext hU]
    ext i j
    by_cases h : i = j <;> simp [one_apply, h]
  have hq : S * S = (2 - 6 * w) • S + (4 * w - 8 * w ^ 2) • (1 : Matrix (Fin k) (Fin k) ℝ) := by
    rw [heq, hdu]
    simp only [smul_mul_assoc, mul_smul_comm, one_mul, mul_one, smul_smul]
    module
  set M : Matrix (Fin k) (Fin k) ℝ := S + (2 * w) • (1 : Matrix (Fin k) (Fin k) ℝ) with hM
  have hSM : S * M = (2 - 4 * w) • M := by
    rw [hM, mul_add, mul_smul_comm, mul_one, hq]
    module
  have hMe : ∀ i j, M i j = S i j + 2 * w * (1 : Matrix (Fin k) (Fin k) ℝ) i j := fun i j => by
    simp [hM]
  have hMd : ∀ i, M i i = 2 * w := fun i => by rw [hMe, hdiag, one_apply_eq]; ring
  have hMpos : ∀ i j, 0 < M i j := by
    intro i j
    by_cases hij : i = j
    · rw [hij, hMd]; linarith
    · rw [hMe, one_apply_ne hij, mul_zero, add_zero]; exact hpos i j hij
  have hSsym : ∀ i j, S i j = S j i := fun i j => by
    rw [← transpose_apply S j i, hsym]
  have hMsym : ∀ i j, M i j = M j i := by
    intro i j
    by_cases hij : i = j
    · rw [hij]
    · rw [hMe, hMe, one_apply_ne hij, one_apply_ne (Ne.symm hij), hSsym]
  have heig : ∀ j l, ∑ m, S l m * M m j = (2 - 4 * w) * M l j := fun j l => by
    have e := congrFun (congrFun hSM l) j
    rwa [mul_apply, Matrix.smul_apply, smul_eq_mul] at e
  have hconst : ∀ i j, M i j = 2 * w := by
    intro i j
    obtain ⟨t, ht⟩ := eigvec_proportional S hdiag hpos (2 - 4 * w) (fun l => M l j)
      (fun l => M l i) (fun l => hMpos l i) (heig j) (heig i)
    have h1 := ht i
    have h2 := ht j
    rw [hMd] at h1
    rw [hMd, hMsym j i, h1] at h2
    have hij := hMpos i j
    rw [h1] at hij
    have htpos : 0 < t := by
      by_contra hn
      have := not_lt.mp hn
      nlinarith
    have htt : t = 1 := by
      have : (t - 1) * (t + 1) * w = 0 := by linear_combination -h2 / 2
      rcases mul_eq_zero.mp this with h | h
      · rcases mul_eq_zero.mp h with h | h
        · linarith
        · linarith
      · linarith
    rw [h1, htt, one_mul]
  have hrow := heig i0 i0
  simp only [hconst] at hrow
  have hsumS : ∑ m, S i0 m = (k : ℝ) * (2 * w) - 2 * w := by
    have e : ∀ m, S i0 m = 2 * w - 2 * w * (1 : Matrix (Fin k) (Fin k) ℝ) i0 m := fun m => by
      have := hMe i0 m
      rw [hconst] at this
      linarith
    simp only [e, Finset.sum_sub_distrib, ← Finset.mul_sum, one_apply, Finset.sum_ite_eq,
      Finset.mem_univ, if_true, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
      nsmul_eq_mul]
    ring
  have hrow' : (∑ m, S i0 m) * (2 * w) = (2 - 4 * w) * (2 * w) := by
    rw [Finset.sum_mul]; exact hrow
  rw [hsumS] at hrow'
  have hk : (0 : ℝ) < k + 1 := by positivity
  have hwk : w = 1 / (k + 1) := by
    rw [eq_div_iff hk.ne']
    have : ((k : ℝ) + 1) * w - 1 = 0 := by
      have h4 : 4 * w * (((k : ℝ) + 1) * w - 1) = 0 := by linear_combination hrow'
      rcases mul_eq_zero.mp h4 with h | h
      · linarith
      · exact h
    linarith
  refine ⟨fun i => by rw [hU, hwk], fun i j hij => ?_⟩
  have := hMe i j
  rw [hconst, one_apply_ne hij, mul_zero, add_zero] at this
  rw [← this, hwk]
  ring

/-- **The source's statement, from the torus rows.** The long rows and the `p`-rows of
`𝔰𝔭(k)`'s torus system, in the note's notation (`P` the short weights on `ε_i − ε_j`, `Q` those on
`ε_i + ε_j`, `a_i` the Cartan diagonal), at a positive solution with `p = q`: every `u_i` and every
off-diagonal `p_{ij} = q_{ij}` equals `1/(k+1)`. The note's steps 1 and 2 reduce it to
`equal_weight_unique`. -/
theorem equal_weight_torus (P Q : Matrix (Fin k) (Fin k) ℝ) (u a : Fin k → ℝ) (hPQ : Q = P)
    (hsym : Pᵀ = P) (hdiag : ∀ i, P i i = 0) (hpos : ∀ i j, i ≠ j → 0 < P i j)
    (hu0 : ∀ i, 0 < u i)
    (ha : ∀ i, a i = 2 * u i ^ 2 + 1 / 2 * ∑ j, (P i j ^ 2 + Q i j ^ 2))
    (hlong : ∀ i, u i * (1 - 2 * a i) = ∑ j, P i j * Q i j)
    (hrow : ∀ i j, i ≠ j → P i j * (1 - ((a i + a j) / 2 - (Q i j ^ 2 - P i j ^ 2) / 2))
      = (u i + u j) * Q i j + 1 / 2 * ∑ l, (P i l * P j l + Q i l * Q j l)) :
    (∀ i, u i = 1 / (k + 1)) ∧ ∀ i j, i ≠ j → P i j = 1 / (k + 1) ∧ Q i j = 1 / (k + 1) := by
  subst hPQ
  have hPs : ∀ i j, Q i j = Q j i := fun i j => by rw [← transpose_apply Q j i, hsym]
  have hr : ∀ i, ∑ j, Q i j * Q i j = a i - 2 * u i ^ 2 := by
    intro i
    rw [ha i]
    have : ∑ j, (Q i j ^ 2 + Q i j ^ 2) = 2 * ∑ j, Q i j * Q i j := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun j _ => by ring
    rw [this]
    ring
  -- step 1: the long rows give `a_i = u_i`
  have hau : ∀ i, a i = u i := by
    intro i
    have h := hlong i
    rw [hr i] at h
    have h2 : (u i - a i) * (1 + 2 * u i) = 0 := by linear_combination h
    rcases mul_eq_zero.mp h2 with h3 | h3
    · linarith
    · linarith [hu0 i]
  have hu1 : ∀ i, u i < 1 := by
    intro i
    have h := hlong i
    rw [hau i] at h
    have hnn : 0 ≤ ∑ j, Q i j * Q i j := Finset.sum_nonneg fun j _ => mul_self_nonneg _
    have := hu0 i
    nlinarith
  -- step 2: the `p`-rows and the long rows are one matrix equation for `S = 2P`
  have heq : ((2 : ℝ) • Q) * ((2 : ℝ) • Q) = (2 : ℝ) • ((2 : ℝ) • Q)
      - (3 : ℝ) • (diagonal u * ((2 : ℝ) • Q) + ((2 : ℝ) • Q) * diagonal u)
      + (4 : ℝ) • diagonal u - (8 : ℝ) • (diagonal u * diagonal u) := by
    ext i j
    simp only [Matrix.mul_smul, Matrix.smul_mul, smul_smul, Matrix.sub_apply, Matrix.add_apply,
      Matrix.smul_apply, smul_eq_mul, diagonal_mul, mul_diagonal, diagonal_mul_diagonal]
    rw [mul_apply]
    by_cases hij : i = j
    · subst hij
      have h := hr i
      rw [hau i] at h
      have e : ∑ l, Q i l * Q l i = ∑ l, Q i l * Q i l :=
        Finset.sum_congr rfl fun l _ => by rw [hPs l i]
      rw [e, h, hdiag, diagonal_apply_eq, diagonal_apply_eq]
      ring
    · have h := hrow i j hij
      rw [hau i, hau j] at h
      have e : ∑ l, Q i l * Q l j = ∑ l, Q i l * Q j l :=
        Finset.sum_congr rfl fun l _ => by rw [hPs l j]
      have e2 : ∑ l, (Q i l * Q j l + Q i l * Q j l) = 2 * ∑ l, Q i l * Q j l := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun l _ => by ring
      rw [e2] at h
      rw [e, diagonal_apply_ne _ hij, diagonal_apply_ne _ hij]
      linear_combination (-4 : ℝ) * h
  have hS := equal_weight_unique ((2 : ℝ) • Q) u (by rw [transpose_smul, hsym])
    (fun i => by simp [hdiag]) (fun i j hij => by simpa using hpos i j hij) hu0 hu1 heq
  refine ⟨hS.1, fun i j hij => ?_⟩
  have h := hS.2 i j hij
  simp only [Matrix.smul_apply, smul_eq_mul] at h
  rw [div_eq_mul_one_div (2 : ℝ)] at h
  have : Q i j = 1 / (k + 1) := by linarith
  exact ⟨this, this⟩

/-- Non-vacuity at `k = 3`: the uniform point `u = a = p = q = 1/4` meets every hypothesis of
`equal_weight_torus`. -/
example : let P : Matrix (Fin 3) (Fin 3) ℝ := !![0, 1 / 4, 1 / 4; 1 / 4, 0, 1 / 4; 1 / 4, 1 / 4, 0]
    let u : Fin 3 → ℝ := fun _ => 1 / 4
    let a : Fin 3 → ℝ := fun _ => 1 / 4
    Pᵀ = P ∧ (∀ i, P i i = 0) ∧ (∀ i j, i ≠ j → 0 < P i j) ∧ (∀ i, 0 < u i) ∧
    (∀ i, a i = 2 * u i ^ 2 + 1 / 2 * ∑ j, (P i j ^ 2 + P i j ^ 2)) ∧
    (∀ i, u i * (1 - 2 * a i) = ∑ j, P i j * P i j) ∧
    (∀ i j, i ≠ j → P i j * (1 - ((a i + a j) / 2 - (P i j ^ 2 - P i j ^ 2) / 2))
      = (u i + u j) * P i j + 1 / 2 * ∑ l, (P i l * P j l + P i l * P j l)) := by
  intro P u a
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · ext i j; fin_cases i <;> fin_cases j <;> simp [P]
  · intro i; fin_cases i <;> simp [P]
  · intro i j hij; fin_cases i <;> fin_cases j <;> simp [P] at hij ⊢
  · intro i; simp [u]
  · intro i; fin_cases i <;> simp [P, u, a, Fin.sum_univ_three] <;> norm_num
  · intro i; fin_cases i <;> simp [P, u, a, Fin.sum_univ_three] <;> norm_num
  · intro i j hij
    fin_cases i <;> fin_cases j <;> simp [P, u, a, Fin.sum_univ_three] at hij ⊢ <;> norm_num

end HamiltonsCubic.SpTorusEqualWeight
