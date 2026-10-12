# Brief, round L55

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement as the findings file carries it ([findings/diagonal-half.md](../findings/diagonal-half.md) lines 452-456, under the heading at line 436)

Let $K$ be hollow, symmetric, with zero row sums and $\|K\|_F^2=t$. Then
\[
\Big|\min_{a\ne b}K_{ab}\Big|\;\ge\;\sqrt{\frac t{n(n-1)(n-2)}},
\]
and for even $n$ the bound is attained, the extremizers being exactly the perfect matchings: $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere.

## Passage B, the proof as written ([findings/diagonal-half.md](../findings/diagonal-half.md) line 458)

**Proof** (*supplied by [ELIM-halves](../reviews/ELIM-halves.md), the block's pointer named a truncated section title containing no min-entry argument, so the proof was absent from the record*). Fix the row $a$ achieving the minimal entry and let $m=\lvert\min_{b}K_{ab}\rvert$. The row vector $(K_{ab})_{b\ne a}$ has $n-1$ entries summing to $-K_{aa}=0$, each entry $\ge-m$, so each entry is also $\le(n-2)m$, a point of the row polytope $\{x\in\mathbb R^{n-1}:\sum x_b=0,\ x_b\ge-m\}$, whose extreme points have one coordinate at $(n-2)m$ and the rest at $-m$. Hence $s_a:=\sum_b K_{ab}^2\le(n-2)^2m^2+(n-2)m^2=(n-1)(n-2)m^2$, the extreme point maximising the convex functional $s_a$. Summing over rows, $t=\lVert K\rVert_F^2=\sum_a s_a\le n(n-1)(n-2)m^2$, which is the display; and equality forces every row extreme, one entry $(n-2)c$, the rest $-c$, which pairs the rows into a fixed-point-free involution, existing exactly for even $n$. $\square$

## Passage C, the canonical statement, landscape form ([results.md](../results.md) line 206)

- **Lemma L55 (direct). The min-entry bound, sharp for even $n$.** For $K$ hollow, symmetric, with zero row sums and $\lVert K\rVert_F^2=t$, $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$; for even $n$ the bound is attained, exactly by the perfect matchings, $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere.

## Passage D, the canonical statement, detail form ([results.md](../results.md) line 709, under the heading at line 707)

Let $K$ be a hollow symmetric $n\times n$ matrix with zero row sums and $\lVert K\rVert_F^2=t$. Then $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$. In the row achieving the minimal entry $-m$, the $n-1$ off-diagonal entries sum to $0$ and are each $\ge-m$, so they lie in a polytope whose extreme points have one coordinate at $(n-2)m$ and the rest at $-m$; the row norm, convex, is maximised there at $(n-1)(n-2)m^2$, and summing over rows gives the display. Equality forces every row extreme, which pairs the rows into a fixed-point-free involution, so for even $n$ the extremizers are exactly the perfect matchings, $K_{ab}=(n-2)c$ on the matching and $-c$ elsewhere, and at odd $n$ the bound is strict. The lemma is about hollow zero-row-sum matrices and holds on and off the diagonal locus alike; what it bounds is the smallest sectional curvature, and it carries no information about $\theta$ on its own.

## Passage E, the Lean statement ([lean/HamiltonsCubic/Results/L55Statement.lean](../lean/HamiltonsCubic/Results/L55Statement.lean), whole file, 255 lines)

```lean
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

Everything below is proved; there is no `sorry`. What is not stated here is the *uniqueness* half
of the word "exactly": that every equality case is a perfect matching. The record proves it from
strict convexity plus the symmetry step forcing `σ² = id`, and this file supplies attainment and
the inequality only.
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

```

## Definitions

- $K$ is a real $n\times n$ matrix; hollow means $K_{aa}=0$; zero row sums means $\sum_bK_{ab}=0$ for every $a$; $t=\lVert K\rVert_F^2=\sum_{a,b}K_{ab}^2$ over ordered pairs.
- A fixed-point-free involution is a permutation $\sigma$ of $\{1,\dots,n\}$ with $\sigma^2=\mathrm{id}$ and $\sigma(a)\ne a$ for all $a$; the matching matrix for $\sigma$ and $c$ has $K_{a\sigma(a)}=(n-2)c$ and $K_{ab}=-c$ for $b\notin\{a,\sigma(a)\}$.

## What to attack, beyond the standing list

1. **The inequality**: each step of Passage B, the row polytope and its extreme points, why the convex functional is maximised at an extreme point, and **which hypotheses the inequality actually uses** (hollowness, zero row sums, symmetry).
2. **"The bound is attained, the extremizers being exactly the perfect matchings"**: attainment by the matching matrix, **for which sign of $c$**; and the uniqueness half, **whether Passage B's "equality forces every row extreme ... which pairs the rows into a fixed-point-free involution" is argued**: strictness of the row inequality away from the extreme points, why one entry per row is $(n-2)c$, and where symmetry turns the pairing into an involution.
3. **The zero matrix**: what the statement and each canonical form say at $K=0$, $t=0$, at even and at odd $n$.
4. **Passage D's "at odd $n$ the bound is strict"**: whether it is true as stated, and what the strict statement needs.
5. **Passage D's closing sentence**: that the lemma holds on and off the diagonal locus and carries no information about $\theta$ alone.
6. **The ordered-pair reading of $t$**: what the constant becomes under the unordered reading.
7. **Passage E against Passages A and D**: what its theorems state (the inequality without symmetry, the symmetric restatement, attainment with its sign hypothesis) and what the file says it does not type.
8. The boundary: $n=2,3$, odd $n$, $K=0$, $c<0$.

