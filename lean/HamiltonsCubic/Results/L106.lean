import HamiltonsCubic.Results.L68
import Mathlib.Tactic.NormNum

/-!
# L106, the zero-defect set, and why the biconditional is a restatement

[bounds.md](../../../findings/bounds.md)'s Lemma L106, confirmed with the audit's caveat that
*"the biconditional is a restatement, not a theorem"*.

**Here is why, in one line.** `Δ` is a **sum of non-negative terms**, [L68](L68.lean)'s
`g_γ`, whose non-negativity needs no hypothesis at all, so `Δ = 0` iff every term vanishes.
That is not a fact about curvature; it is what a sum of non-negative reals does.
`sum_zero_iff_termwise` below is the whole content, and L68's `g_nonneg` supplies the only
input.

**And an iff between two descriptions says nothing about size.** The audit warns *"never as
evidence that `{Δ = 0}` is small"*, and the reason is structural: a set equality carries no
cardinality or dimension, so the biconditional cannot bound the zero-defect set from either
side. `iff_carries_no_size` is that, with a two-element witness.
-/

namespace HamiltonsCubic.ZeroDefect

open Finset HamiltonsCubic.Diagonal

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {M : ι → ι → ℝ}

/-! ## The biconditional is what a sum of non-negative terms does -/

/-- **A sum of non-negative terms vanishes iff every term does.** With `Δ = Σ g_γ` over the
positive edges and `g_γ ≥ 0` from [L68](L68.lean), this *is* L106, no curvature enters. -/
theorem sum_zero_iff_termwise (s : Finset ι) (f : ι → ℝ) (hf : ∀ a ∈ s, 0 ≤ f a) :
    ∑ a ∈ s, f a = 0 ↔ ∀ a ∈ s, f a = 0 :=
  Finset.sum_eq_zero_iff_of_nonneg hf

/-- Applied to `Δ`: the defect vanishes iff each edge's density does, and the non-negativity
is L68's with no hypothesis. -/
theorem defect_zero_iff (s : Finset (ι × ι)) :
    ∑ p ∈ s, g M p.1 p.2 = 0 ↔ ∀ p ∈ s, g M p.1 p.2 = 0 :=
  Finset.sum_eq_zero_iff_of_nonneg fun p _ => g_nonneg p.1 p.2

/-- **And each such term vanishes iff the pair is a twin pair**, by L68, so the chain from
`Δ = 0` to the geometric description is two restatements, neither of them a theorem about
curvature. -/
theorem defect_zero_iff_twins (s : Finset (ι × ι)) :
    ∑ p ∈ s, g M p.1 p.2 = 0
      ↔ ∀ p ∈ s, ∀ d ∈ univ \ ({p.1, p.2} : Finset ι), M p.1 d = M p.2 d := by
  rw [defect_zero_iff]
  constructor
  · intro h p hp
    exact g_eq_zero_iff.1 (h p hp)
  · intro h p hp
    exact g_eq_zero_iff.2 (h p hp)

/-! ## An iff carries no size -/

/-- **A set equality says nothing about how large the set is.** So the biconditional cannot
be evidence that `{Δ = 0}` is small, two descriptions can agree on a set of any size. -/
theorem iff_carries_no_size :
    ∃ (A B : Set ℕ), A = B ∧ (0 : ℕ) ∈ A ∧ (1 : ℕ) ∈ A := by
  refine ⟨{0, 1}, {0, 1}, rfl, by simp, by simp⟩

/-- The same descriptions agree on a singleton too, so the agreement is compatible with every
size and distinguishes none. -/
theorem iff_compatible_with_small :
    ∃ (A B : Set ℕ), A = B ∧ ∀ x ∈ A, x = 0 := by
  refine ⟨{0}, {0}, rfl, ?_⟩
  intro x hx
  simpa using hx

end HamiltonsCubic.ZeroDefect
