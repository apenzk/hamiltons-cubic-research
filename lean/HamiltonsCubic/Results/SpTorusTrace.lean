import Mathlib
import HamiltonsCubic.Results.SpTorusBlocks

/-!
# Every positive torus idempotent of `𝔰𝔭(k)`, `k ≥ 2`, has trace at least `2`

[The I117 working note](../../../reviews/2026-09-28l-I117-g2-torus.md), the `𝔰𝔭(k)` bullet of
"H asks nothing more of `𝔤₂`'s torus family", and [L286]'s corollary. The row of the largest short
weight is at most that weight times its row sum, so the row sum plus `X^∓` is at least `1`, and
every weight carries at least twice its part of that in `tr C = ∑ a_i + 2 ∑ u_i + ∑_{i ≠ j} (p + q)`.

**Typed**: `sp_trace_ge_two`, from `TorusRows` with positive weights and two distinct indices.
**Not typed**: the rows from `C # C = C` (Gate 2 [r1888], [r1889]) and the threshold comparison
(`TraceThreshold`), which gives H at `k = 2, 3`.
-/

namespace HamiltonsCubic.SpTorusTrace

open HamiltonsCubic.SpTorusBlocks

variable {k : ℕ} {P Q : Matrix (Fin k) (Fin k) ℝ} {u a : Fin k → ℝ}

/-- `x y ≤ M (x + y) / 2` for `0 ≤ x, y ≤ M`. -/
lemma prod_le_half (x y M : ℝ) (hx : 0 ≤ x) (hy : 0 ≤ y) (hxM : x ≤ M) (hyM : y ≤ M) :
    x * y ≤ M * (x + y) / 2 := by nlinarith

/-- The row bound: at the largest short weight `M = P i j`, the right side of the `p`-row is at
most `M` times the row sum. -/
lemma rhs_le (_h : TorusRows P Q u a) (hu : ∀ i, 0 < u i) (hP0 : ∀ i j, 0 ≤ P i j)
    (hQ0 : ∀ i j, 0 ≤ Q i j) (M : ℝ) (hPM : ∀ i j, P i j ≤ M) (hQM : ∀ i j, Q i j ≤ M)
    (i j : Fin k) :
    (u i + u j) * Q i j + 1 / 2 * ∑ l, (P i l * P j l + Q i l * Q j l)
      ≤ M * ((u i + u j) + 1 / 4 * ∑ l, (P i l + P j l + Q i l + Q j l)) := by
  have h1 : (u i + u j) * Q i j ≤ (u i + u j) * M :=
    mul_le_mul_of_nonneg_left (hQM i j) (by linarith [hu i, hu j])
  have h2 : ∑ l, (P i l * P j l + Q i l * Q j l)
      ≤ ∑ l, (M * (P i l + P j l) / 2 + M * (Q i l + Q j l) / 2) :=
    Finset.sum_le_sum fun l _ => add_le_add
      (prod_le_half _ _ _ (hP0 i l) (hP0 j l) (hPM i l) (hPM j l))
      (prod_le_half _ _ _ (hQ0 i l) (hQ0 j l) (hQM i l) (hQM j l))
  have e : ∑ l, (M * (P i l + P j l) / 2 + M * (Q i l + Q j l) / 2)
      = M * (1 / 2 * ∑ l, (P i l + P j l + Q i l + Q j l)) := by
    simp only [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by ring
  rw [e] at h2
  nlinarith


/-- The same bound for the `q`-row. -/
lemma rhs_le_q (hu : ∀ i, 0 < u i) (hP0 : ∀ i j, 0 ≤ P i j)
    (hQ0 : ∀ i j, 0 ≤ Q i j) (M : ℝ) (hPM : ∀ i j, P i j ≤ M) (hQM : ∀ i j, Q i j ≤ M)
    (i j : Fin k) :
    (u i + u j) * P i j + 1 / 2 * ∑ l, (P i l * Q j l + Q i l * P j l)
      ≤ M * ((u i + u j) + 1 / 4 * ∑ l, (P i l + P j l + Q i l + Q j l)) := by
  have h1 : (u i + u j) * P i j ≤ (u i + u j) * M :=
    mul_le_mul_of_nonneg_left (hPM i j) (by linarith [hu i, hu j])
  have h2 : ∑ l, (P i l * Q j l + Q i l * P j l)
      ≤ ∑ l, (M * (P i l + Q j l) / 2 + M * (Q i l + P j l) / 2) :=
    Finset.sum_le_sum fun l _ => add_le_add
      (prod_le_half _ _ _ (hP0 i l) (hQ0 j l) (hPM i l) (hQM j l))
      (prod_le_half _ _ _ (hQ0 i l) (hP0 j l) (hQM i l) (hPM j l))
  have e : ∑ l, (M * (P i l + Q j l) / 2 + M * (Q i l + P j l) / 2)
      = M * (1 / 2 * ∑ l, (P i l + P j l + Q i l + Q j l)) := by
    simp only [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by ring
  rw [e] at h2
  nlinarith

/-- **The trace is at least `2`.** -/
theorem sp_trace_ge_two (h : TorusRows P Q u a) (hu : ∀ i, 0 < u i)
    (hP : ∀ i j, i ≠ j → 0 < P i j) (hQ : ∀ i j, i ≠ j → 0 < Q i j) (i0 j0 : Fin k)
    (hij0 : i0 ≠ j0) :
    2 ≤ ∑ i, a i + 2 * ∑ i, u i + ∑ i, ∑ j, (P i j + Q i j) := by
  have hP0 : ∀ i j, 0 ≤ P i j := fun i j => by
    by_cases hij : i = j
    · rw [hij, h.diagP]
    · exact (hP i j hij).le
  have hQ0 : ∀ i j, 0 ≤ Q i j := fun i j => by
    by_cases hij : i = j
    · rw [hij, h.diagQ]
    · exact (hQ i j hij).le
  -- the largest short weight
  have hne : (Finset.univ : Finset (Fin k × Fin k)).Nonempty := ⟨(i0, j0), Finset.mem_univ _⟩
  obtain ⟨⟨i, j⟩, -, hmax⟩ :=
    Finset.exists_max_image Finset.univ (fun x : Fin k × Fin k => max (P x.1 x.2) (Q x.1 x.2)) hne
  set M := max (P i j) (Q i j) with hM
  have hPM : ∀ x y, P x y ≤ M := fun x y =>
    le_trans (le_max_left _ _) (hmax (x, y) (Finset.mem_univ _))
  have hQM : ∀ x y, Q x y ≤ M := fun x y =>
    le_trans (le_max_right _ _) (hmax (x, y) (Finset.mem_univ _))
  have hMpos : 0 < M := lt_of_lt_of_le (hP i0 j0 hij0) (hPM i0 j0)
  have hij : i ≠ j := by
    rintro rfl
    have : M = 0 := by rw [hM, h.diagP, h.diagQ, max_self]
    linarith
  -- a_l in [0, 1/2], and every weight at most 1
  have hsq : ∀ l, 0 ≤ ∑ m, (P l m ^ 2 + Q l m ^ 2) := fun l =>
    Finset.sum_nonneg fun m _ => by positivity
  have ha0 : ∀ l, 0 ≤ a l := fun l => by rw [h.ha l]; nlinarith [hsq l, sq_nonneg (u l)]
  have hahalf : ∀ l, a l ≤ 1 / 2 := fun l => by
    have hl := h.hlong l
    have : 0 ≤ ∑ m, P l m * Q l m := Finset.sum_nonneg fun m _ => mul_nonneg (hP0 l m) (hQ0 l m)
    have hul := hu l
    nlinarith
  have hPle : P i j ^ 2 ≤ 1 := by
    have hs : P i j ^ 2 + Q i j ^ 2 ≤ ∑ m, (P i m ^ 2 + Q i m ^ 2) :=
      Finset.single_le_sum (f := fun m => P i m ^ 2 + Q i m ^ 2) (fun m _ => by positivity)
        (Finset.mem_univ j)
    have := h.ha i; have := hahalf i
    nlinarith [sq_nonneg (Q i j), sq_nonneg (u i)]
  have hQle : Q i j ^ 2 ≤ 1 := by
    have hs : P i j ^ 2 + Q i j ^ 2 ≤ ∑ m, (P i m ^ 2 + Q i m ^ 2) :=
      Finset.single_le_sum (f := fun m => P i m ^ 2 + Q i m ^ 2) (fun m _ => by positivity)
        (Finset.mem_univ j)
    have := h.ha i; have := hahalf i
    nlinarith [sq_nonneg (P i j), sq_nonneg (u i)]
  -- the trace against the two rows i and j
  set R := (u i + u j) + 1 / 4 * ∑ l, (P i l + P j l + Q i l + Q j l) with hR
  have hrows : ∑ l, (P i l + Q i l) + ∑ l, (P j l + Q j l) ≤ ∑ x, ∑ y, (P x y + Q x y) := by
    have hsub : ({i, j} : Finset (Fin k)) ⊆ Finset.univ := Finset.subset_univ _
    have := Finset.sum_le_sum_of_subset_of_nonneg hsub
      (f := fun x => ∑ y, (P x y + Q x y))
      (fun x _ _ => Finset.sum_nonneg fun y _ => add_nonneg (hP0 x y) (hQ0 x y))
    rwa [Finset.sum_pair hij] at this
  have hsplit : ∑ l, (P i l + P j l + Q i l + Q j l)
      = ∑ l, (P i l + Q i l) + ∑ l, (P j l + Q j l) := by
    rw [← Finset.sum_add_distrib]; exact Finset.sum_congr rfl fun l _ => by ring
  have hPij : P i j ≤ ∑ l, (P i l + Q i l) :=
    le_trans (le_add_of_nonneg_right (hQ0 i j))
      (Finset.single_le_sum (f := fun l => P i l + Q i l)
        (fun l _ => add_nonneg (hP0 i l) (hQ0 i l)) (Finset.mem_univ j))
  have hPji : P j i ≤ ∑ l, (P j l + Q j l) :=
    le_trans (le_add_of_nonneg_right (hQ0 j i))
      (Finset.single_le_sum (f := fun l => P j l + Q j l)
        (fun l _ => add_nonneg (hP0 j l) (hQ0 j l)) (Finset.mem_univ i))
  have hQij : Q i j ≤ ∑ l, (P i l + Q i l) :=
    le_trans (le_add_of_nonneg_left (hP0 i j))
      (Finset.single_le_sum (f := fun l => P i l + Q i l)
        (fun l _ => add_nonneg (hP0 i l) (hQ0 i l)) (Finset.mem_univ j))
  have hQji : Q j i ≤ ∑ l, (P j l + Q j l) :=
    le_trans (le_add_of_nonneg_left (hP0 j i))
      (Finset.single_le_sum (f := fun l => P j l + Q j l)
        (fun l _ => add_nonneg (hP0 j l) (hQ0 j l)) (Finset.mem_univ i))
  have hsymP := h.symP i j
  have hsymQ := h.symQ i j
  have hasum : a i + a j ≤ ∑ l, a l := by
    have := Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ ({i, j} : Finset (Fin k)))
      (f := a) (fun x _ _ => ha0 x)
    rwa [Finset.sum_pair hij] at this
  have husum : u i + u j ≤ ∑ l, u l := by
    have := Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ ({i, j} : Finset (Fin k)))
      (f := u) (fun x _ _ => (hu x).le)
    rwa [Finset.sum_pair hij] at this
  rcases max_choice (P i j) (Q i j) with hc | hc
  · -- the largest is a p-weight
    have hMP : M = P i j := by rw [hM, hc]
    have hrow := h.hp i j hij
    have hb := rhs_le h hu hP0 hQ0 M hPM hQM i j
    rw [← hrow, hMP] at hb
    have hG : 1 ≤ R + ((a i + a j) / 2 - (Q i j ^ 2 - P i j ^ 2) / 2) := by
      have hp := hP i j hij
      rw [hR]
      nlinarith
    rw [hsplit] at hR
    nlinarith
  · -- the largest is a q-weight
    have hMQ : M = Q i j := by rw [hM, hc]
    have hrow := h.hq i j hij
    have hb := rhs_le_q hu hP0 hQ0 M hPM hQM i j
    rw [← hrow, hMQ] at hb
    have hG : 1 ≤ R + ((a i + a j) / 2 + (Q i j ^ 2 - P i j ^ 2) / 2) := by
      have hq := hQ i j hij
      rw [hR]
      nlinarith
    rw [hsplit] at hR
    nlinarith

end HamiltonsCubic.SpTorusTrace
