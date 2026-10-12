import Mathlib

set_option linter.style.longLine false

/-!
# L93, the lower bound on the vertex matrix's most negative entry

## The record's statement, quoted verbatim from [bispectral.md](../../../findings/bispectral.md)

> **Lemma.** Let $K$ be hollow, symmetric, with zero row sums and $\lVert K\rVert_F^2=t$. Then
> $$\bigl\lvert\min_{a\ne b}K_{ab}\bigr\rvert\ \ge\ \sqrt{\frac{t}{n(n-1)(n-2)}} .$$

and, from the same block, the row step it runs on:

> For reals $y_1,\dots,y_M$ with $\sum y=0$ and $\sum y^2=s$, the configuration minimising
> $\lvert\min y\rvert$ is $M-1$ equal negatives against a single positive,
> $y=(\alpha,\dots,\alpha,-(M-1)\alpha)$ **with $\alpha<0$**, the sign is load-bearing, since at
> $\alpha>0$ the minimum is the single entry and $\lvert\min y\rvert=(M-1)\lvert\alpha\rvert$,
> larger by exactly $M-1=n-2$, making it the *maximising* configuration instead.

## The number is withdrawn; the mathematics is not

The record withdraws **L93 as a number**: it is [Lemma L55](../../../findings/diagonal-half.md)
under a second id, same constant `n(n-1)(n-2)` and same extremiser, and 55 is the number the
report and [results.md](../../../results.md) cite. This file therefore types the *statement the
L93 block displays*, which is the shared mathematics, and states the sign caveat that the L93
copy carried and its sibling did not. The parallel file
[L55Statement.lean](L55Statement.lean) types the same inequality from L55's block together with
L55's attainment clause.

Everything below is proved; there is no `sorry`.

**`t` is the ordered-pair sum**, `∑ a, ∑ b, K a b ^ 2`, which is what makes the constant
`n(n-1)(n-2)` rather than half of it. **Symmetry is inert for the inequality**, the derivation
reads one row at a time, so it is carried in `min_entry_bound_symm` for the record's sentence and
absent from the working form.

## What is NOT typed here

The L93 block's own audit notes: that the displayed `y` is the *maximising* configuration unless
`α < 0` is typed (`max_config_is_larger`), but the claim that the constant is loose by `√n` at the
balanced sphere product, and the odd-`n` ratio `√(21/17)`, are measurements of specific curvature
tensors and are not.
-/

namespace HamiltonsCubic.L93Statement

open Finset

variable {n M : ℕ}

/-! ## The row step, in the record's own vector form -/

/-- **Every entry is at most `(M-1)m`** when `-m` is a lower bound and the entries sum to zero:
one entry is the negative of the other `M-1`. -/
theorem entry_le {y : Fin M → ℝ} (hsum : ∑ i, y i = 0) {m : ℝ} (hm : ∀ i, -m ≤ y i) (i : Fin M) :
    y i ≤ ((M : ℝ) - 1) * m := by
  classical
  have hcard : (univ.erase i).card = M - 1 := by
    rw [card_erase_of_mem (mem_univ i), card_univ, Fintype.card_fin]
  have hM1 : 1 ≤ M := Fin.pos i
  have hcast : (((M - 1 : ℕ)) : ℝ) = (M : ℝ) - 1 := by push_cast [Nat.cast_sub hM1]; ring
  have hsplit : y i + ∑ j ∈ univ.erase i, y j = 0 := by
    rwa [← Finset.add_sum_erase _ _ (mem_univ i)] at hsum
  have hlow : -(((M : ℝ) - 1) * m) ≤ ∑ j ∈ univ.erase i, y j := by
    have hs : ∑ _j ∈ univ.erase i, (-m) ≤ ∑ j ∈ univ.erase i, y j :=
      Finset.sum_le_sum fun j _ => hm j
    rw [Finset.sum_const, nsmul_eq_mul, hcard, hcast] at hs
    linarith
  linarith

/-- **The row bound.** For `y₁,…,y_M` summing to zero with `-m ≤ yᵢ` for every `i`,
`∑ yᵢ² ≤ M(M-1)m²`. Equivalently `|min y| ≥ √(s/(M(M-1)))` with `s = ∑ yᵢ²`, the record's row
step, cleared of its square root. -/
theorem row_bound {y : Fin M → ℝ} (hsum : ∑ i, y i = 0) {m : ℝ} (hm : ∀ i, -m ≤ y i) :
    ∑ i, y i ^ 2 ≤ (M : ℝ) * ((M : ℝ) - 1) * m ^ 2 := by
  classical
  have hstep : ∀ i : Fin M, y i ^ 2 ≤ ((M : ℝ) - 2) * m * y i + ((M : ℝ) - 1) * m ^ 2 := by
    intro i
    have h1 : -m ≤ y i := hm i
    have h2 : y i ≤ ((M : ℝ) - 1) * m := entry_le hsum hm i
    nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ y i + m)
      (by linarith : (0:ℝ) ≤ ((M:ℝ) - 1) * m - y i)]
  calc ∑ i, y i ^ 2
      ≤ ∑ i : Fin M, (((M : ℝ) - 2) * m * y i + ((M : ℝ) - 1) * m ^ 2) :=
        Finset.sum_le_sum fun i _ => hstep i
    _ = (M : ℝ) * ((M : ℝ) - 1) * m ^ 2 := by
        rw [Finset.sum_add_distrib, ← Finset.mul_sum, hsum, Finset.sum_const, card_univ,
          Fintype.card_fin, nsmul_eq_mul]
        ring

/-- **The row step with its square root**, as the record displays it: `|min y| ≥ √(s/(M(M-1)))`,
with `m` any bound satisfying `-m ≤ yᵢ`. -/
theorem row_sqrt_bound (hM : 2 ≤ M) {y : Fin M → ℝ} (hsum : ∑ i, y i = 0) {m s : ℝ}
    (hm0 : 0 ≤ m) (hm : ∀ i, -m ≤ y i) (hs : ∑ i, y i ^ 2 = s) :
    Real.sqrt (s / ((M : ℝ) * ((M : ℝ) - 1))) ≤ m := by
  have hM2 : (2 : ℝ) ≤ (M : ℝ) := by exact_mod_cast hM
  have hpos : (0 : ℝ) < (M : ℝ) * ((M : ℝ) - 1) := mul_pos (by linarith) (by linarith)
  have hle : s ≤ (M : ℝ) * ((M : ℝ) - 1) * m ^ 2 := hs ▸ row_bound hsum hm
  have hdiv : s / ((M : ℝ) * ((M : ℝ) - 1)) ≤ m ^ 2 := by
    rw [div_le_iff₀ hpos]; nlinarith
  calc Real.sqrt (s / ((M : ℝ) * ((M : ℝ) - 1)))
      ≤ Real.sqrt (m ^ 2) := Real.sqrt_le_sqrt hdiv
    _ = m := Real.sqrt_sq hm0

/-! ## The sign caveat the L93 copy carried

*The record's displayed configuration is extremal in one direction at `α < 0` and in the other at
`α > 0`, the two differing by exactly `M - 1 = n - 2`.* -/

/-- The record's configuration `y = (α,…,α,-(M-1)α)`, written with the single distinguished entry
at index `i`. -/
noncomputable def config (M : ℕ) (i : Fin M) (α : ℝ) : Fin M → ℝ :=
  fun j => if j = i then -((M : ℝ) - 1) * α else α

/-- **The configuration sums to zero**, for every `α`. -/
theorem config_sum (hM : 1 ≤ M) (i : Fin M) (α : ℝ) : ∑ j, config M i α j = 0 := by
  classical
  have hcard : (univ.erase i).card = M - 1 := by
    rw [card_erase_of_mem (mem_univ i), card_univ, Fintype.card_fin]
  have hcast : (((M - 1 : ℕ)) : ℝ) = (M : ℝ) - 1 := by push_cast [Nat.cast_sub hM]; ring
  have hsplit : ∑ j, config M i α j
      = config M i α i + ∑ j ∈ univ.erase i, config M i α j := by
    rw [← Finset.add_sum_erase _ _ (mem_univ i)]
  have hother : ∀ j ∈ univ.erase i, config M i α j = α := by
    intro j hj
    simp [config, Finset.ne_of_mem_erase hj]
  have hi : config M i α i = -((M : ℝ) - 1) * α := by simp [config]
  rw [hsplit, Finset.sum_congr rfl hother, Finset.sum_const, hcard, nsmul_eq_mul, hcast, hi]
  ring

/-- **At `α < 0` the minimum is `α`**: every entry is at least `α`, so `|min y| = |α|` and the row
bound is met with equality. -/
theorem config_min_neg (hM : 2 ≤ M) {α : ℝ} (hα : α < 0) (i j : Fin M) :
    α ≤ config M i α j := by
  have hM2 : (2 : ℝ) ≤ (M : ℝ) := by exact_mod_cast hM
  unfold config
  split_ifs with h
  · nlinarith
  · exact le_refl α

/-- **At `α > 0` the same configuration has minimum `-(M-1)α`**, whose modulus is
`M - 1 = n - 2` times `|α|`, larger by exactly the factor the record names, which is why the
sign is load-bearing and the `α > 0` reading is the *maximising* configuration. -/
theorem max_config_is_larger (hM : 2 ≤ M) {α : ℝ} (hα : 0 < α) (i : Fin M) :
    config M i α i = -(((M : ℝ) - 1) * |α|) ∧ ∀ j, config M i α i ≤ config M i α j := by
  have habs : |α| = α := abs_of_pos hα
  have hM2 : (2 : ℝ) ≤ (M : ℝ) := by exact_mod_cast hM
  have hi : config M i α i = -((M : ℝ) - 1) * α := by simp [config]
  constructor
  · rw [hi, habs]; ring
  · intro j
    rw [hi]
    simp only [config]
    split_ifs with h
    · nlinarith
    · nlinarith

/-! ## The lemma -/

/-- The record's hypothesis set: hollow, with vanishing row sums. -/
structure IsHollowZeroRow (K : Matrix (Fin n) (Fin n) ℝ) : Prop where
  hollow : ∀ a, K a a = 0
  rowsum : ∀ a, ∑ b, K a b = 0

/-- **The Frobenius sum is at most `n(n-1)(n-2)m²`**, the record's display cleared of its square
root. The row step is applied to each of the `n` rows, whose `n-1` off-diagonal entries sum to
zero, and then `∑ₐ sₐ = t` gives some row with `sₐ ≥ t/n`. -/
theorem frobenius_le {K : Matrix (Fin n) (Fin n) ℝ} (hn : 2 ≤ n) (hK : IsHollowZeroRow K) {m : ℝ}
    (hm : ∀ a b, -m ≤ K a b) :
    ∑ a, ∑ b, K a b ^ 2 ≤ (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
  classical
  have hrow : ∀ a : Fin n, ∑ b, K a b ^ 2 ≤ ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
    intro a
    -- restrict to the `n-1` off-diagonal entries of row `a`
    have hzero : ∑ b ∈ univ.erase a, K a b = 0 := by
      have := hK.rowsum a
      rwa [← Finset.add_sum_erase _ _ (mem_univ a), hK.hollow a, zero_add] at this
    have hcard : (univ.erase a).card = n - 1 := by
      rw [card_erase_of_mem (mem_univ a), card_univ, Fintype.card_fin]
    have hcast : (((n - 1 : ℕ)) : ℝ) = (n : ℝ) - 1 := by
      push_cast [Nat.cast_sub (by omega : 1 ≤ n)]; ring
    have hentry : ∀ b ∈ univ.erase a, K a b ≤ (((n : ℝ) - 1) - 1) * m := by
      intro b hb
      have hsplit : K a b + ∑ c ∈ (univ.erase a).erase b, K a c = 0 := by
        rwa [← Finset.add_sum_erase _ _ (show b ∈ univ.erase a from hb)] at hzero
      have hcard2 : ((univ.erase a).erase b).card = n - 2 := by
        rw [card_erase_of_mem hb, card_erase_of_mem (mem_univ a), card_univ, Fintype.card_fin]
        omega
      have hcast2 : (((n - 2 : ℕ)) : ℝ) = (n : ℝ) - 2 := by
        push_cast [Nat.cast_sub hn]; ring
      have hlow : -(((n : ℝ) - 2) * m) ≤ ∑ c ∈ (univ.erase a).erase b, K a c := by
        have hs : ∑ _c ∈ (univ.erase a).erase b, (-m) ≤ ∑ c ∈ (univ.erase a).erase b, K a c :=
          Finset.sum_le_sum fun c _ => hm a c
        rw [Finset.sum_const, nsmul_eq_mul, hcard2, hcast2] at hs
        linarith
      have : K a b ≤ ((n : ℝ) - 2) * m := by linarith
      linarith
    have hstep : ∀ b ∈ univ.erase a,
        K a b ^ 2 ≤ ((n : ℝ) - 3) * m * K a b + ((n : ℝ) - 2) * m ^ 2 := by
      intro b hb
      have h1 : -m ≤ K a b := hm a b
      have h2 : K a b ≤ ((n : ℝ) - 2) * m := by have := hentry b hb; linarith
      nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ K a b + m)
        (by linarith : (0:ℝ) ≤ ((n:ℝ) - 2) * m - K a b)]
    have hoff : ∑ b ∈ univ.erase a, K a b ^ 2 ≤ ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
      calc ∑ b ∈ univ.erase a, K a b ^ 2
          ≤ ∑ b ∈ univ.erase a, (((n : ℝ) - 3) * m * K a b + ((n : ℝ) - 2) * m ^ 2) :=
            Finset.sum_le_sum hstep
        _ = ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
            rw [Finset.sum_add_distrib, ← Finset.mul_sum, hzero, Finset.sum_const, hcard,
              nsmul_eq_mul, hcast]
            ring
    have hfull : ∑ b, K a b ^ 2 = ∑ b ∈ univ.erase a, K a b ^ 2 := by
      rw [← Finset.add_sum_erase _ _ (mem_univ a), hK.hollow a]; ring
    rw [hfull]; exact hoff
  calc ∑ a, ∑ b, K a b ^ 2
      ≤ ∑ _a : Fin n, ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 :=
        Finset.sum_le_sum fun a _ => hrow a
    _ = (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 := by
        rw [Finset.sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul]; ring

/-- **The record's display.** Any lower bound `-m` on the entries of a hollow, zero-row-sum `K`
with `∑ₐ∑_b Kₐb² = t` satisfies `m ≥ √(t/(n(n-1)(n-2)))`. Taking `m = |min_{a≠b} Kₐb|`, a lower
bound, since the row sums put the minimum at or below zero, is the sentence as written. -/
theorem min_entry_bound {K : Matrix (Fin n) (Fin n) ℝ} (hn : 3 ≤ n) (hK : IsHollowZeroRow K)
    {m t : ℝ} (hm0 : 0 ≤ m) (hm : ∀ a b, -m ≤ K a b) (ht : ∑ a, ∑ b, K a b ^ 2 = t) :
    Real.sqrt (t / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2))) ≤ m := by
  have hn3 : (3 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hpos : (0 : ℝ) < (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) :=
    mul_pos (mul_pos (by linarith) (by linarith)) (by linarith)
  have hle : t ≤ (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) * m ^ 2 :=
    ht ▸ frobenius_le (by omega) hK hm
  have hdiv : t / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2)) ≤ m ^ 2 := by
    rw [div_le_iff₀ hpos]; nlinarith
  calc Real.sqrt (t / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2)))
      ≤ Real.sqrt (m ^ 2) := Real.sqrt_le_sqrt hdiv
    _ = m := Real.sqrt_sq hm0

/-- **The record's sentence with its symmetry hypothesis restored.** Symmetry is inert for the
inequality, so this is `min_entry_bound` with an unused hypothesis. -/
theorem min_entry_bound_symm {K : Matrix (Fin n) (Fin n) ℝ} (hn : 3 ≤ n)
    (_hsymm : ∀ a b, K a b = K b a) (hhollow : ∀ a, K a a = 0) (hrow : ∀ a, ∑ b, K a b = 0)
    {m t : ℝ} (hm0 : 0 ≤ m) (hm : ∀ a b, -m ≤ K a b) (ht : ∑ a, ∑ b, K a b ^ 2 = t) :
    Real.sqrt (t / ((n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2))) ≤ m :=
  min_entry_bound hn ⟨hhollow, hrow⟩ hm0 hm ht

/-- **The hypotheses are not empty**: the `3 × 3` hollow symmetric matrix with every off-diagonal
entry `0` satisfies them, and so does any hollow symmetric matrix with vanishing row sums. -/
example : IsHollowZeroRow (fun _ _ => (0 : ℝ) : Matrix (Fin 3) (Fin 3) ℝ) :=
  ⟨fun _ => rfl, fun _ => by simp⟩

end HamiltonsCubic.L93Statement
