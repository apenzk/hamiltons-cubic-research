import Mathlib.Algebra.Module.LinearMap.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum

/-!
# Taking invariants is exact **given** the projection, [L89](L89.lean)'s owed half

[L89](L89.lean) records as owed *"exactness of `(-)^{O(5)}` via the Reynolds operator, and the
rank `14` itself"*. **The exactness is formal once the projection exists**, and needs nothing
about `O(5)`, Haar measure or characteristic zero.

**The argument is three lines.** Let `f` be a surjective equivariant map and `π_V`, `π_W` the
Reynolds projections, idempotent and intertwined by `f`. Given an invariant `w`, lift it to any
`v₀` with `f v₀ = w`; then `π_V v₀` is invariant by idempotence, and

`f (π_V v₀) = π_W (f v₀) = π_W w = w`.

So the lift can be taken invariant. **That is the whole of exactness in the direction the block
uses**, and the Reynolds operator enters only as the projection's existence.

**This is the third owed entry with the same shape.** [SpectralCorollaries](SpectralCorollaries.lean)
needed one existence statement rather than the spectral theorem, [DoublyStochastic](DoublyStochastic.lean)
needed Jensen rather than Karamata, and this needs a projection rather than representation theory.
*The debts were recorded at the name of the machinery, not at the size of the gap.*

**What stays owed is the projection's existence and the rank `14`**, the first genuine
representation theory, the second a computation.
-/

namespace HamiltonsCubic.InvariantsExact

variable {V W : Type*} [AddCommGroup V] [Module ℝ V] [AddCommGroup W] [Module ℝ W]

/-- **Invariant lifts exist.** Given a surjective map intertwined with idempotent projections onto
the invariants, every invariant of the target lifts to an invariant of the source. -/
theorem invariant_lift (f : V →ₗ[ℝ] W) (hf : Function.Surjective f)
    (πV : V →ₗ[ℝ] V) (πW : W →ₗ[ℝ] W)
    (hidem : ∀ v, πV (πV v) = πV v)
    (hcomm : ∀ v, f (πV v) = πW (f v))
    (w : W) (hw : πW w = w) :
    ∃ v, πV v = v ∧ f v = w := by
  obtain ⟨v₀, hv₀⟩ := hf w
  refine ⟨πV v₀, hidem v₀, ?_⟩
  rw [hcomm v₀, hv₀, hw]

/-- **Idempotence is load-bearing.** Without it the lift need not be invariant: scaling by two
intertwines with itself and commutes with any map, yet fixes only zero. -/
theorem idempotence_is_needed :
    ∃ π : ℝ → ℝ, (∀ v, π v = 2 * v) ∧ ∃ v, π (π v) ≠ π v :=
  ⟨fun v => 2 * v, fun _ => rfl, 1, by norm_num⟩

end HamiltonsCubic.InvariantsExact
