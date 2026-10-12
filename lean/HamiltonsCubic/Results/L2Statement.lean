import Mathlib

/-!
# L2, the exact dimension threshold, STATED

[problem.md](../../../findings/problem.md)'s Lemma L2, quoted verbatim:

> **Statement.** Let `n ≥ 4` and let `θ_max^sp(n) = max_{p+q=n} θ(S^p × S^q)`. Then
> `θ_max^sp(n)² < 3/2` for `4 ≤ n ≤ 11` and `θ_max^sp(n)² > 3/2` for `n ≥ 12`, where `3/2` is
> the squared value of the `ℂP²`-type competitor, Fox's `S⁴(α)`. No dimension sits at equality.

**What [L2.lean](L2.lean) already carries and this file does not repeat**: the threshold
polynomials `n² - 12n + 8` and `n² - 13n + 18`, their irrational roots, the fact that both lie
strictly inside `(11, 12)` so no integer separates them, and the excesses at `n = 11, 13`.
**What that file never states is the lemma**, it proves facts about the two closed forms and
never quantifies over the splits `p + q = n`, which is where the word *maximum* lives. That
quantifier is what is typed here.

## The two imported values, and which of them is a hypothesis

* `θ(S^p × S^q)² = 2(n-1)(p-1)(q-1)/((n-2)pq)` with `p + q = n`
  ([Nienhaus](../../../references/nienhaus-2023-second-best-einstein/notes.md) Prop 2.25,
  squared) is taken as the **definition** of `thetaSpSq` below. Its derivation needs `𝒲ₙ` and
  `Q`, which have no Lean base layer here.
* `θ(S⁴(α))² = 3/2` at every `n ≥ 4`
  ([Nienhaus](../../../references/nienhaus-2023-second-best-einstein/notes.md) Thm 4.14(a) at
  `n = 4`, then zero-padding) is the numeral `3/2` in the goals. **The record names it a single
  point of failure for every route to the threshold**, and it is imported, not proved.

Everything between those two inputs and the statement is arithmetic, and it is proved.
**Both inputs are now theorems of the layer**: [L2Operators.lean](L2Operators.lean) derives
`thetaSpSq` as `θ²` of the unit sphere-product operator and `3/2` as `θ²` of the padded `ℂP²`
operator, and states L2 against those operators (`L2_operators`).

## The domain of the maximum

`p, q ≥ 2`, since `S¹` is flat and `S^p × S^q` is the record's Einstein object only from `2`
upward. That is the smaller domain, so the `∀` clause below is exactly the record's
`max < 3/2` rather than a stronger statement over a wider index set.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L2Statement

open Finset

/-- `θ(S^p × S^q)² = 2(n-1)(p-1)(q-1)/((n-2)pq)` at `n = p + q`, read off the split. -/
noncomputable def thetaSpSq (p q : ℕ) : ℝ :=
  2 * ((p : ℝ) + (q : ℝ) - 1) * ((p : ℝ) - 1) * ((q : ℝ) - 1) /
    (((p : ℝ) + (q : ℝ) - 2) * ((p : ℝ) * (q : ℝ)))

/-! ## The split-dependent factor, and why the balanced split wins

The record's one clause, *"`(p-1)(q-1)/(pq) = 1 - (n-1)/(pq)` is strictly increasing in `pq`,
so the maximum over splits is attained at the most balanced one"*, typed. -/

/-- **The whole split dependence is through `pq`.** At fixed `n = p + q`,
`θ² = 2(n-1)/(n-2) · (1 - (n-1)/(pq))`. -/
theorem thetaSpSq_eq_of_sum {p q : ℕ} (hp : 1 ≤ p) (hq : 1 ≤ q) (h3 : 3 ≤ p + q) :
    thetaSpSq p q
      = 2 * ((p : ℝ) + (q : ℝ) - 1) / ((p : ℝ) + (q : ℝ) - 2) *
          (1 - (((p : ℝ) + (q : ℝ)) - 1) / ((p : ℝ) * (q : ℝ))) := by
  have hp0 : (1 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have hq0 : (1 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
  have h3' : (3 : ℝ) ≤ (p : ℝ) + (q : ℝ) := by exact_mod_cast h3
  have hpne : (p : ℝ) ≠ 0 := by linarith
  have hqne : (q : ℝ) ≠ 0 := by linarith
  have hd : (p : ℝ) + (q : ℝ) - 2 ≠ 0 := by intro h; linarith
  unfold thetaSpSq
  field_simp
  ring

/-- **And that factor rises with `pq`**, so the largest product, the most balanced split,
carries the maximum. -/
theorem thetaSpSq_mono {p q p' q' : ℕ} (hp : 1 ≤ p) (hq : 1 ≤ q) (hp' : 1 ≤ p') (hq' : 1 ≤ q')
    (hsum : p + q = p' + q') (h3 : 3 ≤ p + q) (hprod : p * q ≤ p' * q') :
    thetaSpSq p q ≤ thetaSpSq p' q' := by
  have hp0 : (1 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have hq0 : (1 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
  have hp0' : (1 : ℝ) ≤ (p' : ℝ) := by exact_mod_cast hp'
  have hq0' : (1 : ℝ) ≤ (q' : ℝ) := by exact_mod_cast hq'
  have h3' : (3 : ℝ) ≤ (p : ℝ) + (q : ℝ) := by exact_mod_cast h3
  have hsum' : (p : ℝ) + (q : ℝ) = (p' : ℝ) + (q' : ℝ) := by exact_mod_cast hsum
  have hprod' : (p : ℝ) * (q : ℝ) ≤ (p' : ℝ) * (q' : ℝ) := by exact_mod_cast hprod
  have h3'' : 3 ≤ p' + q' := by omega
  rw [thetaSpSq_eq_of_sum hp hq h3, thetaSpSq_eq_of_sum hp' hq' h3'']
  rw [← hsum']
  have hpos : (0 : ℝ) < (p : ℝ) * (q : ℝ) := by nlinarith
  have hcoef : (0 : ℝ) < 2 * ((p : ℝ) + (q : ℝ) - 1) / ((p : ℝ) + (q : ℝ) - 2) := by
    apply div_pos <;> linarith
  have hstep : 1 - (((p : ℝ) + (q : ℝ)) - 1) / ((p : ℝ) * (q : ℝ))
      ≤ 1 - (((p : ℝ) + (q : ℝ)) - 1) / ((p' : ℝ) * (q' : ℝ)) := by
    have : (((p : ℝ) + (q : ℝ)) - 1) / ((p' : ℝ) * (q' : ℝ))
        ≤ (((p : ℝ) + (q : ℝ)) - 1) / ((p : ℝ) * (q : ℝ)) := by
      apply div_le_div_of_nonneg_left (by linarith) hpos hprod'
    linarith
  exact mul_le_mul_of_nonneg_left hstep hcoef.le

/-! ## Below the threshold: `4 ≤ n ≤ 11`

A finite check over every admissible split, which is what `max < 3/2` says once the maximum is
unfolded. -/

/-- **`θ(S^p × S^q)² < 3/2` at every split of every `n` with `4 ≤ n ≤ 11`.** -/
theorem lt_three_halves_of_le_eleven {n p q : ℕ} (h4 : 4 ≤ n) (h11 : n ≤ 11)
    (hp : 2 ≤ p) (hq : 2 ≤ q) (hpq : p + q = n) :
    thetaSpSq p q < 3 / 2 := by
  subst hpq
  have hp9 : p ≤ 9 := by omega
  have hq9 : q ≤ 9 := by omega
  clear h4
  interval_cases p <;> interval_cases q <;>
    first
      | omega
      | (unfold thetaSpSq; norm_num)

/-! ## At and above the threshold: `n ≥ 12`

The balanced split is exhibited, at each parity, and it beats `3/2`. -/

/-- **The balanced even split.** At `n = 2m` with `m ≥ 6`, `θ₀(n)² > 3/2`, the record's
`n² - 12n + 8 > 0`, here in `m` as `m² - 6m + 2 > 0`. -/
theorem balanced_even {m : ℕ} (hm : 6 ≤ m) : 3 / 2 < thetaSpSq m m := by
  have hx : (6 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  unfold thetaSpSq
  rw [lt_div_iff₀ (by nlinarith)]
  have h1 : (0 : ℝ) < (m : ℝ) - 1 := by linarith
  have h2 : (0 : ℝ) < (m : ℝ) ^ 2 - 6 * (m : ℝ) + 2 := by nlinarith
  nlinarith [mul_pos h1 h2]

/-- **The near-balanced odd split.** At `n = 2m + 1` with `m ≥ 6`, `Θₙ² > 3/2`, the record's
`n² - 13n + 18 > 0`, here in `m` as `2m² - 11m + 3 > 0`. -/
theorem balanced_odd {m : ℕ} (hm : 6 ≤ m) : 3 / 2 < thetaSpSq m (m + 1) := by
  have hx : (6 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  unfold thetaSpSq
  push_cast
  have hden : (0 : ℝ) < ((m : ℝ) + ((m : ℝ) + 1) - 2) * ((m : ℝ) * ((m : ℝ) + 1)) := by
    have h1 : (0 : ℝ) < (m : ℝ) + ((m : ℝ) + 1) - 2 := by linarith
    have h2 : (0 : ℝ) < (m : ℝ) * ((m : ℝ) + 1) := by nlinarith
    exact mul_pos h1 h2
  rw [lt_div_iff₀ hden]
  have h2 : (0 : ℝ) < 2 * (m : ℝ) ^ 2 - 11 * (m : ℝ) + 3 := by nlinarith
  nlinarith [mul_pos (by linarith : (0:ℝ) < (m : ℝ)) h2]

/-- **A split above `3/2` exists at every `n ≥ 12`**, which is what `max > 3/2` says once the
maximum is unfolded. The witness is the most balanced split at either parity. -/
theorem exists_gt_three_halves {n : ℕ} (hn : 12 ≤ n) :
    ∃ p q : ℕ, 2 ≤ p ∧ 2 ≤ q ∧ p + q = n ∧ 3 / 2 < thetaSpSq p q := by
  rcases Nat.even_or_odd n with he | ho
  · obtain ⟨m, hm⟩ := he
    exact ⟨m, m, by omega, by omega, by omega, balanced_even (by omega)⟩
  · obtain ⟨m, hm⟩ := ho
    exact ⟨m, m + 1, by omega, by omega, by omega, balanced_odd (by omega)⟩

/-! ## The statement itself

`M` below is `θ_max^sp(n)²`, pinned by the two clauses that make a real number the maximum of a
set: it dominates every split, and some split attains it. **Attainment is what "no dimension sits
at equality" needs**, an upper bound alone would leave `M = 3/2` open below the threshold. -/

/-- **L2.** For `n ≥ 4`, with `M = θ_max^sp(n)²` the maximum over splits `p + q = n`:
`M < 3/2` when `4 ≤ n ≤ 11`, `M > 3/2` when `n ≥ 12`, and `M ≠ 3/2` at every `n ≥ 4`. -/
theorem L2 {n : ℕ} (h4 : 4 ≤ n) (M : ℝ)
    (hub : ∀ p q : ℕ, 2 ≤ p → 2 ≤ q → p + q = n → thetaSpSq p q ≤ M)
    (hatt : ∃ p q : ℕ, 2 ≤ p ∧ 2 ≤ q ∧ p + q = n ∧ thetaSpSq p q = M) :
    (n ≤ 11 → M < 3 / 2) ∧ (12 ≤ n → 3 / 2 < M) ∧ M ≠ 3 / 2 := by
  have hlow : n ≤ 11 → M < 3 / 2 := by
    intro h11
    obtain ⟨p, q, hp, hq, hpq, hM⟩ := hatt
    rw [← hM]
    exact lt_three_halves_of_le_eleven h4 h11 hp hq hpq
  have hhigh : 12 ≤ n → 3 / 2 < M := by
    intro h12
    obtain ⟨p, q, hp, hq, hpq, hlt⟩ := exists_gt_three_halves h12
    exact lt_of_lt_of_le hlt (hub p q hp hq hpq)
  refine ⟨hlow, hhigh, ?_⟩
  by_cases h : n ≤ 11
  · exact ne_of_lt (hlow h)
  · exact ne_of_gt (hhigh (by omega))

/-- **The hypotheses of `L2` are not empty.** At `n = 12` the balanced split `6 + 6` is
admissible, so the set the maximum runs over is inhabited at the first dimension above the
threshold. -/
example : (2 : ℕ) ≤ 6 ∧ (2 : ℕ) ≤ 6 ∧ 6 + 6 = 12 ∧ 3 / 2 < thetaSpSq 6 6 :=
  ⟨by norm_num, by norm_num, by norm_num, balanced_even (by norm_num)⟩

/-- **And the witness the record names at `n = 11`**: `S⁵ × S⁶` attains `40/27`, short of `3/2`
by `1/54`. -/
theorem eleven_witness : thetaSpSq 5 6 = 40 / 27 ∧ (40 / 27 : ℝ) - 3 / 2 = -(1 / 54) := by
  constructor
  · unfold thetaSpSq; norm_num
  · norm_num

end HamiltonsCubic.L2Statement
