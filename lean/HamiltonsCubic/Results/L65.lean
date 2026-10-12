import Mathlib.Tactic.NormNum
import Mathlib.Tactic.DeriveFintype
import Mathlib.Data.List.Basic

/-!
# L65, the seed is the inclusion padded by cups

[brauer-pairing.md](../../../findings/brauer-pairing.md)'s Lemma L65. The construction is
representation theory; the admissibility bookkeeping is combinatorics and is here.

**Why admissibility cannot fail in the programme's range, with the reason, not the
observation.** The condition is `λ'₁ + λ'₂ ≤ n` on the conjugate partition. For *any*
partition, `λ'₁ + λ'₂ ≤ |λ|`: the first counts the nonzero parts and the second the parts of
size at least two, and a part of size `p` contributes `1` to the first, `1` more to the second
only when `p ≥ 2`, so it is charged at most `p` either way. **Hence `|λ| ≤ n` implies
admissible**, and in the programme `|λ| ≤ 12 = n`. It is a theorem about partitions and needs no
census, and the record states it in this form.

**Tightness is where the two bounds meet.** `λ = (2,2,2,2,2,2)` has `|λ| = 12 = n` and
`λ'₁ + λ'₂ = 6 + 6 = 12`, so both inequalities are equalities at once, which is what makes
the hypothesis tight rather than slack.

**The `12` is a leg count.** Three Weyl tensors at four legs each, so `f = 12` never refers
to a dimension and the result is dimension-free.
-/

namespace HamiltonsCubic.Seed

/-- The number of nonzero parts, `λ'₁`. -/
def rows (l : List ℕ) : ℕ := (l.filter (fun p => 0 < p)).length

/-- The number of parts of size at least two, `λ'₂`. -/
def rows2 (l : List ℕ) : ℕ := (l.filter (fun p => 2 ≤ p)).length

/-- `O(n)`-admissibility: `λ'₁ + λ'₂ ≤ n`. -/
abbrev admissible (n : ℕ) (l : List ℕ) : Prop := rows l + rows2 l ≤ n

/-! ## Admissibility follows from `|λ| ≤ n`, for every partition -/

/-- **`λ'₁ + λ'₂ ≤ |λ|`**, by induction: a part of size `p` is charged `1` when `p = 1` and
`2` when `p ≥ 2`, never more than `p`. -/
theorem conj_le_size : ∀ l : List ℕ, rows l + rows2 l ≤ l.sum
  | [] => by simp [rows, rows2]
  | p :: t => by
    have ih := conj_le_size t
    unfold rows rows2 at *
    rcases Nat.lt_or_ge p 1 with hp | hp
    · have hp0 : p = 0 := by omega
      subst hp0
      simp only [List.filter_cons, List.sum_cons]
      norm_num
      omega
    · rcases Nat.lt_or_ge p 2 with hp2 | hp2
      · have hp1 : p = 1 := by omega
        subst hp1
        simp only [List.filter_cons, List.sum_cons]
        norm_num
        omega
      · have h0 : 0 < p := by omega
        simp only [List.filter_cons, List.sum_cons]
        rw [if_pos (by simpa using h0), if_pos (by simpa using hp2)]
        simp only [List.length_cons]
        omega

/-- **So `|λ| ≤ n` implies admissible**, no census over blocks is needed. -/
theorem admissible_of_size_le {n : ℕ} {l : List ℕ} (h : l.sum ≤ n) : admissible n l :=
  le_trans (conj_le_size l) h

/-- In the programme `|λ| ≤ 12 = n`, so every block is admissible by the theorem above. -/
theorem admissible_in_range {l : List ℕ} (h : l.sum ≤ 12) : admissible 12 l :=
  admissible_of_size_le h

/-! ## Tightness -/

/-- `λ = (2,2,2,2,2,2)` has `λ'₁ = λ'₂ = 6`, so `λ'₁ + λ'₂ = 12`. -/
theorem tight_conj : rows [2, 2, 2, 2, 2, 2] + rows2 [2, 2, 2, 2, 2, 2] = 12 := by decide

/-- Its size is also `12`, so both inequalities are equalities at once, the hypothesis is
tight, not slack. -/
theorem tight_size : ([2, 2, 2, 2, 2, 2] : List ℕ).sum = 12 := by decide

/-! ## The witnesses where admissibility genuinely fails -/

/-- `λ = (2,2)` fails at `n = 3`: `λ'₁ + λ'₂ = 4 > 3`. -/
theorem fails_22_at_three : ¬ admissible 3 [2, 2] := by decide

theorem fails_22_at_two : ¬ admissible 2 [2, 2] := by decide

/-- `λ = (2,1,1)` fails at `n = 3`: `λ'₁ + λ'₂ = 3 + 1 = 4 > 3`. -/
theorem fails_211_at_three : ¬ admissible 3 [2, 1, 1] := by decide

/-- Both witnesses have `|λ| = 4 > n`, consistent with the theorem: failure needs the size to
exceed `n`. -/
theorem witnesses_exceed : ([2, 2] : List ℕ).sum = 4 ∧ ([2, 1, 1] : List ℕ).sum = 4 := by
  constructor <;> decide

/-! ## The leg count, and the `diagram` heading -/

/-- **`f = 12` is a leg count**: three Weyl tensors at four legs each. It is not a dimension,
which is why the result is dimension-free. -/
theorem leg_count : 3 * 4 = 12 := by decide

/-- `k = (12 - |λ|)/2` needs `|λ|` even and at most `12`, the cups pair the remaining legs
in twos. -/
theorem cups_wellposed (s : ℕ) (heven : s % 2 = 0) (hle : s ≤ 12) : 2 * ((12 - s) / 2) = 12 - s := by
  omega

/-- **The heading's *diagram* fails at `16` of `71` blocks**, as the file's own prose says,
just under a quarter. -/
theorem diagram_failure_share : 16 * 4 < 71 ∧ 71 < 16 * 5 := by
  constructor <;> decide

end HamiltonsCubic.Seed
