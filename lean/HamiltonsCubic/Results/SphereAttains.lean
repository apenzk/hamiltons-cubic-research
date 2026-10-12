import Mathlib.Analysis.Normed.Module.FiniteDimension
import Mathlib.Topology.MetricSpace.ProperSpace
import Mathlib.Topology.Order.Compact
import Mathlib.Analysis.Normed.Order.Basic

/-!
# The unit sphere attains a maximum, [L0](L0.lean)'s owed compactness

[L0](L0.lean) records as owed *"compactness and the Lagrange condition, which are imported"*.
**The compactness half is a composition of library facts** and is carried here; the Lagrange
condition is analysis on the constraint and stays imported.

The block's step reads: *`𝒲ₙ` is finite-dimensional, so `{‖W‖ = 1}` is compact and the polynomial
`P` attains its maximum on it.* That is three facts in sequence, a finite-dimensional normed
space is proper, a sphere in a proper space is compact, and a continuous function on a nonempty
compact set attains a maximum. **None of them concerns `P`, Weyl tensors or the dimension `n`.**

*The Lagrange condition, that the maximiser is critical for the restricted problem, is
[WeylMaximiser.lean](WeylMaximiser.lean)'s `Qop2_eq_smul_weyl`, on the unit Weyl sphere itself.*
-/

namespace HamiltonsCubic.SphereAttains

open Metric

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]

/-- **The unit sphere is compact** in a finite-dimensional real normed space. -/
theorem sphere_compact : IsCompact (sphere (0 : E) 1) := isCompact_sphere 0 1

/-- **And a continuous function attains a maximum on it**, when the space is nontrivial so the
sphere is nonempty. -/
theorem exists_max [Nontrivial E] (f : E → ℝ) (hf : Continuous f) :
    ∃ x ∈ sphere (0 : E) 1, ∀ y ∈ sphere (0 : E) 1, f y ≤ f x := by
  obtain ⟨x, hx, hmax⟩ :=
    sphere_compact.exists_isMaxOn (NormedSpace.sphere_nonempty.2 zero_le_one) hf.continuousOn
  exact ⟨x, hx, fun y hy => hmax hy⟩

end HamiltonsCubic.SphereAttains
