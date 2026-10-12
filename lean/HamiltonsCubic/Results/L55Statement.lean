import Mathlib

set_option linter.style.longLine false

/-!
# L55, the min-entry bound, stated and proved, with its extremisers

**The record's statement, quoted verbatim from [diagonal-half.md](../../../findings/diagonal-half.md):**

> Let $K$ be hollow, symmetric, with zero row sums and $\|K\|_F^2=t$. Then
> $$\Big|\min_{a\ne b}K_{ab}\Big|\;\ge\;\sqrt{\frac t{n(n-1)(n-2)}},$$
> and for even $n$ the bound is attained, the extremizers being exactly the perfect matchings: $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere.

Two of that block's own audit notes are honoured here rather than paraphrased.

**Symmetry is never used for the inequality**, so `frobenius_le` and `min_entry_bound` take
hollowness and vanishing row sums alone; `min_entry_bound_symm` restates the result with the
symmetry hypothesis the record's display carries, so the record's sentence appears as a theorem
in its own words.

**The extremiser needs `c > 0`**, which the record's display omits and its audit note supplies:
at `c < 0` the minimum entry is `(n-2)c` and the bound is missed by a factor `n-2`. `matching`
carries `0 < c` as a hypothesis for exactly that reason.

**`t` is the ordered-pair sum** (`∑ a, ∑ b, K a b ^ 2` over all ordered `(a,b)`) which is what
makes the constant `n(n-1)(n-2)` rather than half of it.

Everything below is proved; there is no `sorry`. **The uniqueness half of "exactly" is proved too**:
at equality with `m > 0` every off-diagonal entry is `-m` or `(n-2)m` (`entries_extreme`, the
row step's slack vanishing), each row has exactly one entry `(n-2)m` (`unique_large`, from the zero
row sum), symmetry makes the row-to-large-entry map a fixed-point-free involution
(`extremiser_is_matching`), and such an involution exists only at even `n` (`even_of_matching`).
**Symmetry is used only there**, and it is needed: a non-symmetric cyclic matrix attains equality
with no involution.
-/

namespace HamiltonsCubic.L55Statement

open Finset

variable {n : ℕ}

/-- The record's hypothesis set for the inequality: hollow, with vanishing row sums. Symmetry is
absent because the derivation reads rows only. -/
structure IsHollowZeroRow (K : Matrix (Fin n) (Fin n) ℝ) : Prop where
  hollow : ∀ a, K a a = 0
  rowsum : ∀ a, ∑ b, K a b = 0

/-! ## The row step -/

/-- **Every off-diagonal entry is at most `(n-2)m`**, given that `-m` is a lower bound: the row's
`n-1` off-diagonal entries sum to zero, so one of them is at most the negative of the other
`n-2`. -/
theorem entry_le {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsHollowZeroRow K) {m : ℝ}
    (hm : ∀ a b, -m ≤ K a b) (a b : Fin n) (hab : a ≠ b) :
    K a b ≤ ((n : ℝ) - 2) * m := by
  classical
  have hn2 : 2 ≤ n := by
    by_contra h
    interval_cases n
    · exact (Fin.elim0 a)
    · exact hab (Subsingleton.elim a b)
  have hcard : ((univ.erase a).erase b).card = n - 2 := by
    rw [card_erase_of_mem (by simp [hab.symm]), card_erase_of_mem (mem_univ a),
      card_univ, Fintype.card_fin]
    omega
  have hsplit : K a b + ∑ c ∈ (univ.erase a).erase b, K a c = 0 := by
    have h1 : ∑ c ∈ univ.erase a, K a c = 0 := by
      have := hK.rowsum a
      rwa [← Finset.add_sum_erase _ _ (mem_univ a), hK.hollow a, zero_add] at this
    rwa [← Finset.add_sum_erase _ _ (show b ∈ univ.erase a by simp [hab.symm])] at h1
  have hlow : -(((n : ℝ) - 2) * m) ≤ ∑ c ∈ (univ.erase a).erase b, K a c := by
    have hsum : ∑ _c ∈ (univ.erase a).erase b, (-m) ≤ ∑ c ∈ (univ.erase a).erase b, K a c :=
      Finset.sum_le_sum fun c _ => hm a c
    rw [Finset.sum_const, nsmul_eq_mul, hcard] at hsum
    have hcast : ((n - 2 : ℕ) : ℝ) = (n : ℝ) - 2 := by
      push_cast [Nat.cast_sub hn2]; ring
    rw [hcast] at hsum
    linarith
  linarith

/-- **The row bound**: with `-m` a lower bound on the entries, the squared row norm off the
diagonal is at most `(n-1)(n-2)m²`. The row polytope's convex functional is maximised at an
extreme point, which is the pointwise inequality `x² ≤ (n-3)mx + (n-2)m²` used here. -/
theorem row_bound {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsHollowZeroRow K) {m : ℝ}
    (hm : ∀ a b, -m ≤ K a b) (a : Fin n) :
    ∑ b ∈ univ.erase a, K a b ^ 2 ≤ ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
  classical
  have hn1 : 1 ≤ n := Fin.pos a
  have hzero : ∑ b ∈ univ.erase a, K a b = 0 := by
    have := hK.rowsum a
    rwa [← Finset.add_sum_erase _ _ (mem_univ a), hK.hollow a, zero_add] at this
  have hcard : (univ.erase a).card = n - 1 := by
    rw [card_erase_of_mem (mem_univ a), card_univ, Fintype.card_fin]
  have hcast : (((n - 1 : ℕ)) : ℝ) = (n : ℝ) - 1 := by push_cast [Nat.cast_sub hn1]; ring
  have hstep : ∀ b ∈ univ.erase a,
      K a b ^ 2 ≤ ((n : ℝ) - 3) * m * K a b + ((n : ℝ) - 2) * m ^ 2 := by
    intro b hb
    have hab : a ≠ b := (Finset.ne_of_mem_erase hb).symm
    have h1 : -m ≤ K a b := hm a b
    have h2 : K a b ≤ ((n : ℝ) - 2) * m := entry_le hK hm a b hab
    nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ K a b + m) (by linarith : (0:ℝ) ≤ ((n:ℝ) - 2) * m - K a b)]
  calc ∑ b ∈ univ.erase a, K a b ^ 2
      ≤ ∑ b ∈ univ.erase a, (((n : ℝ) - 3) * m * K a b + ((n : ℝ) - 2) * m ^ 2) :=
        Finset.sum_le_sum hstep
    _ = ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
        rw [Finset.sum_add_distrib, ← Finset.mul_sum, hzero, Finset.sum_const, hcard,
          nsmul_eq_mul, hcast]
        ring

/-! ## The bound -/

/-- **The Frobenius sum is at most `n(n-1)(n-2)m²`**, the record's display, cleared of its square
root. `t = ∑ a, ∑ b, K a b ^ 2` is the ordered-pair sum. -/
theorem frobenius_le {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsHollowZeroRow K) {m : ℝ}
    (hm0 : 0 ≤ m) (hm : ∀ a b, -m ≤ K a b) :
    ∑ a, ∑ b, K a b ^ 2 ≤ (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
  classical
  have hrow : ∀ a : Fin n, ∑ b, K a b ^ 2 ≤ ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
    intro a
    have h := row_bound hK hm a
    have : ∑ b, K a b ^ 2 = ∑ b ∈ univ.erase a, K a b ^ 2 := by
      rw [← Finset.add_sum_erase _ _ (mem_univ a), hK.hollow a]
      ring
    rw [this]; exact h
  calc ∑ a, ∑ b, K a b ^ 2
      ≤ ∑ _a : Fin n, ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := Finset.sum_le_sum fun a _ => hrow a
    _ = (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
        rw [Finset.sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul]; ring

/-- **The record's display**: any lower bound `-m` on the entries satisfies
`m ≥ √(t/(n(n-1)(n-2)))`. Taking `m = |min_{a≠b} K_ab|`, which is a lower bound, since the row
sums put the minimum at or below zero, gives the sentence as written. -/
theorem min_entry_bound {K : Matrix (Fin n) (Fin n) ℝ} (hn : 3 ≤ n) (hK : IsHollowZeroRow K)
    {m t : ℝ} (hm0 : 0 ≤ m) (hm : ∀ a b, -m ≤ K a b) (ht : ∑ a, ∑ b, K a b ^ 2 = t) :
    Real.sqrt (t / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2))) ≤ m := by
  have hn3 : (3 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hpos : (0 : ℝ) < (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) :=
    mul_pos (mul_pos (by linarith) (by linarith)) (by linarith)
  have hle : t ≤ (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := ht ▸ frobenius_le hK hm0 hm
  have : t / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2)) ≤ m ^ 2 := by
    rw [div_le_iff₀ hpos]; nlinarith [hle]
  calc Real.sqrt (t / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2)))
      ≤ Real.sqrt (m ^ 2) := Real.sqrt_le_sqrt this
    _ = m := by rw [Real.sqrt_sq hm0]

/-- **The record's sentence with its symmetry hypothesis restored.** Symmetry is inert for the
inequality, so this is `min_entry_bound` with an unused hypothesis, which is exactly the audit
note's point. -/
theorem min_entry_bound_symm {K : Matrix (Fin n) (Fin n) ℝ} (hn : 3 ≤ n)
    (hsymm : ∀ a b, K a b = K b a) (hhollow : ∀ a, K a a = 0) (hrow : ∀ a, ∑ b, K a b = 0)
    {m t : ℝ} (hm0 : 0 ≤ m) (hm : ∀ a b, -m ≤ K a b) (ht : ∑ a, ∑ b, K a b ^ 2 = t) :
    Real.sqrt (t / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2))) ≤ m :=
  min_entry_bound hn ⟨hhollow, hrow⟩ hm0 hm ht

/-! ## Attainment: the perfect matchings -/

/-- The record's extremiser: `(n-2)c` on a fixed-point-free involution `σ`, `-c` off it, `0` on
the diagonal. -/
noncomputable def matching (σ : Fin n → Fin n) (c : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  fun a b => if b = σ a then ((n : ℝ) - 2) * c else if b = a then 0 else -c

variable {σ : Fin n → Fin n} {c : ℝ}

/-- **The matching matrix is hollow with vanishing row sums**, so it satisfies the lemma's
hypotheses. -/
theorem matching_hollowZeroRow (hn : 3 ≤ n) (hinv : ∀ a, σ (σ a) = a) (hfix : ∀ a, σ a ≠ a) :
    IsHollowZeroRow (matching σ c) := by
  classical
  have hn1 : 1 ≤ n := by omega
  refine ⟨fun a => ?_, fun a => ?_⟩
  · simp [matching, (hfix a).symm]
  · have hne : σ a ≠ a := hfix a
    have hsplit : ∑ b, matching σ c a b
        = matching σ c a (σ a) + matching σ c a a
          + ∑ b ∈ (univ.erase (σ a)).erase a, matching σ c a b := by
      rw [← Finset.add_sum_erase _ _ (mem_univ (σ a)),
        ← Finset.add_sum_erase _ _ (show a ∈ univ.erase (σ a) by simp [hne.symm])]
      ring
    have hother : ∀ b ∈ (univ.erase (σ a)).erase a, matching σ c a b = -c := by
      intro b hb
      have h1 : b ≠ a := Finset.ne_of_mem_erase hb
      have h2 : b ≠ σ a := Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hb)
      simp [matching, h1, h2]
    have hcard : ((univ.erase (σ a)).erase a).card = n - 2 := by
      rw [card_erase_of_mem (by simp [hne.symm]), card_erase_of_mem (mem_univ (σ a)),
        card_univ, Fintype.card_fin]
      omega
    have hcast : (((n - 2 : ℕ)) : ℝ) = (n : ℝ) - 2 := by
      push_cast [Nat.cast_sub (by omega : 2 ≤ n)]; ring
    rw [hsplit, Finset.sum_congr rfl hother, Finset.sum_const, hcard, nsmul_eq_mul, hcast]
    simp [matching, hne.symm]
    try ring

/-- **Its Frobenius sum is exactly `n(n-1)(n-2)c²`**, the value at which the bound is tight. -/
theorem matching_frobenius (hn : 3 ≤ n) (hinv : ∀ a, σ (σ a) = a) (hfix : ∀ a, σ a ≠ a) :
    ∑ a, ∑ b, matching σ c a b ^ 2
      = (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * c ^ 2 := by
  classical
  have hrow : ∀ a : Fin n, ∑ b, matching σ c a b ^ 2
      = ((n : ℝ) - 1) * ((n : ℝ) - 2) * c ^ 2 := by
    intro a
    have hne : σ a ≠ a := hfix a
    have hsplit : ∑ b, matching σ c a b ^ 2
        = matching σ c a (σ a) ^ 2 + matching σ c a a ^ 2
          + ∑ b ∈ (univ.erase (σ a)).erase a, matching σ c a b ^ 2 := by
      rw [← Finset.add_sum_erase _ _ (mem_univ (σ a)),
        ← Finset.add_sum_erase _ _ (show a ∈ univ.erase (σ a) by simp [hne.symm])]
      ring
    have hother : ∀ b ∈ (univ.erase (σ a)).erase a, matching σ c a b ^ 2 = c ^ 2 := by
      intro b hb
      have h1 : b ≠ a := Finset.ne_of_mem_erase hb
      have h2 : b ≠ σ a := Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hb)
      simp [matching, h1, h2]
    have hcard : ((univ.erase (σ a)).erase a).card = n - 2 := by
      rw [card_erase_of_mem (by simp [hne.symm]), card_erase_of_mem (mem_univ (σ a)),
        card_univ, Fintype.card_fin]
      omega
    have hcast : (((n - 2 : ℕ)) : ℝ) = (n : ℝ) - 2 := by
      push_cast [Nat.cast_sub (by omega : 2 ≤ n)]; ring
    rw [hsplit, Finset.sum_congr rfl hother, Finset.sum_const, hcard, nsmul_eq_mul, hcast]
    simp [matching, hne.symm]
    try ring
  calc ∑ a, ∑ b, matching σ c a b ^ 2
      = ∑ _a : Fin n, ((n : ℝ) - 1) * ((n : ℝ) - 2) * c ^ 2 := Finset.sum_congr rfl fun a _ => hrow a
    _ = (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * c ^ 2 := by
        rw [Finset.sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul]; ring

/-- **At `c > 0` the minimum entry is `-c`**, so `|min| = c` and the bound is attained with
equality. **`0 < c` is load-bearing**: at `c < 0` the minimum is `(n-2)c` instead and the bound
is missed by a factor `n-2`. -/
theorem matching_min (hn : 3 ≤ n) (hc : 0 < c) (a b : Fin n) : -c ≤ matching σ c a b := by
  have hn2 : (2 : ℝ) ≤ (n : ℝ) := by exact_mod_cast (by omega : 2 ≤ n)
  unfold matching
  split_ifs <;> nlinarith

/-- **Equality**: at the matching with `c > 0`, `√(t/(n(n-1)(n-2))) = c`, which is `|min|`. -/
theorem matching_equality (hn : 3 ≤ n) (hinv : ∀ a, σ (σ a) = a) (hfix : ∀ a, σ a ≠ a)
    (hc : 0 < c) :
    Real.sqrt ((∑ a, ∑ b, matching σ c a b ^ 2)
      / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2))) = c := by
  have hn3 : (3 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hpos : (0 : ℝ) < (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) :=
    mul_pos (mul_pos (by linarith) (by linarith)) (by linarith)
  have h0 : (n : ℝ) ≠ 0 := by linarith
  have h1 : ((n : ℝ) - 1) ≠ 0 := by linarith
  have h2 : ((n : ℝ) - 2) ≠ 0 := by linarith
  rw [matching_frobenius hn hinv hfix]
  rw [show (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * c ^ 2
      / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2)) = c ^ 2 by field_simp]
  exact Real.sqrt_sq hc.le

/-- **The extremiser hypotheses are not empty**: at `n = 4` the swap `(0 1)(2 3)` is a
fixed-point-free involution. A fixed-point-free involution exists exactly for even `n`, which is
where the record's *"for even `n` the bound is attained"* comes from. -/
example : ∃ σ : Fin 4 → Fin 4, (∀ a, σ (σ a) = a) ∧ (∀ a, σ a ≠ a) := by
  refine ⟨![1, 0, 3, 2], ?_, ?_⟩ <;> decide

/-! ## The equality case -/

/-- At equality every off-diagonal entry is `-m` or `(n-2)m`. -/
theorem entries_extreme {K : Matrix (Fin n) (Fin n) ℝ} (hn : 3 ≤ n) (hK : IsHollowZeroRow K)
    {m : ℝ} (hm0 : 0 ≤ m) (hm : ∀ a b, -m ≤ K a b)
    (heq : ∑ a, ∑ b, K a b ^ 2 = (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2) (a b : Fin n) (hab : a ≠ b) :
    K a b = -m ∨ K a b = ((n : ℝ) - 2) * m := by
  classical
  -- the slack of each term is nonnegative and the slacks sum to zero
  set g : Fin n → Fin n → ℝ := fun a b => (K a b + m) * (((n : ℝ) - 2) * m - K a b) with hg
  have hgnn : ∀ a b, a ≠ b → 0 ≤ g a b := fun a b h =>
    mul_nonneg (by linarith [hm a b]) (by linarith [entry_le hK hm a b h])
  have hrowsum : ∀ a, ∑ b ∈ univ.erase a, K a b = 0 := fun a => by
    have := hK.rowsum a
    rwa [← Finset.add_sum_erase _ _ (mem_univ a), hK.hollow a, zero_add] at this
  have hn1 : 1 ≤ n := by omega
  have hcard : ∀ a : Fin n, (univ.erase a).card = n - 1 := fun a => by
    rw [card_erase_of_mem (mem_univ a), card_univ, Fintype.card_fin]
  have hcast : (((n - 1 : ℕ)) : ℝ) = (n : ℝ) - 1 := by push_cast [Nat.cast_sub hn1]; ring
  have hgrow : ∀ a, ∑ b ∈ univ.erase a, g a b
      = ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 - ∑ b ∈ univ.erase a, K a b ^ 2 := fun a => by
    have : ∀ b ∈ univ.erase a, g a b = ((n : ℝ) - 3) * m * K a b + ((n : ℝ) - 2) * m ^ 2 - K a b ^ 2 :=
      fun b _ => by simp only [hg]; ring
    rw [Finset.sum_congr rfl this, Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum,
      hrowsum a, Finset.sum_const, hcard a, nsmul_eq_mul, hcast]
    ring
  have hfull : ∀ a, ∑ b, K a b ^ 2 = ∑ b ∈ univ.erase a, K a b ^ 2 := fun a => by
    rw [← Finset.add_sum_erase _ _ (mem_univ a), hK.hollow a]; ring
  have htot : ∑ a, ∑ b ∈ univ.erase a, g a b = 0 := by
    simp only [hgrow, Finset.sum_sub_distrib, ← hfull, heq, Finset.sum_const, card_univ,
      Fintype.card_fin, nsmul_eq_mul]
    ring
  have hrow0 := (Finset.sum_eq_zero_iff_of_nonneg fun a _ =>
    Finset.sum_nonneg fun b hb => hgnn a b (Finset.ne_of_mem_erase hb).symm).mp htot a (mem_univ a)
  have h0 := (Finset.sum_eq_zero_iff_of_nonneg fun b hb =>
    hgnn a b (Finset.ne_of_mem_erase hb).symm).mp hrow0 b (by simp [hab.symm])
  simp only [hg] at h0
  rcases mul_eq_zero.mp h0 with h | h
  · left; linarith
  · right; linarith

/-- At equality with `m > 0`, each row has exactly one entry `(n-2)m`. -/
theorem unique_large {K : Matrix (Fin n) (Fin n) ℝ} (hn : 3 ≤ n) (hK : IsHollowZeroRow K)
    {m : ℝ} (hm0 : 0 < m) (hm : ∀ a b, -m ≤ K a b)
    (heq : ∑ a, ∑ b, K a b ^ 2 = (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2) (a : Fin n) :
    ∃ b, ((univ.erase a).filter fun b => K a b = ((n : ℝ) - 2) * m) = {b} := by
  classical
  have hn3 : (3 : ℝ) ≤ n := by exact_mod_cast hn
  have hn1 : 1 ≤ n := by omega
  have hcard : (univ.erase a).card = n - 1 := by
    rw [card_erase_of_mem (mem_univ a), card_univ, Fintype.card_fin]
  have hcast : (((n - 1 : ℕ)) : ℝ) = (n : ℝ) - 1 := by push_cast [Nat.cast_sub hn1]; ring
  have hrowsum : ∑ b ∈ univ.erase a, K a b = 0 := by
    have := hK.rowsum a
    rwa [← Finset.add_sum_erase _ _ (mem_univ a), hK.hollow a, zero_add] at this
  have hterm : ∀ b ∈ univ.erase a, K a b + m
      = if K a b = ((n : ℝ) - 2) * m then ((n : ℝ) - 1) * m else 0 := by
    intro b hb
    have hab : a ≠ b := (Finset.ne_of_mem_erase hb).symm
    rcases entries_extreme hn hK hm0.le hm heq a b hab with h | h
    · rw [if_neg]
      · linarith
      · intro h'; nlinarith
    · rw [if_pos h, h]; ring
  have hsum1 : ∑ b ∈ univ.erase a, (K a b + m) = ((n : ℝ) - 1) * m := by
    rw [Finset.sum_add_distrib, hrowsum, Finset.sum_const, hcard, nsmul_eq_mul, hcast]; ring
  have hsum2 : ∑ b ∈ univ.erase a, (K a b + m)
      = (((univ.erase a).filter fun b => K a b = ((n : ℝ) - 2) * m).card : ℝ) * (((n : ℝ) - 1) * m) := by
    rw [Finset.sum_congr rfl hterm, Finset.sum_ite, Finset.sum_const_zero, add_zero, Finset.sum_const,
      nsmul_eq_mul]
  have hpos : 0 < ((n : ℝ) - 1) * m := mul_pos (by linarith) hm0
  have hc : (((univ.erase a).filter fun b => K a b = ((n : ℝ) - 2) * m).card : ℝ) = 1 := by
    have := hsum1.symm.trans hsum2
    field_simp at this
    nlinarith
  exact Finset.card_eq_one.mp (by exact_mod_cast hc)

/-- **The equality case: a perfect matching.** -/
theorem extremiser_is_matching {K : Matrix (Fin n) (Fin n) ℝ} (hn : 3 ≤ n) (hK : IsHollowZeroRow K)
    (hsym : ∀ a b, K a b = K b a) {m : ℝ} (hm0 : 0 < m) (hm : ∀ a b, -m ≤ K a b)
    (heq : ∑ a, ∑ b, K a b ^ 2 = (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2) :
    ∃ σ : Equiv.Perm (Fin n), (∀ a, σ a ≠ a) ∧ (∀ a, σ (σ a) = a) ∧
      ∀ a b, b ≠ a → K a b = if b = σ a then ((n : ℝ) - 2) * m else -m := by
  classical
  have hn3 : (3 : ℝ) ≤ n := by exact_mod_cast hn
  choose f hf using unique_large hn hK hm0 hm heq
  have hmem : ∀ a b, (b ∈ (univ.erase a).filter fun b => K a b = ((n : ℝ) - 2) * m) ↔ b = f a :=
    fun a b => by rw [hf a, Finset.mem_singleton]
  have hfa : ∀ a, f a ≠ a ∧ K a (f a) = ((n : ℝ) - 2) * m := fun a => by
    have := (hmem a (f a)).mpr rfl
    simp only [Finset.mem_filter, Finset.mem_erase, Finset.mem_univ, and_true] at this
    exact this
  have hinv : ∀ a, f (f a) = a := fun a => by
    have h1 : a ∈ (univ.erase (f a)).filter fun b => K (f a) b = ((n : ℝ) - 2) * m := by
      simp only [Finset.mem_filter, Finset.mem_erase, Finset.mem_univ, and_true]
      exact ⟨(hfa a).1.symm, by rw [hsym]; exact (hfa a).2⟩
    exact ((hmem (f a) a).mp h1).symm
  have hinvol : Function.Involutive f := hinv
  refine ⟨hinvol.toPerm f, fun a => (hfa a).1, hinv, fun a b hba => ?_⟩
  simp only [Function.Involutive.coe_toPerm]
  by_cases hb : b = f a
  · subst hb; simpa using (hfa a).2
  · rcases entries_extreme hn hK hm0.le hm heq a b (Ne.symm hba) with h | h
    · simpa [hb] using h
    · exfalso; apply hb
      apply (hmem a b).mp
      simp only [Finset.mem_filter, Finset.mem_erase, Finset.mem_univ, and_true]
      exact ⟨hba, h⟩

/-- **A fixed-point-free involution exists only at even `n`.** -/
theorem even_of_matching (σ : Equiv.Perm (Fin n)) (hfp : ∀ a, σ a ≠ a) (hinv : ∀ a, σ (σ a) = a) :
    Even n := by
  classical
  let f : Function.End (Fin n) := ⇑σ
  have h2 : f ^ 2 ^ 1 = 1 := by
    funext a
    rw [pow_one, pow_two]
    exact hinv a
  have hp : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have hmod := Equiv.Perm.card_fixedPoints_modEq (f := f) (p := 2) (n := 1) h2
  have hfix : Fintype.card (Function.fixedPoints f) = 0 := by
    rw [Fintype.card_eq_zero_iff]
    exact ⟨fun ⟨a, ha⟩ => hfp a ha⟩
  rw [hfix, Fintype.card_fin] at hmod
  exact Nat.even_iff.mpr hmod


#print axioms HamiltonsCubic.L55Statement.extremiser_is_matching
#print axioms HamiltonsCubic.L55Statement.even_of_matching
