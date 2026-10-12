import Mathlib

/-!
# L237, the graph lemma behind `κ_r ≤ r + 2`

[findings/second-order.md](../../../findings/second-order.md), Lemma L237, the uniform proof
(Gate 2 by [r1152](../../../reviews/REVIEW_r1152.md) and [r1153](../../../reviews/REVIEW_r1153.md)).

**The lemma.** Edges `i : I` with distinct endpoints `f i ≠ g i` in a block set `V`, each unordered
pair carried by at most two edges, and weights `a : V → ℝ`. Then
`∑ᵢ (a (f i) + a (g i))² ≤ (|I| + 2) ∑_{u touched} a u²`.
The proof is the degree-weighted inequality `(x + y)² ≤ (1 + q/p) x² + (1 + p/q) y²` with `p, q` the
endpoint degrees, whose load at `u` is `d_u + ∑_{i ∋ u} d_{other}/d_u ≤ |I| + 2`, because an edge at the
other endpoint either avoids `u` or is parallel to `i`.
-/

namespace HamiltonsCubic.L237GraphLoad

open Finset

variable {V I : Type*} [Fintype I] [DecidableEq V] [DecidableEq I] (f g : I → V)

/-- Edges touching `u`. -/
def inc (u : V) : Finset I := univ.filter (fun i => f i = u ∨ g i = u)

/-- The degree of `u`. -/
def deg (u : V) : ℕ := (inc f g u).card

/-- The other endpoint of `i`, seen from `u`. -/
def other (i : I) (u : V) : V := if f i = u then g i else f i

/-- Edges parallel to `i` (same unordered pair). -/
def par (i : I) : Finset I :=
  univ.filter (fun j => (f j = f i ∧ g j = g i) ∨ (f j = g i ∧ g j = f i))

theorem amgm (x y p q : ℝ) (hp : 0 < p) (hq : 0 < q) :
    (x + y) ^ 2 ≤ (1 + q / p) * x ^ 2 + (1 + p / q) * y ^ 2 := by
  have key : 0 ≤ (q * x - p * y) ^ 2 := sq_nonneg _
  have e : (1 + q / p) * x ^ 2 + (1 + p / q) * y ^ 2 - (x + y) ^ 2
      = (q * x - p * y) ^ 2 / (p * q) := by
    field_simp; ring
  have : 0 ≤ (q * x - p * y) ^ 2 / (p * q) := div_nonneg key (by positivity)
  linarith

/-- An edge at the other endpoint either avoids `u` or is parallel to `i`. -/
theorem deg_other_le (hfg : ∀ i, f i ≠ g i) {u : V} {i : I} (hi : i ∈ inc f g u) :
    deg f g (other f g i u) ≤ (Fintype.card I - deg f g u) + (par f g i).card := by
  classical
  set o := other f g i u
  have hsub : inc f g o ⊆ (univ \ inc f g u) ∪ par f g i := by
    intro j hj
    simp only [inc, mem_filter, mem_univ, true_and] at hj hi
    by_cases hju : f j = u ∨ g j = u
    · apply mem_union_right
      simp only [par, mem_filter, mem_univ, true_and]
      have hou : o ≠ u := by
        simp only [o, other]; split_ifs with h
        · exact fun e => hfg i (h.trans e.symm)
        · intro e; exact h e
      simp only [o, other] at hj hou
      rcases hi with hi | hi <;> [simp only [hi, if_true] at hj hou; skip]
      · rcases hju with h1 | h1 <;> rcases hj with h2 | h2
        · exact absurd (h1.symm.trans h2) (Ne.symm hou)
        · left; exact ⟨h1.trans hi.symm, h2⟩
        · right; exact ⟨h2, h1.trans hi.symm⟩
        · exact absurd (h2.symm.trans h1) hou
      · have hfu : f i ≠ u := fun e => hfg i (e.trans hi.symm)
        simp only [hfu, if_false] at hj hou
        rcases hju with h1 | h1 <;> rcases hj with h2 | h2
        · exact absurd (h1.symm.trans h2) (Ne.symm hou)
        · right; exact ⟨h1.trans hi.symm, h2⟩
        · left; exact ⟨h2, h1.trans hi.symm⟩
        · exact absurd (h2.symm.trans h1) hou
    · apply mem_union_left
      simp only [inc, mem_sdiff, mem_univ, mem_filter, true_and]
      exact hju
  have := card_le_card hsub
  have h2 := card_union_le (univ \ inc f g u) (par f g i)
  rw [card_univ_diff] at h2
  unfold deg; omega

theorem mem_inc_f (i : I) : i ∈ inc f g (f i) := by simp [inc]
theorem mem_inc_g (i : I) : i ∈ inc f g (g i) := by simp [inc]

theorem deg_pos_f (i : I) : 0 < deg f g (f i) := card_pos.mpr ⟨i, mem_inc_f f g i⟩
theorem deg_pos_g (i : I) : 0 < deg f g (g i) := card_pos.mpr ⟨i, mem_inc_g f g i⟩

/-- **The load at a vertex**: `∑_{i ∋ u} (1 + d_{other}/d_u) ≤ |I| + 2`. -/
theorem load_le (hfg : ∀ i, f i ≠ g i) (hpar : ∀ i, (par f g i).card ≤ 2) (u : V) :
    ∑ i ∈ inc f g u, (1 + (deg f g (other f g i u) : ℝ) / deg f g u) ≤ Fintype.card I + 2 := by
  rcases Nat.eq_zero_or_pos (deg f g u) with h0 | hpos
  · have : inc f g u = ∅ := card_eq_zero.mp h0
    rw [this, sum_empty]; positivity
  have hD : (0 : ℝ) < deg f g u := by exact_mod_cast hpos
  have hDle : deg f g u ≤ Fintype.card I := by
    unfold deg; exact (card_le_univ _)
  have hb : ∀ i ∈ inc f g u, (deg f g (other f g i u) : ℝ) ≤ (Fintype.card I - deg f g u : ℕ) + 2 := by
    intro i hi
    have := deg_other_le f g hfg hi
    have := hpar i
    exact_mod_cast (by omega : deg f g (other f g i u) ≤ (Fintype.card I - deg f g u) + 2)
  have hsum : ∑ i ∈ inc f g u, (deg f g (other f g i u) : ℝ)
      ≤ deg f g u * (((Fintype.card I - deg f g u : ℕ) : ℝ) + 2) := by
    calc _ ≤ ∑ i ∈ inc f g u, (((Fintype.card I - deg f g u : ℕ) : ℝ) + 2) := sum_le_sum hb
      _ = _ := by rw [sum_const, nsmul_eq_mul]; rfl
  rw [sum_add_distrib, sum_const, nsmul_eq_mul, mul_one, ← sum_div]
  have hcast : (((Fintype.card I - deg f g u : ℕ) : ℝ)) = Fintype.card I - deg f g u := by
    rw [Nat.cast_sub hDle]
  change (deg f g u : ℝ) + _ ≤ _
  have : (∑ i ∈ inc f g u, (deg f g (other f g i u) : ℝ)) / deg f g u
      ≤ ((Fintype.card I - deg f g u : ℕ) : ℝ) + 2 := by
    rw [div_le_iff₀ hD]; linarith
  rw [hcast] at this
  linarith

/-- **The graph lemma.** -/
theorem graph_load [Fintype V] (hfg : ∀ i, f i ≠ g i) (hpar : ∀ i, (par f g i).card ≤ 2)
    (a : V → ℝ) :
    ∑ i, (a (f i) + a (g i)) ^ 2
      ≤ (Fintype.card I + 2) * ∑ u ∈ univ.filter (fun u => 0 < deg f g u), a u ^ 2 := by
  set G : I → V → ℝ := fun i u => (1 + (deg f g (other f g i u) : ℝ) / deg f g u) * a u ^ 2
  have hof : ∀ i, other f g i (f i) = g i := fun i => by simp [other]
  have hog : ∀ i, other f g i (g i) = f i := fun i => by
    simp [other, hfg i]
  have edge : ∀ i, (a (f i) + a (g i)) ^ 2 ≤ G i (f i) + G i (g i) := by
    intro i
    have hp : (0 : ℝ) < deg f g (f i) := by exact_mod_cast deg_pos_f f g i
    have hq : (0 : ℝ) < deg f g (g i) := by exact_mod_cast deg_pos_g f g i
    simp only [G, hof, hog]
    exact amgm _ _ _ _ hp hq
  have regroup : ∑ i, (G i (f i) + G i (g i)) = ∑ u, ∑ i ∈ inc f g u, G i u := by
    have : ∀ i, G i (f i) + G i (g i) = ∑ u, if f i = u ∨ g i = u then G i u else 0 := by
      intro i
      have hs : ∀ u, (if f i = u ∨ g i = u then G i u else 0)
          = (if f i = u then G i u else 0) + (if g i = u then G i u else 0) := by
        intro u; by_cases h1 : f i = u <;> by_cases h2 : g i = u
        · exact absurd (h1.trans h2.symm) (hfg i)
        all_goals simp [h1, h2]
      simp only [hs, sum_add_distrib, sum_ite_eq, mem_univ, if_true]
    simp only [this]
    rw [sum_comm]
    refine sum_congr rfl fun u _ => ?_
    simp only [inc, sum_filter]
  calc ∑ i, (a (f i) + a (g i)) ^ 2 ≤ ∑ i, (G i (f i) + G i (g i)) := sum_le_sum fun i _ => edge i
    _ = ∑ u, ∑ i ∈ inc f g u, G i u := regroup
    _ = ∑ u, (∑ i ∈ inc f g u, (1 + (deg f g (other f g i u) : ℝ) / deg f g u)) * a u ^ 2 := by
        simp only [G, sum_mul]
    _ ≤ ∑ u, (if 0 < deg f g u then ((Fintype.card I : ℝ) + 2) * a u ^ 2 else 0) := by
        refine sum_le_sum fun u _ => ?_
        split_ifs with h
        · exact mul_le_mul_of_nonneg_right (load_le f g hfg hpar u) (sq_nonneg _)
        · have : inc f g u = ∅ := card_eq_zero.mp (Nat.eq_zero_of_not_pos h)
          simp [this]
    _ = _ := by rw [← sum_filter, mul_sum]

section counts
/-! ## The arithmetic core of `κ_r ≤ r + 2`, on slot counts

On each block pair `a < b`, `P a b` slots of eigenvalue `(s_a + s_b)²` and `M a b` of `(s_a − s_b)²`
(each at most `2`); on each block `c`, `F c` block-free slots of eigenvalue `s_c²`. If the counts total
at most `r`, the chosen eigenvalues sum to at most `(r + 2) ∑ s²`. -/

variable {k : ℕ}

/-- One block pair: `P x + M y ≤ 2 min(P,M)(s_a² + s_b²) + |P − M| (|s_a| + |s_b|)²`. -/
theorem pair_split (P M : ℕ) (sa sb : ℝ) :
    P * (sa + sb) ^ 2 + M * (sa - sb) ^ 2
      ≤ 2 * (min P M : ℕ) * (sa ^ 2 + sb ^ 2) + ((P : ℤ) - M).natAbs * (|sa| + |sb|) ^ 2 := by
  have hab : sa * sb ≤ |sa| * |sb| := by rw [← abs_mul]; exact le_abs_self _
  have hab' : -(sa * sb) ≤ |sa| * |sb| := by rw [← abs_mul]; exact neg_le_abs _
  have hz : (|sa| + |sb|) ^ 2 = sa ^ 2 + sb ^ 2 + 2 * (|sa| * |sb|) := by
    rw [add_sq, sq_abs, sq_abs]; ring
  have hx : (sa + sb) ^ 2 ≤ (|sa| + |sb|) ^ 2 := by rw [hz]; nlinarith
  have hy : (sa - sb) ^ 2 ≤ (|sa| + |sb|) ^ 2 := by rw [hz]; nlinarith
  have hxy : (sa + sb) ^ 2 + (sa - sb) ^ 2 = 2 * (sa ^ 2 + sb ^ 2) := by ring
  rcases le_total P M with h | h
  · have e : ((P : ℤ) - M).natAbs = M - P := by omega
    rw [min_eq_left h, e, Nat.cast_sub h]
    have hP : (0 : ℝ) ≤ P := Nat.cast_nonneg _
    have hMP : (0 : ℝ) ≤ (M : ℝ) - P := sub_nonneg.mpr (by exact_mod_cast h)
    nlinarith [mul_le_mul_of_nonneg_left hy hMP]
  · have e : ((P : ℤ) - M).natAbs = P - M := by omega
    rw [min_eq_right h, e, Nat.cast_sub h]
    have hPM : (0 : ℝ) ≤ (P : ℝ) - M := sub_nonneg.mpr (by exact_mod_cast h)
    nlinarith [mul_le_mul_of_nonneg_left hx hPM]

/-- The ordered block pairs `a < b`. -/
def pairs (k : ℕ) : Finset (Fin k × Fin k) := univ.filter (fun x => x.1 < x.2)

/-- Regrouping a pair sum by block. -/
theorem pair_regroup (w : Fin k × Fin k → ℝ) (q : Fin k → ℝ) :
    ∑ x ∈ pairs k, w x * (q x.1 + q x.2)
      = ∑ c, q c * ∑ x ∈ (pairs k).filter (fun x => x.1 = c ∨ x.2 = c), w x := by
  have hne : ∀ x ∈ pairs k, x.1 ≠ x.2 := fun x hx => by
    simp only [pairs, mem_filter] at hx; exact hx.2.ne
  have : ∀ x ∈ pairs k, w x * (q x.1 + q x.2)
      = ∑ c, (if x.1 = c ∨ x.2 = c then q c * w x else 0) := by
    intro x hx
    have hs : ∀ c, (if x.1 = c ∨ x.2 = c then q c * w x else 0)
        = (if x.1 = c then q c * w x else 0) + (if x.2 = c then q c * w x else 0) := by
      intro c; by_cases h1 : x.1 = c <;> by_cases h2 : x.2 = c
      · exact absurd (h1.trans h2.symm) (hne x hx)
      all_goals simp [h1, h2]
    simp only [hs, sum_add_distrib, sum_ite_eq, mem_univ, if_true]; ring
  rw [sum_congr rfl this, sum_comm]
  refine sum_congr rfl fun c _ => ?_
  rw [mul_sum, sum_filter]

/-- The leftover edges: `e x` copies of each pair `x`, indexed by `t < e x` in `Fin 2`. -/
def edges (e : Fin k × Fin k → ℕ) : Finset ((Fin k × Fin k) × Fin 2) :=
  univ.filter (fun y => y.1 ∈ pairs k ∧ (y.2 : ℕ) < e y.1)

theorem sum_edges (e : Fin k × Fin k → ℕ) (he : ∀ x, e x ≤ 2) (G : Fin k × Fin k → ℝ) :
    ∑ y ∈ edges e, G y.1 = ∑ x ∈ pairs k, (e x : ℝ) * G x := by
  rw [edges, sum_filter, Fintype.sum_prod_type, pairs, sum_filter]
  refine sum_congr rfl fun x _ => ?_
  rw [Fin.sum_univ_two]
  have hx2 := he x
  by_cases hx : x.1 < x.2
  · simp only [mem_filter, mem_univ, true_and, hx, if_true, Fin.val_zero, Fin.val_one]
    interval_cases h : e x <;> simp <;> ring
  · simp [hx]

theorem card_edges (e : Fin k × Fin k → ℕ) (he : ∀ x, e x ≤ 2) :
    ((edges e).card : ℝ) = ∑ x ∈ pairs k, (e x : ℝ) := by
  have := sum_edges e he (fun _ => 1)
  simp only [mul_one, sum_const, nsmul_eq_mul] at this
  exact this

/-- The leftover edges satisfy `graph_load`'s parallel bound: two edges on one ordered pair at most. -/
theorem edges_par (e : Fin k × Fin k → ℕ) (y : edges e) :
    (par (fun z : edges e => z.1.1.1) (fun z : edges e => z.1.1.2) y).card ≤ 2 := by
  classical
  have hlt : ∀ z : edges e, z.1.1.1 < z.1.1.2 := fun z => by
    have := z.2; simp only [edges, pairs, mem_filter, mem_univ, true_and] at this; exact this.1
  have hsub : ∀ z ∈ par (fun z : edges e => z.1.1.1) (fun z : edges e => z.1.1.2) y, z.1.1 = y.1.1 := by
    intro z hz
    simp only [par, mem_filter, mem_univ, true_and] at hz
    rcases hz with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · exact Prod.ext h1 h2
    · exfalso; have a := hlt z; have b := hlt y; rw [h1, h2] at a; exact absurd (a.trans b) (lt_irrefl _)
  calc _ ≤ (univ : Finset (Fin 2)).card := by
        refine card_le_card_of_injOn (fun z => z.1.2) (fun _ _ => mem_univ _) ?_
        intro z hz w hw hzw
        apply Subtype.ext; apply Prod.ext
        · exact (hsub z hz).trans (hsub w hw).symm
        · exact hzw
    _ = 2 := by simp

/-- **The arithmetic core of `κ_r ≤ r + 2`.** -/
theorem counts_bound (s : Fin k → ℝ) (P M : Fin k × Fin k → ℕ) (F : Fin k → ℕ)
    (hP : ∀ x, P x ≤ 2) (hM : ∀ x, M x ≤ 2) (r : ℕ)
    (hr : ∑ x ∈ pairs k, (P x + M x) + ∑ c, F c ≤ r) :
    ∑ x ∈ pairs k, ((P x : ℝ) * (s x.1 + s x.2) ^ 2 + M x * (s x.1 - s x.2) ^ 2)
      + ∑ c, (F c : ℝ) * s c ^ 2 ≤ (r + 2) * ∑ c, s c ^ 2 := by
  classical
  set e : Fin k × Fin k → ℕ := fun x => ((P x : ℤ) - M x).natAbs with he_def
  set mn : Fin k × Fin k → ℕ := fun x => min (P x) (M x) with hmn_def
  have he : ∀ x, e x ≤ 2 := fun x => by have := hP x; have := hM x; simp only [he_def]; omega
  have key : ∀ x, 2 * mn x + e x = P x + M x := fun x => by simp only [he_def, hmn_def]; omega
  -- each pair splits
  have h1 : ∑ x ∈ pairs k, ((P x : ℝ) * (s x.1 + s x.2) ^ 2 + M x * (s x.1 - s x.2) ^ 2)
      ≤ ∑ x ∈ pairs k, (((2 * mn x : ℕ) : ℝ) * (s x.1 ^ 2 + s x.2 ^ 2))
          + ∑ x ∈ pairs k, (e x : ℝ) * (|s x.1| + |s x.2|) ^ 2 := by
    rw [← sum_add_distrib]
    refine sum_le_sum fun x _ => ?_
    have := pair_split (P x) (M x) (s x.1) (s x.2)
    simp only [hmn_def, he_def]; push_cast at this ⊢; linarith
  -- the leftovers through graph_load
  have hsq : ∀ c, |s c| ^ 2 = s c ^ 2 := fun c => sq_abs _
  have hg : ∑ x ∈ pairs k, (e x : ℝ) * (|s x.1| + |s x.2|) ^ 2
      ≤ ((edges e).card + 2) * ∑ c, s c ^ 2 := by
    rw [← sum_edges e he (fun x => (|s x.1| + |s x.2|) ^ 2)]
    have hfg : ∀ z : edges e, z.1.1.1 ≠ z.1.1.2 := fun z => by
      have := z.2; simp only [edges, pairs, mem_filter, mem_univ, true_and] at this; exact this.1.ne
    have hl := graph_load (fun z : edges e => z.1.1.1) (fun z : edges e => z.1.1.2) hfg
      (edges_par e) (fun c => |s c|)
    rw [Fintype.card_coe] at hl
    have hsub : ∑ u ∈ univ.filter (fun u => 0 < deg (fun z : edges e => z.1.1.1)
        (fun z : edges e => z.1.1.2) u), |s u| ^ 2 ≤ ∑ c, s c ^ 2 := by
      simp only [hsq]
      exact sum_le_sum_of_subset_of_nonneg (subset_univ _) fun _ _ _ => sq_nonneg _
    rw [← sum_coe_sort (edges e)]
    calc _ ≤ _ := hl
      _ ≤ _ := mul_le_mul_of_nonneg_left hsub (by positivity)
  -- regroup the opposite-sign pairs by block
  have hm := pair_regroup (fun x => ((2 * mn x : ℕ) : ℝ)) (fun c => s c ^ 2)
  -- the coefficient of each block, in ℕ
  have hc : ∀ c, (∑ x ∈ (pairs k).filter (fun x => x.1 = c ∨ x.2 = c), 2 * mn x) + F c
      + (edges e).card ≤ r := by
    intro c
    have hcard : (edges e).card = ∑ x ∈ pairs k, e x := by
      have := card_edges e he; exact_mod_cast this
    rw [hcard]
    have s1 := sum_filter_add_sum_filter_not (pairs k) (fun x => x.1 = c ∨ x.2 = c) e
    have s2 := sum_filter_add_sum_filter_not (pairs k) (fun x => x.1 = c ∨ x.2 = c)
      (fun x => P x + M x)
    have s3 : ∑ x ∈ (pairs k).filter (fun x => x.1 = c ∨ x.2 = c), (P x + M x)
        = ∑ x ∈ (pairs k).filter (fun x => x.1 = c ∨ x.2 = c), 2 * mn x
          + ∑ x ∈ (pairs k).filter (fun x => x.1 = c ∨ x.2 = c), e x := by
      rw [← sum_add_distrib]; exact sum_congr rfl fun x _ => (key x).symm
    have s4 : ∑ x ∈ (pairs k).filter (fun x => ¬(x.1 = c ∨ x.2 = c)), e x
        ≤ ∑ x ∈ (pairs k).filter (fun x => ¬(x.1 = c ∨ x.2 = c)), (P x + M x) :=
      sum_le_sum fun x _ => by have := key x; omega
    have s5 : F c ≤ ∑ c', F c' := single_le_sum (fun _ _ => Nat.zero_le _) (mem_univ c)
    omega
  -- assemble
  have hcR : ∀ c, (∑ x ∈ (pairs k).filter (fun x => x.1 = c ∨ x.2 = c), ((2 * mn x : ℕ) : ℝ))
      + F c + (edges e).card ≤ r := fun c => by
    have := hc c; rw [← Nat.cast_sum]; exact_mod_cast this
  calc _ ≤ ∑ x ∈ pairs k, (((2 * mn x : ℕ) : ℝ) * (s x.1 ^ 2 + s x.2 ^ 2))
          + ((edges e).card + 2) * ∑ c, s c ^ 2 + ∑ c, (F c : ℝ) * s c ^ 2 := by
        linarith
    _ = ∑ c, (∑ x ∈ (pairs k).filter (fun x => x.1 = c ∨ x.2 = c), ((2 * mn x : ℕ) : ℝ)
            + F c + ((edges e).card + 2)) * s c ^ 2 := by
        rw [hm, mul_sum]
        simp only [add_mul, sum_add_distrib]
        rw [add_right_comm]; congr 1
        · congr 1; exact sum_congr rfl fun c _ => by ring
    _ ≤ ∑ c, ((r : ℝ) + 2) * s c ^ 2 := by
        refine sum_le_sum fun c _ => mul_le_mul_of_nonneg_right ?_ (sq_nonneg _)
        linarith [hcR c]
    _ = _ := by rw [mul_sum]

end counts

end HamiltonsCubic.L237GraphLoad
