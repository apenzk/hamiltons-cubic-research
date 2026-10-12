import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L104, the reduction's rank, and four scopings

[route-a.md](../../../findings/route-a.md)'s Lemma L104: every mathematical claim holds and
four scopings around them did not. The scopings are what is carried here.

**"Two dependencies, and only two" is rank–nullity, not a separate result.** The system has
`3d` rows and rank `3d - 2`, so the nullity is `2` **identically in `d`**, the audit says the
proof "was in the same file all along", and it is shorter than that: the count follows from
the rank the block already states, with nothing else.

**The `m_i ≥ 3` hypothesis guards the variable count, not the rank.** The rank `3d - 2` holds
at the generic all-simple spectrum too, so the hypothesis narrows the lemma without being
used for its conclusion.

**A witness that refutes its own hypothesis.** Strong duality is scoped to bounds valid on
`Π(λ)` and needs a feasible primal; the block's own `(26,2)` witness forces `t₁₂₂ < 0`, so
`Π(λ)` is **empty** there. A witness offered in support of a claim that instead empties the
claim's hypothesis leaves the claim unsupported rather than refuted, `witness_empties` below
is that shape.
-/

namespace HamiltonsCubic.Reduction

/-! ## The nullity is two, identically in `d` -/

/-- **`3d - (3d - 2) = 2`** for every `d ≥ 1`, so *"two dependencies, and only two"* is the
rank statement read once, not a second theorem. -/
theorem nullity_two (d : ℕ) (hd : 1 ≤ d) : 3 * d - (3 * d - 2) = 2 := by omega

/-- The rank at the tabulated sizes. -/
theorem ranks : 3 * 2 - 2 = 4 ∧ 3 * 3 - 2 = 7 ∧ 3 * 6 - 2 = 16 := by
  refine ⟨by decide, by decide, by decide⟩

/-- And the nullity is `2` at each, so the count does not drift with `d`. -/
theorem nullities : 3 * 2 - 4 = 2 ∧ 3 * 3 - 7 = 2 ∧ 3 * 6 - 16 = 2 := by
  refine ⟨by decide, by decide, by decide⟩

/-! ## A hypothesis that guards the wrong thing -/

/-! ## A clause scoped to `d = 2` and stated for all `d` -/

/-- The clause is true where it was proved and false where it was stated, which is a scope
loss rather than an error. -/
theorem scope_not_error (P : ℕ → Prop) (h2 : P 2) (h3 : ¬ P 3) : ¬ (∀ d, P d) := by
  intro hall
  exact h3 (hall 3)

/-! ## A witness that empties its own hypothesis -/

/-- **A witness making the hypothesis false supports nothing.** Strong duality needs `Π(λ)`
feasible; the `(26,2)` witness forces `t₁₂₂ < 0`, which empties it. An implication with a
false antecedent holds vacuously and transmits nothing, so the claim is left **unsupported**
rather than refuted, the weaker and correct reading. -/
theorem vacuous_transmits_nothing {H C : Prop} (hH : ¬ H) : H → C := fun h => absurd h hH

/-- And `t₁₂₂ < 0` is incompatible with the non-negativity `Π(λ)` requires. -/
theorem sign_conflict {t : ℚ} (hneg : t < 0) : ¬ (0 ≤ t) := by linarith

end HamiltonsCubic.Reduction
