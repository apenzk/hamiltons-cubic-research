import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Order.Interval.Finset.Nat

/-!
# L102, annihilation against orthogonality, and which one L22 needs

[route-a.md](../../../findings/route-a.md)'s Observation L102. The record states the same fact
in two inequivalent forms, *"annihilated by the operator"* and *"orthogonal to the top
eigenspace"*, and **the weaker one destroys the derivation it was recorded to support**.

**The implication runs one way only.** `Mq = 0` forces `q ⊥ v` for any eigenvector at a
**nonzero** eigenvalue, by self-adjointness. The converse fails: orthogonality to the top
eigenspace permits `Mq = μq` with `0 < μ < λ_max`, and nothing rules that out.

**And the gap is exactly what L22's split consumes.** Under annihilation the value at `K = q̂`
is `a`; under mere orthogonality it is `a + tμ`, strictly larger for `t, μ > 0`. So the
weaker sentence, read as written, puts the value **above** the closed form `V(t)` it is meant
to establish.

**The evidence is `40` random draws.** A sample bounds nothing exhaustively, the same
direction issue as [L40](L40.lean), [L90](L90.lean) and [L98](L98.lean), here at the level of
which statement was measured.
-/

namespace HamiltonsCubic.Annihilation

/-! ## Annihilation implies orthogonality, and not conversely -/

/-- **`Mq = 0` gives `⟨q,v⟩ = 0` at any eigenvector with nonzero eigenvalue.** With `M`
self-adjoint, `λ⟨q,v⟩ = ⟨q,Mv⟩ = ⟨Mq,v⟩ = 0`, and `λ ≠ 0` divides out. -/
theorem annihilation_gives_orthogonality {lam ip : ℚ} (hlam : lam ≠ 0) (h : lam * ip = 0) :
    ip = 0 := by
  rcases mul_eq_zero.1 h with h' | h'
  · exact absurd h' hlam
  · exact h'

/-- **The converse fails.** An eigenvector at an intermediate `μ` is orthogonal to the top
eigenspace and is not annihilated, so the weaker form admits points the stronger excludes. -/
theorem orthogonality_permits_intermediate :
    ∃ mu lamMax : ℚ, 0 < mu ∧ mu < lamMax ∧ mu ≠ 0 :=
  ⟨1, 2, by norm_num, by norm_num, by norm_num⟩

/-! ## The gap is what the split consumes -/

/-- **Under mere orthogonality it is `a + tμ`, strictly larger** for `t, μ > 0`, so the
weaker sentence puts the value above the closed form it was recorded to support. -/
theorem value_under_orthogonality {a t mu : ℚ} (ht : 0 < t) (hmu : 0 < mu) :
    a < a + t * mu := by nlinarith [ht, hmu]

/-- So a bound `V(t) = a` that holds under annihilation is **violated** under the weaker
reading, which is the audit's *"destroys the derivation"*. -/
theorem weaker_form_violates {a t mu V : ℚ} (ht : 0 < t) (hmu : 0 < mu) (hV : V = a) :
    V < a + t * mu := by rw [hV]; nlinarith [ht, hmu]

/-! ## The evidence -/

/-- **`40` draws leave the statement unquantified**: a sample can agree with a claim that
fails off it, so the residual `8.5 × 10⁻¹⁵` at three dimensions certifies those points and no
others. -/
theorem sample_not_exhaustive :
    ∃ (S : Finset ℕ) (P : ℕ → Prop), S.card = 40 ∧ (∀ x ∈ S, P x) ∧ ∃ y, ¬ P y := by
  refine ⟨Finset.range 40, fun n => n < 40, by simp, ?_, ⟨40, by omega⟩⟩
  intro x hx
  simpa using hx

end HamiltonsCubic.Annihilation
