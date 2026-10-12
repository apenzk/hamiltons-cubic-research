import HamiltonsCubic.Results.L173Statement

set_option linter.style.longLine false

/-!
# L173's lift: the value-type system is the index-level system

[L173Statement.lean](L173Statement.lean) checks L173's witness on the ten value-type variables `t_{ijk}`, with
the reduced relations weighted by `w_{ijk}`, `μ_j μ_k` off the diagonal and `μ_j(μ_j - 1)` on it. **The owed step
is that the reduced system is the index-level one**: lift `t` to a tensor on `N` indices by class, zero on
repeated indices, and its row sums over ordered pairs are the reduced sums.

* **`pair_count`**: for any class map `cls : Fin N → Fin 3` and any `f`, the sum of `f(cls q, cls r)` over
  ordered pairs `(q, r)` of distinct indices both distinct from `p` is `Σ_{j,k} w_{jk}(p) f(j,k)`, with
  `w` the reduced weight at the class of `p` and the class sizes `m_j`;
* **`lift_row`**: so each index-level row sum of the lifted tensor is the value-type row sum;
* **`tLift_symm`**, **`tLift_hollow`**, **`tLift_nonneg`**: the lift of a totally symmetric nonnegative `t` is
  totally symmetric, hollow and nonnegative, the three properties L173's statement asks of `T`;
* **`sym_weight`**: for such a lift the symmetric weight `(ν_q + ν_r)/2` and the one-sided `ν_q` give the same row
  sum, so (B) reads as the record's `Σ_{β,γ} λ_β T_{kβγ}`;
* **`witness_index_level`**, **`witness_B_one_sided`**, **`witness_cap`**: L173's witness, lifted to the `66`
  pair indices by the class map `clsW` of sizes `(4, 3, 59)`, satisfies (A), (B), (C) at every row, (B) also
  in its one-sided form, and the pair cap at every pair.

**The direction**: this lifts a value-type solution to an index-level one, which is what L173's existence
claim needs. The converse, that every index-level solution reduces to value types, is L104's reduction and is
not what this file proves.
-/

namespace HamiltonsCubic.L173Statement

open Finset

variable {N : ℕ} (cls : Fin N → Fin 3)

/-- The class sizes. -/
def msz (j : Fin 3) : ℚ := ((univ.filter fun q => cls q = j).card : ℚ)

/-- `μ_j = m_j - δ_{ij}` at the class `i` of the row. -/
def muC (i j : Fin 3) : ℚ := msz cls j - if j = i then 1 else 0

/-- The reduced weight at class `i`. -/
def wC (i j k : Fin 3) : ℚ := if j = k then muC cls i j * (muC cls i j - 1) else muC cls i j * muC cls i k

theorem msz_eq (j : Fin 3) : msz cls j = ∑ q, if cls q = j then (1 : ℚ) else 0 := by
  unfold msz; rw [Finset.sum_boole]

/-- Distinct from `p` and `q`, in class `k`: `m_k - [cls p = k] - [cls q = k]` when `q ≠ p`. -/
theorem inner_count (p q : Fin N) (hq : q ≠ p) (k : Fin 3) :
    (∑ r, if r ≠ p ∧ q ≠ r ∧ cls r = k then (1 : ℚ) else 0)
      = msz cls k - (if cls p = k then 1 else 0) - (if cls q = k then 1 else 0) := by
  have hpt : ∀ r, (if r ≠ p ∧ q ≠ r ∧ cls r = k then (1 : ℚ) else 0)
      = (if cls r = k then 1 else 0) - (if r = p then (if cls p = k then 1 else 0) else 0)
        - (if r = q then (if cls q = k then 1 else 0) else 0) := fun r => by
    by_cases h1 : r = p
    · subst h1; simp [Ne.symm hq]
    · by_cases h2 : r = q
      · subst h2; simp [h1]
      · simp [h1, h2, Ne.symm h2]
  simp only [hpt, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true, msz_eq]

/-- The count of ordered pairs of distinct indices, both distinct from `p`, in classes `j` and `k`. -/
theorem pair_count_jk (p : Fin N) (j k : Fin 3) :
    (∑ q, ∑ r, if q ≠ p ∧ r ≠ p ∧ q ≠ r ∧ cls q = j ∧ cls r = k then (1 : ℚ) else 0)
      = wC cls (cls p) j k := by
  have hq : ∀ q, (∑ r, if q ≠ p ∧ r ≠ p ∧ q ≠ r ∧ cls q = j ∧ cls r = k then (1 : ℚ) else 0)
      = if q ≠ p ∧ cls q = j then msz cls k - (if cls p = k then 1 else 0) - (if j = k then 1 else 0) else 0 := by
    intro q
    by_cases h : q ≠ p ∧ cls q = j
    · have hi := inner_count cls p q h.1 k
      rw [h.2] at hi
      rw [if_pos h, ← hi]
      refine Finset.sum_congr rfl fun r _ => ?_
      by_cases h' : r ≠ p ∧ q ≠ r ∧ cls r = k
      · rw [if_pos h', if_pos ⟨h.1, h'.1, h'.2.1, h.2, h'.2.2⟩]
      · rw [if_neg h', if_neg]; tauto
    · rw [if_neg h]
      exact Finset.sum_eq_zero fun r _ => by rw [if_neg]; tauto
  simp only [hq]
  have hsplit : ∀ q, (if q ≠ p ∧ cls q = j then msz cls k - (if cls p = k then 1 else 0) - (if j = k then (1 : ℚ) else 0) else 0)
      = ((if cls q = j then 1 else 0) - (if q = p then (if cls p = j then 1 else 0) else 0))
        * (msz cls k - (if cls p = k then 1 else 0) - (if j = k then 1 else 0)) := fun q => by
    by_cases h1 : q = p
    · subst h1; by_cases h2 : cls q = j <;> simp [h2]
    · by_cases h2 : cls q = j <;> simp [h1, h2]
  simp only [hsplit, ← Finset.sum_mul, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true,
    ← msz_eq]
  unfold wC muC
  simp only [eq_comm (a := cls p)]
  by_cases hjk : j = k
  · subst hjk; simp only [if_true]
  · simp only [hjk, if_false, sub_zero]

/-- **The pair count**: summing `f(cls q, cls r)` over ordered pairs of distinct indices, both distinct from
`p`, reproduces the reduced weight. -/
theorem pair_count (p : Fin N) (f : Fin 3 → Fin 3 → ℚ) :
    (∑ q, ∑ r, if q ≠ p ∧ r ≠ p ∧ q ≠ r then f (cls q) (cls r) else 0)
      = ∑ j, ∑ k, wC cls (cls p) j k * f j k := by
  have hpt : ∀ q r, (if q ≠ p ∧ r ≠ p ∧ q ≠ r then f (cls q) (cls r) else 0)
      = ∑ j, ∑ k, f j k * (if q ≠ p ∧ r ≠ p ∧ q ≠ r ∧ cls q = j ∧ cls r = k then (1 : ℚ) else 0) := by
    intro q r
    rw [Finset.sum_eq_single (cls q) (fun j _ hj => Finset.sum_eq_zero fun k _ => by
        rw [if_neg (fun h => hj h.2.2.2.1.symm), mul_zero]) (by simp)]
    rw [Finset.sum_eq_single (cls r) (fun k _ hk => by rw [if_neg (fun h => hk h.2.2.2.2.symm), mul_zero])
      (by simp)]
    by_cases h : q ≠ p ∧ r ≠ p ∧ q ≠ r
    · rw [if_pos h, if_pos ⟨h.1, h.2.1, h.2.2, rfl, rfl⟩, mul_one]
    · rw [if_neg h, if_neg (fun h' => h ⟨h'.1, h'.2.1, h'.2.2.1⟩), mul_zero]
  simp only [hpt]
  have sw : ∀ g : Fin N → Fin N → Fin 3 → Fin 3 → ℚ,
      ∑ q, ∑ r, ∑ j, ∑ k, g q r j k = ∑ j, ∑ k, ∑ q, ∑ r, g q r j k := by
    intro g
    calc ∑ q, ∑ r, ∑ j, ∑ k, g q r j k = ∑ q, ∑ j, ∑ k, ∑ r, g q r j k := by
          refine Finset.sum_congr rfl fun q _ => ?_
          rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun j _ => Finset.sum_comm
      _ = ∑ j, ∑ k, ∑ q, ∑ r, g q r j k := by
          rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun j _ => Finset.sum_comm
  rw [sw]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
  simp only [← Finset.mul_sum]
  rw [pair_count_jk, mul_comm]

/-- **The lift**: the value-type tensor `t` on `N` indices by class, zero on repeated indices. -/
def tLift (t : Fin 3 → Fin 3 → Fin 3 → ℚ) (p q r : Fin N) : ℚ :=
  if q ≠ p ∧ r ≠ p ∧ q ≠ r then t (cls p) (cls q) (cls r) else 0

/-- **Each index-level row sum of the lift is the value-type row sum**: for any class-level weight `g`,
`Σ_{q,r} tLift(p,q,r) g(cls q, cls r) = Σ_{j,k} w_{jk} t_{cls p, j, k} g(j, k)`. -/
theorem lift_row (t : Fin 3 → Fin 3 → Fin 3 → ℚ) (g : Fin 3 → Fin 3 → ℚ) (p : Fin N) :
    (∑ q, ∑ r, tLift cls t p q r * g (cls q) (cls r))
      = ∑ j, ∑ k, wC cls (cls p) j k * (t (cls p) j k * g j k) := by
  rw [← pair_count cls p (fun j k => t (cls p) j k * g j k)]
  refine Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun r _ => ?_
  unfold tLift
  split_ifs <;> simp

/-- **The lift of a totally symmetric `t` is totally symmetric**: swapping the first two or the last two
indices leaves it unchanged. -/
theorem tLift_symm (t : Fin 3 → Fin 3 → Fin 3 → ℚ) (ht : ∀ i j k, t i j k = t j i k ∧ t i j k = t i k j)
    (p q r : Fin N) : tLift cls t p q r = tLift cls t q p r ∧ tLift cls t p q r = tLift cls t p r q := by
  unfold tLift
  refine ⟨?_, ?_⟩
  · by_cases h : q ≠ p ∧ r ≠ p ∧ q ≠ r
    · rw [if_pos h, if_pos ⟨h.1.symm, h.2.2.symm, h.2.1.symm⟩, (ht _ _ _).1]
    · rw [if_neg h, if_neg fun h' => h ⟨h'.1.symm, h'.2.2.symm, h'.2.1.symm⟩]
  · by_cases h : q ≠ p ∧ r ≠ p ∧ q ≠ r
    · rw [if_pos h, if_pos ⟨h.2.1, h.1, Ne.symm h.2.2⟩, (ht _ _ _).2]
    · rw [if_neg h, if_neg fun h' => h ⟨h'.2.1, h'.1, Ne.symm h'.2.2⟩]

/-- **The lift is hollow**: it vanishes whenever two indices coincide. -/
theorem tLift_hollow (t : Fin 3 → Fin 3 → Fin 3 → ℚ) (p q : Fin N) :
    tLift cls t p p q = 0 ∧ tLift cls t p q p = 0 ∧ tLift cls t q p p = 0 := by
  unfold tLift
  refine ⟨if_neg fun h => h.1 rfl, if_neg fun h => h.2.1 rfl, if_neg fun h => h.2.2 rfl⟩

/-- **The lift of a nonnegative `t` is nonnegative.** -/
theorem tLift_nonneg (t : Fin 3 → Fin 3 → Fin 3 → ℚ) (ht : ∀ i j k, 0 ≤ t i j k) (p q r : Fin N) :
    0 ≤ tLift cls t p q r := by
  unfold tLift; split_ifs
  · exact ht _ _ _
  · exact le_refl 0

/-- **The symmetric weight is the one-sided weight** for a lift symmetric in its last two slots:
`Σ_{q,r} T(p,q,r) (f_q + f_r)/2 = Σ_{q,r} T(p,q,r) f_q`, which is how (B) reads as `Σ_{β,γ} λ_β T_{kβγ}`. -/
theorem sym_weight (t : Fin 3 → Fin 3 → Fin 3 → ℚ) (ht : ∀ i j k, t i j k = t j i k ∧ t i j k = t i k j)
    (f : Fin 3 → ℚ) (p : Fin N) :
    (∑ q, ∑ r, tLift cls t p q r * ((f (cls q) + f (cls r)) / 2)) = ∑ q, ∑ r, tLift cls t p q r * f (cls q) := by
  have hswap : (∑ q, ∑ r, tLift cls t p q r * f (cls r)) = ∑ q, ∑ r, tLift cls t p q r * f (cls q) := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun r _ => by
      rw [(tLift_symm cls t ht p r q).2]
  have e : ∀ q r, tLift cls t p q r * ((f (cls q) + f (cls r)) / 2)
      = (tLift cls t p q r * f (cls q) + tLift cls t p q r * f (cls r)) / 2 := fun q r => by ring
  simp only [e, ← Finset.sum_div, Finset.sum_add_distrib, hswap]
  ring

/-! ## The witness on `66 = C(12,2)` indices -/

/-- The class of each of the `66` pair indices: `4` at `-a`, `3` at `4a/3`, `59` at `0`. -/
def clsW (q : Fin 66) : Fin 3 := if q.val < 4 then 0 else if q.val < 7 then 1 else 2

theorem msz_clsW : msz clsW = m := by
  funext j
  unfold msz m
  fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;> norm_num <;> decide

theorem wC_clsW (i j k : Fin 3) : wC clsW i j k = w i j k := by
  unfold wC muC w mu; rw [msz_clsW]

/-- **L173's witness at the index level**: the lift of `T` to the `66` pair indices satisfies (A), (B) and
(C) at every row, in the scaled variable with `θ' = 7`. -/
theorem witness_index_level (p : Fin 66) :
    (∑ q, ∑ r, tLift clsW T p q r * 1) = 20 ∧
    (∑ q, ∑ r, tLift clsW T p q r * ((nu (clsW q) + nu (clsW r)) / 2)) = -2 * nu (clsW p) ∧
    (∑ q, ∑ r, tLift clsW T p q r * (nu (clsW q) * nu (clsW r))) = 2 * nu (clsW p) * (7 - nu (clsW p)) := by
  refine ⟨?_, ?_, ?_⟩
  · have h := lift_row clsW T (fun _ _ => 1) p
    simp only [wC_clsW] at h
    rw [h, ← relA (clsW p)]; unfold relAlhs
    exact Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => by ring
  · have h := lift_row clsW T (fun j k => (nu j + nu k) / 2) p
    simp only [wC_clsW] at h
    rw [h, ← relB (clsW p)]; unfold relBlhs
    exact Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => by ring
  · have h := lift_row clsW T (fun j k => nu j * nu k) p
    simp only [wC_clsW] at h
    rw [h, ← relC (clsW p)]; unfold relClhs
    exact Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => by ring

/-- **(B) in the record's one-sided form**, `Σ_{q,r} T(p,q,r) ν_q = -2ν_p`, at every row of the lifted witness. -/
theorem witness_B_one_sided (p : Fin 66) :
    (∑ q, ∑ r, tLift clsW T p q r * nu (clsW q)) = -2 * nu (clsW p) := by
  rw [← sym_weight clsW T T_symm nu p]
  exact (witness_index_level p).2.1

/-- **The single count**: summing `f(cls r)` over `r` distinct from `p` and `q ≠ p` gives `Σ_k μ_k^{(pq)} f(k)`. -/
theorem single_count (p q : Fin N) (hq : q ≠ p) (f : Fin 3 → ℚ) :
    (∑ r, if r ≠ p ∧ q ≠ r then f (cls r) else 0)
      = ∑ k, (msz cls k - (if cls p = k then 1 else 0) - (if cls q = k then 1 else 0)) * f k := by
  have hpt : ∀ r, (if r ≠ p ∧ q ≠ r then f (cls r) else 0)
      = ∑ k, f k * (if r ≠ p ∧ q ≠ r ∧ cls r = k then (1 : ℚ) else 0) := fun r => by
    rw [Finset.sum_eq_single (cls r) (fun k _ hk => by rw [if_neg (fun h => hk h.2.2.symm), mul_zero]) (by simp)]
    by_cases h : r ≠ p ∧ q ≠ r
    · rw [if_pos h, if_pos ⟨h.1, h.2, rfl⟩, mul_one]
    · rw [if_neg h, if_neg (fun h' => h ⟨h'.1, h'.2.1⟩), mul_zero]
  simp only [hpt]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.mul_sum, inner_count cls p q hq k, mul_comm]

/-- **The pair cap at the index level**: at distinct indices `p ≠ q`, `Σ_r tLift(p,q,r)` is L173Statement's
`capLhs` at their classes, so every index-level pair cap holds. -/
theorem witness_cap (p q : Fin 66) (hq : q ≠ p) :
    (∑ r, tLift clsW T p q r) = capLhs (clsW p) (clsW q) ∧ (∑ r, tLift clsW T p q r) ≤ 2 := by
  have h : (∑ r, tLift clsW T p q r) = capLhs (clsW p) (clsW q) := by
    have e : ∀ r, tLift clsW T p q r = if r ≠ p ∧ q ≠ r then T (clsW p) (clsW q) (clsW r) else 0 := fun r => by
      unfold tLift
      by_cases h' : r ≠ p ∧ q ≠ r
      · rw [if_pos ⟨hq, h'.1, h'.2⟩, if_pos h']
      · rw [if_neg (fun h'' => h' ⟨h''.2.1, h''.2.2⟩), if_neg h']
    simp only [e]
    rw [single_count clsW p q hq (fun k => T (clsW p) (clsW q) k), msz_clsW]
    unfold capLhs
    refine Finset.sum_congr rfl fun k _ => ?_
    simp only [eq_comm (a := clsW p), eq_comm (a := clsW q)]
  exact ⟨h, h ▸ caps_hold _ _⟩

end HamiltonsCubic.L173Statement
