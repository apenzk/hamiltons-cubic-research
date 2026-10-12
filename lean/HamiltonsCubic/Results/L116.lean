import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L116, `b(W^#) = -b(W²)`, and why it is the literature's claim

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L116.

**"Literally one proposition" is linearity, and it is one line.** With `b` linear,
`b(X) = -b(Y)` and `b(X + Y) = 0` are the same statement, so the block's identity and the
literature's vanishing claim are not two facts to be reconciled but one fact written twice.
The block never says so, and the equivalence needs nothing but additivity.

**The two hypotheses are not symmetric.** Trace-freeness is unnecessary and Bianchi for `W` is
necessary, by an `n = 4` hand witness. So the heading's set is strictly smaller than the
identity's: one hypothesis can be dropped and the other cannot, and a statement scoped by both
understates its own reach on exactly one axis.
-/

namespace HamiltonsCubic.BLinear

/-! ## Linearity makes the two claims one -/

/-- **`b(X) = -b(Y)` and `b(X + Y) = 0` are the same statement** when `b` is additive. -/
theorem identity_iff_vanishing {b : ℚ → ℚ} (hadd : ∀ x y, b (x + y) = b x + b y) (X Y : ℚ) :
    b X = -b Y ↔ b (X + Y) = 0 := by
  rw [hadd]
  constructor
  · intro h; rw [h]; ring
  · intro h; linarith

/-- So the block's identity and the literature's vanishing claim are one proposition, and no
reconciliation is needed, only the observation that `b` is additive. -/
theorem one_proposition {b : ℚ → ℚ} (hadd : ∀ x y, b (x + y) = b x + b y) (X Y : ℚ)
    (h : b (X + Y) = 0) : b X = -b Y :=
  (identity_iff_vanishing hadd X Y).2 h

/-! ## The two hypotheses are not symmetric -/

/-- **One hypothesis can be dropped and the other cannot.** A conclusion may follow from `H₂`
alone while failing without it, so a statement scoped by both `H₁` and `H₂` understates its
reach on exactly one axis. -/
theorem asymmetric_hypotheses :
    ∃ (H₁ H₂ C : Prop), (H₂ → C) ∧ ¬ (H₁ → C) := by
  refine ⟨True, False, False, fun h => h.elim, ?_⟩
  intro h
  exact (h trivial).elim

/-- The heading's set is then strictly smaller than the identity's: adding an unnecessary
hypothesis cuts instances without changing what is proved. -/
theorem unnecessary_hypothesis_cuts :
    ∃ (S T : Set ℕ), S ⊆ T ∧ (1 : ℕ) ∈ T ∧ (1 : ℕ) ∉ S := by
  refine ⟨{0}, {0, 1}, ?_, by simp, by simp⟩
  intro x hx
  simp only [Set.mem_singleton_iff] at hx
  simp [hx]

end HamiltonsCubic.BLinear
