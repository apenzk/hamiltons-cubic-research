import Mathlib

/-!
# L172, Jäger's three dimension hypotheses are one constraint, STATED

[problem.md](../../../findings/problem.md)'s Lemma L172, quoted verbatim:

> **Statement.** Under `n = 2m` with `n` even, Lemma 3.5.6's `n ≥ 15` **is** `m ≥ 8`: the two are
> one constraint, and Assumption 1 and Theorem 3.0.2 state it twice more. **So Assumption 1 binds
> at `n = 12` and `n = 14`**, and [L1](../../../findings/problem.md)'s dependency there is not
> discharged by reading the source.
>
> **Proof.** `n ≥ 15` with `n` even gives `n ≥ 16`, hence `m ≥ 8`; and `m ≥ 8` gives
> `n ≥ 16 ≥ 15`. `□`

**What [L172.lean](L172.lean) already carries and this file does not repeat**: the equivalence
`15 ≤ 2m ↔ 8 ≤ m` and the sign data for `g` and `h` as bare numerals. **What that file never
states is the lemma's conclusion**, that the constraint *binds* at the two dimensions, which is
a statement about the census and not about the equivalence. The census is typed here, and the
two facts the block records as what the refuted attempt left behind.

## The census, corrected, as the record's own table

| where | as written | in `m` | binds at `n = 12, 14` |
|---|---|---|---|
| Lemma 3.5.5, eq. (3.13) | `n ≥ 9` | `m ≥ 5` | no |
| Lemma 3.5.5, applying Lemma 3.5.4 at `k = n` | `k ≥ 12` | `m ≥ 6` | no |
| **Lemma 3.5.6, Case 1** | `g(n) < 0` for `n ≥ 15` | `m ≥ 8` | **yes** |
| **Lemma 3.5.6, Case 2** | `h(n) < 0` for `n ≥ 15` | `m ≥ 8` | **yes** |
| Theorem 3.0.2's proof | `m ≥ 8` | `m ≥ 4` | no |

*The error the block records because its shape recurs: the first version censused the **string**
`m ≥ 8`, found three occurrences, and concluded the hypothesis was invoked once. Chapter 3 states
its results in `m` and argues them in `n = 2m`, so a constraint is consumed without ever being
spelled.*

## What is not typed here, and why

**The reading of the source.** Which thresholds Chapter 3 actually consumes is a fact about a
document, and every row of the table above enters this file as a numeral rather than as a claim
about Jäger.

**The values of `g` and `h`.** The record prints `g(12) = 194169`, `g(14) = 89095`,
`h(12) = 2232117`, `h(14) = 1224567`, `g(15) = -25497`, `h(15) = -59616` and gives no closed
form for either function, so their positivity at `12, 14` is carried as data, which is all the
lemma needs, since what it asserts is that the contradictions the source's proof requires are
unavailable at those two dimensions.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L172Statement

open Finset

/-! ## The lemma's own proof: the two thresholds are one constraint -/

/-- **`n ≥ 15` with `n = 2m` even IS `m ≥ 8`.** Both directions: `15 ≤ 2m` forces `16 ≤ 2m`, so
`8 ≤ m`; and `8 ≤ m` gives `16 ≤ 2m`, hence `15 ≤ 2m`. -/
theorem thresholds_agree (m : ℕ) : 15 ≤ 2 * m ↔ 8 ≤ m := by omega

/-- **And the two dimensions at issue are `m = 6` and `m = 7`.** -/
theorem the_two_dimensions : 2 * 6 = 12 ∧ 2 * 7 = 14 := by norm_num

/-! ## The conclusion: the constraint binds at `n = 12, 14`

*"Binds" is exactly: the threshold excludes both `m = 6` and `m = 7`. A row of the census binds
precisely when its threshold in `m` is at least `8`.* -/

/-- A threshold `t` in `m` **binds at `n = 12, 14`** when it excludes `m = 6` and `m = 7`. -/
def BindsAt1214 (t : ℕ) : Prop := ¬ (t ≤ 6) ∧ ¬ (t ≤ 7)

/-- **Binding is exactly `t ≥ 8`**, which is why one constraint stated three ways is what has to
be cleared and not three. -/
theorem bindsAt1214_iff (t : ℕ) : BindsAt1214 t ↔ 8 ≤ t := by
  unfold BindsAt1214; omega

/-- **Assumption 1's threshold binds.** `m ≥ 8` excludes both `m = 6` and `m = 7`. -/
theorem assumption_one_binds : BindsAt1214 8 := by
  rw [bindsAt1214_iff]

/-- The census's five thresholds, read in `m`, in the table's order. -/
def census : Fin 5 → ℕ := ![5, 6, 8, 8, 4]

/-- **Exactly two of the five consumptions bind**, and they are Lemma 3.5.6's two cases. -/
theorem census_two_bind : (Finset.univ.filter (fun i => 8 ≤ census i)).card = 2 := by decide

/-- **And they are rows 2 and 3**, Lemma 3.5.6's Case 1 and Case 2, the two the record marks. -/
theorem census_which_bind :
    (Finset.univ.filter (fun i => 8 ≤ census i)) = {2, 3} := by decide

/-- **The other three do not**, so the earlier reading, that the hypothesis was invoked once and
slackly, fails on the count as well as on the location. -/
theorem census_others_slack :
    ¬ BindsAt1214 (census 0) ∧ ¬ BindsAt1214 (census 1) ∧ ¬ BindsAt1214 (census 4) := by
  refine ⟨?_, ?_, ?_⟩ <;> (rw [bindsAt1214_iff]; decide)

/-! ## The constraint is live rather than slack, on the source's own numbers

Lemma 3.5.6's two contradictions read *"`g(n) < 0` for all `n ≥ 15`"* and *"`h(n) < 0` for all
`n ≥ 15`"*, and both functions are **positive** at the two dimensions in question. -/

/-- **`g` is positive at `n = 12, 14` and negative at `n = 15`**, so the contradiction Case 1
needs is unavailable exactly where the attempt claimed to free the argument. -/
theorem g_data : (0 : ℤ) < 194169 ∧ (0 : ℤ) < 89095 ∧ (-25497 : ℤ) < 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **And likewise `h`**, for Case 2. -/
theorem h_data : (0 : ℤ) < 2232117 ∧ (0 : ℤ) < 1224567 ∧ (-59616 : ℤ) < 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## What survives the refuted attempt, and the debt it uncovered -/

/-- **The isolated index choice, which is what survives.** *"Choose `l ∈ A_k` with
`l ∉ {a,b,c,d}`"* needs only that the block has five members, and that is a counting fact with no
dimension hypothesis in it. **It was never the binding step**, so the observation is true and
idle. -/
theorem free_index_exists {α : Type*} [DecidableEq α] (A B : Finset α)
    (hA : 5 ≤ A.card) (hB : B.card ≤ 4) : ∃ l ∈ A, l ∉ B := by
  by_contra h
  have hsub : A ⊆ B := by
    intro x hx
    by_contra hxB
    exact h ⟨x, hx, hxB⟩
  have := Finset.card_le_card hsub
  omega

/-- **The debt the attempt uncovered, and the one thing it adds.** The source's induction from a
combination of `s` basis vectors to one of `s-1` has no argument on file, and its literal
extension needs `|A_k| ≥ 2s + 1` with `s` reaching `m(m-1)` while `|A_k| = m`. **The gap is
quadratic, so no dimension hypothesis closes it**: the requirement fails at every `m ≥ 2`. -/
theorem induction_gap_fails (m : ℕ) (hm : 2 ≤ m) : ¬ (2 * (m * (m - 1)) + 1 ≤ m) := by
  have h2 : m ≤ m * (m - 1) :=
    calc m = m * 1 := (Nat.mul_one m).symm
      _ ≤ m * (m - 1) := Nat.mul_le_mul_left m (by omega)
  generalize hX : m * (m - 1) = X at h2
  omega

/-! ## The statement itself -/

/-- **L172.** Under `n = 2m` with `n` even, Lemma 3.5.6's `n ≥ 15` and Assumption 1's `m ≥ 8` are
one constraint; and that constraint binds at `n = 12` and `n = 14`.

*The second clause is the one the block's refuted first version got backwards, and it is the one
[L1](../../../findings/problem.md) depends on: its conditionality at those two dimensions is not
discharged by reading the source.* -/
theorem L172 : (∀ m : ℕ, 15 ≤ 2 * m ↔ 8 ≤ m) ∧ BindsAt1214 8 ∧
    (Finset.univ.filter (fun i => 8 ≤ census i)).card = 2 :=
  ⟨thresholds_agree, assumption_one_binds, census_two_bind⟩

end HamiltonsCubic.L172Statement
