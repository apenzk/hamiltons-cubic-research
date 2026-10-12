import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L81, the sharp centraliser criterion, and three things around it

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L81. The criterion itself is
representation theory; the three refutations are about the *shape* of hypotheses and
statements, and that is what is carried here.

**`m ≠ 3` against `m ≥ 4`.** The sharp hypothesis excludes one value; the block's excludes
every value below `4`. They differ exactly at `m ∈ {0,1,2}`, and the record notes `m = 2`
specifically, so `m ≥ 4` is conservative by three cases, not one.

**A disjunction narrowed to one disjunct is a *stronger* hypothesis.** The block writes
*"requires `p ≥ 2`"* where its source wrote *"`p ≥ 2` **or** `dim ker x ≥ 2`"*. Dropping a
disjunct from a hypothesis shrinks the lemma's reach, and `disjunct_strengthens` is that with
its converse refuted, so the misquotation loses cases rather than merely rewording.

**A `D`-type argument does not reach odd `n`.** `𝔰𝔬(2p)` is `D_p` and `𝔰𝔬(2p+1)` is `B_p`, and
no odd number is `2p`, so a root step stated over `D_p` is silent at every odd `n`, which is
the gap the audit names.

**Bounding is weaker than giving.** *"Wider than L32"* is refuted because L32 supplies the
values this only brackets, and a bound never implies the value it bounds.
-/

namespace HamiltonsCubic.Centraliser

/-! ## The sharp hypothesis against the stated one -/

/-- **`m ≥ 4` is strictly narrower than `m ≠ 3`**, and `m = 2` witnesses the difference, the
case the record names. -/
theorem two_is_lost : (2 : ℕ) ≠ 3 ∧ ¬ (4 ≤ 2) := by
  constructor <;> omega

/-- The stated hypothesis implies the sharp one, so nothing false was proved, only less. -/
theorem stated_implies_sharp {m : ℕ} (h : 4 ≤ m) : m ≠ 3 := by omega

/-- **They differ at exactly three values.** `m ≠ 3` admits `0, 1, 2` where `m ≥ 4` does
not. -/
theorem difference_is_three {m : ℕ} (h : m ≠ 3) (h' : ¬ (4 ≤ m)) : m = 0 ∨ m = 1 ∨ m = 2 := by
  omega

/-! ## A disjunction narrowed to one disjunct -/

/-- **Dropping a disjunct strengthens the hypothesis**: `A` implies `A ∨ B`, so a lemma
stated under `A` covers less than one stated under `A ∨ B`. -/
theorem disjunct_strengthens {A B : Prop} (hA : A) : A ∨ B := Or.inl hA

/-- **And the converse fails**, so the misquotation loses cases rather than rewording. -/
theorem disjunct_not_reversible : ∃ A B : Prop, (A ∨ B) ∧ ¬ A := ⟨False, True, Or.inr trivial, id⟩

/-! ## `D_p` does not reach odd `n` -/

/-- **No odd `n` is `2p`**, so a root step stated over `D_p` is silent at every odd
dimension. -/
theorem odd_not_D (n : ℕ) (hodd : n % 2 = 1) (p : ℕ) : n ≠ 2 * p := by omega

/-- `𝔰𝔬(2p+1)` is `B_p`, and `B_p ≠ D_p` as root systems for every `p ≥ 1`, the ranks agree
while the dimensions do not: `p(2p+1)` against `p(2p-1)`. -/
theorem B_ne_D (p : ℕ) (hp : 1 ≤ p) : p * (2 * p + 1) ≠ p * (2 * p - 1) := by
  cases p with
  | zero => omega
  | succ k => simp; omega

/-! ## Bounding is weaker than giving -/

/-- **A statement bracketing a value does not supply it**, so *"wider than L32"* fails when
L32 gives what this only bounds. -/
theorem bound_is_weaker :
    ∃ (lo hi v w : ℚ), lo ≤ v ∧ v ≤ hi ∧ lo ≤ w ∧ w ≤ hi ∧ v ≠ w :=
  ⟨0, 1, 0, 1, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.Centraliser
